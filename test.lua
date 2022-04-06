require("TSLib")
init(1)

x, y =
    findMultiColorInRegionFuzzy(
    0x48301e,
    "5|2|0x48301e,18|2|0x48301e,38|8|0x533922,61|4|0xecbd5e,115|15|0xe4c39c,-278|29|0xe2ba8b,-228|-18|0xf2c465",
    90,
    341,
    129,
    802,
    511,
    {orient = 2}
)

toast(x .. "," .. y)
