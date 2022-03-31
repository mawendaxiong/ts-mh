require("TSLib")
init(1)

x, y =
    findMultiColorInRegionFuzzy(
    0xe50113,
    "9|8|0xe50113,16|6|0xe50113,32|7|0xe50113,44|17|0xe50113,61|-14|0xe50113",
    90,
    435,
    115,
    527,
    191,
    {orient = 2}
)
toast(x .. "," .. y)
