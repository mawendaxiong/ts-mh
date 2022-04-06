require("TSLib")

Common = require("Common.index")
TaskBoard = require("TaskBoard.index")

Lottery = {}

-- 检查刮刮乐有没有被开过
local function checkScratch()
    return findColorsUntil(0xa4a4a4, "74|43|0xa3a3a3", 90, 755, 423, 951, 513, {orient = 2}, 500, 1)
end

-- 检查是否刮完
local function checkScratchFinish()
    ret1 = isColor(621, 423, 0xe9bd7c)
    ret2 = isColor(869, 425, 0xe9bc7c)

    return ret1 and ret2
end
-- 打开福利
function Lottery.openWelfareBox()
    while (true) do
        if Common.checkMainPage() then
            break
        end
        Common.closeWindow()
        mSleep(1000)
    end
    -- 打开福利
    tap(37, 123)
    mSleep(1000)

    return 0
end

-- 打开刮刮乐
function Lottery.openScratch()
    ret, tim, x, y = checkScratch()
    if ret then
        -- 打开刮刮乐
        tap(867, 568)
        return 0
    end

    -- 已经刮奖了,结束
    return -2
end

-- 刮奖
function Lottery.Scratch()
    start = 332
    while true do
        moveTo(571, start, 920, start, 2, 50)
        if checkScratchFinish() then
            break
        end
        start = start + 24
        mSleep(1000)
    end

    return 0
end

-- 关闭窗口
function Lottery.close()
    while (true) do
        if Common.checkMainPage() then
            break
        end
        Common.closeWindow()
        mSleep(1000)
    end

    return -2
end

function Lottery.crashCallack()
    return 1
end

return Lottery
