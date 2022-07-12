-- 活跃值不足50点
function enough50()
    local offset = '1|11|0x8d5d2c,6|10|0x8d5d2c,9|5|0xede0cf,12|7|0x8d5d2c,25|0|0x8d5d2c,23|15|0x8d5d2c'
    return findColorsUntil(0x8d5d2c, offset, 90, 361, 212, 775, 349, {orient = 2}, 500, 2)
end
-- 押送按钮
function escortButton()
    local offset = '0|3|0xf2d8b6,7|3|0x553923,8|17|0x5f432b,26|11|0x553923,28|8|0xeccfaa,37|17|0x654930'
    return findColorsUntil(0x5a3e28, offset, 90, 816, 264, 1106, 454, {orient = 2}, 500, 2)
end

-- 确认运镖
function confirm()
    local offset = '-123|-62|0xb3b3b3,-112|-63|0x77777f,-118|-55|0x84a6b3'
    return findColorsUntil(0xf1c868, offset, 90, 360, 239, 760, 401, {orient = 2}, 500, 2)
end

-- 运镖中的地图
function yunbiaozhong()
    local offset =
        '-7|0|0xfbe8c3,0|7|0xf7ddb9,1|16|0xe39505,-13|-1|0xf3b00b,0|-13|0xfac125,13|0|0xf0ac0a,-6|13|0xf5b909'
    return findColorsUntil(0xf1c868, offset, 90, 103, 17, 1044, 618, {orient = 2}, 500, 2)
end
