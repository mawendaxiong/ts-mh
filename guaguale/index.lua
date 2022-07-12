require('TSLib')
require('guaguale.components')
Common = require('Common.index')
TaskBoard = require('renwuban.index')

Lottery = {}

-- 检查是否刮完
local function checkScratchFinish()
    local ret1 = isColor(621, 423, 0xe9bd7c)
    local ret2 = isColor(869, 425, 0xe9bc7c)

    return ret1 and ret2
end
-- 打开福利
function Lottery.openWelfareBox()
    Common.blockCheckMainPage('打开福利异常')

    -- 打开福利
    tap(37, 123)
    mSleep(1000)

    while true do
        if fuliPage() then
            break
        end
        coroutine.yield('福利页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 打开刮刮乐
function Lottery.openScratch()
    while true do
        if fuliPage() then
            break
        end
        coroutine.yield('福利页面异常', 'c2')
        mSleep(1000)
    end

    if checkScratch() then
        tap(867, 568) -- 打开刮刮乐

        while true do
            if guagualePage() then
                break
            end
            coroutine.yield('刮刮乐页面异常', 'c2')
            mSleep(1000)
        end
        return 0
    end

    tap(961, 71) -- 关闭福利

    Common.blockCheckMainPage('福利页面异常')

    -- 已经刮奖了,结束
    return -2
end

-- 刮奖
function Lottery.Scratch()
    local start = 332
    while true do
        if not guagualePage() then
            coroutine.yield('刮奖页面异常', 'c2')
        else
            moveTo(571, start, 920, start, 2, 50)
            if checkScratchFinish() then
                break
            end
            start = start + 24
        end

        mSleep(1000)
    end

    while true do
        if guagualePage() then
            break
        end
        coroutine.yield('刮刮乐结束时页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 关闭窗口
function Lottery.close()
    while true do
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
