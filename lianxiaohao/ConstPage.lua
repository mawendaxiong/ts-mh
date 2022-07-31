--[[
练小号
]] require("TSLib")

lxh = require("lianxiaohao.index")
-- TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

page = {}

function page.index()
    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = lxh,
            ["method"] = "crashCallack"
        },
        --[[ ["1"] = {
            ["now"] = "1",
            ["name"] = "创建角色",
            ["class"] = lxh,
            ["method"] = "createRole",
            ["next"] = "2"
        }, ]]
        ["1"] = {
            ["now"] = "1",
            ["name"] = "跳动画",
            ["class"] = lxh,
            ["method"] = "skipCartoon",
            ["next"] = "2"
        },
        ["2"] = {
            ["now"] = "2",
            ["name"] = "选择角色",
            ["class"] = lxh,
            ["method"] = "xuanjuese",
            ["next"] = "3"
        },
        ["3"] = {
            ["now"] = "3",
            ["name"] = "起名",
            ["class"] = lxh,
            ["method"] = "name",
            ["next"] = "4"
        },
        ["4"] = {
            ["now"] = "4",
            ["name"] = "执行",
            ["class"] = lxh,
            ["method"] = "execute",
            ["next"] = "1"
        }
    }
    return page
end

-- 不建号直接练小号
function page.simple()
    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = lxh,
            ["method"] = "crashCallack"
        },
        ["1"] = {
            ["now"] = "1",
            ["name"] = "执行",
            ["class"] = lxh,
            ["method"] = "execute",
            ["next"] = "1"
        }
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

7.低等级一上线会有推荐师傅的弹窗
]]
