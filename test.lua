require("TSLib")
init(1)

-- tap(600, 400)
x, y =
    findMultiColorInRegionFuzzy(
    0x64120f,
    "18|6|0xa9622c,153|4|0xac2946,207|-2|0x35d3a8,227|3|0x0a5ea5",
    90,
    201,
    0,
    631,
    72,
    {orient = 2}
)

toast(x .. "," .. y)
