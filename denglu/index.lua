require('TSLib')
require('denglu.components')
local Common = require('Common.index')
local TaskBoard = require('renwuban.index')
local timer = require('Common.timer')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local log = container.log

local Login = {}

-- 重启游戏
function Login.restartGame()
    closeApp('com.netease.my')
    mSleep(2000)
    runApp('com.netease.my')

    return 0
end

-- 等登录页面
function Login.waitLoginPage()
    while true do
        keepScreen(true)
        local r1 = miniRedManLogo()
        local r2 = gameLogo()
        keepScreen(false)

        if r1 or r2 then
            break
        end
        -- if miniRedManLogo() then break end
        -- if gameLogo() then break end -- 没有账号打开游戏就是这个logo
        tap(400, 600) -- 跳过动画
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
        if gameLogo() then
            break
        end
        coroutine.yield('准备登录,出现异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 账号类型页面
function Login.accountType()
    while true do
        if gameLogo() then
            break
        end
        coroutine.yield('准备登录,出现异常', 'c2')
        mSleep(1000)
    end

    while true do
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
    while true do
        if switchAccount() then
            break
        end
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
        if timer.check() then
            break
        end
        mSleep(1000)
    end

    if input_account_passwd_page() then -- 账号密码错误
        wLog(
            log.name,
            '[DATE] 账号密码错误,账号: ' .. UISetting.currentAccount.account .. ' 密码: ' .. UISetting.currentAccount.passwd
        )
        taskRecord.currentTaskIndex = #taskRecord.taskStr + 1 -- 执行下一个账号
        return -2
    end

    while true do
        mSleep(3000)
        if miniRedManLogo() then
            break
        end
        coroutine.yield('登录账号后异常', 'c2')
    end

    return 0
end

-- 选择区服
function Login.selectServer()
    while true do
        mSleep(3000)
        if miniRedManLogo() then
            break
        end
        coroutine.yield('登录账号后异常', 'c2')
    end

    -- 直到打开选择服务器页面
    while true do
        if serverPage() then
            break
        end
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
            if serverPage() then
                break
            end
            coroutine.yield('练小号页面异常', 'c2')
            mSleep(1000)
        end

        return -2
    end

    -- 默认选择第一个角色
    local ret, tim, x, y = loginRole()
    -- 如果有角色
    if ret then
        tap(x, y)
        -- 等5秒,可能会出现更新资源
        wLog(log.name, '[DATE] 等5秒,可能会出现更新资源')
        mSleep(5000)
    else
        return -2
    end

    if loginTip() then -- 去了测试服,要更新资源
        wLog(log.name, '[DATE] 去了测试服,要更新资源')

        -- 点击确定
        tap(568, 377)
        mSleep(8000)

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

function Login.closeWindow()
    mSleep(3000)

    while true do
        local ret, tim, x, y = Common.checkMainPage()
        if ret then
            return -2
        end
        
        if huigui_tiaozhan() then -- 回归挑战
            tap(992, 48)
        elseif quanxin_huigui_tiaozhan() then -- 全新回归挑战
            tap(989, 55)
        elseif jiuzhuan_tianjie() then -- 九转天阶
            tap(990, 146)
        elseif sanjie_redian() then -- 三界热点
            tap(650, 563)
        elseif zaici_queren_sanjie_redian() then -- 三界热点
            tap(567, 426)
        end
        mSleep(1500)

        Common.timeLimitedWindow()
        Common.closeWindow()
        mSleep(1000)
    end
end

function Login.crashCallack()
    return 2
end
return Login
