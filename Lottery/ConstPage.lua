--[[
刮刮乐
]]
require("TSLib")

TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

Lottery = require("Lottery.index")

page = {}
function page.index()
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = Escort, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {["now"] = "2", ["name"] = "打开福利", ["class"] = Lottery, ["method"] = "openWelfareBox", ["next"] = "3"},
        ["3"] = {
            ["now"] = "3",
            ["name"] = "打开刮刮乐",
            ["class"] = Lottery,
            ["method"] = "openScratch",
            ["next"] = "4"
        },
        ["4"] = {["now"] = "4", ["name"] = "刮奖", ["class"] = Lottery, ["method"] = "Scratch", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "关闭", ["class"] = Lottery, ["method"] = "close", ["next"] = "6"}
    }
    return page
end
return page
