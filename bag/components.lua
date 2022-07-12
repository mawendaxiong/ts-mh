-- 鬼怪画像
function guiguaihuaxiang_bag()
    local offset = '15|3|0xaa4acc,-13|-2|0xb58d6a,-10|-31|0xb58d6a,38|-30|0xb58d6a,29|-14|0xd260d7'
    return findColorsUntil(0xbb33c6, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 月亮石
function yueliangshi_bag()
    local offset = '-24|-7|0x99ddff,-7|-26|0x22bbee,-8|8|0xaa66ff'
    return findColorsUntil(0x3322bb, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 太阳石
function taiyangshi_bag()
    local offset = '-5|14|0xff3388,-15|21|0xff2255,3|31|0xcc0033'
    return findColorsUntil(0xffaaaa, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 昆仑玉
function kunlunyu_bag()
    local offset = '6|24|0xffdd99,-8|3|0xffffff,3|26|0xffffff'
    return findColorsUntil(0xffdd88, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 光芒石
function guangmangshi_bag()
    local offset = '-8|-8|0x11eeff,-23|-15|0x88ffff,-24|10|0x33aadd'
    return findColorsUntil(0x11bbff, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 舍利子
function shelizi_bag()
    local offset = '24|-22|0xeeee11,33|-1|0xddee11,40|-8|0x448811'
    return findColorsUntil(0xeeee11, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 翡翠石
function feicuishi_bag()
    local offset = '-4|12|0x44cc77,-26|21|0x44bb66,-13|1|0xffffff'
    return findColorsUntil(0x55cc88, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 黑宝石
function heibaoshi_bag()
    local offset = '-39|2|0x332233,-6|-27|0xeeeeee,-9|16|0x776688'
    return findColorsUntil(0x443344, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 红纹石
function hongwenshi_bag()
    local offset = '18|0|0xdd2255,-16|17|0xcc2233,-27|2|0xffffff'
    return findColorsUntil(0xffccff, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 神秘石
function shenmieshi_bag()
    local offset = '-22|4|0xffbbee,-22|22|0x7766bb,-39|-3|0x9944bb'
    return findColorsUntil(0xaa22bb, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 九转金丹
function jiuzhuan_bag()
    local offset = '-20|11|0xd8881d,-29|-4|0xffffff,-30|28|0xeeaa22'
    return findColorsUntil(0x881d11, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 修炼果
function xiulianguo_bag()
    local offset = '21|-15|0xcc7700,-3|-23|0xffffee,-11|-3|0xcc7700'
    return findColorsUntil(0xcc7706, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-- 聚灵仙饮
function juling_bag()
    local offset = '14|-4|0xffff17,28|3|0xff9911,23|-19|0xffffff'
    return findColorsUntil(0x44aad7, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 鬼谷子
function guiguzi_bag()
    local offset = '-10|15|0x33ffee,3|20|0x22ddcc,15|1|0x11ccbb'
    return findColorsUntil(0x22eedd, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 百炼精铁
function jingtie_bag()
    local offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 心魔宝珠
function xinmobaozhu()
    local offset = '10|20|0x33116c,-15|24|0xf439f9,-23|36|0x331166,-30|16|0x444add,-1|1|0x3339c6'
    return findColorsUntil(0x4433b5, offset, 85, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-- 青龙石
function qinglongshi()
    local offset = '11|19|0x229933,11|34|0x229933,-13|36|0x119922'
    return findColorsUntil(0x88ee77, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 白虎石
function baihushi()
    local offset = '3|36|0x888888,-20|27|0xffffff,15|6|0xaaaaaa'
    return findColorsUntil(0xeeeedd, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 朱雀石
function zhuqueshi()
    local offset = '-1|17|0xdd3322,15|30|0xcc2233,10|11|0xdd3322'
    return findColorsUntil(0xdd4422, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 阵法残卷
function canjuan()
    local offset = '-31|4|0x991d11,-25|31|0xb61111,-23|47|0x773322,3|0|0xcc9e66'
    return findColorsUntil(0xd1aa6b, offset, 85, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-- 玄武石
function xuanwushi()
    local offset = '24|1|0x2255aa,-4|27|0x2288ee,-9|-9|0xbbeeff'
    return findColorsUntil(0x3399dd, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 月华露
function yuehualu_bag()
    local offset = '24|-11|0xffee93,10|12|0xc6ee60,16|-9|0xccff71'
    return findColorsUntil(0xccf466, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

---------------------------以下是商会------------------------------
-- 制造书(商会)
function zhizaoshu_market()
    local offset =
        '49|0|0xb58d6a,30|72|0x5d422c,30|77|0x5d422d,36|77|0x5c412b,6|75|0x634832,6|83|0x644a34,0|81|0x765e49,0|71|0x765e49'
    return findColorsUntil(0xb58d6a, offset, 90, 151, 140, 982, 546, {orient = 2}, 500, 1)
end
-- 百炼精铁(商会)
function jingtie_market()
    local offset = '27|14|0x4a5577,32|38|0xffffff,25|10|0x5b668e'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 黑宝石(商会)
function heibaoshi_market()
    local offset = '41|0|0x373344,14|16|0x332f40,36|-25|0xeae1ee'
    return findColorsUntil(0x2f2f37, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 翡翠石(商会)
function feicuishi_market()
    local offset = '15|4|0x55cc7b,22|38|0x91f799,-3|23|0x37bb66'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 舍利子(商会)
function shelizi_market()
    local offset = '7|22|0xe5ea11,-27|23|0xeaee11,-35|21|0xfbfbd5'
    return findColorsUntil(0xeaee15, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 光芒石(商会)
function guangmangshi_market()
    local offset = '6|-16|0x11eeff,-19|-22|0xfbffff,-20|-4|0x88fbff'
    return findColorsUntil(0x0962fb, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 月亮石(商会)
function yueliangshi_market()
    local offset = '-21|-26|0xffffff,-28|4|0x443ca1,-6|8|0xaa65f7'
    return findColorsUntil(0x2c29aa, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 神秘石(商会)
function shenmishi_market()
    local offset = '23|-20|0xae22bf,-8|-31|0xa133b7,11|-20|0xffeaf7'
    return findColorsUntil(0x7b48aa, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 红纹石(商会)
function hongwenshi_market()
    local offset = '-10|28|0x99446a,19|-2|0xc84095,2|13|0xaa1111'
    return findColorsUntil(0xfbaeea, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 太阳石(商会)
function taiyangshi_market()
    local offset = '-7|34|0xff3362,8|4|0xffeaee,25|19|0xff626f'
    return findColorsUntil(0xffae91, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 昆仑玉(商会)
function kunlunyu_market()
    local offset = '19|15|0xffdda0,9|-8|0xfffeaa,8|19|0xfffffe'
    return findColorsUntil(0xffffff, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 鬼谷子(商会)
function guiguzi_market()
    local offset = '10|12|0x264462,-7|-7|0x26fbf7,-17|17|0x44c8c8'
    return findColorsUntil(0x26f2ea, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 锻造册(商会)
function duanzaoce_market()
    local offset = '4|-21|0xc32226,-17|8|0xd0222b,-35|-8|0xb72226'
    return findColorsUntil(0x912f15, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end
-- 月华露(商会)
function yuehualu_market()
    local offset = '-25|9|0xccf26f,-11|27|0x5ed900,-8|-4|0xccf76a'
    return findColorsUntil(0xffee8c, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-----------------------------------------------------

-- 推荐价格
function tuijianjiage()
    local offset = '5|1|0x553923,40|4|0x553923,52|3|0x553923,66|7|0x553923,74|7|0x553923'
    return findColorsUntil(0x5c402a, offset, 90, 662, 444, 850, 473, {orient = 2}, 500, 1)
end

function up_tuijianjiage()
    local offset = '0|10|0x0bb008,5|7|0x02ae00,21|8|0x14b20f,40|6|0x02ae00,52|6|0x02ae00,61|9|0x02ae00,74|9|0x02ae00'
    return findColorsUntil(0x0ab007, offset, 90, 662, 444, 850, 473, {orient = 2}, 500, 1)
end

function down_tuijianjiage()
    local offset = '0|9|0xe01e09,5|8|0xe01500,40|7|0xe01500,52|8|0xe01500,61|9|0xe01500,74|10|0xe01500'
    return findColorsUntil(0xe01702, offset, 90, 662, 444, 850, 473, {orient = 2}, 500, 1)
end

-- 节日道具
function jieri()
    local offset = '29|-24|0xf1352b,3|-11|0xfcf75a,0|-13|0xfff666,7|-23|0xef362a,24|-20|0xfbe97d,11|-22|0xfffa90'
    return findColorsUntil(0xc73712, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-- 丢弃按钮
function drop()
    local offset = '-4|6|0x6c310a,8|6|0x6c310a,29|10|0x6c310a,20|-4|0x6c310a,30|-4|0x6c310a,13|10|0xecbd5e'
    return findColorsUntil(0x6c310a, offset, 90, 149, 131, 991, 534, {orient = 2}, 500, 1)
end

-- 背包
function bag()
    local offset = '-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba'
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606, {orient = 2}, 500, 1)
end

-- 商会为空
function empty()
    local offset =
        '155|-52|0x8d5d2c,170|-49|0x8d5d2c,182|-49|0x8d5d2c,201|-53|0x8d5d2c,208|-53|0x8d5d2c,235|-52|0x936536,316|-47|0x8d5d2c'
    return findColorsUntil(0x5144aa, offset, 90, 345, 273, 799, 417, {orient = 2}, 500, 1)
end

-- 修炼页面 (九转金丹 和 修炼果)
function xiulianPage()
    local offset = '29|345|0x553923,32|344|0x553923,30|364|0x553923,39|365|0x553923,41|371|0x553923,37|361|0x553923'
    return findColorsUntil(0xce0000, offset, 100, 941, 20, 1068, 571, {orient = 2}, 500, 1)
end

-- 捉鬼碎片页面
function guiPage()
    local offset =
        '-118|27|0x6c310a,-108|27|0x6c310a,-118|42|0x6c310a,-61|36|0x6c310a,-62|27|0x6c310a,-10|227|0xc58d5a,-10|239|0xc58d5a'
    return findColorsUntil(0xb91f28, offset, 100, 869, 35, 1031, 342, {orient = 2}, 500, 1)
end
-- 解锁捉鬼碎片
function guilock()
    local offset = '-8|-3|0xf6e6c9,8|-2|0xf6e4c2,-9|-27|0xfee1b8,7|-27|0xfddfb2'
    return findColorsUntil(0xa7703f, offset, 100, 258, 77, 606, 370, {orient = 2}, 500, 1)
end

-- 背包出售
function bagSell()
    local offset = '-225|240|0x875832,-83|239|0x875832,-31|243|0x6c310a,-23|242|0x70350e,-148|393|0xecbe5f'
    return findColorsUntil(0xbf1500, offset, 100, 394, 85, 741, 540, {orient = 2}, 500, 1)
end

-- 珍品出售
function zhenpin()
    local offset = '-292|152|0x8cd626,-273|147|0x36bf7f,-120|153|0x81532a,97|285|0xffe195'
    return findColorsUntil(0xc01500, offset, 100, 562, 56, 991, 335, {orient = 2}, 500, 1)
end

-- 普通出售
function simple()
    local offset =
        '-236|359|0x875832,-25|360|0x875832,-105|483|0x6c310a,-85|492|0x6c310a,-58|490|0x6c310a,-30|485|0x6c310a'
    return findColorsUntil(0xc01500, offset, 90, 559, 43, 913, 587, {orient = 2}, 500, 1)
end

function baitan_logo()
    local offset =
        '-13|-3|0xfef9b0,-35|-3|0xfef9b0,394|-9|0xce0000,296|33|0x713710,298|42|0x6c310a,321|40|0x6c310a,337|40|0x6c310a'
    return findColorsUntil(0xfefdb8, offset, 90, 464, 13, 1024, 117, {orient = 2}, 500, 1)
end

-- 上架成功的提示
function shangjia_success1()
    local offset = '168|59|0xedbf60,125|-148|0xe01500,145|-134|0xe01500,169|-136|0xe01500,194|-136|0xe01500'
    return findColorsUntil(0x82532a, offset, 90, 358, 220, 781, 525, {orient = 2}, 500, 1)
end
-- 超时上架
function expire()
    local offset = '34|5|0x70350d,20|11|0xecbe5f,191|4|0x6e330b,210|-1|0x6d320a,216|10|0x6c310a'
    return findColorsUntil(0x6e330b, offset, 90, 566, 498, 906, 566, {orient = 2}, 500, 1)
end

-- 商城页面
function baitanPage()
    local offset = '47|392|0xffdd6d,45|402|0xffdd6d,45|423|0xffdd6d,35|424|0xffdc6d,36|315|0x6c310a,36|334|0x6c310a'
    return findColorsUntil(0xce0000, offset, 90, 947, 11, 1064, 500, {orient = 2}, 500, 1)
end

function shanghui_logo()
    local offset = '-331|-530|0xfefcb7,-316|-531|0xfefbb6,-347|-530|0xfefdb8,-369|-531|0xfefbb6,-358|-536|0xfdf6a7'
    return findColorsUntil(0xecb555, offset, 90, 493, 8, 994, 606, {orient = 2}, 500, 1)
end

function empty_store()
    local offset =
        '12|0|0xb58d6a,13|12|0xb58d6a,0|12|0xb58d6a,-35|6|0xdfc2a0,44|9|0xdfc2a0,5|45|0xdfc2a0,-9|-33|0xdfc2a0'
    return findColorsUntil(0xb58d6a, offset, 90, 120, 124, 547, 549, {orient = 2}, 500, 1)
end

-- 第一个仓库
function first_store()
    local offset = '67|2|0xf3d4aa,88|-46|0xf7e6c5,-3|-42|0xf8e5c5,304|-83|0x875832,313|-96|0x875832'
    return findColorsUntil(0xf3d5ac, offset, 90, 127, 73, 545, 211, {orient = 2}, 500, 1)
end
