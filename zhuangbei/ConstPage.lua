--[[
助战
]]
require("TSLib")

local zb = require("zhuangbei.index")
-- TaskBoard = require("TaskBoard.index")
local Common = require("Common.index")

local page = {}

function page.index()
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = zb, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {
            ["now"] = "2",
            ["name"] = "打开背包",
            ["class"] = zb,
            ["method"] = "open",
            ["next"] = "3"
        },
        ["3"] = {["now"] = "3", ["name"] = "佩戴装备", ["class"] = zb, ["method"] = "adjust", ["next"] = "4"}
    }
    return page
end
return page
