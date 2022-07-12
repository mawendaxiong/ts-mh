-- 检查刮刮乐有没有被开过
function checkScratch()
    local offset = '-130|-84|0x6d6d6d,-83|-82|0x6d6d6d,-30|-80|0x6d6d6d,-94|-73|0x6d6d6d'
    return findColorsUntil(0xe02a22, offset, 90, 754, 423, 950, 590, {orient = 2}, 500, 1)
end

-- 福利页面
function fuliPage()
    local offset = '-359|-10|0x6c310a,-365|-10|0x6c310a,-375|-2|0x6c310a,-418|-18|0x6c310a,-417|-7|0x6c310a'
    return findColorsUntil(0xcf0000, offset, 90, 126, 8, 1022, 101, {orient = 2}, 500, 1)
end

function guagualePage()
    local offset = '-116|245|0x875832,-692|47|0xfff9cb,-726|57|0xffeb72'
    return findColorsUntil(0xcf0000, offset, 90, 239, 12, 1057, 324, {orient = 2}, 500, 1)
end
