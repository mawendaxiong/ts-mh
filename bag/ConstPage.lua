--[[
宝图
]] require("TSLib")

local renwuban = require("renwuban.index")
local Common = require("Common.index")
local bagFunc = require("bag.index")

local page = {}

function page.index()

    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = bagFunc,
            ["method"] = "crashCallack"
        },
        ["1"] = {
            ["now"] = "1",
            ["name"] = "回长安",
            ["class"] = Common,
            ["method"] = "b2a",
            ["next"] = "2"
        },
        ["2"] = {
            ["now"] = "2",
            ["name"] = "打开商城",
            ["class"] = bagFunc,
            ["method"] = "openMall",
            ["next"] = "3"
        },
        ["3"] = {
            ["now"] = "3",
            ["name"] = "切换商会",
            ["class"] = bagFunc,
            ["method"] = "switch_shanghui",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "商会出售",
            ["class"] = bagFunc,
            ["method"] = "sell_shanghui",
            ["next"] = "5"
        },
        ["5"] = {
            ["now"] = "5",
            ["name"] = "切换摆摊",
            ["class"] = bagFunc,
            ["method"] = "switch_baitan",
            ["next"] = "6"
        },
        ["6"] = {
            ["now"] = "6",
            ["name"] = "摆摊出售",
            ["class"] = bagFunc,
            ["method"] = "sell_baitan",
            ["next"] = "7"
        },
        ["7"] = {
            ["now"] = "7",
            ["name"] = "关闭商城",
            ["class"] = bagFunc,
            ["method"] = "close_market",
            ["next"] = "8"
        },
        ["8"] = {
            ["now"] = "8",
            ["name"] = "打开背包",
            ["class"] = bagFunc,
            ["method"] = "open_bag",
            ["next"] = "9"
        },
        ["9"] = {
            ["now"] = "9",
            ["name"] = "清理背包",
            ["class"] = bagFunc,
            ["method"] = "clear_bag",
            ["next"] = "1"
        }
    }
    return page
end
return page
