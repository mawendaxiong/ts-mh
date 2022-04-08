--[[
押镖
]]
require("TSLib")

sanjie = require("sanjie.index")
renwuban = require("renwuban.index")
Common = require("Common.index")

page = {}
function page.index()
    renwuban.new("sanjie")
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = sanjie, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "检查时间", ["class"] = sanjie, ["method"] = "checkTime", ["next"] = "2"},
        ["2"] = {["now"] = "2", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "3"},
        ["3"] = {["now"] = "3", ["name"] = "打开活动面板", ["class"] = renwuban, ["method"] = "open", ["next"] = "4"},
        ["4"] = {
            ["now"] = "4",
            ["name"] = "查找任务并打开",
            ["class"] = sanjie,
            ["method"] = "findTaskOnTaskBoard",
            ["next"] = "5"
        },
        ["5"] = {["now"] = "5", ["name"] = "答题", ["class"] = sanjie, ["method"] = "answer", ["next"] = "1"}
    }
    return page
end
return page
