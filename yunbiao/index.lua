require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

Escort = {}

-- 活跃值不足50点
local function enough50()
    offset =
        "1|11|0x8d5d2c,6|10|0x8d5d2c,9|5|0xede0cf,12|7|0x8d5d2c,25|0|0x8d5d2c,23|15|0x8d5d2c"
    return findColorsUntil(0x8d5d2c, offset, 90, 361, 212, 775, 349,
                           {orient = 2}, 500, 2)
end
-- 押送按钮
local function escortButton()
    offset =
        "0|3|0xf2d8b6,7|3|0x553923,8|17|0x5f432b,26|11|0x553923,28|8|0xeccfaa,37|17|0x654930"
    return findColorsUntil(0x5a3e28, offset, 90, 816, 264, 1106, 454,
                           {orient = 2}, 500, 2)
end

-- 确认运镖
local function confirm()
    offset = "-123|-62|0xb3b3b3,-112|-63|0x77777f,-118|-55|0x84a6b3"
    return findColorsUntil(0xf1c868, offset, 90, 360, 239, 760, 401,
                           {orient = 2}, 500, 2)
end

-- 运镖中的地图s
local function yunbiaozhong()
    offset =
        '-7|0|0xfbe8c3,0|7|0xf7ddb9,1|16|0xe39505,-13|-1|0xf3b00b,0|-13|0xfac125,13|0|0xf0ac0a,-6|13|0xf5b909'
    return findColorsUntil(0xf1c868, offset, 90, 103, 17, 1044, 618,
                           {orient = 2}, 500, 2)
end

-- 任务板找任务
function Escort.findTaskOnTaskBoard()

    if TaskBoard.findTask() == -1 then -- 没有找到任务,那就是已经打完了
        coroutine.yield('任务板可能被弹窗挡住了', 'c2')
        if TaskBoard.findTask() == -1 then -- 二次确认
            -- 关闭活动板
            tap(1014, 43)
            mSleep(1000)

            return -2
        end
    end
    -- 执行下一步
    return 0
end

-- 等待郑镖头
function Escort.waitLeader()

    if not Common.userDialog(1000, 10) then -- 没出现郑镖头对话框

        coroutine.yield('郑镖头对话框可能被弹窗挡住了', 'c2')
        if not Common.userDialog() then return 2 end -- 二次确认,还是没有就从打开任务板开始
    end

    -- 执行下一步
    return 0
end

-- 执行运镖
function Escort.excute()
    freq = 0 -- 统计运镖次数
    while true do
        ret, tim, x, y = escortButton() -- 运镖按钮
        if ret then
            tap(x, y)
            mSleep(1000)
            if enough50() then -- 活跃值不足50
                Common.record("活跃不足50,执行下一个任务")
                mSleep(2000)
                return -2 -- 活跃不足50,直接结束
            end

            ret, tim, x, y = confirm() -- 确认运镖按钮
            if ret then
                -- 点击确认
                tap(x, y)
                mSleep(1000)
                freq = freq + 1
                Common.record("运镖: " .. freq)
            end
        elseif not yunbiaozhong() then -- 运镖中
            coroutine.yield('运镖中可能弹出了弹窗', 'c2')
            -- 没有运镖且不在主页
            if not Common.checkMainPage() then Common.closeWindow() end
        elseif freq == 3 and Common.checkMainPage() then -- 运镖三次了
            return -2
        end
    end
end

function Escort.crashCallack() return 2 end
return Escort
