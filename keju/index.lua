require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

keju = {}

local function penLogo()
    offset = "9|-8|0xab652e,14|-16|0xa9632e"
    return findColorsUntil(0xac662e, offset, 90, 426, 123, 466, 166,
                           {orient = 2}, 500, 1)
end

local function kejuPage()
    offset =
        '9|0|0xf4f114,106|118|0x6c310a,129|118|0x6d320b,48|122|0x6c310a,53|115|0x6c310a'
    return findColorsUntil(0xac662e, offset, 90, 155, 416, 359, 588,
                           {orient = 2}, 500, 1)
end

-- 检查时间是否到达下午5点
function keju.checkTime()
    -- 获取当前时间
    nowTime = getNetTime()
    -- 获取当前的小时
    nowHour = os.date("%H", nowTime)
    -- 还没到下午5点,结束
    if tonumber(nowHour) < 17 then return -2 end

    return 0
end

-- 任务板找任务
function keju.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then break end
        coroutine.yield('查找科举任务异常', 'c2')
        mSleep(1000)
    end

    ret = TaskBoard.findTask()

    -- 没有找到任务,那就是已经打完了
    if ret == -1 then
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)

        Common.blockCheckMainPage('科举提前结束异常')
        return -2
    end

    while true do
        if kejuPage() then break end
        coroutine.yield('科举准备答题异常', 'c2')
        mSleep(1000)
    end
    -- 执行下一步
    return 0
end

-- 答题
function keju.answer()
    while true do
        if kejuPage() then break end
        coroutine.yield('科举准备答题异常', 'c2')
        mSleep(1000)
    end

    while true do
        -- 有笔的logo
        if penLogo() then
            -- 点击第一个选项
            tap(587, 333)
            mSleep(1500)
        else
            break
        end
    end

    -- 关闭科举界面
    tap(1013, 140)
    mSleep(1000)

    Common.blockCheckMainPage('科举结束异常')
    -- 说明科举完毕
    return -2
end

function keju.crashCallack() return 1 end

return keju
