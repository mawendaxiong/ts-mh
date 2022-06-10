--[[
宝图
]] require("TSLib")

renwuban = require("renwuban.index")
Common = require("Common.index")
baotu = require("baotu.index")

page = {}

function page.index()
    renwuban.new("baotu")

    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = baotu,
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
            ["class"] = baotu,
            ["method"] = "findTaskOnTaskBoard",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "领取任务",
            ["class"] = baotu,
            ["method"] = "getTask",
            ["next"] = "5"
        },
        ["5"] = {
            ["now"] = "5",
            ["name"] = "右侧查找任务",
            ["class"] = baotu,
            ["method"] = "findTask",
            ["next"] = "6"
        },
        ["6"] = {
            ["now"] = "6",
            ["name"] = "等待打宝图",
            ["class"] = baotu,
            ["method"] = "waitBattle",
            ["next"] = "7"
        },
        ["7"] = {
            ["now"] = "7",
            ["name"] = "打开背包",
            ["class"] = baotu,
            ["method"] = "openBag",
            ["next"] = "8"
        },
        ["8"] = {
            ["now"] = "8",
            ["name"] = "查找宝图",
            ["class"] = baotu,
            ["method"] = "findMap",
            ["next"] = "9"
        },
        ["9"] = {
            ["now"] = "9",
            ["name"] = "使用宝图",
            ["class"] = baotu,
            ["method"] = "excute",
            ["next"] = "1"
        },
        ["path"] = "baotu.ConstPage",
        ["func"] = "index"
    }
    return page
end
return page
