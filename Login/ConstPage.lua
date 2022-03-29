--[[
押镖
]]
require("TSLib")

Login = require("Login.index")
TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

page = {}
function page.index()
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = Escort, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "重启游戏", ["class"] = Login, ["method"] = "restartGame", ["next"] = "2"},
        ["2"] = {
            ["now"] = "2",
            ["name"] = "等登录界面",
            ["class"] = Login,
            ["method"] = "waitLoginPage",
            ["next"] = "3"
        },
        ["3"] = {["now"] = "3", ["name"] = "账号类型", ["class"] = Login, ["method"] = "accountType", ["next"] = "4"},
        ["4"] = {["now"] = "4", ["name"] = "账号密码", ["class"] = Login, ["method"] = "inputAccountPasswd", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "选区", ["class"] = Login, ["method"] = "selectServer", ["next"] = "6"},
        ["6"] = {["now"] = "6", ["name"] = "关闭弹窗", ["class"] = Login, ["method"] = "closeWindow", ["next"] = "1"}
    }
    return page
end
return page
