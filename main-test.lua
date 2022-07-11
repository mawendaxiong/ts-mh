init(1)
require('TSLib')
-- 鬼怪画像
function guiguaihuaxiang_bag()
    offset = '15|3|0xaa4acc,-13|-2|0xb58d6a,-10|-31|0xb58d6a,38|-30|0xb58d6a,29|-14|0xd260d7'
    return findColorsUntil(0xbb33c6, offset, 90, 561, 137, 970, 534, {orient = 2}, 500, 1)
end

-- 捉鬼碎片页面
local function guiPage()
    offset =
        '-118|27|0x6c310a,-108|27|0x6c310a,-118|42|0x6c310a,-61|36|0x6c310a,-62|27|0x6c310a,-10|227|0xc58d5a,-10|239|0xc58d5a'
    return findColorsUntil(0xb91f28, offset, 100, 869, 35, 1031, 342, {orient = 2}, 500, 1)
end

-- 解锁捉鬼碎片
local function guilock()
    offset = '-8|-3|0xf6e6c9,8|-2|0xf6e4c2,-9|-27|0xfee1b8,7|-27|0xfddfb2'
    return findColorsUntil(0xa7703f, offset, 100, 258, 77, 606, 370, {orient = 2}, 500, 1)
end

-- local r, t, x, y = guilock()
-- toast(x .. ',' .. y)
-- tap(x,y)

for i = 1, 4, 1 do -- 最多四个碎片
    local r, t, x, y = guilock()
    if r then
        tap(x, y)
    end
    mSleep(2000)
end

tap(1018, 61) -- 关闭
mSleep(1000)

while true do
    if bag() then
        break
    end
    coroutine.yield('存放仓库异常', 'c2')
    mSleep(1000)
end
