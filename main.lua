Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
Treasure = require("Treasure.index")

function main()
    createGobalTable("mainStatus")

    createGobalTable("taskRecord")
    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    -- 当前任务正在执行的步骤
    taskRecord.currentStep = -1
    taskRecord.taskStr = ""

    createGobalTable("UISetting")

    uiret, uiValues = UI.show()

    if uiret == 0 then
        return
    end
    UI.analysis(uiValues)

    init(1)
    fwShowWnd("recordBoard", 0, 394, 155, 456, 0)

    for var = 1, #UISetting.accountList do
        UISetting.currentAccount = UISetting.accountList[var]
        -- 登录
        Main.login()
        mSleep(2000)
        -- 执行任务
        for taskIndex = 1, #taskRecord.taskStr do
            taskNum = string.sub(taskRecord.taskStr, taskIndex, taskIndex)

            if taskNum == nil then
                dialog("size: " .. #taskRecord.taskStr)

                for i = 1, #taskRecord.taskStr do
                    foo = string.sub(taskRecord.taskStr, i, i)
                    dialog("item: " .. foo)
                end
            end
            
            if taskNum == "1" then --刮刮乐
                Common.record("执行: 刮刮乐")
                page = lotteryPage.index()
            elseif taskNum == "2" then --秘境
                Common.record("执行: 秘境")
                page = unchartedPage.index()
            elseif taskNum == "3" then --师门
                Common.record("执行: 师门")
                page = sectPage.index()
            elseif taskNum == "4" then --宝图
                Common.record("执行: 宝图")
                page = treasurePage.index()
            elseif taskNum == "5" then --捉鬼
                Common.record("执行: 捉鬼")
                page = ghostPage.joinTeam()
            else --运镖
                Common.record("执行: 运镖")
                page = escortPage.index()
            end

            taskRecord.currentPage = page

            if taskRecord.currentStep == -1 then -- 没有记录的任务步骤,就从1开始
                taskRecord.currentNode = page["1"]
            else --有记录的任务步骤,就从记录的步骤开始
                taskRecord.currentNode = page["" .. taskRecord.currentStep]
                taskRecord.currentStep = -1
            end
            taskRecord.nextNode = page[taskRecord.currentNode["next"]]

            -- 执行任务
            excute()
        end
    end
end
-- hrptk
-- init(1)
-- fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
-- Treasure.findTask()
main()
