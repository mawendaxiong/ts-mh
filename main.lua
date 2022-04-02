Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
Login = require("Login.index")

initSuccess = false
finish = false
waitUpdate = false
init(1)

function init()
    createGobalTable("mainStatus")
    mainStatus.isCrash = -1

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
    t1, t2, t3 = nil
    if not waitUpdate then
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
                        elseif taskNum == "6" then -- 三界奇缘
                            Common.record("执行: 三界")
                            page = sanjiePage.index()
                        elseif taskNum == "7" then -- 科举
                            Common.record("执行: 科举")
                            page = kejuPage.index()
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
                thread.stop(t2)
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
                        -- 标识闪退,登录不用重新输入密码
                        mainStatus.isCrash = 1
                        -- 终止执行线程
                        thread.stop(t1)
                        -- 连自己本身一同终止
                        break
                    end

                    -- 获取当前是星期几
                    local week = os.date("%w", os.time())
                    if week == "3" then -- 星期三
                        if tonumber(timetable) >= 8 then -- 到8点,要停服维护了
                            -- 终止执行线程
                            thread.stop(t1)
                            -- 表示等待更新
                            waitUpdate = true
                            break
                        end
                    end
                end
            end
        )
    else -- 等游戏更新
        t3 =
            thread.create(
            function()
                while true do
                    if miniRedManLogo() then
                        tap(x, y)
                    elseif updateNotice() then -- 出现更新公告
                        -- 关闭更新公告
                        tap(648, 691)
                        mSleep(1000)
                    elseif serverPage() then --选择服务器的页面
                        Login.selectServer() -- 选择服务器,进入游戏
                        break
                    end
                    mSleep(5000)
                end
                waitUpdate = false
            end
        )
    end

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
