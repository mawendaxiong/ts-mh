Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
Treasure = require("Treasure.index")

initSuccess = false
finish = false
init(1)

function init()
    createGobalTable("mainStatus")

    createGobalTable("taskRecord")
    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    -- 当前任务正在执行的步骤
    taskRecord.currentStep = -1
    taskRecord.taskStr = ""

    createGobalTable("UISetting")
    -- 当前正在执行任务的账号
    UISetting.currentAccountIndex = 1

    uiret, uiValues = UI.show()

    if uiret == 0 then
        return
    end
    UI.analysis(uiValues)

    fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
    initSuccess = true
end

function main()
    local thread = require("thread")

    t1 =
        thread.create(
        function()
            for accountIndex = UISetting.currentAccountIndex, #UISetting.accountList do
                -- 记录账号,游戏闪退时可以恢复
                UISetting.currentAccountIndex = accountIndex

                UISetting.currentAccount = UISetting.accountList[accountIndex]
                -- 登录
                Main.login()
                mSleep(2000)
                -- 执行任务
                for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr do
                    -- 记录当前正在执行的任务,游戏闪退是保存状态
                    taskRecord.currentTaskIndex = taskIndex

                    taskNum = string.sub(taskRecord.taskStr, taskIndex, taskIndex)

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
                -- 一个账号的任务做完后复位
                taskRecord.currentTaskIndex = 1
            end

            finish = true
        end
    )

    t2 =
        thread.create(
        function()
            while (true) do
                mSleep(5000)
                flag = appIsRunning("com.netease.my")
                if flag == 0 then
                    toast("闪退")

                    nowPage = taskRecord.currentPage
                    crashNode = nowPage["-1"]
                    class = crashNode["class"]
                    method = crashNode["method"]
                    -- 闪退前正在执行的步骤
                    taskRecord.currentStep = class[method]()

                    -- 终止执行线程
                    thread.stop(t1)
                    -- 连自己本身一同终止
                    break
                end
            end
        end
    )

    thread.waitAllThreadExit()
end
-- hrptk
-- init(1)
-- fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
-- Treasure.findTask()
init()
if initSuccess then
    while not finish do
        main()
    end
end
