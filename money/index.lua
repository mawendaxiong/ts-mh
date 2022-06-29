require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

money = {}

--  人物属性
local function statusPage()
    offset =
        '39|112|0x48301e,36|249|0x48301e,37|344|0x48301e,47|345|0x48301e,40|368|0x48301e,-49|186|0x936324'
    return findColorsUntil(0xce0000, offset, 90, 891, 7, 1046, 493,
                           {orient = 2}, 500, 1)
end

-- 使用活力的详细页面
local function useDetailPage()
    offset =
        '-234|103|0xf7f722,-227|215|0x73dd37,-245|281|0xd5eedd,23|119|0xedbf5f'
    return findColorsUntil(0x875832, offset, 90, 572, 88, 929, 565,
                           {orient = 2}, 500, 1)
end

function money.openUserTab()
    Common.blockCheckMainPage('打开任务属性异常')

    tap(1108, 27) -- 打开任务属性

    while true do
        if statusPage() then break end
        coroutine.yield('打开人物属性面板异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function money.openDetailTab()
    while true do
        if statusPage() then break end
        coroutine.yield('打开人物属性面板异常', 'c2')
        mSleep(1000)
    end

    tap(918, 239) -- 打开活力使用详细面板

    while true do
        if useDetailPage() then break end
        coroutine.yield('使用活力页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function money.use()
    while true do
        if useDetailPage() then break end
        coroutine.yield('使用活力页面异常', 'c2')
        mSleep(1000)
    end
    
end

-- 闪退补偿
function money.crashCallack() return 1 end

return money
