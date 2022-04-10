require("TSLib")

local ts = require("ts")
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
        ["titlesize"] = 16,
        ["okname"] = "运行",
        ["titles"] = "账号信息,任务配置,第三页,第四页",
        ["pagetype"] = "multi",
        ["selpage"] = 1,
        ["orient"] = 0,
        ["btnbkcolor"] = "255,255,255",
        ["bgcolor"] = "255,255,255",
        ["pagenumtype"] = "tab",
        ["config"] = "showuiTest1.txt",
        ["timer"] = 399,
        ["rettype"] = "table",
        pages = {
            {
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
                },
                {
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
            },
            {
                {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "任务列表",
                    ["size"] = 16,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                },
                {
                    ["type"] = "Label",
                    ["align"] = "left",
                    ["text"] = "0-一条龙加捉鬼 1-一条龙 2-秘境 3-师门 4-宝图 5-混队捉鬼 6-带队捉鬼 7-运镖 ",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 0,
                    ["valign"] = "bottom"
                },
                {
                    ["type"] = "Edit",
                    ["id"] = "taskOrder",
                    ["prompt"] = "配置执行顺序",
                    ["align"] = "left",
                    ["size"] = 12,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }
            },
            {
                {
                    ["type"] = "Label",
                    ["align"] = "center",
                    ["text"] = "第三页",
                    ["size"] = 20,
                    ["width"] = -1,
                    ["nowrap"] = 1,
                    ["valign"] = "bottom"
                }
            },
            {
                {
                    ["type"] = "Label",
                    ["align"] = "center",
                    ["text"] = "第四页",
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

function UI.analysis(uiValues)
    -- 账号信息
    accountStr = uiValues.mailInfo

    -- 任务顺序
    UISetting.taskOrder = uiValues.taskOrder

    analysisAccount(accountStr)
end

return UI
