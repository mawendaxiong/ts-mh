require('TSLib')
require('yunbiao.components')
Common = require('Common.index')
TaskBoard = require('renwuban.index')
local container = require('Main.state')
local escort = container.escort
local log = container.log
Escort = {}

-- 任务板找任务
function Escort.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('任务板查找任务异常', 'c2')
        mSleep(1000)
    end

    if TaskBoard.findTask() == -1 then -- 没有找到任务,那就是已经打完了
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)

        Common.blockCheckMainPage('提前结束运镖任务时页面异常')
        return -2
    end

    while true do
        if Common.userDialog() then
            break
        end -- 到达镖头
        coroutine.yield('等待去镖头', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

-- 执行运镖
function Escort.excute()
    while true do
        if Common.userDialog() then
            break
        end -- 到达镖头
        coroutine.yield('等待去镖头', 'c2')
        mSleep(1000)
    end

    while true do
        local ret, tim, x, y = escortButton() -- 运镖按钮
        if ret then
            tap(x, y)
            mSleep(1000)
            if enough50() then -- 活跃值不足50
                tap(473, 388) -- 点击取消
                Common.record('活跃不足50,执行下一个任务')

                Common.blockCheckMainPage('运镖结束时页面页面异常')
                wLog(log.name, '[DATE] 活跃不足50,无法运镖')
                return -2 -- 活跃不足50,直接结束
            end

            ret, tim, x, y = confirm() -- 确认运镖按钮
            if ret then
                -- 点击确认
                tap(x, y)
                mSleep(1000)
                escort.freq = escort.freq + 1
                Common.record('运镖: ' .. escort.freq)
                wLog(log.name, '[DATE] 第 ' .. escort.freq .. ' 次运镖')
            end
        elseif escort.freq == 3 then -- 运镖三次了
            Common.blockCheckMainPage('运镖结束时页面异常')

            escort.freq = 0 -- 清零,下一账号从0开始
            wLog(log.name, '[DATE] 3次运镖结束')
            wLog(log.name, '[DATE] 确认运镖是否清零: ' .. escort.freq)
            return -2
        elseif not yunbiaozhong() then -- 运镖中
            coroutine.yield('运镖中可能弹出了弹窗', 'c2')
            -- 没有运镖且不在主页
            if not Common.checkMainPage() then
                Common.closeWindow()
            end
        end
    end
end

function Escort.crashCallack()
    return 1
end
return Escort
