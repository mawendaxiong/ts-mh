Common = require('Common.index')

local UI = require('UI.index')
local Main = require('Main.index')
local denglu = require('denglu.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local exception = container.exception
local log = container.log
local devStatus = container.dev
-- 1
local initSuccess = false
local waitUpdate = false
-- 调试模式
local dev = false
-- 一个月的第几天,用来判断脚本是不是跨日执行了
local day = os.date('%d')

local unknow_error = false

-------------------------
-- 限时折扣
function xianshizhekou()
    local offset = '-237|-27|0xd1321f,-276|-28|0xffcf15,-308|-29|0xffd117,-410|-20|0xfeb914,-307|-33|0xffda24'
    return findColorsUntil(0xbc824e, offset, 90, 386, 82, 939, 185, {orient = 2}, 500, 1)
end
-- 梦幻迷城弹出框
local function menghuanmicheng()
    local offset = '-143|-4|0xb07a55,-167|3|0xb77f58,-239|0|0xb37247,-287|70|0x02ae00,-240|74|0x02ae00'
    return findMultiColorInRegionFuzzy(0xe72500, offset, 90, 261, 19, 891, 154, {orient = 2})
end

-- 服务器已关闭,周三维护更新
local function serverShutDown()
    local offset = '20|8|0x533922,-64|-77|0x8d5d2c,-37|-75|0x8d5d2c,-5|-78|0x8d5d2c,6|-86|0x8d5d2c,71|-77|0x8d5d2c'
    return findColorsUntil(0x48301e, offset, 90, 474, 276, 675, 403, {orient = 2}, 500, 1)
end

-- 维护过程中弹出的 [连接不上服务器]
local function cannotConnect()
    local offset = '19|-6|0x48301e,7|-5|0x48301e,-59|-115|0x8d5d2c,-18|-108|0x8d5d2c'
    return findColorsUntil(0x48301e, offset, 90, 474, 276, 675, 403, {orient = 2}, 500, 1)
end

-- 通用提示框
local function commonTip()
    local offset =
        '302|-2|0xf3c365,227|17|0x48301e,235|22|0x48301e,259|27|0x4d3520,269|13|0x48301e,336|49|0xe3c095,-31|52|0xe3be92'
    return findMultiColorInRegionFuzzy(0xf3c767, offset, 90, 341, 129, 802, 511, {orient = 2})
end

-- 秘境的提示框
local function mijingTip()
    local offset =
        '0|-5|0x8d5d2c,21|2|0x8d5d2c,32|0|0x8d5d2c,36|4|0x8d5d2c,-22|30|0x8d5d2c,-8|22|0x8d5d2c,9|25|0x8d5d2c,16|37|0x8d5d2c'
    return findMultiColorInRegionFuzzy(0x8d5d2c, offset, 90, 366, 225, 766, 416, {orient = 2})
end

-- 运镖的提示框
local function yunbiaoTip()
    local offset = '7|0|0x8d5d2c,1|9|0x8d5d2c,22|4|0x8d5d2c,28|8|0x8d5d2c,27|0|0x8d5d2c,28|12|0x8f6030'

    return findMultiColorInRegionFuzzy(0x8d5d2c, offset, 90, 366, 225, 766, 416, {orient = 2})
end

-- 推荐师傅
local function shifutuijian()
    local offset = '32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c'
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575, {orient = 2}, 500, 2)
end

local function initProp()
    mainStatus.isCrash = -1

    -- 当前正在执行的任务
    taskRecord.currentTaskIndex = 1
    taskRecord.taskStr = ''

    -- 当前正在执行任务的账号
    UISetting.currentAccountIndex = 1

    local uiret, uiValues = UI.show()

    if uiret == 0 then
        return
    end
    UI.analysis(uiValues)
    -- 设置屏幕方向，home键在右边
    init(1)

    fwShowWnd('recordBoard', 0, 394, 155, 456, 0)
    initSuccess = true
end

local function execute()
    for accountIndex = UISetting.currentAccountIndex, #UISetting.accountList do
        -- 记录账号,游戏闪退时可以恢复
        UISetting.currentAccountIndex = accountIndex

        UISetting.currentAccount = UISetting.accountList[accountIndex]
        wLog(log.name, '[DATE] 开始执行账号账号: ' .. UISetting.currentAccount.account)

        if not dev then
            Main.login()
        else
            generateRandomTaskList(dev)
        end

        if mainStatus.isCrash == 1 then
            -- 复位
            mainStatus.isCrash = -1

            -- 闪退后,根据重新登录的页面,再决定执行哪个步骤
            local crashPage = taskRecord.crashPage
            local crashNode = crashPage['-1']
            local class = crashNode['class']
            local method = crashNode['method']

            -- 闪退后继续执行的步骤
            taskRecord.currentStep = class[method]()
            wLog(log.name, '[DATE] 闪退后继续执行的步骤:' .. taskRecord.currentStep)
        end
        wLog(log.name, '[DATE] 本次执行任务顺序:' .. taskRecord.taskStr)

        -- 执行任务
        for taskIndex = taskRecord.currentTaskIndex, #taskRecord.taskStr, 1 do
            -- 记录当前正在执行的任务,游戏闪退是保存状态
            taskRecord.currentTaskIndex = taskIndex

            local taskNum = string.sub(taskRecord.taskStr, taskIndex, taskIndex)
            taskRecord.currentPage = Main.switchTaskPage(taskNum)

            if nil == taskRecord.currentPage then
                wLog(log.name, '[DATE] 返回page为空')
            end

            if taskRecord.currentStep == -1 then -- 没有记录的任务步骤,就从1开始
                wLog(log.name, '[DATE] 从头开始')
                taskRecord.currentNode = taskRecord.currentPage['1']
            else -- 有记录的任务步骤,就从记录的步骤开始
                wLog(log.name, '[DATE] 指定步骤开始')
                taskRecord.currentNode = taskRecord.currentPage['' .. taskRecord.currentStep]
                taskRecord.currentStep = -1
            end

            if nil == taskRecord.currentNode then
                wLog(log.name, '[DATE] currentNode为空')
            end

            taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode['next']]

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
            toast('重启游戏: ' .. exception.freq, 1)
            mSleep(1000)
            if exception.freq <= 0 then -- 页面卡太久了,关闭游戏
                wLog(log.name, '[DATE] 页面卡住,重新打开游戏')
                closeApp('com.netease.my')
                mSleep(2000)
            end
        else
            exception.freq = 20
        end
    end
end
local function daemon()
    check_hold()

    local flag = appIsRunning('com.netease.my')
    if flag == 0 then -- 程序闪退
        toast('闪退', 2)
        mSleep(2000)
        wLog(log.name, '[DATE] 闪退')

        c1 = coroutine.create(execute) -- 复位协程,走闪退的逻辑

        exception.freq = 20 -- 异常次数重置
        if unknow_error then
            wLog(log.name, '[DATE] 未知错误，账号: ' .. UISetting.currentAccount.account)
            -- 执行下一个账号
            UISetting.currentAccountIndex = UISetting.currentAccountIndex + 1
            taskRecord.currentTaskIndex = 0
        else
            -- 标识闪退,登录不用重新输入密码
            mainStatus.isCrash = 1
            taskRecord.crashPage = taskRecord.currentPage
            taskRecord.crashNode = taskRecord.currentNode
        end

        return
    end

    if taskRecord.taskName == 'login' then -- 登录时出现异常
        if updateNotice() then
            -- 关闭更新公告
            tap(651, 588)
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
    local x, y = commonTip()

    if x ~= -1 then -- 弹出 确认 取消 的对话框
        wLog(log.name, '[DATE] 弹出 确认取消对话框')

        local x1, y1 = mijingTip() -- 秘境
        local x2, y2 = yunbiaoTip() -- 运镖

        if x1 == -1 and x2 == -1 then -- 不是运镖和秘境的提示
            Common.record('秘境关闭弹窗')

            -- 关闭掉弹窗
            tap(x, y)
            mSleep(1000)
            return
        end
    end

    if xianshizhekou() then -- 限时折扣
        wLog(log.name, '[DATE] 弹出 限时折扣')

        tap(914, 154)
        mSleep(1000)
        return
    end

    
    if shifutuijian() then -- 推荐师傅
        wLog(log.name, '[DATE] 弹出 推荐师傅')

        Common.record('关闭师傅推荐')
        -- 关闭师傅推荐
        tap(901, 135)
        mSleep(1000)
        return
    end

    -- 检测梦幻迷城弹窗
    x, y = menghuanmicheng()
    if x ~= -1 then
        wLog(log.name, '[DATE] 弹出 梦幻迷城')

        Common.record('关闭迷城')
        -- 关闭梦幻迷城的弹出框
        tap(x, y)
        mSleep(1000)
        return
    end

    local now = os.date('%H')
    if now == '00' then -- 到零点了
        local newDay = os.date('%d')
        if tonumber(newDay) > tonumber(day) and UISetting.restart == '0' then -- 说明垮了一天了
            lua_restart()
        else
            closeApp('com.netease.my') -- 停止app
            lua_exit() -- 退出app
        end
    end

    -- 游戏关服更新
    local r, t, x, y = serverShutDown()
    if r then
        wLog(log.name, '[DATE] 弹出 游戏要更新了')

        -- 确定
        tap(x, y)
        -- 表示等待更新
        waitUpdate = true
        return
    end
end

local function wait5pm()
    Common.record('5点科举三界')
    while true do
        -- 获取24小时进制的当前小时
        local now = os.date('%H')
        if tonumber(now) >= 17 then -- 到5点了
            break
        end
        mSleep(1000 * 10)
    end
    toast('到5点!!!', 1)
    mSleep(1000)

    -- 复位执行账号
    UISetting.currentAccountIndex = 1
    -- 复位执行任务下标
    taskRecord.currentTaskIndex = 1
    -- 将要执行的任务设为科举和三界
    UISetting.taskOrder = 'schedule'
end

local function wait2Update()
    Common.record('等待更新')
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
    while coroutine.status(c1) ~= 'dead' do
        local status, tips, ret, after = coroutine.resume(c1)
        if nil == after then
            after = '无'
        end
        wLog(log.name, '[DATE] daemon :' .. tips .. ' | 后续执行 :' .. after)
        toast(tips,1)

        -- 程序出现了异常导致携程出错，但是账号没有执行完的
        if
            coroutine.status(c1) == 'dead' and
                (UISetting.currentAccountIndex <= #UISetting.accountList or
                    taskRecord.currentTaskIndex < #taskRecord.taskStr)
         then
            -- 游戏关闭掉，按闪退处理
            closeApp('com.netease.my')
            -- 未知错误
            unknow_error = true
        end

        if ret == 'c2' then
            local c2 = coroutine.create(daemon)
            coroutine.resume(c2)
        end

        if waitUpdate then -- 游戏更新
            local wait_update = coroutine.create(wait2Update)
            coroutine.resume(wait_update)
        end
    end
end

initProp()

if devStatus.status == 1 then
    dev = true
end

initLog(log.name, 0)

if initSuccess then
    wLog(log.name, '')
    wLog(log.name, '')
    wLog(log.name, '')

    wLog(log.name, '------------分割线------------')
    wLog(log.name, '[DATE] script start')

    masterMain()
    -- local bag = require("bag.ConstPage")
    -- test = coroutine.create(function() Main.excuteLocal(bag.index(), 1) end)
    -- while true do coroutine.resume(test) end

    if UISetting.schedule == '0' then -- 到了5点三界和科举
        toast('5pm')
        -- 先关闭游戏
        closeApp('com.netease.my')
        local c3 = coroutine.create(wait5pm)
        coroutine.resume(c3)
        -- 复位执行账号
        UISetting.currentAccountIndex = 1
        -- 复位执行任务下标
        taskRecord.currentTaskIndex = 1
        -- 将要执行的任务设为科举和三界
        UISetting.taskOrder = 'schedule'

        c1 = coroutine.create(execute)
        masterMain()
    end

    if UISetting.restart == '00' then -- 12点重新执行
        while true do
            local now = os.date('%H')
            if now == '0' then -- 到零点了
                break
            end
        end
        lua_restart()
    end
end
