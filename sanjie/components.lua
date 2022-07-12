-- 三界奇缘结束
function finish()
    local offset = '-9|-16|0xbb9955,6|51|0xffeedd,13|73|0xff9977'
    return findColorsUntil(0xbb66aa, offset, 90, 604, 102, 804, 272, {orient = 2}, 500, 1)
end

-- 三界奇缘的页面
function sanjiePage()
    local offset = '28|3|0x9e5811,52|4|0x9e5811,68|-2|0x9e5811,95|6|0x9e5811,111|-2|0xa3601b,149|5|0xd3a981'
    return findColorsUntil(0xd2a780, offset, 90, 190, 415, 388, 476, {orient = 2}, 500, 1)
end
