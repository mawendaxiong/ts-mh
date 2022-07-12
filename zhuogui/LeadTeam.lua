require('TSLib')
require('zhuogui.components')

Common = require('Common.index')
timer = require('Common.timer')
local container = require('Main.state')
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

    -- 说明还没足够3个人
    if count < 3 then
        return 0
    end
    return 1
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
    while true do
        if Common.teamPage() then
            break
        end
        coroutine.yield('调整等级,但页面异常', 'c2')
        mSleep(1000)
    end

    -- 打开调整等级
    tap(757, 101)
    mSleep(1000)

    while true do
        if fixLevelPage() then
            break
        end
        coroutine.yield('调整等级,但页面异常', 'c2')
        mSleep(1000)
    end

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
        end,
        nil,
        function()
            return fixLevelPage()
        end
    )

    while true do
        if fixLevelPage() then
            break
        end
        coroutine.yield('调整等级,但页面异常', 'c2')
        mSleep(1000)
    end

    -- 确定
    tap(654, 585)
    mSleep(1000)

    while true do
        if Common.teamPage() then
            break
        end
        coroutine.yield('调整等级,但页面异常', 'c2')
        mSleep(1000)
    end
    return 0
end

-- 等人
function Ghost.waitTeamMember()
    -- 等人
    while true do
        if not Common.teamPage() then
            coroutine.yield('带队捉鬼等人页面异常', 'c2')
        end
        if checkMinPeople() == 1 then
            break
        end -- 组够人了
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
    -- 没有出现钟馗的对话框
    if not Common.userDialog(1000, 10) then
        coroutine.yield('带队捉鬼钟馗领取任务页面异常', 'c2')
        if not Common.userDialog(1000, 10) then -- 再次确认有没有钟馗的对话框
            -- 执行 [回长安]
            return 1
        end
    end
    -- 执行下一步
    return 0
end

-- 获取任务
function Ghost.getTask()
    while true do
        if Common.userDialog() then
            break
        end
        coroutine.yield('钟馗领取任务界面异常1', 'c2')
    end

    while true do
        ret, tim, x, y = ghostTask()
        if ret then
            break
        end
        coroutine.yield('钟馗领取任务界面异常2', 'c2')
        mSleep(1000)
    end

    tap(x, y)
    mSleep(1000)

    -- 执行下一步
    return 0
end

-- 检查提示
function Ghost.checkTip()
    timer.start(5)
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

        if timer.check() then
            break
        end
        mSleep(1000)
    end

    -- 关闭钟馗的对话框
    tap(1, 1)
    mSleep(1000)
    -- 执行下一步
    return 0
end

-- 查找任务
function Ghost.findTask()
    while true do
        if Common.checkMainPage() then
            break
        end
        coroutine.yield('带队捉鬼找任务页面异常', 'c2')
        mSleep(1000)
    end

    -- 激活右侧任务tab
    if not isColor(931, 122, 0xcde5ac, 100) then
        tap(931, 122)
        mSleep(1000)
    end

    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        if not Common.checkMainPage() then
            coroutine.yield('带队捉鬼找任务页面异常', 'c2')
        end
        ret, tim, x, y = Common.redCancle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    r, t, x, y = ghostTaskGuide()
    if r then
        tap(x, y)
        -- 执行下一步
        return 0
    else
        -- 先重置右侧任务栏
        Common.resetRightTaskBoard()

        Common.move(
            function()
                r, t, x, y = ghostTaskGuide()
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
            end,
            function()
                return Common.checkMainPage()
            end
        )

        return 0
    end
end

-- 检查一轮鬼结束
function Ghost.checkRoundOver()
    if globalGhost['ghostNum'] == nil then
        globalGhost['ghostNum'] = 0
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
                Common.record('主页面: ' .. mainPageTime)

                if mainPageTime <= 1 then
                    break
                end
            else
                ret = roundOverTip()
                if ret then -- 一轮鬼结束
                    toast('round over!!')
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
                globalGhost['ghostNum'] = globalGhost['ghostNum'] + 1
                Common.record('鬼: ' .. globalGhost['ghostNum'])
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
    collectgarbage('collect')
    num = globalGhost['ghostNum']
    if num < UISetting.g1 then
        -- collectgarbage("collect")
        return 1
    end

    toast('结束捉鬼')
    return -2
end

-- 检查队伍人数
function Ghost.checkTeamMember()
    Common.blockCheckMainPage('带队捉鬼打开队伍页面异常')

    -- 打开组队
    Common.commonOpenGroup()

    local isMinPeople = checkMinPeople()

    -- 说明还不够3个人
    if isMinPeople == 0 then
        ret, tim, x, y = Common.quitTeam() -- 检查是有队伍
        if ret then
            -- 退出队伍
            tap(209, 582)
            mSleep(1000)
        end
    end

    tap(982, 39) -- 关闭组队界面
    mSleep(1000)

    Common.blockCheckMainPage('带队捉鬼组人异常')
    return 0 -- 接着打开任务板
end

-- 打开便捷组队
function Ghost.simpleGroup()
    while true do
        if Common.easyGroupPage() then
            break
        end
        coroutine.yield('混队捉鬼等待加入队伍异常', 'c2')
        mSleep(1000)
    end

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
            local p2 = getColor(713, 226)
            local p3 = getColor(723, 227)
            local p4 = getColor(723, 212)
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

function Ghost.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('带队捉鬼查找任务异常', 'c2')
        mSleep(1000)
    end

    while true do
        if TaskBoard.findTask() == 0 then
            break
        end
        coroutine.yield('带队捉鬼的任务板被弹窗挡住了', 'c2')
        mSleep(1000)
    end

    while true do
        if Common.easyGroupPage() then
            break
        end
        coroutine.yield('带队捉鬼等待加入队伍异常', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

function Ghost.getTaskOrWaitMember()
    while true do
        if Common.easyGroupPage() then -- 便捷组队页面
            tap(465, 584) -- 创建队伍
            mSleep(1000)

            while true do
                if Common.teamPage() then
                    break
                end
                coroutine.yield('带队捉鬼创建队伍异常', 'c2')
                mSleep(1000)
            end

            return 0
        elseif Common.userDialog() then -- 钟馗的对话框
            return 10 -- 领取任务
        else
            coroutine.yield('带队捉鬼页面异常', 'c2')
        end
        mSleep(1000)
    end
end

function Ghost.crashCallack()
    nowNode = taskRecord.currentNode
    toast('num: ' .. nowNode['now'])
    if nowNode['now'] == '1' then -- 回长安
        return 2
    elseif nowNode['now'] == '2' then -- 检查人数
        return 2
    elseif nowNode['now'] == '3' then -- 打开活动面板
        return 2
    elseif nowNode['now'] == '4' then -- 查找任务并打开
        return 2
    elseif nowNode['now'] == '5' then -- 创建队伍
        return 2
    elseif nowNode['now'] == '6' then -- 调整等级
        return 2
    elseif nowNode['now'] == '7' then -- 等人
        return 2
    elseif nowNode['now'] == '8' then -- 打开活动面板
        return 2
    elseif nowNode['now'] == '9' then -- 查找任务并打开
        return 2
    elseif nowNode['now'] == '10' then -- 等钟馗
        return 2
    elseif nowNode['now'] == '11' then -- 领取任务
        return 2
    elseif nowNode['now'] == '12' then -- 检查提示
        return 2
    elseif nowNode['now'] == '13' then -- 找任务
        return 2
    elseif nowNode['now'] == '14' then -- 检查一轮鬼
        ret = Common.checkMainPage(1000, 5)
        if ret then
            return 13
        end

        return 14
    elseif nowNode['now'] == '15' then -- 检查次数
        return 15
    end
end

return Ghost
