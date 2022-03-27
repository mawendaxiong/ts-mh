require("TSLib")

Common = require("Common.index")

ghostPage = require("Ghost.ConstPage")
treasurePage = require("Treasure.ConstPage")
escortPage = require("Escort.ConstPage")
unchartedPage = require("Uncharted.ConstPage")
sectPage = require("Sect.ConstPage")
lotteryPage = require("Lottery.ConstPage")
loginPage = require("Login.ConstPage")

Main = {}

-- 生成随机任务列表
function generateRandomTaskList()
    taskOrder = UISetting.taskOrder
    result = {}
    for var = 1, #taskOrder do
        taskNum = string.sub(taskOrder, var, var)
        if taskNum == "0" or taskNum == "1" then
            task = {2, 3, 4, 5}
            index = #task
            while true do
                if index == 0 then
                    break
                end
                randomIndex = math.random(1, index)
                v = task[randomIndex]
                table.insert(result, v)

                -- temp = task[index]
                -- task[index] = task[randomIndex]
                -- task[randomIndex] = temp
                index = index - 1
            end
        else
            table.insert(result, tonumber(taskNum))
        end
        mSleep(2000)
    end

    -- 插入刮刮乐
    table.insert(result, 1, 1)
    -- 插入运镖
    -- table.insert(result, 6)

    taskRecord.taskList = result
end

function excute()
    while taskRecord.nextNode ~= nil do
        class = taskRecord.currentNode["class"]
        method = taskRecord.currentNode["method"]
        step = taskRecord.currentNode["now"]

        Common.record("step: " .. step .. " " .. taskRecord.currentNode["name"])
        mSleep(2000)
        ret = class[method]()

        if ret == nil then
            toast("[" .. method .. "]执行失败")
            mSleep(1000)
            break
        elseif ret == 0 then --直接执行next
            taskRecord.currentNode = taskRecord.nextNode
            taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode["next"]]
            mSleep(2000)
        elseif ret == -2 then -- 一系类任务执行完毕
            break
        else --执行指定跳转的步骤
            taskRecord.currentNode = taskRecord.currentPage["" .. ret]
            taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode["next"]]
            mSleep(2000)
        end
    end
end

--[[
检查游戏是否闪退
停止 [执行游戏任务线程]
停止 [监测画面卡死线程]

]]
function Main.checkAppCrash()
    while true do
        flag = appIsRunning("com.netease.my")
        if flag == 0 then
            toast("闪退")
            mainStatus.isCrash = 1
            taskRecord.status = -1

            thread.stop(mainThread.excuteThread)
            thread.stop(mainThread.stuckThread)

            break
        end
        mSleep(3000)
    end
end
function crash()
    flag = appIsRunning("com.netease.my")
    if flag == 0 then
        toast("闪退")
        mainStatus.isCrash = 1
        taskRecord.status = -1
        -- 停止执行任务线程
        thread.stop(mainThread.excuteThread)

        -- 重启app
        mSleep(1000)
        state = runApp("com.netease.my")
        step = 0
        while true do
            ret =
                multiColor(
                {
                    {475, 451, 0xebbe4b},
                    {474, 479, 0xe39323},
                    {653, 455, 0xebc05a},
                    {654, 485, 0xe29625},
                    {1094, 44, 0xc26551}
                }
            )
            if step == 0 and not ret then
                tap(30, 100)
                mSleep(2000)
            elseif ret then
                tap(565, 453)
                mSleep(2000)
                step = 1
            elseif step == 1 and not ret then
                break
            end
        end

        while true do
            isMainPage = Common.checkMainPage()
            if isMainPage then
                break
            end
            Common.timeLimitedWindow()
            Common.closeWindow()
        end

        -- 根据之前执行任务的状态判断接下来要执行的步骤
        nowPage = taskRecord.currentPage
        crashNode = nowPage["-1"]
        class = crashNode["class"]
        method = crashNode["method"]

        step = class[method]()

        taskRecord.currentNode = nowPage["" .. step]
        taskRecord.nextNode = nowPage[taskRecord.currentNode["next"]]

        mainStatus.restartSuccess = 1
    end
end

function cancleWindow()
    ret, tim, x, y = Common.wordCancle()
    if ret then
        tap(x, y)
        mSleep(1000)
    end
end

function support()
    while true do
        crash()
        cancleWindow()
    end
end

--[[
画面是否卡住
间隔1分钟,取四个点的值,如果5分钟都是相同,判断为画面卡住
然后通过关闭游戏,触发[游戏闪退线程]
]]
function Main.checkStuck()
    point1 = nil
    point2 = nil
    point3 = nil
    point4 = nil

    checkTime = 0
    while true do
        p1 = isColor(270, 143, 0x63594b)
        p2 = isColor(974, 129, 0x61554c)
        p3 = isColor(572, 48, 0x5c5244)
        p4 = isColor(570, 450, 0x615752)

        if p1 == point1 and p2 == point2 and p3 == point3 and p4 == point4 then
            checkTime = checkTime + 1
            if checkTime == 6 then
                -- 关闭app,触发闪退线程的监测
                state = closeApp("com.netease.my")
                break
            end
            point1 = p1
            point2 = p2
            point3 = p3
            point4 = p4
        end
        mSleep(1000 * 60)
    end
end

-- 重启app
function Main.restartApp()
    mainStatus.isCrash = -1
    state = runApp("com.netease.my")
    step = 0
    while true do
        ret =
            multiColor(
            {
                {475, 451, 0xebbe4b},
                {474, 479, 0xe39323},
                {653, 455, 0xebc05a},
                {654, 485, 0xe29625},
                {1094, 44, 0xc26551}
            }
        )
        if step == 0 and not ret then
            tap(30, 100)
            mSleep(2000)
        elseif ret then
            tap(565, 453)
            mSleep(2000)
            step = 1
        elseif step == 1 and not ret then
            break
        end
    end

    -- 等待主页面,即社群按钮,5秒
    while true do
        isMainPage = Common.checkMainPage()
        if isMainPage then
            break
        end
        Common.timeLimitedWindow()
        Common.closeWindow()
    end

    -- 根据之前执行任务的状态判断接下来要执行的步骤
    nowPage = taskRecord.currentPage
    crashNode = nowPage["-1"]
    class = crashNode["class"]
    method = crashNode["method"]

    step = class[method]()

    taskRecord.currentNode = nowPage["" .. step]
    taskRecord.nextNode = nowPage[taskRecord.currentNode["next"]]

    mainStatus.restartSuccess = 1
end

function Main.login()
    page = loginPage.index()

    -- 记录当前执行
    taskRecord.currentPage = page
    taskRecord.currentNode = page["1"]
    taskRecord.nextNode = page[taskRecord.currentNode["next"]]
    excute()

    -- 生成任务列表
    generateRandomTaskList()
end

return Main
