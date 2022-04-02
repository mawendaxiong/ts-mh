require("TSLib")
init(1)

offset = "-132|-122|0xe9d5ba,201|-94|0xeddfce,200|-2|0xeddfcd,-129|-3|0xeddfcc"
r, t, x, y = findColorsUntil(0xedc060, offset, 90, 352, 218, 787, 422, {orient = 2}, 500, 1)
toast(x .. "," .. y)
