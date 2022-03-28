require("TSLib")
init(1)

x, y =
    findMultiColorInRegionFuzzy(
    0xbf1500,
    "-7|-5|0xb80c00,8|-5|0xba0c00,8|5|0xc40e00,-5|6|0xc30c00",
    90,
    994,
    306,
    1061,
    466,
    {orient = 2}
)

toast(x .. "," .. y)
