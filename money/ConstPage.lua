--[[
使用体力
]] require("TSLib")

local money = require("money.index")
local Common = require("Common.index")

local page = {}

function page.index()
    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = money,
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
            ["name"] = "打开人物属性",
            ["class"] = money,
            ["method"] = "openUserTab",
            ["next"] = "3"
        },
        ["3"] = {
            ["now"] = "3",
            ["name"] = "打开活力",
            ["class"] = money,
            ["method"] = "openDetailTab",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "使用活力",
            ["class"] = money,
            ["method"] = "use",
            ["next"] = "1"
        }

    }

    return page
end

return page
