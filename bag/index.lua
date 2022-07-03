require("TSLib")
Common = require("Common.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

local can_store = true
local bagFunc = {}
-- 鬼怪画像
function guiguaihuaxiang_bag()
    offset =
        '15|3|0xaa4acc,-13|-2|0xb58d6a,-10|-31|0xb58d6a,38|-30|0xb58d6a,29|-14|0xd260d7'
    return findColorsUntil(0xbb33c6, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

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
    offset = '-20|11|0xd8881d,-29|-4|0xffffff,-30|28|0xeeaa22'
    return findColorsUntil(0x881d11, offset, 90, 561, 137, 970, 534,
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

-- 月华露
local function yuehualu_bag()
    offset = '24|-11|0xffee93,10|12|0xc6ee60,16|-9|0xccff71'
    return findColorsUntil(0xccf466, offset, 90, 149, 131, 991, 534,
                           {orient = 2}, 500, 1)
end

---------------------------以下是商会------------------------------
-- 制造书(商会)
function zhizaoshu()
    offset =
        '49|0|0xb58d6a,30|72|0x5d422c,30|77|0x5d422d,36|77|0x5c412b,6|75|0x634832,6|83|0x644a34,0|81|0x765e49,0|71|0x765e49'
    return findColorsUntil(0xb58d6a, offset, 90, 151, 140, 982, 546,
                           {orient = 2}, 500, 1)
end
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
-- 昆仑玉(商会)
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
-- 推荐价格
local function tuijianjiage()
    offset =
        '5|1|0x553923,40|4|0x553923,52|3|0x553923,66|7|0x553923,74|7|0x553923'
    return findColorsUntil(0x5c402a, offset, 90, 662, 444, 850, 473,
                           {orient = 2}, 500, 1)
end

local function up_tuijianjiage()
    offset =
        '0|10|0x0bb008,5|7|0x02ae00,21|8|0x14b20f,40|6|0x02ae00,52|6|0x02ae00,61|9|0x02ae00,74|9|0x02ae00'
    return findColorsUntil(0x0ab007, offset, 90, 662, 444, 850, 473,
                           {orient = 2}, 500, 1)
end

local function down_tuijianjiage()
    offset =
        '0|9|0xe01e09,5|8|0xe01500,40|7|0xe01500,52|8|0xe01500,61|9|0xe01500,74|10|0xe01500'
    return findColorsUntil(0xe01702, offset, 90, 662, 444, 850, 473,
                           {orient = 2}, 500, 1)
end

-- 调整价格
local function fix_price()
    local initX = 0
    local initY = 0

    keepScreen(true)
    if not tuijianjiage() then -- 如果不是在原价,先调整到原价

        if up_tuijianjiage() then
            initX = 660
            initY = 424
        elseif down_tuijianjiage() then
            initX = 865
            initY = 424
        end
        keepScreen(false)

        while true do
            if tuijianjiage() then break end
            tap(initX, initY)
            mSleep(1000)
        end
    end

    local tap_times = UISetting.price_baitan
    if UISetting.price_baitan < 0 then -- 推荐价格以下,调整要按的按钮
        initX = 660
        initY = 424

        tap_times = -(tap_times)
    else
        initX = 865
        initY = 424
    end

    for i = 1, tap_times, 1 do
        tap(initX, initY)
        mSleep(1000)
    end
end

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

-- 商会为空
local function empty()
    offset =
        '155|-52|0x8d5d2c,170|-49|0x8d5d2c,182|-49|0x8d5d2c,201|-53|0x8d5d2c,208|-53|0x8d5d2c,235|-52|0x936536,316|-47|0x8d5d2c'
    return findColorsUntil(0x5144aa, offset, 90, 345, 273, 799, 417,
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

-- 珍品出售
local function zhenpin()
    offset =
        '-292|152|0x8cd626,-273|147|0x36bf7f,-120|153|0x81532a,97|285|0xffe195'
    return findColorsUntil(0xc01500, offset, 100, 562, 56, 991, 335,
                           {orient = 2}, 500, 1)
end
-- 普通出售
local function simple()
    offset =
        '-236|359|0x875832,-25|360|0x875832,-105|483|0x6c310a,-85|492|0x6c310a,-58|490|0x6c310a,-30|485|0x6c310a'
    return findColorsUntil(0xc01500, offset, 90, 559, 43, 913, 587,
                           {orient = 2}, 500, 1)
end

local function baitan_logo()
    offset =
        '-13|-3|0xfef9b0,-35|-3|0xfef9b0,394|-9|0xce0000,296|33|0x713710,298|42|0x6c310a,321|40|0x6c310a,337|40|0x6c310a'
    return findColorsUntil(0xfefdb8, offset, 90, 464, 13, 1024, 117,
                           {orient = 2}, 500, 1)
end

-- 上架成功的提示
local function success()
    offset =
        '168|59|0xedbf60,125|-148|0xe01500,145|-134|0xe01500,169|-136|0xe01500,194|-136|0xe01500'
    return findColorsUntil(0x82532a, offset, 90, 358, 220, 781, 525,
                           {orient = 2}, 500, 1)
end
-- 超时上架
local function expire()
    offset =
        '34|5|0x70350d,20|11|0xecbe5f,191|4|0x6e330b,210|-1|0x6d320a,216|10|0x6c310a'
    return findColorsUntil(0x6e330b, offset, 90, 566, 498, 906, 566,
                           {orient = 2}, 500, 1)
end

local function doubleClick(resFunc, x, y)
    if resFunc ~= nil then r, t, x, y = resFunc() end
    tap(x, y)
    mSleep(100)
    tap(x, y)
    mSleep(1000)
end

local function store(resFunc)
    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    if not can_store then return end -- 因为是扫描全仓库,如果有一个确定了无法存储,其他的也无需存储了,节省时间

    while true do
        local r, t, x, y = resFunc()
        if r then
            tap(1037, 284) -- 打开仓库
            mSleep(1500)
            find_store()

            doubleClick(nil, x, y)
            tap(1021, 171) -- 回到背包,继续下个物品
            mSleep(1000)
        else
            break
        end
    end

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

    r, t, x, y = resFunc()
    if r then
        doubleClick(nil, x, y)
        mSleep(1500)
        while true do
            if xiulianPage() then break end
            coroutine.yield('修炼页面异常', 'c2')
            mSleep(1000)
        end
        tap(863, 562) -- 使用修炼丹or修炼果
        mSleep(1500)
        tap(980, 43) -- 关闭修炼页面
        mSleep(1500)
    end

    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
end

local function dropSth(resFunc)
    while true do
        if bag() then break end
        -- coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    r, t, x, y = resFunc()
    if r then
        tap(x, y) -- 选中物品
        mSleep(1000)

        r, t, x, y = drop()
        tap(x, y) -- 丢弃
        mSleep(1000)

        tap(665, 373) -- 确认丢弃
        mSleep(1000)
    end

    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

end

-- 商城页面
local function baitanPage()
    offset =
        '47|392|0xffdd6d,45|402|0xffdd6d,45|423|0xffdd6d,35|424|0xffdc6d,36|315|0x6c310a,36|334|0x6c310a'
    return findColorsUntil(0xce0000, offset, 90, 947, 11, 1064, 500,
                           {orient = 2}, 500, 1)
end

local function shanghui_logo()
    offset =
        '-331|-530|0xfefcb7,-316|-531|0xfefbb6,-347|-530|0xfefdb8,-369|-531|0xfefbb6,-358|-536|0xfdf6a7'
    return findColorsUntil(0xecb555, offset, 90, 493, 8, 994, 606, {orient = 2},
                           500, 1)
end

function unlock_huaxiang()
    while true do
        if guiPage() then break end
        coroutine.yield('画像碎片页面异常', 'c2')
        mSleep(1000)
    end

    for i = 1, 4, 1 do -- 最多四个碎片
        local r, t, x, y = guilock()
        if r then tap(x, y) end
        mSleep(2000)
    end

    tap(1018, 61) -- 关闭
    mSleep(1000)

    while true do
        if bag() then break end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
end
local str_jingtie = "1"
local str_guiguzi = "2"
local str_heibaoshi = "3"
local str_taiyangshi = "4"
local str_shelizi = "5"
local str_yueliangshi = "6"
local str_hongwenshi = "7"
local str_shenmishi = "8"
local str_feicuishi = "9"
local str_guangmangshi = "10"
local str_kunlunyu = "11"
local str_qinglongshi = "12"
local str_baihushi = "13"
local str_zhuqueshi = "14"
local str_xuanwushi = "15"
local str_jiuzhuan = "16"
local str_xiulianguo = "17"
local str_juling = "18"
local str_xinmobaozhu = "19"
local str_canjuan = "20"
local str_jieri = "21"
local str_yuehualu = "22"
local str_duanaoce = "23"

bag_table = {
    function()
        toast('画像碎片', 1)
        mSleep(1000)
        while true do
            local r, t, x, y = guiguaihuaxiang_bag()
            if r then
                doubleClick(nil, x, y)
                mSleep(1000)
                unlock_huaxiang()
            else
                break
            end
        end
    end, -- 捉鬼碎片
    function()
        toast('精铁', 1)
        mSleep(1000)
        store(jingtie_bag)
    end, -- 精铁(存储)
    function()
        toast('鬼谷子', 1)
        mSleep(1000)
        store(guiguzi_bag)
    end, -- 鬼谷子(存储)
    function()
        toast('黑宝石', 1)
        mSleep(1000)
        store(heibaoshi_bag)
    end, -- 黑宝石(存储)
    function()
        toast('太阳石', 1)
        mSleep(1000)
        store(taiyangshi_bag)
    end, -- 太阳石(存储)
    function()
        toast('神秘石', 1)
        mSleep(1000)
        store(shenmieshi_bag)
    end, -- 神秘石(存储)
    function()
        toast('舍利子', 1)
        mSleep(1000)
        store(shelizi_bag)
    end, -- 舍利子(存储)
    function()
        toast('翡翠石', 1)
        mSleep(1000)
        store(feicuishi_bag)
    end, -- 翡翠石(存储)
    function()
        toast('红纹石', 1)
        mSleep(1000)
        store(hongwenshi_bag)
    end, -- 红纹石(存储)
    function()
        toast('月亮石', 1)
        mSleep(1000)
        store(yueliangshi_bag)
    end, -- 月亮石(存储)
    function()
        toast('光芒石', 1)
        mSleep(1000)
        store(guangmangshi_bag)
    end, -- 光芒石(存储)
    function()
        toast('昆仑玉', 1)
        mSleep(1000)
        store(kunlunyu_bag)
    end, -- 昆仑玉(存储)
    function()
        toast('青龙石', 1)
        mSleep(1000)
        store(qinglongshi)
    end, -- 青龙石(存储)
    function()
        toast('白虎石', 1)
        mSleep(1000)
        store(baihushi)
    end, -- 白虎石(存储)
    function()
        toast('玄武石', 1)
        mSleep(1000)
        store(xuanwushi)
    end, -- 玄武石(存储)
    function()
        toast('朱雀石', 1)
        mSleep(1000)
        store(zhuqueshi)
    end, -- 朱雀石(存储)
    function()
        toast('九转金丹', 1)
        mSleep(1000)
        xiulian(jiuzhuan_bag)
    end, -- 九转金丹(修炼)
    function()
        toast('修炼果', 1)
        mSleep(1000)
        xiulian(xiulianguo_bag)
    end, -- 修炼果(修炼)
    function()
        toast('聚灵仙露', 1)
        mSleep(1000)
        doubleClick(juling_bag)
    end, -- 聚灵仙露(使用)
    function()
        toast('心魔宝珠', 1)
        mSleep(1000)
        doubleClick(xinmobaozhu)
    end, -- 心魔宝珠(使用)
    function()
        toast('阵法残卷', 1)
        mSleep(1000)
        while true do
            -- if canjuan() then doubleClick(canjuan) end
            if canjuan() then dropSth(canjuan) end
            mSleep(1000)
        end
    end, -- 阵法残卷(使用)
    function()
        toast('节日道具', 1)
        mSleep(1000)
        dropSth(jieri)
    end -- 节日道具(丢弃)

}

function empty_store()
    offset =
        '12|0|0xb58d6a,13|12|0xb58d6a,0|12|0xb58d6a,-35|6|0xdfc2a0,44|9|0xdfc2a0,5|45|0xdfc2a0,-9|-33|0xdfc2a0'
    return findColorsUntil(0xb58d6a, offset, 90, 120, 124, 547, 549,
                           {orient = 2}, 500, 1)
end

function first_store()
    offset =
        '67|2|0xf3d4aa,88|-46|0xf7e6c5,-3|-42|0xf8e5c5,304|-83|0x875832,313|-96|0x875832'
    return findColorsUntil(0xf3d5ac, offset, 90, 127, 73, 545, 211,
                           {orient = 2}, 500, 1)
end
function find_store()
    if empty_store() then
        can_store = true
        return
    end
    tap(394, 93) -- 打开仓库选择页面

    r, t, x, y = first_store()
    tap(x, y) -- 打开第一个仓库

    -- 记录五个格子的颜色,用于识别是不是扫完一遍仓库了
    p1 = getColor(173, 177)
    p2 = getColor(254, 260)
    p3 = getColor(327, 338)
    p4 = getColor(426, 417)
    p5 = getColor(495, 511)
    sameTime = 1

    while sameTime <= 3 do
        if empty_store() then
            can_store = true
            return
        end
        tap(271, 588) -- 下一个仓库
        new_p1 = getColor(173, 177)
        new_p2 = getColor(254, 260)
        new_p3 = getColor(327, 338)
        new_p4 = getColor(426, 417)
        new_p5 = getColor(495, 511)
        if new_p1 == p1 and new_p2 == p2 and new_p3 == p3 and new_p4 == p4 and
            new_p5 == p5 then sameTime = sameTime + 1 end -- 5个点颜色一直,认为是回到了首页,防止是碰巧,相同3次才结束
    end
    can_store = false
end

function marketSellTable(setting)
    sell_table = {}
    bag_table_use = {}
    for i = 1, #setting, 1 do
        num = setting[i]
        if num == '0' then
            table.insert(sell_table, {
                ["res"] = function() return jingtie_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_jingtie)])
        elseif num == '1' then
            table.insert(sell_table, {
                ["res"] = function() return guiguzi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_guiguzi)])
        elseif num == '2' then
            table.insert(sell_table, {
                ["res"] = function() return heibaoshi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_heibaoshi)])
        elseif num == '3' then
            table.insert(sell_table, {
                ["res"] = function() return taiyangshi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_taiyangshi)])
        elseif num == '4' then
            table.insert(sell_table, {
                ["res"] = function() return shenmishi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_shenmishi)])
        elseif num == '5' then
            table.insert(sell_table, {
                ["res"] = function() return shelizi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_shelizi)])
        elseif num == '6' then
            table.insert(sell_table, {
                ["res"] = function() return feicuishi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_feicuishi)])
        elseif num == '7' then
            table.insert(sell_table, {
                ["res"] = function() return hongwenshi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_hongwenshi)])
        elseif num == '8' then
            table.insert(sell_table, {
                ["res"] = function() return yueliangshi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_yueliangshi)])
        elseif num == '9' then
            table.insert(sell_table, {
                ["res"] = function() return guangmangshi_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_guangmangshi)])
        elseif num == '10' then
            table.insert(sell_table, {
                ["res"] = function() return kunlunyu_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_kunlunyu)])
        elseif num == '11' then
            table.insert(sell_table, {
                ["res"] = function() return yuehualu_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_yuehualu)])
        elseif num == '12' then
            table.insert(sell_table, {
                ["res"] = function() return duanzaoce_market() end,
                ["bagIndex"] = 1
            })
            table.insert(bag_table_use, bag_table[tonumber(str_duanaoce)])
        end
    end
    return sell_table, bag_table_use
end

-- 商会出售
function sell()
    -- t1 = marketSellTable()
    if empty() then return end -- 商会没有可出售的
    for i = 1, 10, 1 do -- 直接滑动10次
        for i = 1, #UISetting.shanghui_list, 1 do
            obj = UISetting.shanghui_list[i]
            while true do
                r, t, x, y = obj.res()
                if r then
                    tap(x, y)
                    mSleep(1000)

                    tap(716, 586) -- 打开数量
                    mSleep(1000)

                    tap(662, 500) -- 点击数字9
                    mSleep(500)
                    tap(662, 500) -- 点击数字9
                    mSleep(500)

                    tap(896, 584) -- 出售
                    mSleep(1000)

                else
                    break
                end
            end
            if empty() then break end -- 商会没有可出售的

            mSleep(1000)
            tap(1, 1)
        end
    end
end

function sell2User()

    local initX = 706
    local initY = 171

    targetX = 0
    targetY = 0
    -- 从第一行找到第一个装备
    for i = 1, 10, 1 do
        lastColor = nil
        while initX <= 946 do
            mSleep(1500)
            if not isColor(582, 473, 0xdfc2a0) then -- 上架满了,无法上架了
                -- 看看有没有上架超时的,然后取回
                local initX_sale = 442
                local initY_sale = 491
                for i = 1, 8, 1 do -- 最多上架8个商品,检查有没有上架超时的
                    if i % 2 == 0 then
                        initX_sale = 442
                        initY_sale = initY_sale - 90
                    end -- 说明点完一行了,一行两个
                    tap(initX_sale, initY_sale)
                    mSleep(1000)
                    if expire() then
                        tap(653, 538) -- 点击取回
                    elseif isColor(888, 79, 0xbf1500) then -- 有红色叉叉就关闭掉
                        tap(888, 79) -- 关闭
                    end
                    mSleep(1500)
                    initX_sale = initX_sale - 250 -- 往前
                end
                if not isColor(582, 473, 0xdfc2a0) then -- 清理完超时后再次确认
                    toast('没位置上架了')
                    return
                end

            end

            color = getColor(initX, initY)
            if color == 0xdfc2a0 then -- 说明没有东西可以上架了
                toast('没东西上架了')
                return
            end

            -- if color == lastColor then initX = initX + 80 end -- bug: 多个相同物品会跳格
            tap(initX, initY)
            mSleep(1000)
            if not baitanPage() then -- 说面点击了物品有变化
                -- 普通出售
                r, t, x, y = simple()
                if not r then -- 不是普通物品出售
                    initX = initX + 80 -- 指向向下一个物品

                    r, t, x, y = zhenpin()
                    if r then -- 珍品装备出售
                        tap(x, y) -- 关闭窗口
                    else
                        tap(661, 561) -- 珍品,取消掉
                    end

                    if isColor(661, 561, 0xecbc5e) then
                        tap(661, 561)
                    end -- 有取消按钮点击取消
                else
                    fix_price() -- 调整价格
                    mSleep(1000)

                    tap(825, 555) -- 上架

                end

                mSleep(2000)

                if success() then
                    tap(400, 437) -- 7天不提示
                    mSleep(1000)
                    tap(569, 497) -- 确定
                    mSleep(1000)
                end
            else
                initX = initX + 80 -- 指向向下一个物品
            end

            -- lastColor = color
        end
        if i % 5 == 0 then moveTo(789, 513, 789, 121, 2, 50) end

        initX = 706 -- 复位,下一行第一个开始
        initY = initY + 80 -- 换到下一行
    end

end

local function cleanBag()
    local point1 = 0xffffff
    local point2 = 0xffffff
    local point3 = 0xffffff
    local point4 = 0xffffff

    while true do
        local p1 = getColor(606, 180)
        local p2 = getColor(686, 265)
        local p3 = getColor(769, 337)
        local p4 = getColor(841, 416)
        for i = 1, #UISetting.bag_list, 1 do UISetting.bag_list[i]() end

        if (p1 == point1 and p2 == point2 and p3 == point3 and p4 == point4) then -- 拉到底
            break
        end
        point1 = p1
        point2 = p2
        point3 = p3
        point4 = p4
        moveTo(729, 358, 729, 217, 2, 50)
    end

    tap(980, 42) -- 关闭背包
end

-- todo 背包的种子|打造书无法识别

function bagFunc.openMall()
    Common.blockCheckMainPage('打开商城异常')

    tap(34, 195) -- 打开商城

    while true do
        if baitanPage() then break end
        coroutine.yield('打开商城后页面异常', 'c2')
        mSleep(1000)
    end
    return 0
end

function bagFunc.switch_shanghui()
    while true do
        if baitanPage() then break end
        coroutine.yield('打开商城后页面异常', 'c2')
        mSleep(1000)
    end
    tap(1023, 172) -- 切换商会
    mSleep(1000)

    tap(407, 94) -- 切换到出售
    mSleep(1000)

    while true do
        if shanghui_logo() then break end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end
    return 0
end

function bagFunc.sell_shanghui()
    while true do
        if shanghui_logo() then break end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end

    sell()

    while true do
        if shanghui_logo() then break end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.switch_baitan()
    while true do
        if shanghui_logo() then break end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end
    tap(1025, 272) -- 切换摆摊
    mSleep(1000)

    tap(401, 92) -- 切换到出售
    mSleep(1000)

    while true do
        if baitan_logo() then break end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.sell_baitan()
    while true do
        if baitan_logo() then break end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end
    sell2User()

    while true do
        if baitan_logo() then break end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.close_market()
    while true do
        if baitan_logo() then break end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    tap(978, 40) -- 关闭商城
    mSleep(1500)

    Common.blockCheckMainPage('关闭商城异常')

    return 0
end

function bagFunc.open_bag()
    Common.blockCheckMainPage('打开背包异常')

    tap(1096, 522) -- 打开背包
    mSleep(1000)

    while true do
        if bag() then break end
        coroutine.yield('打开背包后页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.clear_bag()
    while true do
        if bag() then break end
        coroutine.yield('打开背包后页面异常', 'c2')
        mSleep(1000)
    end
    cleanBag() -- 清空背包

    Common.blockCheckMainPage('清空背包后页面异常')

    return -2
end

return bagFunc
