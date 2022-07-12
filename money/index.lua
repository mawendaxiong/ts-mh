require('TSLib')
require('money.components')
local Common = require('Common.index')
local TaskBoard = require('renwuban.index')

local money = {}

function money.openUserTab()
    Common.blockCheckMainPage('打开任务属性异常')

    tap(1108, 27) -- 打开任务属性

    while true do
        if statusPage() then
            break
        end
        coroutine.yield('打开人物属性面板异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function money.openDetailTab()
    while true do
        if statusPage() then
            break
        end
        coroutine.yield('打开人物属性面板异常', 'c2')
        mSleep(1000)
    end

    tap(918, 239) -- 打开活力使用详细面板

    while true do
        if useDetailPage() then
            break
        end
        coroutine.yield('使用活力页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function money.use()
    while true do
        if useDetailPage() then
            break
        end
        coroutine.yield('使用活力页面异常', 'c2')
        mSleep(1000)
    end

    for i = 1, 30, 1 do
        tap(860, 235)
    end
    return -2
end

-- 闪退补偿
function money.crashCallack()
    return 1
end

return money
