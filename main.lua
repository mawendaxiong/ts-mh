Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
Login = require("Login.index")

initSuccess = false
finish = false
waitUpdate = false

init(1)

-- 梦幻迷城弹出框
local function menghuanmicheng()
    return findMultiColorInRegionFuzzy(
        0xe72500,
        "-143|-4|0xb07a55,-167|3|0xb77f58,-239|0|0xb37247,-287|70|0x02ae00,-240|74|0x02ae00",
        90,
        261,
        19,
        891,
        154,
        {orient = 2}
    )
end

-- 服务器已关闭,周三维护更新
local function serverShutDown()
    return findMultiColorInRegionFuzzy(
        0x48301e,
        "27|5|0x4f3621,37|-6|0x48301e,54|1|0xedc061,-59|-79|0x8d5d2c,-51|-79|0x8d5d2c,-12|-84|0x8d5d2c,2|-68|0x8d5d2c,63|-80|0x8d5d2c,61|-74|0x8f602f,83|-78|0x8d5d2c,74|-70|0x936536",
        90,
        342,
        217,
        788,
        420,
        {orient = 2}
    )
end

local function commonTip()
    return findMultiColorInRegionFuzzy(
        0xf3c767,
        "302|-2|0xf3c365,227|17|0x48301e,235|22|0x48301e,259|27|0x4d3520,269|13|0x48301e,336|49|0xe3c095,-31|52|0xe3be92",
        90,
        341,
        129,
        802,
        511,
        {orient = 2}
    )
end

local function mijingTip()
    return findMultiColorInRegionFuzzy(
        0x8d5d2c,
        "0|-5|0x8d5d2c,21|2|0x8d5d2c,32|0|0x8d5d2c,36|4|0x8d5d2c,-22|30|0x8d5d2c,-8|22|0x8d5d2c,9|25|0x8d5d2c,16|37|0x8d5d2c",
        90,
        366,
        225,
        766,
        416,
        {orient = 2}
    )
end

local function yunbiaoTip()
    return findMultiColorInRegionFuzzy(
        0x8d5d2c,
        "7|0|0x8d5d2c,1|9|0x8d5d2c,22|4|0x8d5d2c,28|8|0x8d5d2c,27|0|0x8d5d2c,28|12|0x8f6030",
        90,
        366,
        225,
        766,
        416,
        {orient = 2}
    )
end

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
function generateTask()
    -- 不需要登录游戏
    if mainStatus.needLogin ~= 1 then
        mainStatus.needLogin = 1
        return -2
    end

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
    -- 插入登录游戏
    taskOrder = "0" .. taskOrder

    -- 插入运镖
    -- table.insert(result, 6)

    taskRecord.taskStr = taskOrder
end

function init()
    createGobalTable("mainStatus")
    mainStatus.isCrash = -1
    mainStatus.needLogin = 1

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
                -- todo 关闭窗口的时候,任务被清空了
                -- todo 选择服务器前会弹出更新公告

                for accountIndex = UISetting.currentAccountIndex, #UISetting.accountList do
                    -- 记录账号,游戏闪退时可以恢复
                    UISetting.currentAccountIndex = accountIndex

                    UISetting.currentAccount = UISetting.accountList[accountIndex]

                    -- toast("accountIndex: " .. accountIndex .. " taskStr: " .. #taskRecord.taskStr, 1)
                    if mainStatus.needLogin == 1 then
                        -- Main.login()
                        generateTask()
                    -- else
                    -- mainStatus.needLogin = 1
                    end

                    -- toast(" taskIndex: " .. taskRecord.currentTaskIndex .. " taskStrSize: " .. #taskRecord.taskStr, 2)
                    -- mSleep(2000)

                    -- 执行任务
                    for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr do
                        -- 记录当前正在执行的任务,游戏闪退是保存状态
                        taskRecord.currentTaskIndex = taskIndex

                        taskNum = string.sub(taskRecord.taskStr, taskIndex, taskIndex)
                        toast(
                            "taskIndex: " .. taskIndex .. " taskNum: " .. taskNum .. " str: " .. taskRecord.taskStr,
                            2
                        )
                        mSleep(2000)

                        if taskNum == "0" then
                            Common.record("执行: 登录")
                            page = loginPage.index()
                        elseif taskNum == "1" then --刮刮乐
                            -- Common.record("执行: 刮刮乐")
                            toast("执行: 刮刮乐")
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
                    mSleep(10000)
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
                    -- 弹出的确认 取消 框框,类似于运镖的确认
                    keepScreen(true)
                    x, y = commonTip()

                    if x ~= -1 then -- 弹出 确认 取消 的对话框
                        x1, y1 = mijingTip() -- 秘境
                        x2, y2 = yunbiaoTip() -- 运镖
                        keepScreen(false)

                        if x1 == -1 and x2 == -1 then -- 不是运镖和秘境的提示
                            Common.record("关闭弹窗")
                            -- 终止执行线程
                            thread.stop(t1)

                            -- 关闭掉弹窗
                            tap(x, y)
                            mSleep(1000)
                            -- 记录当前正在执行的任务
                            taskRecord.currentStep = taskRecord.currentNode["now"]
                            -- 表示不用登录
                            mainStatus.needLogin = -1

                            break
                        end
                    end
                    keepScreen(false)

                    -- 检测梦幻迷城弹窗
                    x, y = menghuanmicheng()
                    if x ~= -1 then
                        -- 终止执行线程
                        thread.stop(t1)
                        Common.record("关闭迷城")
                        -- 关闭梦幻迷城的弹出框
                        tap(x, y)
                        mSleep(1000)
                        -- 记录当前正在执行的任务
                        taskRecord.currentStep = taskRecord.currentNode["now"]
                        -- 表示不用登录
                        mainStatus.needLogin = -1
                        break
                    end
                    -- 游戏关服更新
                    x, y = serverShutDown()
                    if x ~= -1 then
                        -- 终止执行线程
                        thread.stop(t1)
                        -- 确定
                        tap(x, y)
                        -- 表示等待更新
                        waitUpdate = true
                        break
                    end
                end
            end
        )
    else -- 等游戏更新
        t3 =
            thread.create(
            function()
                while true do
                    mSleep(5000)

                    if miniRedManLogo() then -- 在进入游戏界面
                        -- 点击选择服务器
                        tap(639, 382)
                    elseif updateNotice() then -- 出现更新公告
                        -- 关闭更新公告
                        tap(648, 691)
                        mSleep(1000)
                    elseif serverPage() then --选择服务器的页面
                        Login.selectServer() -- 选择服务器,进入游戏
                        break
                    end
                end

                waitUpdate = false
            end
        )
    end

    thread.waitAllThreadExit()
end

init()
if initSuccess then
    while not finish do
        main()
    end
end
