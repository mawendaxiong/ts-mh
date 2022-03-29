require("TSLib")

Common = require("Common.index")
TaskBoard = require("TaskBoard.index")

Login = {}
-- 用户中心的黑底用户logo
function userLogo()
    offset = "0|53|0xffffff,-34|433|0xfb4f4f,518|204|0xfb4f4f,-51|203|0xffffff"
    return findColorsUntil(0xd2d2d2, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 1)
end

-- 有没有勾上同意协议
function aggrement()
    offset = "-7|15|0xe50113,8|15|0xe50113,-2|11|0xffffff"
    return findColorsUntil(0xe50113, offset, 90, 331, 489, 385, 549, {orient = 2}, 500, 1)
end

-- 选择服务器页面
function serverPage()
    offset = "103|24|0xffd3c9,-28|76|0xfce1f4,-1|110|0xf8c6ca,78|3|0x5ea657"
    return findColorsUntil(0xffae89, offset, 90, 58, 6, 328, 141, {orient = 2}, 500, 1)
end

-- 选择账号类型界面
function switchAccount()
    offset = "-289|0|0x000000,184|-4|0x4892ff,252|11|0xae9885"
    return findColorsUntil(0xd41d13, offset, 90, 256, 419, 877, 490, {orient = 2}, 500, 1)
end

-- 登录的角色
function loginRole()
    offset = "0|9|0x916333,22|5|0x8d5d2c,40|5|0x8d5d2c,42|13|0x8d5d2c,67|0|0x8d5d2c"
    return findColorsUntil(0x8d5d2c, offset, 90, 328, 32, 1032, 616, {orient = 2}, 500, 2)
end

-- 重启游戏
function Login.restartGame()
    state = closeApp("com.netease.my")
    mSleep(1000)
    state = runApp("com.netease.my")
    return 0
end

-- 等登录页面
function Login.waitLoginPage()
    while (true) do
        if userLogo() then
            break
        end
        -- 点击右上角的小红人
        tap(1064, 49)
        mSleep(1000)
    end

    -- 点击切换账号
    tap(1028, 142)
    mSleep(1000)

    return 0
end

-- 账号类型页面
function Login.accountType()
    while (true) do
        if switchAccount() then
            break
        end

        -- 点击其他账号登录
        tap(575, 512)
        mSleep(1000)
    end

    return 0
end

-- 输入账号密码
function Login.inputAccountPasswd()
    if not aggrement() then
        -- 勾上同意
        tap(361, 518)
    end

    -- 点击使用邮箱登录
    tap(586, 459)
    mSleep(1000)

    -- 驶入账号
    tap(621, 202)
    mSleep(1000)

    -- 输入邮箱账号
    Common.inputText(UISetting.currentAccount.account, 1000)

    -- 输入密码
    tap(608, 303)
    mSleep(1000)

    -- 输入邮箱密码
    Common.inputPasswd(UISetting.currentAccount.passwd, 1000)

    -- 点击登录
    tap(491, 407)
    mSleep(1000)

    return 0
end

-- 选择区服
function Login.selectServer()
    -- 直到打开选择服务器页面
    while true do
        if serverPage() then
            break
        end
        tap(665, 370)
        mSleep(1000)
    end

    -- 点击左上角，输入服务器名字
    tap(254, 86)
    mSleep(1000)

    Common.inputText(UISetting.currentAccount.server, 1000)

    -- 选择第一个服务器
    tap(501, 163)
    mSleep(1000)

    -- 默认选择第一个角色
    ret, tim, x, y = loginRole()
    -- 如果有角色
    if ret then
        tap(x, y)
        mSleep(1000)
    end
    return 0
end

function Login.closeWindow()
    mSleep(3000)

    while true do
        ret, tim, x, y = Common.checkMainPage()
        if ret then
            return -2
        end

        Common.timeLimitedWindow()
        Common.closeWindow()
        mSleep(1000)
    end
end

function Login.crashCallack()
    return 2
end
return Login
