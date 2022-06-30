-- 月亮石
local function yueliangshi_bag()
    offset = '-24|-7|0x99ddff,-7|-26|0x22bbee,-8|8|0xaa66ff'
    return findColorsUntil(0x3322bb, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 太阳石
local function taiyangshi_bag()
    offset = '-5|14|0xff3388,-15|21|0xff2255,3|31|0xcc0033'
    return findColorsUntil(0xffaaaa, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 昆仑玉
local function kunlunyu_bag()
    offset = '6|24|0xffdd99,-8|3|0xffffff,3|26|0xffffff'
    return findColorsUntil(0xffdd88, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 光芒石
local function guangmangshi_bag()
    offset = '-8|-8|0x11eeff,-23|-15|0x88ffff,-24|10|0x33aadd'
    return findColorsUntil(0x11bbff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 舍利子
local function shelizi_bag()
    offset = '24|-22|0xeeee11,33|-1|0xddee11,40|-8|0x448811'
    return findColorsUntil(0xeeee11, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 翡翠石
local function feicuishi_bag()
    offset = '-4|12|0x44cc77,-26|21|0x44bb66,-13|1|0xffffff'
    return findColorsUntil(0x55cc88, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 黑宝石
local function heibaoshi_bag()
    offset = '-39|2|0x332233,-6|-27|0xeeeeee,-9|16|0x776688'
    return findColorsUntil(0x443344, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 红纹石
local function hongwenshi_bag()
    offset = '18|0|0xdd2255,-16|17|0xcc2233,-27|2|0xffffff'
    return findColorsUntil(0xffccff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 神秘石
local function shenmieshi_bag()
    offset = '-22|4|0xffbbee,-22|22|0x7766bb,-39|-3|0x9944bb'
    return findColorsUntil(0xaa22bb, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 九转金丹
local function jiuzhuan_bag()
    offset = '12|12|0xcc881c,23|-5|0xdd3311,-6|29|0xeeb033'
    return findColorsUntil(0xffffff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 修炼果
local function xiulianguo_bag()
    offset = '21|-15|0xcc7700,-3|-23|0xffffee,-11|-3|0xcc7700'
    return findColorsUntil(0xcc7706, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-- 聚灵仙饮
local function juling_bag()
    offset = '14|-4|0xffff17,28|3|0xff9911,23|-19|0xffffff'
    return findColorsUntil(0x44aad7, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 鬼谷子
local function guiguzi_bag()
    offset = '-10|15|0x33ffee,3|20|0x22ddcc,15|1|0x11ccbb'
    return findColorsUntil(0x22eedd, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 百炼精铁
local function jingtie_bag()
    offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 心魔宝珠
local function xinmobaozhu()
    offset =
        '10|20|0x33116c,-15|24|0xf439f9,-23|36|0x331166,-30|16|0x444add,-1|1|0x3339c6'
    return findColorsUntil(0x4433b5, offset, 85, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-- 青龙石
local function qinglongshi()
    offset = '11|19|0x229933,11|34|0x229933,-13|36|0x119922'
    return findColorsUntil(0x88ee77, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 白虎石
local function baihushi()
    offset = '3|36|0x888888,-20|27|0xffffff,15|6|0xaaaaaa'
    return findColorsUntil(0xeeeedd, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 朱雀石
local function zhuqueshi()
    offset = '-1|17|0xdd3322,15|30|0xcc2233,10|11|0xdd3322'
    return findColorsUntil(0xdd4422, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 阵法残卷
local function canjuan()
    offset = '-31|4|0x991d11,-25|31|0xb61111,-23|47|0x773322,3|0|0xcc9e66'
    return findColorsUntil(0xd1aa6b, offset, 85, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-- 玄武石
local function xuanwushi()
    offset = '24|1|0x2255aa,-4|27|0x2288ee,-9|-9|0xbbeeff'
    return findColorsUntil(0x3399dd, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

---------------------------以下是商会------------------------------

-- 百炼精铁(商会)
local function jingtie_market()
    offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 黑宝石(商会)
local function heibaoshi_market()
    offset = '41|0|0x373344,14|16|0x332f40,36|-25|0xeae1ee'
    return findColorsUntil(0x2f2f37, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 翡翠石(商会)
local function feicuishi_market()
    offset = '15|4|0x55cc7b,22|38|0x91f799,-3|23|0x37bb66'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 舍利子(商会)
local function shelizi_market()
    offset = '7|22|0xe5ea11,-27|23|0xeaee11,-35|21|0xfbfbd5'
    return findColorsUntil(0xeaee15, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 光芒石(商会)
local function guangmangshi_market()
    offset = '6|-16|0x11eeff,-19|-22|0xfbffff,-20|-4|0x88fbff'
    return findColorsUntil(0x0962fb, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 月亮石(商会)
local function yueliangshi_market()
    offset = '-21|-26|0xffffff,-28|4|0x443ca1,-6|8|0xaa65f7'
    return findColorsUntil(0x2c29aa, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 神秘石(商会)
local function shenmishi_market()
    offset = '23|-20|0xae22bf,-8|-31|0xa133b7,11|-20|0xffeaf7'
    return findColorsUntil(0x7b48aa, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 红纹石(商会)
local function hongwenshi_market()
    offset = '-10|28|0x99446a,19|-2|0xc84095,2|13|0xaa1111'
    return findColorsUntil(0xfbaeea, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 太阳石(商会)
local function taiyangshi_market()
    offset = '-7|34|0xff3362,8|4|0xffeaee,25|19|0xff626f'
    return findColorsUntil(0xffae91, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
local function kunlunyu_market()
    offset = '19|15|0xffdda0,9|-8|0xfffeaa,8|19|0xfffffe'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 鬼谷子(商会)
local function guiguzi_market()
    offset = '10|12|0x264462,-7|-7|0x26fbf7,-17|17|0x44c8c8'
    return findColorsUntil(0x26f2ea, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 锻造册(商会)
local function duanzaoce_market()
    offset = '4|-21|0xc32226,-17|8|0xd0222b,-35|-8|0xb72226'
    return findColorsUntil(0x912f15, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end
-- 月华露(商会)
local function yuehualu_market()
    offset = '-25|9|0xccf26f,-11|27|0x5ed900,-8|-4|0xccf76a'
    return findColorsUntil(0xffee8c, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-----------------------------------------------------
-- 节日道具
local function jieri()
    offset =
        '29|-24|0xf1352b,3|-11|0xfcf75a,0|-13|0xfff666,7|-23|0xef362a,24|-20|0xfbe97d,11|-22|0xfffa90'
    return findColorsUntil(0xc73712, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-- 丢弃按钮
local function drop()
    offset =
        '-4|6|0x6c310a,8|6|0x6c310a,29|10|0x6c310a,20|-4|0x6c310a,30|-4|0x6c310a,13|10|0xecbd5e'
    return findColorsUntil(0x6c310a, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

-- 背包
local function bag()
    local offset = "-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba"
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606,
                           {orient = 2}, 500, 1)
end

-- 修炼页面 (九转金丹 和 修炼果)
local function xiulianPage()
    offset =
        '29|345|0x553923,32|344|0x553923,30|364|0x553923,39|365|0x553923,41|371|0x553923,37|361|0x553923'
    return findColorsUntil(0xce0000, offset, 100, 941, 20, 1068, 571,
                           {orient = 2}, 500, 1)
end

-- 捉鬼碎片页面
local function guiPage()
    offset =
        '-118|27|0x6c310a,-108|27|0x6c310a,-118|42|0x6c310a,-61|36|0x6c310a,-62|27|0x6c310a,-10|227|0xc58d5a,-10|239|0xc58d5a'
    return findColorsUntil(0xb91f28, offset, 100, 869, 35, 1031, 342,
                           {orient = 2}, 500, 1)
end
-- 解锁捉鬼碎片
local function guilock()
    offset = '-8|-3|0xf6e6c9,8|-2|0xf6e4c2,-9|-27|0xfee1b8,7|-27|0xfddfb2'
    return findColorsUntil(0xa7703f, offset, 100, 258, 77, 606, 370,
                           {orient = 2}, 500, 1)
end

-- 背包出售
local function bagSell()
    offset =
        '-225|240|0x875832,-83|239|0x875832,-31|243|0x6c310a,-23|242|0x70350e,-148|393|0xecbe5f'
    return findColorsUntil(0xbf1500, offset, 100, 394, 85, 741, 540,
                           {orient = 2}, 500, 1)
end

local function doubleClick(resFunc)
    r, t, x, y = resFunc() -- 识别物品位置
    tap(x, y)
    mSleep(100)
    tap(x, y)
end

local function store(resFunc)
    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
    tap(1037, 284) -- 打开仓库

    doubleClick(resFunc)

    tap(1021, 171) -- 回到背包,继续下个物品
    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
end

local function xiulian(resFunc)
    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    doubleClick(resFunc)
    while true do
        if xiulianPage() then break end
        coroutine.yield('修炼页面异常', 'c2')
        mSleep(1000)
    end
    tap(863, 562) -- 使用修炼丹or修炼果

    tap(980, 43) -- 关闭修炼页面

    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
end

local function dropSth(resFunc)
    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    r, t, x, y = resFunc()
    tap(x, y) -- 选中物品
    r, t, x, y = drop()
    if r then
        tap(x, y)
        mSleep(2000)
        tap(665, 373) -- 确认丢弃
    end

    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

end

local market_table = {
    {["res"] = function() jingtie_market() end, ["bagIndex"] = 1},
    {["res"] = function() guiguzi_market() end, ["bagIndex"] = 1},
    {["res"] = function() heibaoshi_market() end, ["bagIndex"] = 1},
    {["res"] = function() taiyangshi_market() end, ["bagIndex"] = 1},
    {["res"] = function() shenmishi_market() end, ["bagIndex"] = 1},
    {["res"] = function() shelizi_market() end, ["bagIndex"] = 1},
    {["res"] = function() feicuishi_market() end, ["bagIndex"] = 1},
    {["res"] = function() hongwenshi_market() end, ["bagIndex"] = 1},
    {["res"] = function() yueliangshi_market() end, ["bagIndex"] = 1},
    {["res"] = function() guangmangshi_market() end, ["bagIndex"] = 1},
    {["res"] = function() kunlunyu_market() end, ["bagIndex"] = 1},
    {["res"] = function() yuehualu_market() end, ["bagIndex"] = 1},
    {["res"] = function() duanzaoce_market() end, ["bagIndex"] = 1}
}

local bag_table = {
    {["use"] = function() store(jingtie_bag) end},
    {["use"] = function() store(guiguzi_bag) end},
    {["use"] = function() store(heibaoshi_bag) end},
    {["use"] = function() store(taiyangshi_bag) end},
    {["use"] = function() store(shenmieshi_bag) end},
    {["use"] = function() store(shelizi_bag) end},
    {["use"] = function() store(feicuishi_bag) end},
    {["use"] = function() store(hongwenshi_bag) end},
    {["use"] = function() store(yueliangshi_bag) end},
    {["use"] = function() store(guangmangshi_bag) end},
    {["use"] = function() store(kunlunyu_bag) end},
    {["use"] = function() store(qinglongshi) end},
    {["use"] = function() store(baihushi) end},
    {["use"] = function() store(xuanwushi) end},
    {["use"] = function() store(zhuqueshi) end},
    {["use"] = function() xiulian(jiuzhuan_bag) end},
    {["use"] = function() xiulian(xiulianguo_bag) end},
    {["use"] = function() doubleClick(juling_bag) end},
    {["use"] = function() doubleClick(xinmobaozhu) end},
    {["use"] = function() doubleClick(canjuan) end},
    {["use"] = function() dropSth(jieri) end}
}

