-- 领取宝图任务
function getTask()
    local offset =
        "3|0|0xf3d7b4,16|6|0x553923,27|0|0xf3d7b4,39|-7|0x5c402a,72|4|0x553923,75|2|0xf3d5b1"
    return findColorsUntil(0x553923, offset, 90, 806, 204, 1119, 492,
                           {orient = 2}, 1000, 2)
end

-- 领取任务后,右侧的任务
-- function rightTask()
--     local offset =
--         "7|4|0xf6ed1c,19|14|0xf8ef1c,34|-1|0xfcf31c,28|9|0xfcf31c,205|44|0xc31b09,196|46|0xd02310"
--     return findColorsUntil(0xfcf31c, offset, 90, 913, 144, 1134, 456,
--                            {orient = 2}, 500, 1)
-- end

-- 领取任务后,右侧的任务
function baotu_rightTask()
    local offset =
        "7|4|0xf6ed1c,19|14|0xf8ef1c,34|-1|0xfcf31c,28|9|0xfcf31c,205|44|0xc31b09,196|46|0xd02310"
    return findColorsUntil(0xfcf31c, offset, 90, 913, 144, 1134, 456,
                           {orient = 2}, 500, 1)
end

-- 宝图道具
function treasureMap()
    local offset = "-5|7|0x4ebb77,12|9|0x44bb77,4|10|0xff5f55,0|28|0xb58d6a"
    return findColorsUntil(0xff5555, offset, 90, 555, 126, 972, 543,
                           {orient = 2}, 500, 1)
end

-- 右下角使用宝图
function useTreasureMap()
    local offset =
        "-15|-109|0xeedd66,-5|-105|0xff4444,6|-99|0x44bb77,19|-103|0xffdd66"
    return findColorsUntil(0xedbf60, offset, 90, 895, 325, 1047, 550,
                           {orient = 2}, 500, 1)
end

-- 背包
function bag()
    local offset = "-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba"
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606,
                           {orient = 2}, 500, 1)
end