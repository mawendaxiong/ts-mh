--[[
捉鬼
]]
require("TSLib")

TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

LeadTeam = require("Ghost.LeadTeam")
JoinTeam = require("Ghost.JoinTeam")

createGobalTable("globalGhost")

page = {}

function page.leadTeam()
    TaskBoard.new("zhuogui")

    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = LeadTeam, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {["now"] = "2", ["name"] = "检查人数", ["class"] = LeadTeam, ["method"] = "checkTeamMember", ["next"] = "3"},
        ["3"] = {["now"] = "3", ["name"] = "打开便捷组队", ["class"] = LeadTeam, ["method"] = "simpleGroup", ["next"] = "4"},
        ["4"] = {["now"] = "4", ["name"] = "调整等级", ["class"] = LeadTeam, ["method"] = "fixLevel", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "等人", ["class"] = LeadTeam, ["method"] = "waitTeamMember", ["next"] = "6"},
        ["6"] = {["now"] = "6", ["name"] = "打开活动面板", ["class"] = TaskBoard, ["method"] = "open", ["next"] = "7"},
        ["7"] = {["now"] = "7", ["name"] = "查找任务并打开", ["class"] = TaskBoard, ["method"] = "findTask", ["next"] = "8"},
        ["8"] = {["now"] = "8", ["name"] = "去钟馗", ["class"] = LeadTeam, ["method"] = "go2Zhongkui", ["next"] = "9"},
        ["9"] = {["now"] = "9", ["name"] = "领取任务", ["class"] = LeadTeam, ["method"] = "getTask", ["next"] = "10"},
        ["10"] = {["now"] = "10", ["name"] = "检查提示", ["class"] = LeadTeam, ["method"] = "checkTip", ["next"] = "11"},
        ["11"] = {["now"] = "11", ["name"] = "找任务", ["class"] = LeadTeam, ["method"] = "findTask", ["next"] = "12"},
        ["12"] = {
            ["now"] = "12",
            ["name"] = "检查一轮鬼",
            ["class"] = LeadTeam,
            ["method"] = "checkRoundOver",
            ["next"] = "13"
        },
        ["13"] = {["now"] = "13", ["name"] = "检查次数", ["class"] = LeadTeam, ["method"] = "checkGhostNum", ["next"] = "1"}
    }
    return page
end

function page.joinTeam()
    TaskBoard.new("zhuogui")

    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = JoinTeam, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "回长安", ["class"] = Common, ["method"] = "b2a", ["next"] = "2"},
        ["2"] = {["now"] = "2", ["name"] = "打开队伍", ["class"] = JoinTeam, ["method"] = "openTeam", ["next"] = "3"},
        ["3"] = {["now"] = "3", ["name"] = "打开便捷组队", ["class"] = JoinTeam, ["method"] = "simpleGroup", ["next"] = "4"},
        ["4"] = {["now"] = "4", ["name"] = "等待加入队伍", ["class"] = JoinTeam, ["method"] = "waitTeam", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "检查状态", ["class"] = JoinTeam, ["method"] = "checkStatus", ["next"] = "6"},
        ["6"] = {
            ["now"] = "6",
            ["name"] = "检查战斗状态",
            ["class"] = JoinTeam,
            ["method"] = "checkBattleStatus",
            ["next"] = "7"
        },
        ["7"] = {["now"] = "7", ["name"] = "统计捉鬼次数", ["class"] = JoinTeam, ["method"] = "checkGhostNum", ["next"] = "1"}
    }

    return page
end

return page
