Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
denglu = require("denglu.index")
-- zhuzhan = require("zhuzhan.ConstPage")

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
    createGobalTable("mainStatus")
    mainStatus.isCrash = -1
    mainStatus.needLogin = 1
    mainStatus.logining = -1

    createGobalTable("taskRecord")
    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    -- 当前任务正在执行的步骤
    taskRecord.currentStep = -1
    taskRecord.taskStr = ""

    if not dev then
        createGobalTable("UISetting")
        -- 当前正在执行任务的账号
        UISetting.currentAccountIndex = 1

        uiret, uiValues = UI.show()

        if uiret == 0 then return end
        UI.analysis(uiValues)
    end

    fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
    initSuccess = true
end

function main()
    local thread = require("thread")
    t1, t2, t3, t4 = nil
    if not waitUpdate then
        if not wait5pm then
            t1 = thread.create(function()
                -- todo 关闭窗口的时候,任务被清空了
                -- todo 选择服务器前会弹出更新公告

                for accountIndex = UISetting.currentAccountIndex, #UISetting.accountList do
                    -- 记录账号,游戏闪退时可以恢复
                    UISetting.currentAccountIndex = accountIndex

                    UISetting.currentAccount =
                        UISetting.accountList[accountIndex]

                    if not dev then Main.login() end

                    toast(taskRecord.taskStr)
                    wLog(log.name, "[DATE] 本次执行任务顺序:" ..
                             taskRecord.taskStr);

                    -- 执行任务
                    for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr do
                        -- 记录当前正在执行的任务,游戏闪退是保存状态
                        taskRecord.currentTaskIndex = taskIndex

                        taskNum = string.sub(taskRecord.taskStr, taskIndex,
                                             taskIndex)

                        taskRecord.currentPage = Main.switchTaskPage(taskNum)

                        if taskRecord.currentStep == -1 then -- 没有记录的任务步骤,就从1开始
                            taskRecord.currentNode = taskRecord.currentPage["1"]
                        else -- 有记录的任务步骤,就从记录的步骤开始
                            taskRecord.currentNode =
                                taskRecord.currentPage["" ..
                                    taskRecord.currentStep]
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

                -- 停止辅助线程
                thread.stop(t2)

                -- 需要5点执行科举和三界
                if UISetting.schedule == "0" then
                    -- 先关闭游戏
                    state = closeApp("com.netease.my")
                    wait5pm = true
                    return
                end

                finish = true
            end)

            t2 = thread.create(function()
                while (true) do
                    mSleep(5000)
                    flag = appIsRunning("com.netease.my")
                    if flag == 0 then
                        toast("闪退")
                        wLog(log.name, "[DATE] 闪退");

                        -- 终止执行线程
                        thread.stop(t1)

                        nowPage = taskRecord.currentPage
                        crashNode = nowPage["-1"]
                        class = crashNode["class"]
                        method = crashNode["method"]
                        -- 闪退后继续执行的步骤
                        taskRecord.currentStep = class[method]()
                        wLog(log.name,
                             "[DATE] 闪退后继续执行的步骤:" ..
                                 taskRecord.currentStep);

                        -- 标识闪退,登录不用重新输入密码
                        mainStatus.isCrash = 1
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
                            Common.record("秘境关闭弹窗")
                            -- 终止执行线程
                            thread.stop(t1)

                            -- 关闭掉弹窗
                            tap(x, y)
                            mSleep(1000)
                            -- 记录当前正在执行的任务
                            taskRecord.currentStep =
                                taskRecord.currentNode["now"]
                            -- 表示不用登录
                            mainStatus.needLogin = -1

                            break
                        end
                    end
                    keepScreen(false)

                    -- 推荐师傅
                    r, t, x, y = shifutuijian()
                    if r then
                        Common.record("关闭师傅推荐")
                        -- 关闭师傅推荐
                        tap(901, 135)
                        mSleep(1000)

                        -- 终止执行线程
                        thread.stop(t1)

                        -- 记录当前正在执行的任务
                        taskRecord.currentStep = taskRecord.currentNode["now"]
                        -- 表示不用登录
                        mainStatus.needLogin = -1

                        break
                    end

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

                    -- 0点重启脚本
                    if UISetting.restart == "0" then
                        while true do
                            now = os.date("%H")
                            if now == "0" then -- 到零点了
                                break
                            end
                        end
                        lua_restart()
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
            end)
        else -- 等待5点执行科举和三界
            t4 = thread.create(function()
                Common.record("5点科举三界")
                while true do
                    -- 获取24小时进制的当前小时
                    now = os.date("%H")
                    if tonumber(now) >= 17 then -- 到5点了
                        break
                    end
                    mSleep(1000 * 10)
                end
                toast("到5点!!!")
                -- 复位执行账号
                UISetting.currentAccountIndex = 1
                -- 复位执行任务下标
                taskRecord.currentTaskIndex = 1
                -- 将要执行的任务设为科举和三界
                UISetting.taskOrder = "schedule"

                -- 复位,防止死循环
                wait5pm = false
                UISetting.schedule = -1
            end)
        end
    else -- 等游戏更新
        t3 = thread.create(function()
            while true do
                mSleep(5000)

                if miniRedManLogo() then -- 在进入游戏界面
                    -- 点击选择服务器
                    tap(639, 382)
                elseif updateNotice() then -- 出现更新公告
                    -- 关闭更新公告
                    tap(648, 691)
                    mSleep(1000)
                elseif serverPage() then -- 选择服务器的页面
                    denglu.selectServer() -- 选择服务器,进入游戏
                    break
                end
            end

            waitUpdate = false
        end)
    end

    thread.waitAllThreadExit()
end
-- dev = true
init()
now = os.date("%Y-%m-%d %X")
createGobalTable("log")
log.name = "mh-debug-" .. now
initLog(log.name, 0);

-- Main.excuteLocal(jinengPage.index(), 1)
-- local jinengPage = require("jineng.index")
-- jinengPage.shengji()
-- Main.excuteLocal(unchartedPage.index(), 1)

if initSuccess then
    wLog(log.name, "");
    wLog(log.name, "");
    wLog(log.name, "");

    wLog(log.name, "------------分割线------------");
    wLog(log.name, "[DATE] script start");

    while not finish do main() end

    -- 0点重启脚本
    if UISetting.restart == "0" then
        while true do
            now = os.date("%H")
            if now == "0" then -- 到零点了
                break
            end
            mSleep(1000 * 10)
        end
        lua_restart()
    end
end
