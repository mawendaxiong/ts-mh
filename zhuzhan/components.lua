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
    local offset = '-411|-18|0x764a2c,-453|-13|0x764a2c,-453|-7|0x764a2c,-457|-13|0x764a2c,-447|-7|0x764a2c'
    return findColorsUntil(0xd10000, offset, 90, 498,13, 1029,59, {orient = 2}, 500, 1)
end
