require("TSLib")

Common = require("Common.index")

zhuzhan = {}

local function logo()
    return findColorsUntil(0xff2423,
                           "13|-21|0xfcaf45,24|9|0x872c10,10|13|0xfef3ea,-5|-13|0xce7b36",
                           90, 519, 557, 1135, 628, {orient = 2}, 500, 1)
end

-- 添加助战 棕色的加号
local function addLogo()
    return findColorsUntil(0x9b7554,
                           "-13|2|0x997352,14|0|0x967050,0|-12|0x997252,0|16|0x9a7453,17|17|0xb08758",
                           90, 577, 133, 994, 244, {orient = 2}, 500, 1)
end

-- 添加助战的绿色箭头
local function addHelper()
    return findColorsUntil(0x80f50c,
                           "-6|6|0x70e308,7|6|0x70e308,0|6|0x70e308,0|21|0x49b20c",
                           90, 135, 67, 226, 550, {orient = 2}, 500, 1)
end

-- 助战page
local function zhuzhanPage()
    return findColorsUntil(0xf88011,
                           '81|-12|0x8be5fe,167|1|0xf33a90,256|-8|0xa6c4ff,346|3|0xacd234',
                           90, 121, 562, 570, 622, {orient = 2}, 500, 1)
end

-- 打开助战
function zhuzhan.open()
    Common.blockCheckMainPage('首页打开助战异常')

    -- 展开选项
    if not logo() then
        tap(1101, 597)
        mSleep(3000)
    end

    -- 打开助战
    r, t, x, y = logo()
    if not r then
        Common.record('未开放助战功能')
        return -2
    end

    tap(x, y)

    while true do
        if zhuzhanPage() then break end
        coroutine.yield('打开助战页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 调整助战
function zhuzhan.adjust()
    while true do
        if zhuzhanPage() then break end
        coroutine.yield('打开助战页面异常', 'c2')
        mSleep(1000)
    end
    -- 选择第一个助战栏
    tap(962, 119)

    while (true) do
        r, t, x, y = addLogo()
        if r then
            tap(x, y)
            mSleep(2000)

            r, t, x, y = addHelper()
            tap(x, y)
            mSleep(1000)
        else
            -- 关闭助战
            tap(1008, 46)
            break
        end
    end

    Common.blockCheckMainPage('关闭助战异常')
    return -2
end

function zhuzhan.crashCallack() return 1 end
return zhuzhan
