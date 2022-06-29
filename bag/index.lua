-- 月亮石
local function yueliangshi()
    offset = '-24|-7|0x99ddff,-7|-26|0x22bbee,-8|8|0xaa66ff'
    return findColorsUntil(0x3322bb, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 太阳石
local function taiyangshi()
    offset = '-5|14|0xff3388,-15|21|0xff2255,3|31|0xcc0033'
    return findColorsUntil(0xffaaaa, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 昆仑玉
local function kunlunyu()
    offset = '6|24|0xffdd99,-8|3|0xffffff,3|26|0xffffff'
    return findColorsUntil(0xffdd88, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 光芒石
local function guangmangshi()
    offset = '-8|-8|0x11eeff,-23|-15|0x88ffff,-24|10|0x33aadd'
    return findColorsUntil(0x11bbff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 舍利子
local function shelizi()
    offset = '24|-22|0xeeee11,33|-1|0xddee11,40|-8|0x448811'
    return findColorsUntil(0xeeee11, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 翡翠石
local function feicuishi()
    offset = '-4|12|0x44cc77,-26|21|0x44bb66,-13|1|0xffffff'
    return findColorsUntil(0x55cc88, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 黑宝石
local function heibaoshi()
    offset = '-39|2|0x332233,-6|-27|0xeeeeee,-9|16|0x776688'
    return findColorsUntil(0x443344, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 红纹石
local function hongwenshi()
    offset = '18|0|0xdd2255,-16|17|0xcc2233,-27|2|0xffffff'
    return findColorsUntil(0xffccff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 神秘石
local function shenmieshi()
    offset = '-22|4|0xffbbee,-22|22|0x7766bb,-39|-3|0x9944bb'
    return findColorsUntil(0xaa22bb, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 九转金丹
local function jiuzhuan()
    offset = '12|12|0xcc881c,23|-5|0xdd3311,-6|29|0xeeb033'
    return findColorsUntil(0xffffff, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 聚灵仙饮
local function juling()
    offset = '14|-4|0xffff17,28|3|0xff9911,23|-19|0xffffff'
    return findColorsUntil(0x44aad7, offset, 90, 561, 137, 970, 534,
                           {orient = 2}, 500, 1)
end

-- 鬼谷子
local function guiguzi()
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