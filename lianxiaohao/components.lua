-- 敬请期待
function jingqingqidai()
    local offset = '23|-1|0xe061fc,29|-7|0xe061fc,61|-2|0xde61f9,49|0|0xe061fc'
    return findColorsUntil(0xe061fc, offset, 90, 854, 91, 1134, 424, {orient = 2}, 500, 1)
end

-- 对话框跳出来的选项
function dialogSelection()
    local offset = '1|32|0xf3d095,55|19|0xf3d5af,-69|30|0xf2d09a'
    return findColorsUntil(0xf4dec0, offset, 90, 810, 81, 1111, 490, {orient = 2}, 500, 1)
end

-- 使用道具
function useProp()
    local offset = '13|1|0x70350c,42|-1|0xeec363,48|15|0x6c310a,36|11|0x6c310a'
    return findColorsUntil(0x6c310a, offset, 90, 894, 329, 1049, 553, {orient = 2}, 500, 1)
end

-- 点击跳过
function skip()
    local offset = '-1|11|0x644637,4|6|0x644637,15|6|0x644637,10|1|0x644637,10|12|0x644637'
    return findColorsUntil(0x644637, offset, 90, 922, 8, 1117, 58, {orient = 2}, 500, 1)
end

-- 福利-领装备
function lingzhuangbei()
    local offset = '32|-3|0x6c310a,55|-2|0x6c310a,85|6|0x6c310a,74|5|0xe9ab54,-17|5|0xe8a953'
    return findColorsUntil(0x6c310a, offset, 90, 169, 93, 353, 585, {orient = 2}, 500, 1)
end

-- 宠物引导
function chongwuGuide()
    local offset = '23|21|0xdd9922,7|-117|0xd9614e,9|-314|0xfef3b8,13|-298|0xf44326'
    return findColorsUntil(0x77dd33, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 技能引导
function jinengGuide()
    local offset = '16|17|0x88aabb,1|-120|0xd9614e,2|-327|0x43bdf0,17|-302|0x184ec9'
    return findColorsUntil(0xbbcccc, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 助战引导
function zhuzhanGuide()
    local offset = '7|5|0x553923,7|33|0x553923,-1|-82|0xff1a1a,23|-97|0xd47f1c,34|-82|0x922c04,4|39|0x553923'
    return findColorsUntil(0x553923, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 师门引导
function shimenGuide()
    local offset = '12|3|0xddaa11,-5|-122|0xd9614e,-8|-327|0xeeee22,14|-309|0xeedd22'
    return findColorsUntil(0xffee55, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 红尘试炼引导
function hongchenGuide()
    local offset = '9|-2|0xbb2222,-15|-137|0xd9614e,-7|-318|0xdd9955,-7|-326|0x110011'
    return findColorsUntil(0xcc2211, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 见面礼,充值
function jianmianli()
    local offset = '-253|22|0xe2535d,-294|212|0x2b1e20,-258|428|0x29b47a,-227|235|0x58d8cf'
    return findColorsUntil(0xffe03f, offset, 90, 292, 26, 895, 516, {orient = 2}, 500, 1)
end

-- 推荐师傅
function zhaoshifu()
    local offset = '-180|63|0x81522a,-433|173|0x80522a,-599|297|0x427bdd,-573|337|0xfff2a4,-597|369|0x301312'
    return findColorsUntil(0xffe7b8, offset, 90, 181, 96, 930, 573, {orient = 2}, 500, 1)
end

-- 跳过剧情
function tiaoguojuqing()
    local offset = '12|0|0x644637,-48|3|0x624436,-85|-1|0x644637,-178|-1|0x644637'
    return findColorsUntil(0x644637, offset, 90, 459, 8, 1132, 73, {orient = 2}, 500, 2)
end

-- 跳过对话
function tiaoguoduihua()
    local offset = '2|11|0x644637,18|6|0x644637,-34|2|0xeee1cf,-36|9|0xeee1cf'
    return findColorsUntil(0x644637, offset, 90, 869, 36, 1125, 75, {orient = 2}, 500, 1)
end

function guideTap()
    local offset = '0|7|0xffda35,-4|15|0xffda34,-14|17|0xffd933,0|12|0xffda34'
    return findColorsUntil(0xffdb35, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 2)
end

-- 师傅的来信
function shifulaixin()
    local offset = '-28|-4|0x51e414,-92|-7|0x51e414,-80|-3|0x51e414,-67|-1|0x51e414'
    return findColorsUntil(0x51e414, offset, 90, 902, 147, 1134, 454, {orient = 2}, 1000, 2)
end

-- 首页的任务tab
function taskTab()
    local offset = '16|-1|0xeaf1bc,16|12|0xb47872,-1|28|0x002a7b,23|24|0xad8329'
    return findColorsUntil(0xd2e6ae, offset, 90, 902, 86, 1029, 161, {orient = 2}, 500, 1)
end

-- 师门任务
function shimenrenwu()
    local offset = '12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c'
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end

function zhuangbeiButton()
    local offset = '4|10|0x6c310a,28|10|0x6c310a,20|16|0x6c310a,17|12|0xecbe5f'
    return findColorsUntil(0x6e330b, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 1)
end

-- 提升引导
function tishengGuide()
    local offset = '-19|-306|0xd87315,-11|-301|0xd06212,-23|-126|0xd9614e,50|50|0xe69b5e'
    return findColorsUntil(0xff3377, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 1)
end

-- 推荐师傅
function shifutuijian()
    local offset = '32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c'
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575, {orient = 2}, 500, 2)
end

-- 一路同行,师傅来信后的弹窗
function yilutongxing()
    local offset = '19|95|0xc57448,33|208|0x698e7c,4|203|0x63917e,54|204|0xd29567'
    return findColorsUntil(0xb35b41, offset, 90, 176, 162, 305, 477, {orient = 2}, 500, 1)
end

-- 剧情难度提示
function zhandounandu()
    local offset = '31|-1|0x8d5d2c,52|5|0x8d5d2c,98|-4|0x8d5d2c,202|4|0x8d5d2c,274|6|0x8d5d2c'
    return findColorsUntil(0x8d5d2c, offset, 90, 375, 248, 765, 404, {orient = 2}, 500, 2)
end

-- 创建角色
function chuangjianjuese()
    local offset = '0|-12|0x67d70f,-13|0|0x53c712,14|1|0x51c612,0|14|0x3cb716,16|18|0xb98f69'
    return findColorsUntil(0x53c712, offset, 90, 335, 60, 1027, 620, {orient = 2}, 500, 1)
end

-- 创建角色下一步
function xiayibu()
    local offset = '2|10|0xf6b047,93|9|0xf6af46,93|-3|0xf5b245'
    return findColorsUntil(0xf5b146, offset, 90, 915, 574, 1080, 611, {orient = 2}, 500, 1)
end

-- 随机名字
function randomName()
    local offset = '-12|17|0xf4dab2,16|21|0xeec396,1|28|0xca6829'
    return findColorsUntil(0xff6220, offset, 90, 1045, 483, 1099, 536, {orient = 2}, 500, 1)
end

-- 选择引导人
function chooseGuide()
    local offset = '281|-129|0x84c89f,11|-260|0xfee57d,-280|-185|0x57b6d1,376|-397|0xfbf0c8,-200|-116|0x56a60f'
    return findColorsUntil(0xecbe5f, offset, 90, 92, 80, 1037, 568, {orient = 2}, 500, 1)
end

-- 新手调查
function investigation()
    local offset = '8|94|0xf96c4e,109|29|0xfff6d5,-125|105|0xb81621,145|104|0xbb1621,-28|266|0xefc263'
    return findColorsUntil(0xfe3e56, offset, 90, 282, 78, 820, 519, {orient = 2}, 500, 1)
end

-- 背包
function bag()
    local offset = '-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba'
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606, {orient = 2}, 500, 1)
end

function chongwu2()
    local offset = '78|2|0xa6c82b,0|24|0x83bc24,3|47|0xd0a972,336|-15|0xffdd5a,445|74|0xffdf5d'
    return findColorsUntil(0x80bd22, offset, 90, 332, 191, 977, 443, {orient = 2}, 500, 1)
end

function chongwu3()
    local offset = '74|0|0xfdde0b,44|-39|0xfdf471,35|35|0xfdde0b,69|-374|0xc25a54'
    return findColorsUntil(0xfdde0b, offset, 90, 132, 63, 372, 559, {orient = 2}, 500, 1)
end

function jineng2()
    local offset = '-5|91|0x553a23,444|336|0xeebe5b,-17|-29|0x3fb5ef,31|160|0xd9956b'
    return findColorsUntil(0x1345c4, offset, 90, 100, 92, 1015, 551, {orient = 2}, 500, 1)
end

function zhuzhan22()
    local offset = '722|106|0xfcd873,716|221|0xf0e3d3,26|10|0x802101,320|254|0xdfc19e,435|138|0x483722'
    return findColorsUntil(0xff2020, offset, 90, 93, 19, 1028, 624, {orient = 2}, 500, 1)
end

function hongchen2()
    local offset = '495|25|0xfe7253,-8|-309|0xdd9962,807|-322|0xb91f28'
    return findColorsUntil(0xfdc667, offset, 90, 93, 19, 1028, 624, {orient = 2}, 500, 1)
end

function shimen2()
    local offset = '295|264|0xdd2ac7,274|269|0xefaddf,-11|11|0xf7dd5d,498|218|0xaa5d33'
    return findColorsUntil(0xf9f322, offset, 90, 93, 19, 1028, 624, {orient = 2}, 500, 1)
end

function tisheng2()
    local offset = '591|90|0x853498,450|358|0xe8a64b,10|-20|0xea9c1d'
    return findColorsUntil(0xd36312, offset, 90, 102, 92, 1020, 545, {orient = 2}, 500, 1)
end

function tip()
    local offset = '-132|-122|0xe9d5ba,201|-94|0xeddfce,200|-2|0xeddfcd,-129|-3|0xeddfcc'
    return findColorsUntil(0xedc060, offset, 90, 352, 218, 787, 422, {orient = 2}, 500, 1)
end

-- 创建角色页面
function createRolePage()
    local offset =
        '-840|53|0xb9b4ad,-490|-11|0x6c310a,-438|-2|0x6c310a,-409|-8|0x6c310a,-384|-7|0x6c310a,-385|0|0x6c310a'
    return findColorsUntil(0xce0000, offset, 90, 109, 13, 1043, 173, {orient = 2}, 500, 1)
end

-- 选择角色页面
function chooseRolePage()
    local offset = '78|16|0xe7e6ff,77|-7|0xe7e6ff,915|550|0xf5b146,1028|548|0xf5b045'
    return findColorsUntil(0xfce398, offset, 90, 0, 0, 1114, 621, {orient = 2}, 500, 1)
end

-- 起名的页面
function qimingPage()
    local offset = '-18|14|0x6c310a,-8|14|0x6c310a,19|17|0x6c310a,-156|91|0xf5af46,-35|89|0xf5b045'
    return findColorsUntil(0xefdbc1, offset, 90, 860, 471, 1125, 624, {orient = 2}, 500, 1)
end

-- 助战page
function zhuzhanPage()
    local offset = '81|-12|0x8be5fe,167|1|0xf33a90,256|-8|0xa6c4ff,346|3|0xacd234'
    return findColorsUntil(0xf88011, offset, 90, 121, 562, 570, 622, {orient = 2}, 500, 1)
end

--  人物属性
function statusPage()
    local offset = '39|112|0x48301e,36|249|0x48301e,37|344|0x48301e,47|345|0x48301e,40|368|0x48301e,-49|186|0x936324'
    return findColorsUntil(0xce0000, offset, 90, 891, 7, 1046, 493, {orient = 2}, 500, 1)
end

-- 跳过动画
function skipCartoon()
    local offset = '-69|-3|0x000000,-112|-3|0x000000,-176|-3|0x000000,121|4|0x000000'
    return findColorsUntil(0x000000, offset, 90, 200, 16, 1128, 76, {orient = 2}, 500, 1)
end

-- 去见师傅(师门引导的前置任务)
function qujianshifu()
    local offset = '36|-7|0xfaefd4,74|-4|0xf9eed3,82|-2|0xfaefd4,109|7|0xfaefd4,43|-30|0x4ad013,25|-32|0x51e414'
    return findColorsUntil(0xfaefd4, offset, 90, 906, 149, 1132, 490, {orient = 2}, 1000, 2)
end

-- 师门任务类型选择页面
function shimenTypeChoosePage()
    local offset = '6|6|0xef3d47,48|-362|0xffe7b8,59|-365|0xc5311b,7|-18|0xff5362'
    return findColorsUntil(0xa84407, offset, 90, 876, 81, 1015, 538, {orient = 2}, 500, 1)
end
