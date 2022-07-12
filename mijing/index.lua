require('TSLib')
require('mijing.components')
Common = require('Common.index')
TaskBoard = require('renwuban.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local unchartedState = container.uncharted

Uncharted = {}

function Uncharted.findTask()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('查找秘境任务异常', 'c2')
        mSleep(1000)
    end

    if TaskBoard.findTask() == -1 then -- 没有找到任务,那就是已经打完了
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)

        Common.blockCheckMainPage('找不到秘境任务')

        return -2 -- 结束
    end

    while true do
        if Common.userDialog() then
            break
        end -- 到达逍遥游
        coroutine.yield('去逍遥游路上', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

-- 等云乐游
function Uncharted.waitNPC()
    while true do
        if Common.userDialog() then
            break
        end
        coroutine.yield('等云游乐异常', 'c2')
        mSleep(1000)
    end

    while true do
        ret, tim, x, y = openButton()
        if ret then
            tap(x, y) -- 点击进入
            mSleep(2000)
            break
        end
        coroutine.yield('进入秘境被挡住了', 'c2')
        mSleep(1000)
    end

    -- 新的一周,重新选择秘境,非日月之井
    if newWeekSection() then
        -- 进入左边的秘境
        tap(337, 564)
        mSleep(1000)
        -- 确定
        tap(695, 388)
        mSleep(1000)
    end

    while true do
        if mijingPage() then
            break
        end -- [保证页面是秘境选择关卡的页面]
        coroutine.yield('显示秘境关卡页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 秘境选择关卡
function Uncharted.getInto()
    while true do
        if mijingPage() then
            break
        end
        coroutine.yield('秘境选择关卡页面异常', 'c2')
        mSleep(1000)
    end

    Common.move(
        nil,
        function()
            moveTo(410, 146, 913, 146, 50, 1000)
        end,
        function()
            local p1 = getColor(377, 347)
            local p2 = getColor(586, 483)
            local p3 = getColor(885, 326)
            local p4 = getColor(914, 504)
            return p1, p2, p3, p4
        end,
        nil,
        function()
            return mijingPage()
        end
    )

    -- 点击猛如虎,69秘境
    tap(295, 308)
    mSleep(1000)

    -- 点击确认
    tap(609, 467)
    mSleep(1000)

    while true do
        if mijingInnerPage() then
            break
        end -- [保证在秘境内部]
        coroutine.yield('进入秘境内部异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 计算次数
function Uncharted.count()
    while true do
        if mijingInnerPage() then
            break
        end -- 在秘境里面
        coroutine.yield('秘境被弹窗挡住了', 'c2')
        mSleep(1000)
    end

    tap(1020, 233) -- 点击秘境任务,开始通关
    mSleep(1000)

    pauseTime = 30
    isCount = false
    while true do
        if Common.checkBattle(200, 1) then -- 正在战斗
            if not isCount then
                unchartedState.freq = unchartedState.freq + 1
                Common.record('秘境: ' .. unchartedState.freq)
                if unchartedState.freq == 15 then
                    -- 结束
                    break
                end
            end
            isCount = true
            pauseTime = 30
            mSleep(1000)
        else
            isCount = false
            pauseTime = pauseTime - 1
            Common.record('倒计时: ' .. pauseTime)

            if isColor(894, 354, 0xf3d6b3, 90) then -- 需要点进入战斗
                Common.record('点击进入战斗')

                -- 点击进入战斗
                tap(894, 354)
                mSleep(1000)
            elseif fail() then -- 战斗失败
                Common.record('战斗失败')

                break
            elseif pauseTime == 0 then
                while true do
                    if mijingInnerPage() then
                        break
                    end -- 秘境里的页面
                    coroutine.yield('秘境停住了', 'c2')
                    mSleep(1000)
                end

                tap(1020, 233)
                mSleep(1000)
                tap(1020, 233) -- 多点一次,防止有对话框,只是取消了对话框
                mSleep(1000)

                pauseTime = 30
            elseif not Common.checkMainPage() then
                coroutine.yield('秘境出现弹窗', 'c2')
            end
        end
    end

    while true do
        if Common.checkBattle() then -- 战斗中不做任何处理
        elseif fail() then -- 战斗失败,先清除战斗失败提示
            tap(555, 555)
            Common.record('等待战斗结束')
        elseif not isColor(453, 19, 0xf35e6b) then -- 一直点离开,直到可以看到挂机的按钮
            tap(1067, 302)
        elseif Common.checkMainPage() then
            unchartedState.freq = 0 -- 清零,下一个账号从0开始
            return -2 -- 结束
        else
            coroutine.yield('秘境结束前常规检查', 'c2')
        end
        mSleep(1000)
    end
end

-- 闪退补偿
function Uncharted.crashCallack()
    crashNode = taskRecord.crashNode
    toast('crash num: ' .. crashNode['now'], 3)
    mSleep(3000)
    crashStep = tonumber(crashNode['now'])

    if crashStep <= 4 then
        return 1
    elseif crashStep == 5 then
        while true do
            if mijingInnerPage() then -- 在秘境里面
                return 6
            elseif Common.checkMainPage() then -- 主页
                return 1
            end
        end
    elseif crashStep == 6 then
        while true do
            if mijingInnerPage() then
                break
            end -- 可能在战斗,等到页面是在秘境里面
            mSleep(500)
        end
        tap(555, 555) -- 点击地板防止进入下一关
        mSleep(500)
        tap(555, 555) -- 点击地板防止进入下一关

        return 6
    end
end

return Uncharted
