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
local function jingtie()
    offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 561, 137, 970, 534,
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

-- 玄武石
local function xuanwushi()
    offset = '24|1|0x2255aa,-4|27|0x2288ee,-9|-9|0xbbeeff'
    return findColorsUntil(0x3399dd, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end


-- 百炼精铁(商会)
local function jingtie_market()
    offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 149,131, 991,534,
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