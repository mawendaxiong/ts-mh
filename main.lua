Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
denglu = require("denglu.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

initSuccess = false
finish = false
waitUpdate = false
-- 等待晚上5点
wait5pm = false

dev = false
init(1)

-- 梦幻迷城弹出框
local function menghuanmicheng()
    offset =
        "-143|-4|0xb07a55,-167|3|0xb77f58,-239|0|0xb37247,-287|70|0x02ae00,-240|74|0x02ae00"
    return findMultiColorInRegionFuzzy(0xe72500, offset, 90, 261, 19, 891, 154,
                                       {orient = 2})
end

-- 服务器已关闭,周三维护更新
local function serverShutDown()
    offset =
        "27|5|0x4f3621,37|-6|0x48301e,54|1|0xedc061,-59|-79|0x8d5d2c,-51|-79|0x8d5d2c,-12|-84|0x8d5d2c,2|-68|0x8d5d2c,63|-80|0x8d5d2c,61|-74|0x8f602f,83|-78|0x8d5d2c,74|-70|0x936536"
    return findMultiColorInRegionFuzzy(0x48301e, offset, 90, 342, 217, 788, 420,
                                       {orient = 2})
end

-- 通用提示框
local function commonTip()
    offset =
        "302|-2|0xf3c365,227|17|0x48301e,235|22|0x48301e,259|27|0x4d3520,269|13|0x48301e,336|49|0xe3c095,-31|52|0xe3be92"
    return findMultiColorInRegionFuzzy(0xf3c767, offset, 90, 341, 129, 802, 511,
                                       {orient = 2})
end

-- 秘境的提示框
local function mijingTip()
    offset =
        "0|-5|0x8d5d2c,21|2|0x8d5d2c,32|0|0x8d5d2c,36|4|0x8d5d2c,-22|30|0x8d5d2c,-8|22|0x8d5d2c,9|25|0x8d5d2c,16|37|0x8d5d2c"
    return findMultiColorInRegionFuzzy(0x8d5d2c, offset, 90, 366, 225, 766, 416,
                                       {orient = 2})
end

-- 运镖的提示框
local function yunbiaoTip()
    offset =
        "7|0|0x8d5d2c,1|9|0x8d5d2c,22|4|0x8d5d2c,28|8|0x8d5d2c,27|0|0x8d5d2c,28|12|0x8f6030"

    return findMultiColorInRegionFuzzy(0x8d5d2c, offset, 90, 366, 225, 766, 416,
                                       {orient = 2})
end

-- 推荐师傅
local function shifutuijian()
    offset =
        "32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c"
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575,
                           {orient = 2}, 500, 2)
end

function init()
    -- createGobalTable("mainStatus")

    mainStatus.isCrash = -1
    mainStatus.needLogin = 1
    mainStatus.logining = -1

    -- createGobalTable("taskRecord")
    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    -- 当前任务正在执行的步骤
    taskRecord.currentStep = -1
    taskRecord.taskStr = ""

    -- createGobalTable("UISetting")
    -- 当前正在执行任务的账号
    UISetting.currentAccountIndex = 1

    uiret, uiValues = UI.show()

    if uiret == 0 then return end
    UI.analysis(uiValues)

    fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
    initSuccess = true
end

local function execute()

    for accountIndex = UISetting.currentAccountIndex, #UISetting.accountList do
        -- 记录账号,游戏闪退时可以恢复
        UISetting.currentAccountIndex = accountIndex

        UISetting.currentAccount = UISetting.accountList[accountIndex]

        if not dev then Main.login() else generateRandomTaskList(true) end

        if mainStatus.isCrash == 1 then
            toast('crash!!!', 2)
            mSleep(2000)

            -- 复位
            mainStatus.isCrash = -1

            -- 闪退后,根据重新登录的页面,再决定执行哪个步骤
            local crashPage = taskRecord.crashPage
            crashNode = crashPage["-1"]
            class = crashNode["class"]
            method = crashNode["method"]

            -- 闪退后继续执行的步骤
            taskRecord.currentStep = class[method]()
            wLog(log.name, "[DATE] 闪退后继续执行的步骤:" ..
                     taskRecord.currentStep);
        end

        wLog(log.name, "[DATE] 本次执行任务顺序:" .. taskRecord.taskStr);

        -- 执行任务
        for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr do
            -- 记录当前正在执行的任务,游戏闪退是保存状态
            taskRecord.currentTaskIndex = taskIndex

            taskNum = string.sub(taskRecord.taskStr, taskIndex, taskIndex)

            taskRecord.currentPage = Main.switchTaskPage(taskNum)

            if taskRecord.currentStep == -1 then -- 没有记录的任务步骤,就从1开始
                taskRecord.currentNode = taskRecord.currentPage["1"]
            else -- 有记录的任务步骤,就从记录的步骤开始
                taskRecord.currentNode =
                    taskRecord.currentPage["" .. taskRecord.currentStep]
                taskRecord.currentStep = -1
            end
            taskRecord.nextNode =
                taskRecord.currentPage[taskRecord.currentNode["next"]]

            -- 执行任务
            excute()
        end
        -- 一个账号的任务做完后复位
        taskRecord.currentTaskIndex = 1
    end

end
local c1 = coroutine.create(execute)

local function daemon()
    flag = appIsRunning("com.netease.my")
    if flag == 0 then -- 程序闪退
        toast("闪退", 2)
        mSleep(2000)
        wLog(log.name, "[DATE] 闪退")

        -- 标识闪退,登录不用重新输入密码
        mainStatus.isCrash = 1

        -- 复位协程,走闪退的逻辑
        c1 = coroutine.create(execute)

        taskRecord.crashPage = taskRecord.currentPage
        taskRecord.crashNode = taskRecord.currentNode

        -- 结束辅助协程
        return
    end
    -- 弹出的确认 取消 框框,类似于运镖的确认
    x, y = commonTip()

    if x ~= -1 then -- 弹出 确认 取消 的对话框
        x1, y1 = mijingTip() -- 秘境
        x2, y2 = yunbiaoTip() -- 运镖

        if x1 == -1 and x2 == -1 then -- 不是运镖和秘境的提示
            Common.record("秘境关闭弹窗")

            -- 关闭掉弹窗
            tap(x, y)
            mSleep(1000)
            -- 记录当前正在执行的任务
            taskRecord.currentStep = taskRecord.currentNode["now"]
            -- 表示不用登录
            mainStatus.needLogin = -1

            return
        end
    end

    -- 推荐师傅
    r, t, x, y = shifutuijian()
    if r then
        Common.record("关闭师傅推荐")
        -- 关闭师傅推荐
        tap(901, 135)
        mSleep(1000)

        -- 记录当前正在执行的任务
        taskRecord.currentStep = taskRecord.currentNode["now"]
        -- 表示不用登录
        mainStatus.needLogin = -1

        return
    end

    -- 检测梦幻迷城弹窗
    x, y = menghuanmicheng()
    if x ~= -1 then
        Common.record("关闭迷城")
        -- 关闭梦幻迷城的弹出框
        tap(x, y)
        mSleep(1000)
        -- 记录当前正在执行的任务
        taskRecord.currentStep = taskRecord.currentNode["now"]
        -- 表示不用登录
        mainStatus.needLogin = -1
        return
    end

    -- 0点重启脚本
    if UISetting.restart == "0" then
        while true do
            now = os.dates("%H")
            if now == "0" then -- 到零点了
                break
            end
        end
        lua_restart()
    end

    -- 游戏关服更新
    x, y = serverShutDown()
    if x ~= -1 then
        -- 确定
        tap(x, y)
        -- 表示等待更新
        waitUpdate = true
        return
    end
end

local function masterMain()
    while coroutine.status(c1) ~= "dead" do
        toast('round...', 2)
        mSleep(2000)
        local status, tips, ret, after = coroutine.resume(c1)
        if nil == after then after = '无' end
        wLog(log.name, "daemon :" .. tips .. "后续执行 :" .. after);
        mSleep(1000)
        if ret == 'c2' then
            local c2 = coroutine.create(daemon)
            coroutine.resume(c2)
        end
    end
end

dev = true
init()
now = os.date("%Y-%m-%d %X")
createGobalTable("log")
log.name = "mh-debug-" .. now
initLog(log.name, 0);

if initSuccess then
    wLog(log.name, "");
    wLog(log.name, "");
    wLog(log.name, "");

    wLog(log.name, "------------分割线------------");
    wLog(log.name, "[DATE] script start");

    masterMain()
end
