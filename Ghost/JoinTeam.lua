require("TSLib")

Common = require("Common.index")
Ghost = {}

-- 观战
local function watchBattle()
    offset = "0|7|0xd8a557,10|1|0xd8a85b,22|10|0xd8a659,19|16|0xd7a355"
    return findColorsUntil(0xd8a95c, offset, 90, 1074, 558, 1130, 609, {orient = 2}, 500, 1)
end

-- 打开队伍情况下的战斗
local function battleWithTeamWindow()
    offset = "21|9|0x4e2916,42|-2|0x572f1a,11|28|0x481a0d,-107|6|0xeda847"

    return findColorsUntil(0x60432b, offset, 90, 813, 538, 1126, 625, {orient = 2}, 500, 1)
end

-- 检查战斗的是不是捉鬼
local function checkGhostBattle()
    offset = "-6|-16|0xf8dea6,8|-8|0xe4ae74,6|-5|0xf1cea1,1|-7|0xf6e4c9"
    return findColorsUntil(0xe7a274, offset, 90, 351, 0, 405, 62, {orient = 2}, 1000, 1)
end

-- 战斗中退出队伍
local function battleQuitTeam()
    -- 打开左上角菜单
    tap(35, 47)
    mSleep(1000)
    -- 打开队伍
    tap(118, 195)
    mSleep(2000)
    -- 退出队伍
    tap(276, 573)
    mSleep(1000)
    -- 关闭队伍
    tap(981, 38)
    mSleep(1000)
end

-- 打开队伍
function Ghost.openTeam()
    while true do
        keepScreen(true)
        ret = Common.checkMainPage()
        if ret then
            keepScreen(false)
            break
        end
        Common.closeWindow()
        mSleep(1000)
        keepScreen(false)
    end

    -- 打开队伍
    Common.commonOpenGroup()

    -- 退出队伍
    ret, tim, x, y = Common.quitTeam(1000, 5)
    if ret then
        tap(x, y)
        mSleep(1000)
        return 0
    end
    -- 不一定有队伍
    return 0
end

-- 便捷组队
function Ghost.simpleGroup()
    -- 打开右下角便捷组队
    tap(960, 580)
    mSleep(1000)

    -- 拉到最上面,捉鬼任务在第二个
    Common.move(
        nil,
        function()
            moveTo(290, 183, 290, 407, 200, 50)
        end,
        function()
            local p1 = getColor(713, 222)
            local p2 = getColor(726, 220)
            local p3 = getColor(711, 212)
            local p4 = getColor(723, 224)
            return p1, p2, p3, p4
        end
    )

    -- 点击左侧捉鬼任务
    tap(298, 183)
    mSleep(1000)

    -- 自动匹配
    tap(620, 574)
    mSleep(500)

    -- 关闭
    tap(1014, 42)
    mSleep(500)
    return 0
end

-- 等待加入队伍
function Ghost.waitTeam()
    now = os.time()
    while true do
        -- 是否有弹出的窗口
        ret = isColor(980, 39, 0xcd0000, 100)
        if not ret then
            Common.closeWindow()
        end

        ret = isColor(812, 106, 0x875832, 100)

        -- 加入队伍成功
        if ret then
            return 0
        end

        -- 5分钟都没匹配到队伍
        if now + 300 < os.time() then
            break
        end
    end

    -- 无限等待捉鬼
    if UISetting.ghost.waitTeamTime == nil then
        -- 取消自动匹配状态,先自己创建队伍,再退出
        tap(144, 578)
        mSleep(500)
        tap(144, 578)
        mSleep(500)

        -- 执行打开便捷组队
        return 3
    end

    -- 结束捉鬼了
    return -2
end

-- 检查状态
function Ghost.checkStatus()
    keepScreen(true)
    -- 正在观战
    ret, tim, x, y = watchBattle()
    keepScreen(false)

    waitTime = 120
    if ret then
        -- todo 这里做了观战没有等待时间,可能会出现别人在捉最后一只鬼,然后就不会动了
        isWatchBattle = true
        -- 退出观战
        tap(x, y)
        mSleep(2000)
    end
    while true do
        -- 退出队伍
        ret, tim, x, y = Common.quitTeam()
        -- 被踢了
        if not ret then
            -- 取消自动匹配状态,先自己创建队伍,再退出
            tap(144, 578)
            mSleep(500)
            tap(144, 578)
            mSleep(500)
            -- 回到 [便捷组队]
            return 3
        end

        -- 进入战斗成功
        ret = battleWithTeamWindow()
        if ret then
            -- 关闭队伍
            tap(981, 38)
            mSleep(1000)
            -- 执行下一步
            return 0
        end

        -- 不是观战状态
        if not isWatchBattle then
            waitTime = waitTime - 1
            -- 超时退出队伍
            if waitTime == 0 then
                -- 退出队伍
                tap(276, 573)
                mSleep(1000)
                fwCloseView("recordBoard", "record")
                -- 回到[便捷组队]
                return 3
            end
            Common.record("倒计时: " .. waitTime)
        end
    end
end

-- 检查战斗状态
function Ghost.checkBattleStatus()
    if globalGhost["ghostNum"] == nil then
        globalGhost["ghostNum"] = 0
    end

    -- 主页面倒计时
    local mainPageTime = 60

    -- 捉鬼完成
    local isDone = false

    while true do
        keepScreen(true)

        isBattle = Common.checkBattle()

        -- 不在战斗
        if not isBattle then
            keepScreen(false)
            -- 在主页
            if Common.checkMainPage() then
                -- 终止,可能是捉完鬼,也可能是捉的不是鬼而退出
                if isDone then
                    --  够数,执行下一步
                    return 0
                end

                mainPageTime = mainPageTime - 1
                Common.record("主页面: " .. mainPageTime)

                if mainPageTime <= 1 then
                    break
                end
            else
                -- 关闭弹窗
                Common.closeWindow()
            end
        else
            -- 打的不是鬼
            if not isDone and not checkGhostBattle() then
                keepScreen(false)
                isDone = true
                -- 战斗中退出队伍
                battleQuitTeam()
            end

            -- 捉鬼次数加1
            globalGhost["ghostNum"] = globalGhost["ghostNum"] + 1
            Common.record("鬼: " .. globalGhost["ghostNum"])

            keepScreen(false)
            -- 等于捉完这一只就够了
            if not isDone and globalGhost["ghostNum"] + 1 == 20 then
                isDone = true
                -- 战斗中退出队伍
                battleQuitTeam()
            end

            mainPageTime = 60
        end

        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

-- 统计捉鬼次数
function Ghost.checkGhostNum()
    collectgarbage("collect")

    if globalGhost["ghostNum"] < 20 then
        Common.commonOpenGroup()
        ret, tim, x, y = Common.quitTeam()
        if ret then
            -- 退出队伍
            tap(x, y)
            mSleep(1000)
        end

        -- 返回 [便捷组队]
        return 3
    end

    toast("结束捉鬼")
    return -2
end

local function crashAfter()
    ret = Common.checkMainPage()
    if ret then
        Common.commonOpenGroup()
        return 4
    end
    ret = checkGhostBattle()
    -- 正在战斗
    if ret then
        tap(x, y)
        mSleep(1000)
        return 6
    end
end

function Ghost.crashCallack()
    nowNode = taskRecord.currentNode
    toast("num: " .. nowNode["now"])
    if nowNode["now"] == "1" then --回长安
        return 2
    elseif nowNode["now"] == "2" then -- 打开队伍
        return 2
    elseif nowNode["now"] == "3" then -- 打开便捷组队
        return crashAfter()
    elseif nowNode["now"] == "4" then -- 等待加入队伍
        return crashAfter()
    elseif nowNode["now"] == "5" then -- 检查状态
        return crashAfter()
    elseif nowNode["now"] == "6" then -- 检查战斗状态
        return 6
    elseif nowNode["now"] == "7" then -- 统计捉鬼次数
        return 7
    end
end

return Ghost
