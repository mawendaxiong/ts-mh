require("TSLib")
init(1)

-- 右上角小红人
function miniRedManLogo()
    offset = "-29|15|0xbfe7f8,-26|22|0xc0e8f8,2|29|0xa7442c"
    return findColorsUntil(0xb3454f, offset, 90, 1041, 10, 1119, 77, {orient = 2}, 500, 1)
end
state = runApp("com.netease.my")

while true do
    -- 右上角不是小红人
    if not miniRedManLogo() then
        -- 跳过打开游戏时的动画
        tap(100, 100)
        mSleep(1000)
    else
        toast("b1")
        break
    end
end

while true do
    -- 可以看见右上角小红人
    if miniRedManLogo() then
        -- 一直点击登录游戏
        tap(564, 493)
        mSleep(1000)
    else
        toast("b2")
        break
    end
end
