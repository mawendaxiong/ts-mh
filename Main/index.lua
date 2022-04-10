require("TSLib")

Common = require("Common.index")

ghostPage = require("zhuogui.ConstPage")
treasurePage = require("baotu.ConstPage")
escortPage = require("yunbiao.ConstPage")
unchartedPage = require("mijing.ConstPage")
sectPage = require("shimen.ConstPage")
lotteryPage = require("guaguale.ConstPage")
loginPage = require("denglu.ConstPage")
kejuPage = require("keju.ConstPage")
sanjiePage = require("sanjie.ConstPage")

Main = {}

local function randomTask()
    replace = ""
    task = {2, 3, 4, 5, 6, 7}
    index = #task
    while true do
        if index == 0 then
            break
        end
        randomIndex = math.random(1, index)
        v = task[randomIndex]
        replace = replace .. v

        index = index - 1
    end
    return replace
end

-- 生成随机任务列表
function generateRandomTaskList()
    taskOrder = UISetting.taskOrder

    zeroIndex = string.find(taskOrder, "0")
    oneIndex = string.find(taskOrder, "1")
    -- 包含0和1,以0为准
    if zeroIndex ~= nil and oneIndex ~= nil then
        taskOrder = string.gsub(taskOrder, "1", "")
    end

    if oneIndex ~= nil then
        str = randomTask()
        taskOrder = string.gsub(taskOrder, "1", str)
    end

    if zeroIndex ~= nil then
        str = randomTask()
        taskOrder = string.gsub(taskOrder, "0", str)
    end

    -- 插入刮刮乐
    taskOrder = "1" .. taskOrder
    -- 插入运镖
    -- table.insert(result, 6)

    taskRecord.taskStr = taskOrder
end

function excute()
    while taskRecord.nextNode ~= nil do
        class = taskRecord.currentNode["class"]
        method = taskRecord.currentNode["method"]
        step = taskRecord.currentNode["now"]

        Common.record("step: " .. step .. " " .. taskRecord.currentNode["name"])
        mSleep(1500)
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

function Main.login()
    -- 表示正在登录
    mainStatus.logining = 1
    -- 生成任务列表
    if taskRecord.currentStep == -1 then
        generateRandomTaskList()
    end

    page = loginPage.index()

    -- 记录当前执行
    taskRecord.currentPage = page
    taskRecord.currentNode = page["1"]
    taskRecord.nextNode = page[taskRecord.currentNode["next"]]
    excute()
    -- 复位
    mainStatus.logining = -1
end

function Main.switchTaskPage(taskNum)
    page = nil
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

    return page
end

return Main
