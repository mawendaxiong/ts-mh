--  人物属性
function statusPage()
    local offset = '39|112|0x48301e,36|249|0x48301e,37|344|0x48301e,47|345|0x48301e,40|368|0x48301e,-49|186|0x936324'
    return findColorsUntil(0xce0000, offset, 90, 891, 7, 1046, 493, {orient = 2}, 500, 1)
end

-- 使用活力的详细页面
function useDetailPage()
    local offset = '-234|103|0xf7f722,-227|215|0x73dd37,-245|281|0xd5eedd,23|119|0xedbf5f'
    return findColorsUntil(0x875832, offset, 90, 572, 88, 929, 565, {orient = 2}, 500, 1)
end
