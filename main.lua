Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")
denglu = require("denglu.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local exception = container.exception
local log = container.log
local devStatus = container.dev
-- 1
initSuccess = false
finish = false
waitUpdate = false
-- 等待晚上5点
wait5pm = false
-- 调试模式
local dev = false
-- 一个月的第几天,用来判断脚本是不是跨日执行了
local day = os.date('%d')

init(1)
-- 三界热点,再次关闭
local function zaici_queren_sanjie_redian()
    offset =
        '9|-2|0x6c310a,20|4|0x6c310a,28|3|0x6c310a,45|2|0x6c310a,11|-269|0x02ae00,73|-258|0x0cb008'
    return findMultiColorInRegionFuzzy(0xedc161, offset, 90, 486, 149, 661, 440,
                                       {orient = 2})
end
-- 三界热点
local function sanjie_redian()
    offset =
        '12|0|0xffffff,12|11|0xffffff,0|11|0xffffff,-10|4|0xfed72d,24|4|0xffdc2b,6|21|0xfbca36'
    return findMultiColorInRegionFuzzy(0xffffff, offset, 90, 540, 542, 596, 593,
                                       {orient = 2})
end
-- x9联赛
local function x9_match()
    offset =
        '31|28|0xb58d6a,-169|-6|0xb58d6a,-123|28|0xb58d6a,-66|129|0xeaac4e,-46|124|0xffffff,-27|133|0xffffff,-11|132|0xffffff'
    return findMultiColorInRegionFuzzy(0xb58d6a, offset, 90, 434, 374, 698, 558,
                                       {orient = 2})
end
-- 回归挑战
local function huigui_tiaozhan()
    offset =
        '-218|-156|0xaf5309,-216|-145|0xc0641a,-24|-93|0xb58d6a,-48|-119|0xb58d6a,-6|-75|0xb58d6a,-83|-73|0xb58d6a'
    return findMultiColorInRegionFuzzy(0xeebd5b, offset, 90, 321, 249, 664, 457,
                                       {orient = 2})
end
-- 全新回归挑战
local function quanxin_huigui_tiaozhan()
    offset =
        '-3|21|0xffffff,4|47|0xfffffe,4|48|0xfffffe,9|21|0xffffff,46|43|0xfff1b1,72|40|0xfff1b2,47|88|0xfff1ae,72|95|0xfff1ae'
    return findMultiColorInRegionFuzzy(0xffffff, offset, 90, 524, 250, 630, 392,
                                       {orient = 2})
end
-- 全民争霸赛
local function quanmin_zhengbasai()
    offset =
        '66|-12|0xffdd66,132|1|0xffee77,152|8|0xffee88,177|-10|0xffdd66,207|15|0xffff99,209|14|0xffff99'
    return findMultiColorInRegionFuzzy(0xffee77, offset, 90, 475, 319, 756, 375,
                                       {orient = 2})
end
-- 九转天阶
local function jiuzhuan_tianjie()
    offset =
        '194|-125|0xfef591,28|-125|0xfef591,122|-75|0xdcebfa,24|1|0x6c310a,23|5|0x6c310a,84|-75|0xdbebfa'
    return findMultiColorInRegionFuzzy(0xedbf60, offset, 90, 354, 363, 694, 531,
                                       {orient = 2})
end

-------------------------
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
        '20|8|0x533922,-64|-77|0x8d5d2c,-37|-75|0x8d5d2c,-5|-78|0x8d5d2c,6|-86|0x8d5d2c,71|-77|0x8d5d2c'
    return findColorsUntil(0x48301e, offset, 90, 474, 276, 675, 403,
                           {orient = 2}, 500, 1)
end

-- 维护过程中弹出的 [连接不上服务器]
local function cannotConnect()
    offset = '19|-6|0x48301e,7|-5|0x48301e,-59|-115|0x8d5d2c,-18|-108|0x8d5d2c'
    return findColorsUntil(0x48301e, offset, 90, 474, 276, 675, 403,
                           {orient = 2}, 500, 1)
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

    mainStatus.isCrash = -1

    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    -- 当前任务正在执行的步骤
    taskRecord.currentStep = -1
    taskRecord.taskStr = ""

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

        if not dev then
            Main.login()
        else
            generateRandomTaskList(dev)
        end

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
        for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr, 1 do

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
    return 'all finish'
end
local c1 = coroutine.create(execute)

local function check_hold()
    if #exception.cache_points == 0 then -- 首次记录点的缓存
        for i = 1, #exception.check_points, 1 do
            local xy_table = exception.check_points[i]
            exception.cache_points[i] = getColor(xy_table[1], xy_table[2])
        end
    else
        local match_time = 0 -- 记录点相同的次数
        for i = 1, #exception.check_points, 1 do
            local xy_table = exception.check_points[i]
            local color = getColor(xy_table[1], xy_table[2])
            if color == exception.cache_points[i] then
                match_time = match_time + 1
            else
                exception.cache_points[i] = color
            end

        end

        if match_time >= 8 then -- 超过8个点相同
            exception.freq = exception.freq - 1
            toast("重启游戏: " .. exception.freq, 1)
            mSleep(1000)
            if exception.freq <= 0 then -- 页面卡太久了,关闭游戏
                closeApp("com.netease.my")
                mSleep(2000)
            end
        else
            exception.freq = 20
        end
    end
end
local function daemon()
    check_hold()

    local flag = appIsRunning("com.netease.my")
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

        exception.freq = 20 -- 异常次数清零
        -- 结束辅助协程
        return
    end

    if taskRecord.taskName == 'login' then -- 登录时出现异常
        if updateNotice() then
            -- 关闭更新公告
            tap(651,588)
            mSleep(1000)
            return
        end

        if loginTip() then
            -- 点击确定
            tap(568, 377)
            mSleep(1000)
            return
        end

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
        return
    end

    now = os.date("%H")
    if now == "00" then -- 到零点了
        newDay = os.date("%d")
        if tonumber(newDay) > tonumber(day) and UISetting.restart == '0' then -- 说明垮了一天了
            lua_restart()
        else
            closeApp("com.netease.my") -- 停止app
            lua_exit() -- 退出app
        end
    end

    -- 游戏关服更新
    r, t, x, y = serverShutDown()
    if x ~= -1 then
        -- 确定
        tap(x, y)
        -- 表示等待更新
        waitUpdate = true
        return
    end

end

local function wait5pm()
    Common.record("5点科举三界")
    while true do
        -- 获取24小时进制的当前小时
        now = os.date("%H")
        if tonumber(now) >= 17 then -- 到5点了
            break
        end
        mSleep(1000 * 10)
    end
    toast("到5点!!!", 1)
    mSleep(1000)

    -- 复位执行账号
    UISetting.currentAccountIndex = 1
    -- 复位执行任务下标
    taskRecord.currentTaskIndex = 1
    -- 将要执行的任务设为科举和三界
    UISetting.taskOrder = "schedule"
end

local function wait2Update()
    Common.record("等待更新")
    while true do
        mSleep(5000)

        if miniRedManLogo() then -- 在进入游戏界面
            -- 点击选择服务器
            tap(639, 382)
        elseif cannotConnect() then -- 连接不上服务器
            tap(473, 387) -- 点击好的
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
end

local function masterMain()
    while coroutine.status(c1) ~= "dead" do
        local status, tips, ret, after = coroutine.resume(c1)
        if nil == after then after = '无' end
        wLog(log.name, "daemon :" .. tips .. " | 后续执行 :" .. after)

        -- -- 程序出现了异常导致携程出错，但是账号没有执行完的
        -- if coroutine.status(c1) == "dead" and UISetting.currentAccountIndex <= #UISetting.accountList then
        --     -- 游戏关闭掉，按闪退处理
        --     closeApp("com.netease.my")
        --     c1 = coroutine.create(execute)
        -- end

        if ret == 'c2' then
            local c2 = coroutine.create(daemon)
            coroutine.resume(c2)
        end

        if waitUpdate then -- 游戏更新
            wait_update = coroutine.create(wait2Update)
            coroutine.resume(wait_update)
        end

        
    end
end

init()

if devStatus.status == 1 then dev = true end

initLog(log.name, 0);

if initSuccess then
    wLog(log.name, "");
    wLog(log.name, "");
    wLog(log.name, "");

    wLog(log.name, "------------分割线------------");
    wLog(log.name, "[DATE] script start");

    masterMain()
    -- local bag = require("bag.ConstPage")
    -- test = coroutine.create(function() Main.excuteLocal(bag.index(), 1) end)
    -- while true do coroutine.resume(test) end

    if UISetting.schedule == '0' then -- 到了5点三界和科举
        toast('5pm')
        -- 先关闭游戏
        state = closeApp("com.netease.my")
        local c3 = coroutine.create(wait5pm)
        coroutine.resume(c3)
        -- 复位执行账号
        UISetting.currentAccountIndex = 1
        -- 复位执行任务下标
        taskRecord.currentTaskIndex = 1
        -- 将要执行的任务设为科举和三界
        UISetting.taskOrder = "schedule"

        c1 = coroutine.create(execute)
        masterMain()
    end

    if UISetting.restart == '00' then -- 12点重新执行
        while true do
            now = os.date("%H")
            if now == "0" then -- 到零点了
                break
            end
        end
        lua_restart()
    end
end
