-- 新的一周提示
function newWeekSection()
    local offset = '47|2|0x6e2b00,93|0|0x6e2b00,209|133|0xfdefe9,205|155|0xf95c7c'
    return findColorsUntil(0x6e2b00, offset, 90, 675, 94, 990, 412, {orient = 2}, 500, 1)
end

function openButton()
    local offset = '8|0|0x553923,28|1|0x553923,48|1|0xf2d6af,59|6|0x553923,72|5|0x553923,87|-10|0x563a24'
    return findColorsUntil(0x553923, offset, 90, 813, 82, 1135, 491, {orient = 2}, 500, 1)
end

-- 右边 [秘境降妖]
function task()
    local offset = '21|4|0xffff00,38|15|0xf9f901,57|3|0xffff00,76|8|0xffff00,71|17|0xffff00'
    return findColorsUntil(0xffff00, offset, 90, 898, 197, 1134, 284, {orient = 2}, 500, 1)
end

-- 右侧 [地图]按钮
function unchartedMap()
    local offset = '0|16|0xeccf7b,25|3|0xf9edba,32|18|0xeacb74,44|16|0xeccf7b'
    return findColorsUntil(0xfbf3c7, offset, 90, 897, 246, 1132, 329, {orient = 2}, 500, 1)
end

-- 失败
function fail()
    local offset = '22|18|0xc2e0f4,144|41|0xa1c1db,-89|19|0x404040,245|-6|0x9a2833'
    return findColorsUntil(0xd4e8f7, offset, 90, 307, 111, 805, 291, {orient = 2}, 500, 1)
end

-- 选择秘境关卡的页面
function mijingPage()
    local offset = '-482|34|0xa67f61,-496|-53|0xf2c35b,-441|-29|0xfef4bb,-340|-51|0xf5c157'
    return findColorsUntil(0xb91f28, offset, 90, 63, 3, 1092, 164, {orient = 2}, 500, 1)
end

-- 进入了秘境的页面
function mijingInnerPage()
    local offset = '19|-1|0xcb7823,-8|11|0xff2322,17|19|0x822a0d,-648|160|0x7ebb41'
    return findColorsUntil(0xf6e3d4, offset, 90, 1, 1, 768, 240, {orient = 2}, 500, 1)
end
