require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")
timer = require("Common.timer")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local log = container.log

Login = {}

-- 用户中心的黑底用户logo
function userLogo()
    offset = "0|53|0xffffff,-34|433|0xfb4f4f,518|204|0xfb4f4f,-51|203|0xffffff"
    return findColorsUntil(0xd2d2d2, offset, 90, 0, 0, 1136, 640, {orient = 2},
                           500, 1)
end

-- 有没有勾上同意协议
function aggrement()
    offset = "-7|15|0xe50113,8|15|0xe50113,-2|11|0xffffff"
    return findColorsUntil(0xe50113, offset, 90, 331, 489, 385, 549,
                           {orient = 2}, 500, 1)
end

-- 选择服务器页面
function serverPage()
    offset =
        '-841|52|0xb9b4ad,-805|43|0xb9b4ad,-466|-19|0x6c310a,-445|-11|0x6c310a,-411|-11|0x6c310a,-385|-7|0x6c310a,-386|-19|0x6c310a'
    return findColorsUntil(0xce0000, offset, 90, 88, 25, 1085, 271,
                           {orient = 2}, 500, 1)
end

-- 选择账号类型界面
function switchAccount()
    offset = "-289|0|0x000000,184|-4|0x4892ff,252|11|0xae9885"
    return findColorsUntil(0xd41d13, offset, 90, 256, 419, 877, 490,
                           {orient = 2}, 500, 1)
end

-- 登录的角色
function loginRole()
    offset =
        "0|9|0x916333,22|5|0x8d5d2c,40|5|0x8d5d2c,42|13|0x8d5d2c,67|0|0x8d5d2c"
    return findColorsUntil(0x8d5d2c, offset, 90, 328, 32, 1032, 616,
                           {orient = 2}, 500, 2)
end

-- 右上角小红人
function miniRedManLogo()
    offset = "-29|15|0xbfe7f8,-26|22|0xc0e8f8,2|29|0xa7442c"
    return findColorsUntil(0xb3454f, offset, 90, 1041, 10, 1119, 77,
                           {orient = 2}, 500, 1)
end

-- 选择账号时的游戏logo
function gameLogo()
    offset =
        "9|8|0xe50113,16|6|0xe50113,32|7|0xe50113,44|17|0xe50113,61|-14|0xe50113"
    return findColorsUntil(0xe50113, offset, 90, 435, 115, 527, 191,
                           {orient = 2}, 500, 1)
end

local function input_account_passwd_page()
    offset =
        '-237|-9|0xfb4f4f,124|-103|0xd2d0d0,143|-103|0xd2d0d0,81|75|0xfb4f4f,115|81|0xfb4f4f,152|88|0xfb4f4f'
    return findColorsUntil(0xfb4f4f, offset, 90, 272, 260, 878, 519,
                           {orient = 2}, 500, 1)
end

-- 账号已退出和资源更新提醒
function loginTip()
    offset =
        "-132|-122|0xe9d5ba,201|-94|0xeddfce,200|-2|0xeddfcd,-129|-3|0xeddfcc"
    return findColorsUntil(0xedc060, offset, 90, 352, 218, 787, 422,
                           {orient = 2}, 500, 1)
end

-- 更新公告,星期二下午和星期三更新完都可能会出现
function updateNotice()
    offset =
        "347|-532|0xcd0000,340|-539|0xbf0000,261|-533|0xd58943,-406|-534|0xd68a43"
    return findColorsUntil(0xebb252, offset, 90, 79, 13, 1038, 638,
                           {orient = 2}, 500, 1)
end

-- 重启游戏
function Login.restartGame()
    closeApp("com.netease.my")
    mSleep(2000)
    runApp("com.netease.my")

    while true do
        if miniRedManLogo() then break end
        if gameLogo() then break end -- 没有账号打开游戏就是这个logo
        tap(400, 600) -- 跳过动画
        mSleep(1000)
    end

    return 0
end

-- 等登录页面
function Login.waitLoginPage()
    while true do
        if miniRedManLogo() then break end
        if gameLogo() then break end -- 没有账号打开游戏就是这个logo
        coroutine.yield('启动游戏异常', 'c2')
        mSleep(1000)
    end

    -- 程序闪退了
    if mainStatus.isCrash == 1 then

        while true do
            if updateNotice() then -- 更新公告
                -- 关闭更新公告
                tap(648, 691)
                mSleep(1000)
            elseif not miniRedManLogo() then -- 右上角不是小红人
                -- 跳过打开游戏时的动画
                tap(100, 100)
                mSleep(1000)
            else
                break
            end
        end

        while true do
            if updateNotice() then -- 更新公告
                -- 关闭更新公告
                tap(648, 691)
                mSleep(1000)
            elseif miniRedManLogo() then -- 可以看见右上角小红人
                -- 一直点击登录游戏
                tap(567, 468)
                mSleep(1000)
            else
                break
            end
        end
        -- 关闭弹窗
        return 6
    end

    while true do
        if updateNotice() then -- 更新公告
            -- 关闭更新公告
            tap(648, 691)
            mSleep(1000)

        elseif userLogo() then
            break
        elseif gameLogo() then -- 能够看见选择账号的游戏logo
            -- 直接执行下一步
            return 0
        end

        -- 点击右上角的小红人
        tap(1064, 49)
        mSleep(1000)
    end

    -- 点击切换账号
    tap(1028, 142)
    mSleep(1000)

    while true do
        if gameLogo() then break end
        coroutine.yield('准备登录,出现异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 账号类型页面
function Login.accountType()
    while true do
        if gameLogo() then break end
        coroutine.yield('准备登录,出现异常', 'c2')
        mSleep(1000)
    end

    while true do
        if switchAccount() then break end

        -- 点击其他账号登录
        tap(575, 512)
        mSleep(1000)
    end

    return 0
end

-- 输入账号密码
function Login.inputAccountPasswd()
    while true do
        if switchAccount() then break end
        coroutine.yield('输入账号密码时异常', 'c2')
        mSleep(1000)
    end

    if not aggrement() then
        -- 勾上同意
        tap(361, 518)
        mSleep(1000)
    end

    -- 点击使用邮箱登录
    tap(586, 459)
    mSleep(1000)

    -- 驶入账号
    tap(621, 202)
    mSleep(1000)

    -- 输入邮箱账号
    Common.inputText(UISetting.currentAccount.account)

    -- 输入密码
    tap(608, 303)
    mSleep(1000)

    -- 输入邮箱密码
    Common.inputPasswd(UISetting.currentAccount.passwd)

    -- 点击登录
    tap(491, 407)
    mSleep(1000)

    -- 6秒后再看
    timer.start(6)
    while true do
        if timer.check() then break end
        mSleep(1000)
    end

    if input_account_passwd_page() then -- 账号密码错误
        wLog(log.name,
             "[DATE] 账号密码错误,账号: " ..
                 UISetting.currentAccount.account .. ' 密码: ' ..
                 UISetting.currentAccount.passwd)
        taskRecord.currentTaskIndex = #taskRecord.taskStr + 1 -- 执行下一个账号
        return -2
    end

    while true do
        mSleep(3000)
        if miniRedManLogo() then break end
        coroutine.yield('登录账号后异常', 'c2')
    end

    return 0
end

-- 选择区服
function Login.selectServer()
    while true do
        mSleep(3000)
        if miniRedManLogo() then break end
        coroutine.yield('登录账号后异常', 'c2')
    end

    -- 直到打开选择服务器页面
    while true do
        if serverPage() then break end
        tap(665, 370)
        mSleep(3000)
    end

    -- 点击左上角，输入服务器名字
    tap(254, 86)
    mSleep(1000)

    Common.inputText(UISetting.currentAccount.server)

    -- 选择第一个服务器
    tap(501, 163)
    mSleep(1000)

    -- 如果是练小号,打开了指定服务器即可
    if UISetting.lianxiaohao == 1 then
        toast('练小号', 1)
        -- 直到打开选择服务器页面
        while true do
            if serverPage() then break end
            coroutine.yield('练小号页面异常', 'c2')
            mSleep(1000)
        end

        return -2
    end

    -- 默认选择第一个角色
    ret, tim, x, y = loginRole()
    -- 如果有角色
    if ret then
        tap(x, y)
        -- 等5秒,可能会出现更新资源
        wLog(log.name, "[DATE] 等5秒,可能会出现更新资源");
        mSleep(5000)
    else
        return -2
    end

    if loginTip() then -- 去了测试服,要更新资源
        wLog(log.name, "[DATE] 去了测试服,要更新资源");

        -- 点击确定
        tap(568, 377)
        mSleep(8000)

        now = getNetTime()
        while true do
            if miniRedManLogo() then -- 登录界面
                -- 点击登录
                tap(563, 488)
                mSleep(1000)
            else
                break
            end
        end
    end
    return 0
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

-- 九转天阶
local function jiuzhuan_tianjie()
    offset =
        '194|-125|0xfef591,28|-125|0xfef591,122|-75|0xdcebfa,24|1|0x6c310a,23|5|0x6c310a,84|-75|0xdbebfa'
    return findMultiColorInRegionFuzzy(0xedbf60, offset, 90, 354, 363, 694, 531,
                                       {orient = 2})
end
-- 三界热点,再次确认
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

function Login.closeWindow()
    mSleep(3000)

    while true do
        ret, tim, x, y = Common.checkMainPage()
        if ret then return -2 end
        if huigui_tiaozhan() then -- 回归挑战
            tap(992, 48)
            mSleep(1500)
        end

        if quanxin_huigui_tiaozhan() then -- 全新回归挑战
            tap(989, 55)
            mSleep(1500)
        end
        if jiuzhuan_tianjie() then -- 九转天阶
            tap(450, 508)
            mSleep(1500)
        end
        if sanjie_redian() then -- 三界热点
            tap(650, 563)
            mSleep(1500)
        end
        if zaici_queren_sanjie_redian() then -- 三界热点
            tap(567, 426)
            mSleep(1500)
        end

        Common.timeLimitedWindow()
        Common.closeWindow()
        mSleep(1000)
    end
end

function Login.crashCallack() return 2 end
return Login
