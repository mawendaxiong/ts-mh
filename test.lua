require("TSLib")
init(1)

x, y =
    findMultiColorInRegionFuzzy(
    0xbb66aa,
    "-9|-16|0xbb9955,6|51|0xffeedd,13|73|0xff9977",
    90,
    604,
    102,
    804,
    272,
    {orient = 2}
)

toast(x .. "," .. y)
