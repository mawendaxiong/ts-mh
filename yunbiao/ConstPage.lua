--[[
运镖
]] require("TSLib")

local yunbiao = require("yunbiao.index")
local renwuban = require("renwuban.index")
local Common = require("Common.index")

local page = {}
function page.index()
    renwuban.new("yunbiao")
    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = yunbiao,
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
            ["name"] = "打开活动面板",
            ["class"] = renwuban,
            ["method"] = "open",
            ["next"] = "3"
        },
        ["3"] = {
            ["now"] = "3",
            ["name"] = "查找任务并打开",
            ["class"] = yunbiao,
            ["method"] = "findTaskOnTaskBoard",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "执行运镖",
            ["class"] = yunbiao,
            ["method"] = "excute",
            ["next"] = "1"
        }
    }
    return page
end
return page
