require('TSLib')
require('zhuogui.components')
Common = require('Common.index')
TaskBoard = require('renwuban.index')
timer = require('Common.timer')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local globalGhost = container.globalGhost

Ghost = {}

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

-- 等待加入队伍
function Ghost.waitTeam()
    while true do
        if Common.easyGroupPage() then
            break
        end
        coroutine.yield('混队捉鬼等待加入队伍异常', 'c2')
        mSleep(1000)
    end

    tap(684, 584) -- 点击自动匹配
    timer.start(300)
    while true do
        Common.record('混队倒计时: ' .. timer.detail())

        if Common.checkBattle() then -- 正在战斗,加入队伍成功
            return 0
        elseif timer.check() then -- 时间到了
            if Common.easyGroupPage() then
                tap(684, 584) -- 取消自动匹配
                mSleep(1000)
            end
            break
        elseif TaskBoard.checkTaskBoard() then -- 任务板界面
            tap(1014, 43) -- 关闭任务板
            mSleep(1000)
        elseif Common.teamPage() then -- 组队的页面
            tap(981, 39) -- 关闭组队页面
            mSleep(1000)
        elseif watchBattle() then -- 正在观战
            if not checkGhostBattle() then -- 观战的不是鬼,说明带队的人不是在捉鬼
                battleQuitTeam() -- 战斗中退出队伍
            end
            tap(1109, 585) -- 退出观战
            mSleep(1000)

            Common.blockCheckMainPage('退出观战页面异常')
            return 2
        elseif Common.easyGroupPage() then -- 便捷组队页面不做处理
        elseif Common.checkMainPage() then -- 首页不做处理
        else
            coroutine.yield('混队捉鬼,等队伍页面异常', 'c2')
        end
    end

    while true do
        if Common.easyGroupPage() then
            break
        end -- 便捷组队页面
        coroutine.yield('混队捉鬼组队超时无法关闭页面', 'c2')
        mSleep(1000)
    end

    -- 关闭便捷组队页面
    tap(1015, 44)

    -- 无限等待捉鬼
    if UISetting.ghost.waitTeamTime == nil then
        -- 重新在任务板查找任务
        return 3
    end

    Common.blockCheckMainPage('混队捉鬼组队失败')

    -- 结束捉鬼了
    return -2
end

-- 检查战斗状态
function Ghost.checkBattleStatus()
    while true do
        if Common.checkBattle() then
            break
        end
        coroutine.yield('混队捉鬼检查状态异常', 'c2')
        mSleep(1000)
    end

    -- 主页面倒计时
    local mainPageTime = 60

    -- 捉鬼完成
    local isDone = false
    local isCount = false

    while true do
        if not Common.checkBattle() then -- 不在战斗
            isCount = false
            -- 在主页
            if Common.checkMainPage() then
                -- 终止,可能是捉完鬼,也可能是捉的不是鬼而退出
                if isDone then
                    --  够数,执行下一步
                    return 0
                end

                mainPageTime = mainPageTime - 1
                Common.record('主页面: ' .. mainPageTime)

                if mainPageTime <= 1 then
                    break
                end
            else
                -- 关闭弹窗
                coroutine.yield('混队捉鬼战斗中页面异常', 'c2')
            end
        else
            if not isDone then
                -- 打的不是鬼
                if not checkGhostBattle() then
                    isDone = true
                    toast('不是在捉鬼!!')
                    -- 战斗中退出队伍
                    battleQuitTeam()
                end

                if not isCount then
                    -- 捉鬼次数加1
                    globalGhost['ghostNum'] = globalGhost['ghostNum'] + 1
                    Common.record('鬼: ' .. globalGhost['ghostNum'])
                    isCount = true
                end

                -- 等于捉完这一只就够了
                if globalGhost['ghostNum'] == UISetting.g2 then
                    isDone = true
                    -- 战斗中退出队伍
                    battleQuitTeam()
                end

                mainPageTime = 60
            end
        end

        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

-- 统计捉鬼次数
function Ghost.checkGhostNum()
    Common.blockCheckMainPage('统计捉鬼次数页面异常')

    if globalGhost['ghostNum'] < UISetting.g2 then
        Common.commonOpenGroup()
        ret, tim, x, y = Common.quitTeam()
        if ret then
            -- 退出队伍
            tap(x, y)
            mSleep(1000)
        end

        tap(981, 39) -- 关闭组队页面
        mSleep(1000)

        Common.blockCheckMainPage('混队捉鬼重新找队伍异常')
        -- 返回 [便捷组队]
        return 2
    end

    Common.blockCheckMainPage('混队捉鬼结束时页面异常')

    toast('结束捉鬼')
    return -2
end

function Ghost.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('混队捉鬼查找任务异常', 'c2')
        mSleep(1000)
    end

    while true do
        if TaskBoard.findTask() == 0 then
            break
        end
        coroutine.yield('混队捉鬼的任务板被弹窗挡住了', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
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
    crashNode = taskRecord.crashNode
    toast('crash num: ' .. crashNode['now'], 3)
    mSleep(3000)
    crashStep = tonumber(crashNode['now'])

    if crashStep <= 3 then
        return 1
    elseif crashStep == 4 then
        while true do
            if Common.checkBattle() then
                return 5
            elseif Common.checkMainPage() then
            end
        end
    end
    if nowNode['now'] == '1' then -- 回长安
        return 2
    elseif nowNode['now'] == '2' then -- 打开队伍
        return 2
    elseif nowNode['now'] == '3' then -- 打开便捷组队
        return crashAfter()
    elseif nowNode['now'] == '4' then -- 等待加入队伍
        return crashAfter()
    elseif nowNode['now'] == '5' then -- 检查状态
        return crashAfter()
    elseif nowNode['now'] == '6' then -- 检查战斗状态
        return 6
    elseif nowNode['now'] == '7' then -- 统计捉鬼次数
        return 7
    end
end

return Ghost
