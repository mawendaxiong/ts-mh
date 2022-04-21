--[[
练小号
]]
require("TSLib")

denglu = require("denglu.index")
-- TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

page = {}

function page.index()
    page = {
        ["-1"] = {["now"] = "-1", ["name"] = "闪退补偿", ["class"] = denglu, ["method"] = "crashCallack"},
        ["1"] = {["now"] = "1", ["name"] = "创建角色", ["class"] = denglu, ["method"] = "restartGame", ["next"] = "2"},
        ["2"] = {
            ["now"] = "2",
            ["name"] = "跳过动画",
            ["class"] = denglu,
            ["method"] = "waitLoginPage",
            ["next"] = "3"
        },
        ["3"] = {["now"] = "3", ["name"] = "选择角色", ["class"] = denglu, ["method"] = "accountType", ["next"] = "4"},
        ["4"] = {["now"] = "4", ["name"] = "起名", ["class"] = denglu, ["method"] = "inputAccountPasswd", ["next"] = "5"},
        ["5"] = {["now"] = "5", ["name"] = "等待战斗结束", ["class"] = denglu, ["method"] = "selectServer", ["next"] = "6"},
        ["5"] = {["now"] = "5", ["name"] = "新手调查", ["class"] = denglu, ["method"] = "selectServer", ["next"] = "6"},
        ["6"] = {["now"] = "6", ["name"] = "执行", ["class"] = denglu, ["method"] = "closeWindow", ["next"] = "1"}
    }
    return page
end
return page
--[[
1.0级的时候点击领取装备,不是直接弹出福利窗口领取,后续升级胡会自动打开

2.宠物引导,会打开宠物对话框

3.点击10的礼包会自动打开领取装备的界面,点了领取装备,装备不会自动穿上

4.门派技能引导,不会自动打开技能框

5.助战引导,不会自动打开助战界面

6.点了去做师门任务,会去打开师傅来信,首次的师门任务需用通过完成师门来信来解锁
]]
