require("TSLib")

Common = require("Common.index")

zhuzhan = {}

local function logo()
    return findColorsUntil(
        0xff2423,
        "13|-21|0xfcaf45,24|9|0x872c10,10|13|0xfef3ea,-5|-13|0xce7b36",
        90,
        519,
        557,
        1135,
        628,
        {orient = 2},
        500,
        1
    )
end

-- 添加助战 棕色的加号
local function addLogo()
    return findColorsUntil(
        0x9b7554,
        "-13|2|0x997352,14|0|0x967050,0|-12|0x997252,0|16|0x9a7453,17|17|0xb08758",
        90,
        577,
        133,
        994,
        244,
        {orient = 2},
        500,
        1
    )
end

-- 添加助战的绿色箭头
local function addHelper()
    return findColorsUntil(
        0x80f50c,
        "-6|6|0x70e308,7|6|0x70e308,0|6|0x70e308,0|21|0x49b20c",
        90,
        135,
        67,
        226,
        550,
        {orient = 2},
        500,
        1
    )
end

-- 打开助战
function zhuzhan.open()
    r, t, x, y = logo()
    -- 展开选项
    if not r then
        tap(1101, 597)
        mSleep(3000)
    end

    -- 打开助战
    r, t, x, y = logo()
    tap(x, y)

    return 0
end

-- 调整助战
function zhuzhan.adjust()
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
            return -2
        end
    end
end

function zhuzhan.crashCallack()
    return 1
end
return zhuzhan
