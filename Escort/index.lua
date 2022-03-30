require("TSLib")

Common = require("Common.index")
TaskBoard = require("TaskBoard.index")

Escort = {}

-- 活跃值不足50点
local function enough50()
    offset = "1|11|0x8d5d2c,6|10|0x8d5d2c,9|5|0xede0cf,12|7|0x8d5d2c,25|0|0x8d5d2c,23|15|0x8d5d2c"
    return findColorsUntil(0x8d5d2c, offset, 90, 361, 212, 775, 349, {orient = 2})
end
-- 押送按钮
local function escortButton()
    offset = "0|3|0xf2d8b6,7|3|0x553923,8|17|0x5f432b,26|11|0x553923,28|8|0xeccfaa,37|17|0x654930"
    return findColorsUntil(0x5a3e28, offset, 90, 816, 264, 1106, 454, {orient = 2})
end

-- 确认运镖
local function confirm()
    offset = "-123|-62|0xb3b3b3,-112|-63|0x77777f,-118|-55|0x84a6b3"
    return findColorsUntil(0xf1c868, offset, 90, 360, 239, 760, 401, {orient = 2}, 500, 10)
end

-- 任务板找任务
function Escort.findTaskOnTaskBoard()
    ret = TaskBoard.findTask()

    -- 没有找到任务,那就是已经打完了
    if ret == -1 then
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)
        
        return -2
    end
    -- 执行下一步
    return 0
end

-- 等待郑镖头
function Escort.waitLeaderZheng()
    ret, tim, x, y = Common.userDialog()
    -- 没出现郑镖头对话框
    if not ret then
    -- todo 没出现怎么处理
    end
    -- 执行下一步
    return 0
end

-- 执行运镖
function Escort.excute()
    freq = 0
    while true do
        ret, tim, x, y = escortButton()
        if ret then
            tap(x, y)
            mSleep(1000)
            if enough50() then
                Common.record("活跃不足50,执行下一个任务")
                return -2
            end
            ret, tim, x, y = confirm()
            if ret then
                -- 点击确认
                tap(x, y)
                mSleep(1000)
                freq = freq + 1
                Common.record("运镖: " .. freq)
            end
        else
            -- 没有运镖且不在主页
            if not Common.checkMainPage() then
                Common.closeWindow()
            end
        end
        -- 一天只能运3次镖
        if freq == 3 then
            fwCloseView("recordBoard", "record")
            break
        end
    end

    -- 等待出现主页
    while true do
        ret = Common.checkMainPage()
        if ret then
            break
        end
        mSleep(1000)
    end

    return -2
end

function Escort.crashCallack()
    return 2
end
return Escort
