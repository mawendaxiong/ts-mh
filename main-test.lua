init(1)
require('TSLib')
function rightTask()
    local offset = '12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c'
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end

local r, t, x, y = rightTask()
toast(x .. ',' .. y)
-- tap(x,y)
