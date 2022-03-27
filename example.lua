Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")

function main()
    createGobalTable("UISetting")
    -- 记录当前账号
    UISetting.accountIndex = 1

    uiret, uiValues = UI.show()

    if uiret == 0 then
        return
    end
    UI.analysis(uiValues)

    init(1)
    fwShowWnd("recordBoard", 0, 394, 155, 456, 0)

    for var = UISetting.accountIndex, #UISetting.accountList do
        -- 当前账号
        UISetting.currentAccount = UISetting.accountList[var]
        -- 登录
        Main.login()
        
        -- 执行任务
        for var = 1, #taskRecord.taskList do
            taskNum = taskRecord.taskList[var]

            if taskNum == 1 then --刮刮乐
                Common.record("执行: 刮刮乐")
                page = lotteryPage.index()
            elseif taskNum == 2 then --秘境
                Common.record("执行: 秘境")
                page = unchartedPage.index()
            elseif taskNum == 3 then --师门
                Common.record("执行: 师门")
                page = sectPage.index()
            elseif taskNum == 4 then --宝图
                Common.record("执行: 宝图")
                page = treasurePage.index()
            elseif taskNum == 5 then --捉鬼
                Common.record("执行: 捉鬼")
                page = ghostPage.joinTeam()
            else --运镖
                Common.record("执行: 运镖")
                page = escortPage.index()
            end

            taskRecord.currentPage = page
            taskRecord.currentNode = page["1"]
            taskRecord.nextNode = page[taskRecord.currentNode["next"]]

            -- 执行任务
            excute()
        end
        
        
    end
end
