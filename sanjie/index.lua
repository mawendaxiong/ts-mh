require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

sanjie = {}

-- 三界奇缘结束
local function finish()
    offset = "-9|-16|0xbb9955,6|51|0xffeedd,13|73|0xff9977"
    return findColorsUntil(0xbb66aa, offset, 90, 604, 102, 804, 272,
                           {orient = 2}, 500, 1)
end

-- 三界奇缘的页面
local function sanjiePage()
    offset =
        '28|3|0x9e5811,52|4|0x9e5811,68|-2|0x9e5811,95|6|0x9e5811,111|-2|0xa3601b,149|5|0xd3a981'
    return findColorsUntil(0xd2a780, offset, 90, 190, 415, 388, 476,
                           {orient = 2}, 500, 1)
end

-- 检查时间是否到达下午5点
function sanjie.checkTime()
    -- 获取当前时间
    nowTime = getNetTime()
    -- 获取当前的小时
    nowHour = os.date("%H", nowTime)
    -- 还没到11点,结束
    if tonumber(nowHour) < 11 then return -2 end

    return 0
end

-- 任务板找任务
function sanjie.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then break end
        coroutine.yield('三界奇缘查找任务异常', 'c2')
        mSleep(1000)
    end
    ret = TaskBoard.findTask()

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
        if sanjiePage() then break end
        coroutine.yield('三界奇缘页面异常', 'c2')
        mSleep(1000)
    end
    -- 执行下一步
    return 0
end

-- 答题
function sanjie.answer()
    while true do
        if sanjiePage() then break end
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

function sanjie.crashCallack() return 1 end
return sanjie
