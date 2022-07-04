require("TSLib")

local ts = require("ts")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local dev = container.dev

local cjson = ts.json
UI = {}

function UI.show()
    w, h = getScreenSize()

    MyTable = {
        ["style"] = "default",
        ["width"] = w * 0.9,
        ["height"] = h * 0.9,
        ["title"] = "配置",
        ["titlealign"] = "center",
        ["align"] = "center",
        ["titlesize"] = 18,
        ["okname"] = "运行",
        ["titles"] = "使用主注意,账号信息,任务配置,练小号配置,敬请期待",
        ["pagetype"] = "multi",
        ["selpage"] = 1,
        ["orient"] = 0,
        ["btnbkcolor"] = "255,255,255",
        ["bgcolor"] = "255,255,255",
        ["pagenumtype"] = "tab",
        ["config"] = "showuiTest1.txt",
        ["timer"] = 199,
        ["rettype"] = "table",
        pages = {
            {
                {
                    ["type"] = "Label",
                    ["text"] = "重点注意",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["text"] = "1.该脚本仅可以支持ios系统,开发环境为12.4.3,其他版本暂未测试",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["text"] = "2.本脚本基于iphone6(简称ip6)来开发,ip6分辨率为(640x1136),对于和ip6有同样分辨率的手机应该同样支持,但未测试",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["text"] = "3.运行脚本时,请将home键置于右侧(正对屏幕),否则脚本运行不了",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "devMode",
                    ["list"] = "调试模式(不启动游戏|不处理闪退)",
                    ["countperline"] = "1"
                }
            }, {
                {
                    ["type"] = "Label",
                    ["text"] = "邮箱账号",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                },
                {
                    ["type"] = "TextArea",
                    ["id"] = "mailInfo",
                    ["size"] = 12,
                    ["height"] = 250
                }, {
                    ["type"] = "Label",
                    ["text"] = "手机账号账号",
                    ["size"] = 15,
                    ["valign"] = "bottom"
                },
                {
                    ["type"] = "TextArea",
                    ["id"] = "phoneInfo",
                    ["size"] = 12,
                    ["height"] = 250
                }
            }, {
                {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "任务列表",
                    ["size"] = 16,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "1-师门 2-秘境 3-宝图 4-混队捉鬼 5-带队捉鬼 6-运镖 7-三界 8-科举 9-整理背包 \ra-一条龙 b-一条龙不捉鬼",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "一条龙的捉鬼为混队捉鬼",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Line",
                    ["color"] = "148,0,211",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "配置执行顺序",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Edit",
                    ["id"] = "taskOrder",
                    ["prompt"] = "配置执行顺序",
                    ["align"] = "left",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "schedule",
                    ["list"] = "到点自动科举三界",
                    ["scale"] = "0.4",
                    ["countperline"] = "3",
                    ["nowrap"] = 0
                }, {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "restart",
                    ["list"] = "第二天0点重新执行",
                    ["scale"] = "0.4",
                    ["countperline"] = "3",
                    ["nowrap"] = 0
                }, {
                    ["type"] = "Line",
                    ["color"] = "99,199,99",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "捉鬼配置",
                    ["size"] = 16,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "带队捉鬼",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Edit",
                    ["id"] = "g1",
                    ["prompt"] = "20",
                    ["align"] = "center",
                    ["size"] = 12,
                    ["width"] = 120,
                    ["nowrap"] = 1,
                    ["valign"] = "center"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "只",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "混队捉鬼",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Edit",
                    ["id"] = "g2",
                    ["prompt"] = "20",
                    ["align"] = "center",
                    ["size"] = 12,
                    ["width"] = 120,
                    ["nowrap"] = 1,
                    ["valign"] = "center"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "只",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Line",
                    ["color"] = "255,0,0",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "活力配置",
                    ["size"] = 16,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "目前仅支持打工换100金币,默认执行30次,勾上即可",
                    ["size"] = 16,
                    ["color"] = "51,51,255",
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "money",
                    ["list"] = "打工消耗活力",
                    ["select"] = "0",
                    ["countperline"] = "1"
                }, {
                    ["type"] = "Line",
                    ["color"] = "51,51,255",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "背包清理&上架",
                    ["size"] = 16,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "商会出售",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "sell_shanghui",
                    ["list"] = "精铁,鬼谷子,黑宝石,太阳石,神秘石,舍利子,翡翠石,红纹石,月亮石,光芒石,昆仑玉,月华露,锻造册",
                    ["select"] = "0@1@4@7@10@11@12",
                    ["countperline"] = 3
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "摆摊出售",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "ComboBox",
                    ["id"] = "price_baitan",
                    ["list"] = "-50%,-40%,-30%,-20%,-10%,原价,10%,20%,30%,40%,50%",
                    ["select"] = "5",
                    ["width"] = 150,
                    ["countperline"] = 3
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "背包清理会根据实际使用或放入仓库",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Line",
                    ["color"] = "51,51,255",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "<-右滑账号配置        左滑练小号配置->",
                    ["size"] = 14,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }
            }, {
                {
                    ["type"] = "CheckBoxGroup",
                    ["id"] = "lianxiaohao",
                    ["list"] = "开启练小号",
                    ["countperline"] = "1"
                }, {
                    ["type"] = "RadioGroup",
                    ["id"] = "lianxiaohaoType",
                    ["list"] = "建号,不建号",
                    ["select"] = "0",
                    ["countperline"] = 2,
                    ["nowrap"] = -1
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "练级到",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Edit",
                    ["id"] = "lianxiaohaoLevel",
                    ["prompt"] = "37",
                    ["align"] = "center",
                    ["size"] = 12,
                    ["width"] = 120,
                    ["nowrap"] = 1,
                    ["valign"] = "center"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "级",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "如果选择了建号,请在下面填写账号对应要创建的角色和门派",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["color"] = "255,0,0",
                    ["align"] = "left",
                    ["text"] = "一行对应前面一行的账号配置",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "例子:\r虎头怪-魔王 \r剑侠客-大唐",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "角色:剑侠客,逍遥生,漠少君,巫蛮儿,飞燕女, \r英女侠,龙太子,玄彩娥,神天兵,舞天姬,羽神灵,梦玲珑,杀破狼,骨精灵,虎头怪,狐美人,巨魔王,喵千岁",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "门派:大唐,方寸,化生,女儿,龙宫,普陀,月宫,\r花果,地府,狮驼,魔王,雷音",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "Label",
                    ["color"] = "255,0,0",
                    ["align"] = "left",
                    ["text"] = "注意,女儿村只能女性角色",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = -1,
                    ["valign"] = "bottom"
                }, {
                    ["type"] = "TextArea",
                    ["id"] = "lianxiaohaoText",
                    ["text"] = "",
                    ["size"] = 12,
                    ["align"] = "left",
                    ["height"] = 250,
                    ["color"] = "255,0,0",
                    ["kbtype"] = "number"
                }, {
                    ["type"] = "Line",
                    ["color"] = "255,0,0",
                    ["align"] = "center",
                    ["valign"] = "top",
                    ["height"] = 5,
                    ["width"] = 500
                }, {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "<-右滑任务配置            左滑敬请期待->",
                    ["size"] = 14,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                }
            }, {
                {
                    ["type"] = "Label",
                    ["align"] = "center",
                    ["text"] = "敬请期待",
                    ["size"] = 20,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }
            }
        }

    }

    local MyJsonString = cjson.encode(MyTable)
    return showUI(MyJsonString)

end

local function analysisAccount(accountStr)
    accountInfoList = strSplit(accountStr, "\n")

    accountObjList = {}

    for index = 1, #accountInfoList do
        accountInfo = accountInfoList[index]

        accountDetail = strSplit(accountInfo, "-")

        account = accountDetail[1]
        passwd = accountDetail[2]
        server = accountDetail[3]
        roleNum = accountDetail[4]
        -- toast("account:" .. account .. " passwd:" .. passwd .. " server:" .. server .. " roleNum:" .. roleNum, 2)

        accountObj = {
            ["account"] = account,
            ["passwd"] = passwd,
            ["server"] = server,
            ["roleNum"] = roleNum
        }
        table.insert(accountObjList, accountObj)
    end

    UISetting.accountList = accountObjList
end

local function analysisLianxiaohao(lianxiaohaoStr)
    lianxiaohaoInfoList = strSplit(lianxiaohaoStr, "\n")

    lianxiaohaoObjList = {}

    for index = 1, #lianxiaohaoInfoList do
        lianxiaohaoInfo = lianxiaohaoInfoList[index]

        lianxiaohaoDetail = strSplit(lianxiaohaoInfo, "-")
        renwu = lianxiaohaoDetail[1]
        menpai = lianxiaohaoDetail[2]

        lianxiaohaoObj = {["renwu"] = renwu, ["menpai"] = menpai}
        table.insert(lianxiaohaoObjList, lianxiaohaoObj)
    end

    UISetting.lianxiaohaoList = lianxiaohaoObjList
end

function UI.analysis(uiValues)
    -- 账号信息
    accountStr = uiValues.mailInfo

    -- 练小号
    if uiValues.lianxiaohao == '0' then
        UISetting.lianxiaohao = 1

        UISetting.lianxiaohaoType = tonumber(uiValues.lianxiaohaoType)
        if "" == uiValues.lianxiaohaoLevel then
            UISetting.lianxiaohaoLevel = 37
        else
            UISetting.lianxiaohaoLevel = uiValues.lianxiaohaoLevel

        end

        analysisLianxiaohao(uiValues.lianxiaohaoText)
    end

    -- 任务顺序
    UISetting.taskOrder = uiValues.taskOrder
    -- 定时执行科举和三界
    UISetting.schedule = uiValues.schedule

    -- 第二天零点重新执行
    UISetting.restart = uiValues.restart

    analysisAccount(accountStr)

    if "" == uiValues.g1 then
        -- 带队捉鬼默认20次
        UISetting.g1 = 20
    else
        -- 带队捉鬼次数
        UISetting.g1 = tonumber(uiValues.g1)
    end

    if "" == uiValues.g2 then
        -- 混队捉鬼默认20次
        UISetting.g2 = 20
    else
        -- 混队捉鬼次数
        UISetting.g2 = tonumber(uiValues.g2)
    end

    if uiValues.devMode == '0' then dev.status = 1 end -- 调试模式
    if uiValues.money == '0' then UISetting.money = 1 end -- 活力用来打工
    bag_analysis(uiValues) -- 解析背包参数
end

function bag_analysis(uiValues)
    local shanghui_str = uiValues.sell_shanghui
    local shanghui_list = shanghui_str:split("@")
    local bagFunc = require("bag.index")
    local list1, list2 = marketSellTable(shanghui_list)
    UISetting.shanghui_list = list1
    UISetting.bag_list = list2
    UISetting.price_baitan = tonumber(uiValues.price_baitan) - 5 -- 摆摊出售价格
end
return UI
