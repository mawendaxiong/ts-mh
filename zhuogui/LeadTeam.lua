require("TSLib")

Common = require("Common.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

Ghost = {}

--[[
检查人数
1.有3个人,包含3个,返回 1
2.少于3个,返回 0
]]
local function checkMinPeople()
    keepScreen(true)
    count = 1
    if isColor(427, 513, 0xf0e3d3, 100) then
        count = count + 1
    end
    if isColor(595, 507, 0xf0e3d3, 100) then
        count = count + 1
    end
    if isColor(779, 503, 0xf0e3d3, 100) then
        count = count + 1
    end
    if isColor(955, 515, 0xf0e3d3, 100) then
        count = count + 1
    end
    keepScreen(false)

    -- 说明还没足够3个人
    if count < 3 then
        return 0
    end
    return 1
end

--[[
右侧任务 -> 捉鬼任务
]]
local function ghostTaskGuide()
    offset = "25|0|0xfcf31c,34|14|0xfbf21c,41|15|0xfcf31c,199|4|0xffed00,204|49|0xbc1b09"

    return findMultiColorInRegionFuzzy(0xe5de1e, offset, 90, 0, 0, 1136, 640, {orient = 2})
end

-- 点击钟馗后弹出的选项中的 捉鬼任务
local function ghostTask()
    offset = "-13|19|0x583c26,-5|18|0x553923,3|19|0x553923,8|2|0x553923,25|9|0x553923,20|14|0x553923"

    return findColorsUntil(0x553923, offset, 90, 0, 0, 1136, 640, {orient = 2}, 1000, 5)
end

-- 不足5人 警告
local function notFullTeamWarn()
    offset = "-5|6|0xe01601,0|7|0xe1220d,0|13|0xe1240f,-2|15|0xe1230e,-5|13|0xe23d29"

    return findMultiColorInRegionFuzzy(0xe1210d, offset, 90, 355, 198, 777, 439)
end

-- 没有辅助 警告
local function noSupWarn()
    offset =
        "0|7|0xe45743,5|13|0xe23723,5|4|0xe1240f,9|1|0xe01b06,13|1|0xe01b06,17|7|0xe01500,15|16|0xe01500,11|5|0xe01500"

    return findMultiColorInRegionFuzzy(0xe01500, offset, 90, 355, 198, 777, 439)
end

-- 是否提示一轮鬼结束了
local function roundOverTip()
    offset = "0|11|0x9f764c,33|0|0xede0cf,33|4|0xede0cf,36|-2|0x8d5d2c,43|11|0x906131,-45|63|0xf3ca69,174|82|0xedc061"

    return findColorsUntil(0x9f764c, offset, 90, 376, 269, 756, 402, {orient = 2}, 1000, 5)
end

-- 创建队伍
function Ghost.createTeam()
    -- 点击创建队伍
    tap(465, 583)
    mSleep(1000)
    -- 执行下一步
    return 0
end

-- 调整等级
function Ghost.fixLevel()
    -- 打开调整等级
    tap(757, 101)
    mSleep(1000)

    -- 等级拉到最大匹配
    Common.move(
        nil,
        function()
            moveTo(730, 315, 730, 130, 200, 50)
        end,
        function()
            local p1 = getColor(713, 222)
            local p2 = getColor(726, 220)
            local p3 = getColor(711, 212)
            local p4 = getColor(723, 224)
            return p1, p2, p3, p4
        end
    )

    -- 确定
    tap(654, 585)
    mSleep(1000)

    return 0
end

-- 等人
function Ghost.waitTeamMember()
    -- 等人
    while (true) do
        -- 是否有弹出的窗口
        ret = isColor(980, 39, 0xcd0000, 100)
        if not ret then
            Common.closeWindow()
        end

        if checkMinPeople() == 1 then
            break
        end
        mSleep(1000)
    end

    -- 关闭组队
    tap(980, 40)
    mSleep(1000)
    -- 执行下一步
    return 0
end

-- 去钟馗那里
function Ghost.go2Zhongkui()
    ret, tim, x, y = Common.userDialog(1000, 10)
    -- 没有出现钟馗的对话框
    if not ret then
        -- 执行 [回长安]
        return 1
    end
    -- 执行下一步
    return 0
end

-- 获取任务
function Ghost.getTask()
    keepScreen(true)

    ret, tim, x, y = ghostTask()
    if ret then
        tap(x, y)
        mSleep(1000)
    end

    keepScreen(false)
    -- 执行下一步
    return 0
end

-- 检查提示
function Ghost.checkTip()
    keepScreen(true)

    currentTime = os.time()
    while true do
        -- 不足五人 警告
        x, y = notFullTeamWarn()
        if x ~= -1 then
            -- 点击取消
            tap(471, 385)
            mSleep(1000)
            break
        end

        -- 没有辅助 警告
        x, y = noSupWarn()
        if x ~= -1 then
            -- 点击取消
            tap(471, 385)
            mSleep(1000)
            break
        end

        if currentTime + 5 >= os.time() then
            break
        end
        mSleep(1000)
    end
    keepScreen(false)

    -- 关闭钟馗的对话框
    tap(1, 1)
    mSleep(1000)
    -- 执行下一步
    return 0
end

-- 查找任务
function Ghost.findTask()
    -- 激活右侧任务tab
    if not isColor(931, 122, 0xcde5ac, 100) then
        tap(931, 122)
        mSleep(1000)
    end

    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        ret, tim, x, y = Common.redCacle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    x, y = ghostTaskGuide()
    if x ~= -1 then
        tap(x, y)
        -- 执行下一步
        return 0
    else
        -- 先重置右侧任务栏
        Common.resetRightTaskBoard()

        Common.move(
            function()
                x, y = ghostTaskGuide()
                if x ~= -1 then
                    tap(x, y)
                    mSleep(1000)
                    return true
                end
                return false
            end,
            function()
                moveTo(1107, 350, 1102, 178, 2, 50)
            end,
            function()
                local p1 = getColor(713, 222)
                local p2 = getColor(726, 220)
                local p3 = getColor(711, 212)
                local p4 = getColor(723, 224)
                return p1, p2, p3, p4
            end,
            function()
                Common.resetRightTaskBoard()
            end
        )

        return 0
    end
end

-- 检查一轮鬼结束
function Ghost.checkRoundOver()
    if globalGhost["ghostNum"] == nil then
        globalGhost["ghostNum"] = 0
    end

    -- 主页面倒计时
    local mainPageTime = 60
    local isCount = false

    while true do
        isBattle = Common.checkBattle()

        -- 不在战斗
        if not isBattle then
            isCount = false

            -- 在主页
            if Common.checkMainPage() then
                mainPageTime = mainPageTime - 1
                Common.record("主页面: " .. mainPageTime)

                if mainPageTime <= 1 then
                    break
                end
            else
                ret = roundOverTip()
                if ret then -- 一轮鬼结束
                    toast("round over!!")
                    tap(467, 373)
                    mSleep(1000)
                    break
                else
                    -- 关闭弹窗
                    Common.closeWindow()
                end
            end
        else
            if not isCount then

            globalGhost["ghostNum"] = globalGhost["ghostNum"] + 1
            Common.record("鬼: " .. globalGhost["ghostNum"])
            isCount = true

            end
            mainPageTime = 60
        end

        mSleep(1000)
    end

    -- 检查等级,练小号用
    if globalGhost.checkLevel == 1 then
        text = ocrText(1025, 47, 1046, 66, 0)
        level = tonumber(text)
        -- 大于37结束捉鬼
        if level >= 37 then
            return -2
        end
    end

    -- 执行下一步
    return 0
end

-- 检查总捉鬼次数
function Ghost.checkGhostNum()
    collectgarbage("collect")
    num = globalGhost["ghostNum"]
    if num < UISetting.g1 then
        -- collectgarbage("collect")
        return 1
    end

    toast("结束捉鬼")
    return -2
end

-- 检查队伍人数
function Ghost.checkTeamMember()
    -- 打开组队
    Common.commonOpenGroup()

    local isMinPeople = checkMinPeople()

    -- 说明还不够3个人
    if isMinPeople == 0 then
        keepScreen(true)
        -- 检查是有队伍

        ret, tim, x, y = Common.quitTeam()
        if ret then
            -- 退出队伍
            tap(209, 582)
            mSleep(1000)
        end
        keepScreen(false)
    end

    if isMinPeople == 0 then
        -- 执行下一步 [便捷组队]
        return 0
    end
    -- 关闭组队界面
    tap(982, 39)
    mSleep(1000)
    -- 执行 [打开活动板]
    return 6
end

-- 打开便捷组队
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

    -- 点击创建队伍
    tap(534, 577)
    mSleep(1000)

    return 0
end

function Ghost.crashCallack()
    nowNode = taskRecord.currentNode
    toast("num: " .. nowNode["now"])
    if nowNode["now"] == "1" then --回长安
        return 2
    elseif nowNode["now"] == "2" then -- 检查人数
        return 2
    elseif nowNode["now"] == "3" then -- 打开活动面板
        return 2
    elseif nowNode["now"] == "4" then -- 查找任务并打开
        return 2
    elseif nowNode["now"] == "5" then -- 创建队伍
        return 2
    elseif nowNode["now"] == "6" then -- 调整等级
        return 2
    elseif nowNode["now"] == "7" then -- 等人
        return 2
    elseif nowNode["now"] == "8" then -- 打开活动面板
        return 2
    elseif nowNode["now"] == "9" then -- 查找任务并打开
        return 2
    elseif nowNode["now"] == "10" then -- 等钟馗
        return 2
    elseif nowNode["now"] == "11" then -- 领取任务
        return 2
    elseif nowNode["now"] == "12" then -- 检查提示
        return 2
    elseif nowNode["now"] == "13" then -- 找任务
        return 2
    elseif nowNode["now"] == "14" then -- 检查一轮鬼
        ret = Common.checkMainPage(1000, 5)
        if ret then
            return 13
        end

        return 14
    elseif nowNode["now"] == "15" then -- 检查次数
        return 15
    end
end

return Ghost
