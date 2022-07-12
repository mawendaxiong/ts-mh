-- 检查有没有勾上字段选择
function autoChoose()
    local offset = '12|1|0x58be45,7|7|0x73bf1e,21|-9|0x22be9e'
    return findColorsUntil(0x8cd626, offset, 90, 451, 464, 489, 502, {orient = 2}, 500, 1)
end

-- 没有自动选择,要自行选择的小任务
function unselectTask()
    local offset = '63|-1|0xf8e3c4,63|21|0xf3d6ae,2|21|0xf3d6ae'
    return findColorsUntil(0xf8e3c4, offset, 90, 348, 362, 978, 420, {orient = 2}, 500, 1)
end
-- 药店和武器店的购买
function weaponAndDrug()
    local offset = '-5|19|0xecb146,142|26|0xeba950,144|-2|0xefb651'
    return findColorsUntil(0xeeb956, offset, 90, 755, 480, 977, 563, {orient = 2}, 500, 2)
end

-- 师门结束,师门任务类型选择的,右侧的关闭按钮
function finish()
    local offset = '-10|13|0xf07144,14|11|0xba2a18,4|24|0xd93518,3|12|0xffe7b8'
    return findColorsUntil(0xf26b44, offset, 90, 969, 102, 1015, 170, {orient = 2}, 500, 1)
end

-- 选择任务类型时的 继续任务
function continueTask()
    local offset = '9|0|0x6c310a,36|-2|0x6c310a,32|3|0x6c320b,40|10|0x6c310a'
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423, {orient = 2}, 500, 1)
end

-- 选择任务类型时的 去完成
function startTask()
    local offset = '7|6|0x6c310a,14|14|0x6c310a,28|-3|0x6c310a,31|15|0x6c320b'
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423, {orient = 2}, 500, 1)
end

-- 点击门派师傅首次领取任务的 门派任务 字样
function chooseTask1()
    local offset = '19|8|0x553923,25|4|0x553923,50|6|0x593d27,87|12|0x5f422b,81|5|0x553923'
    return findColorsUntil(0x553923, offset, 90, 822, 166, 1105, 481, {orient = 2}, 500, 1)
end

-- 师门任务 -> 选择执行那种类型的师门
function chooseTask()
    local offset = '0|22|0xf4d7b0,113|24|0xf3d6ae,110|2|0xf8e3c4'
    return findColorsUntil(0xf8e6c5, offset, 90, 804, 6, 1107, 610, {orient = 2}, 500, 1)
end

function rightTask()
    local offset = '12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c'
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end

-- 使用道具
function useProp()
    local offset = '13|1|0x70350c,42|-1|0xeec363,48|15|0x6c310a,36|11|0x6c310a'
    return findColorsUntil(0x6c310a, offset, 90, 894, 329, 1049, 553, {orient = 2}, 500, 1)
end

-- 对话框跳出来的选项
function dialogSelection()
    local offset = '1|32|0xf3d095,55|19|0xf3d5af,-69|30|0xf2d09a'
    return findColorsUntil(0xf4dec0, offset, 90, 810, 81, 1111, 490, {orient = 2}, 500, 1)
end

-- 上交物品
function handIn()
    local offset = '-6|18|0x6c310a,7|18|0x6c310a,25|1|0x6c310a,26|14|0x6c310a,26|6|0xedc061'
    return findColorsUntil(0x6c310a, offset, 90, 750, 445, 1121, 548, {orient = 2}, 500, 1)
end

-- 摆摊购买
function shopping()
    local offset = '105|-126|0xea5419,145|-130|0xc72e1a,125|-100|0xf99804'
    return findColorsUntil(0xebb252, offset, 90, 799, 400, 1091, 618, {orient = 2}, 500, 1)
end

-- 右下角便携使用物品的关闭按钮
function cancelButton()
    local offset = '-7|-5|0xb90c00,8|-7|0xb80900,6|7|0xc60a00,-7|6|0xc10c00'
    return findColorsUntil(0xbf1500, offset, 90, 889, 301, 1055, 422, {orient = 2}, 500, 1)
end

-- 工坊
function workshop()
    local offset = '489|7|0xe2392a,414|8|0xffdc66,123|19|0xf4bf50,246|-8|0xa6612d'

    return findColorsUntil(0xe53c2c, offset, 90, 117, 4, 1048, 71, {orient = 2}, 500, 1)
end

function no_money()
    local offset =
        '-239|-3|0x764a2c,-230|-1|0x764a2c,-233|3|0x764a2c,-209|0|0x764a2c,-216|3|0x764a2c,-188|2|0x764a2c,-173|0|0x764a2c'
    return findColorsUntil(0xc01500, offset, 90, 513, 186, 799, 229, {orient = 2}, 500, 1)
end

-- 首页的任务tab
local function taskTab()
    local offset = '16|-1|0xeaf1bc,16|12|0xb47872,-1|28|0x002a7b,23|24|0xad8329'
    return findColorsUntil(0xd2e6ae, offset, 90, 902, 86, 1029, 161, {orient = 2}, 500, 1)
end

-- 购买宠物
local function buyPet()
    local offset = '-255|16|0x9e5f30,94|-531|0xce0000,-507|19|0x8d5d2c'
    return findColorsUntil(0xebb252, offset, 90, 116, 28, 1029, 617, {orient = 2}, 500, 1)
end

-- 福利-领装备
local function lingzhuangbei()
    local offset = '32|-3|0x6c310a,55|-2|0x6c310a,85|6|0x6c310a,74|5|0xe9ab54,-17|5|0xe8a953'
    return findColorsUntil(0x6c310a, offset, 90, 169, 93, 353, 585, {orient = 2}, 500, 1)
end

-- 检查是不是在选择任务的界面
local function checkChoosePage()
    local offset = '6|6|0xef3d47,48|-362|0xffe7b8,59|-365|0xc5311b,7|-18|0xff5362'
    return findColorsUntil(0xa84407, offset, 90, 876, 81, 1015, 538, {orient = 2}, 500, 1)
end

-- 推荐师傅
local function shifutuijian()
    local offset = '32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c'
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575, {orient = 2}, 500, 2)
end

local function shangjiaochongwu()
    local offset = '-77|425|0xecbe5f,-478|415|0x8d5d2c,-339|417|0x8d5d2c,-258|422|0x8d5d2c,-234|415|0x8d5d2c'
    return findColorsUntil(0xbf1500, offset, 90, 283, 73, 858, 561, {orient = 2}, 500, 2)
end
