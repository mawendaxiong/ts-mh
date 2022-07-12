function logo()
    local offset = '-4|14|0x30b5ef,0|28|0x2554c2,10|15|0x3266c7,-9|2|0x4ebce6'
    return findColorsUntil(0x4db7e5, offset, 90, 426, 564, 1064, 630, {orient = 2}, 500, 1)
end

-- 技能页面
function jinengPage()
    local offset = '-466|-16|0x764a2c,-429|-12|0x764a2c,-409|-20|0x764a2c,-281|526|0xebb151,-70|530|0xda8643'
    return findColorsUntil(0xce0000, offset, 90, 102, 20, 1035, 628, {orient = 2}, 500, 1)
end
