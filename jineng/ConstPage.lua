--[[
助战
]]
require("TSLib")

jn = require("jineng.index")
-- TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

page = {}

function page.index()
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = jn, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {
            ["now"] = "2",
            ["name"] = "打开技能",
            ["class"] = jn,
            ["method"] = "open",
            ["next"] = "3"
        },
        ["3"] = {["now"] = "3", ["name"] = "升级技能", ["class"] = jn, ["method"] = "upgrade", ["next"] = "4"}
    }
    return page
end

return page
