require('TSLib')
require('sanjie.components')
local Common = require('Common.index')
local TaskBoard = require('renwuban.index')

local sanjie = {}

-- 检查时间是否到达下午5点
function sanjie.checkTime()
    -- 获取当前时间
    local nowTime = getNetTime()
    -- 获取当前的小时
    local nowHour = os.date('%H', nowTime)
    -- 还没到11点,结束
    if tonumber(nowHour) < 11 then
        return -2
    end

    return 0
end

-- 任务板找任务
function sanjie.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('三界奇缘查找任务异常', 'c2')
        mSleep(1000)
    end
    local ret = TaskBoard.findTask()

    -- 没有找到任务,那就是已经打完了
    if ret == -1 then
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)
        -- 三界结束
        Common.blockCheckMainPage('三界奇缘提前结束异常')
        return -2
    end

    while true do
        if sanjiePage() then
            break
        end
        coroutine.yield('三界奇缘页面异常', 'c2')
        mSleep(1000)
    end
    -- 执行下一步
    return 0
end

-- 答题
function sanjie.answer()
    while true do
        if sanjiePage() then
            break
        end
        coroutine.yield('三界奇缘页面异常', 'c2')
        mSleep(1000)
    end

    while (true) do
        if finish() then
            break
        else
            -- 点击三界奇缘第一个选项
            tap(445, 224)
            mSleep(1500)
        end
    end

    -- 关闭三界界面
    tap(1007, 91)
    mSleep(1000)

    Common.blockCheckMainPage('三界奇缘结束异常')
    return -2
end

function sanjie.crashCallack()
    return 1
end
return sanjie
