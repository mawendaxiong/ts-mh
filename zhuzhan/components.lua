function logo()
    local offset = '13|-21|0xfcaf45,24|9|0x872c10,10|13|0xfef3ea,-5|-13|0xce7b36'
    return findColorsUntil(0xff2423, offset, 90, 519, 557, 1135, 628, {orient = 2}, 500, 1)
end

-- 添加助战 棕色的加号
function addLogo()
    local offset = '-13|2|0x997352,14|0|0x967050,0|-12|0x997252,0|16|0x9a7453,17|17|0xb08758'
    return findColorsUntil(0x9b7554, offset, 90, 577, 133, 994, 244, {orient = 2}, 500, 1)
end

-- 添加助战的绿色箭头
function addHelper()
    local offset = '-6|6|0x70e308,7|6|0x70e308,0|6|0x70e308,0|21|0x49b20c'
    return findColorsUntil(0x80f50c, offset, 90, 135, 67, 226, 550, {orient = 2}, 500, 1)
end

-- 助战page
function zhuzhanPage()
    local offset = '81|-12|0x8be5fe,167|1|0xf33a90,256|-8|0xa6c4ff,346|3|0xacd234'
    return findColorsUntil(0xf88011, offset, 90, 121, 562, 570, 622, {orient = 2}, 500, 1)
end
