require("TSLib")

Common = require("Common.index")

jineng = {}

local function logo()
    return findColorsUntil(0x4db7e5,
                           "-4|14|0x30b5ef,0|28|0x2554c2,10|15|0x3266c7,-9|2|0x4ebce6",
                           90, 426, 564, 1064, 630, {orient = 2}, 500, 1)
end

-- 技能页面
local function jinengPage()
    offset =
        '-466|-16|0x764a2c,-429|-12|0x764a2c,-409|-20|0x764a2c,-281|526|0xebb151,-70|530|0xda8643'
    return findColorsUntil(0xce0000, offset, 90, 102, 20, 1035, 628,
                           {orient = 2}, 500, 1)
end

-- 打开技能
function jineng.open()
    Common.blockCheckMainPage('打开技能板时页面异常')

    r, t, x, y = logo()
    -- 展开选项
    if not r then
        tap(1101, 597)
        mSleep(3000)
    end

    -- 打开技能
    r, t, x, y = logo()
    -- 说明还没开技能,退出
    if not r then return -2 end
    tap(x, y)

    while true do
        if jinengPage() then break end
        coroutine.yield('技能页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 升级技能
function jineng.sj()

    while true do
        if jinengPage() then break end
        coroutine.yield('技能页面异常', 'c2')
        mSleep(1000)
    end

    -- 点击人物技能
    tap(1017, 163)
    mSleep(1500)

    -- 随机次数点击一键升级
    r = math.random(2, 4)
    for var = 1, r do
        tap(881, 569)
        mSleep(1000)
    end

    -- 关闭技能对话框
    tap(980, 43)

    Common.blockCheckMainPage('技能结束时页面异常')
    return -2
end

function jineng.crashCallack() return 1 end

return jineng
