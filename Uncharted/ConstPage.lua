--[[
秘境
]]
require("TSLib")

TaskBoard = require("TaskBoard.index")
Uncharted = require("Uncharted.index")
Common = require("Common.index")

page = {}

function page.index()
    TaskBoard.new("mijing")
    createGobalTable("uncharted")

    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = Uncharted, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {["now"] = "2", ["name"] = "打开活动面板", ["class"] = TaskBoard, ["method"] = "open", ["next"] = "3"},
        ["3"] = {
            ["now"] = "3",
            ["name"] = "查找任务并打开",
            ["class"] = TaskBoard,
            ["method"] = "findTask",
            ["next"] = "4"
        },
        ["4"] = {["now"] = "4", ["name"] = "等云乐游", ["class"] = Uncharted, ["method"] = "waitNPC", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "进入秘境", ["class"] = Uncharted, ["method"] = "getInto", ["next"] = "6"},
        ["6"] = {["now"] = "6", ["name"] = "计算次数", ["class"] = Uncharted, ["method"] = "count", ["next"] = "1"}
    }

    return page
end

return page
