--[[
登录
]] require("TSLib")

denglu = require("denglu.index")
-- TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

page = {}

function page.index()
    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = denglu,
            ["method"] = "crashCallack"
        },
        ["1"] = {
            ["now"] = "1",
            ["name"] = "重启游戏",
            ["class"] = denglu,
            ["method"] = "restartGame",
            ["next"] = "2"
        },
        ["2"] = {
            ["now"] = "2",
            ["name"] = "等登录界面",
            ["class"] = denglu,
            ["method"] = "waitLoginPage",
            ["next"] = "3"
        },
        ["3"] = {
            ["now"] = "3",
            ["name"] = "账号类型",
            ["class"] = denglu,
            ["method"] = "accountType",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "账号密码",
            ["class"] = denglu,
            ["method"] = "inputAccountPasswd",
            ["next"] = "5"
        },
        ["5"] = {
            ["now"] = "5",
            ["name"] = "选区",
            ["class"] = denglu,
            ["method"] = "selectServer",
            ["next"] = "6"
        },
        ["6"] = {
            ["now"] = "6",
            ["name"] = "关闭弹窗处理",
            ["class"] = denglu,
            ["method"] = "closeWindow",
            ["next"] = "1"
        }
    }
    return page
end
return page
