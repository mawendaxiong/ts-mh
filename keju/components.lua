function penLogo()
    local offset = '9|-8|0xab652e,14|-16|0xa9632e'
    return findColorsUntil(0xac662e, offset, 90, 426, 123, 466, 166, {orient = 2}, 500, 1)
end

function kejuPage()
    local offset = '9|0|0xf4f114,106|118|0x6c310a,129|118|0x6d320b,48|122|0x6c310a,53|115|0x6c310a'
    return findColorsUntil(0xac662e, offset, 90, 155, 416, 359, 588, {orient = 2}, 500, 1)
end
