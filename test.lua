require("TSLib")

init(1)
-- abc = "123456"

-- for var = 1, #abc do
--     foo = string.sub(abc, var, var)
--     if foo == '1' then
--         toast("haha: " .. foo, 2)
--     else
--         toast(foo, 2)
--     end
--     mSleep(2000)
-- end

-- str = string.match(abc, 12)
-- if str ~= nil then
--     toast(str)
-- end
-- r, t, x, y = findColorsUntil(0xebb252, offset, 90, 799, 400, 1091, 618, {orient = 2}, 500, 1)
-- 上交物品
local function fun1()
    offset = "12|9|0xfcf31c,17|7|0xfaf11c,32|2|0xfcf31c,20|-2|0xe6dd1e"
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end
local function fun2()
    return findColorsUntil(
        0xff5555,
        "-5|7|0x4ebb77,12|9|0x44bb77,4|10|0xff5f55,0|28|0xb58d6a",
        90,
        555,
        126,
        972,
        543,
        {orient = 2},
        500,
        1
    )
end

local function foo()
    toast("haha", 1)
    mSleep(1000)
    return true
end
ret = multiColTap({{36, 115, 0xe5d45b}, {315, 28, 0xd79a50}, {327, 31, 0xdab291}, {313, 41, 0x91471d}})

if fun2() then
    toast(111)
elseif foo() then
    toast(2222, 1)
end
