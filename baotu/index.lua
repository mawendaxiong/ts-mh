require('TSLib')
require('baotu.components')
local Common = require('Common.index')
local timer = require('Common.timer')
local TaskBoard = require('renwuban.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

Treasure = {}

-- 领取任务
function Treasure.getTask()
    while true do
        if Common.userDialog() then
            break
        end
        coroutine.yield('领取宝图任务异常', 'c2')
        mSleep(1000)
    end

    local ret, tim, x, y = getTask()
    if ret then
        -- 领取任务
        tap(x, y)
        mSleep(1000)
    else
        coroutine.yield('店小二没有任务', 'c2')
        ret, tim, x, y = getTask() -- 再次确认,防止是弹窗影响了
        if ret then
            -- 领取任务
            tap(x, y)
            mSleep(1000)
        end
    end

    -- 清除和店小二的对话框
    tap(600, 400)
    mSleep(1000)

    Common.blockCheckMainPage('宝图领取任务异常') -- 阻塞等待主页面
    return 0
end

-- 右侧查询任务
function Treasure.findTask()
    Common.blockCheckMainPage('宝图查询页面异常') -- 阻塞等待主页面

    -- 激活右侧任务tab
    if not isColor(931, 122, 0xcde5ac, 100) then
        tap(931, 122)
        mSleep(1000)
    end

    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        local ret, tim, x, y = Common.redCancle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    local ret, tim, x, y = rightTask()
    -- 找到任务
    if ret then
        tap(x, y)

        Common.blockCheckMainPage('宝图查询页面异常') -- 阻塞等待主页面

        return 0 -- 执行
    end

    -- 重置右侧任务栏
    Common.resetRightTaskBoard()

    ret =
        Common.move(
        function()
            ret, tim, x, y = rightTask()
            if ret then
                tap(x, y)
                mSleep(1000)
                return true
            end
            return false
        end,
        function()
            moveTo(1107, 350, 1102, 178, 2, 50)
        end,
        function()
            local p1 = getColor(713, 222)
            local p2 = getColor(726, 220)
            local p3 = getColor(711, 212)
            local p4 = getColor(723, 224)
            return p1, p2, p3, p4
        end,
        function()
            Common.resetRightTaskBoard()
        end,
        function()
            return Common.checkMainPage()
        end -- 确保查找右侧任务栏都在首页
    )

    if ret == 0 then -- 找到了宝图任务
        while true do
            if Common.checkMainPage() or Common.checkBattle() then
                break
            end -- [确保在首页or战斗]
            coroutine.yield('宝图查询页面异常', 'c2')
            mSleep(1000)
        end

        return 0 -- 执行下一步,等待打宝图
    elseif Common.checkMainPage() then -- 没有宝图任务,就打开背包挖宝
        return 7 -- 打开背包找宝图
    else
        Common.blockCheckMainPage('宝图查询页面异常') -- 阻塞等待主页面
        return 7 -- 打开背包
    end
end

-- 等待打完宝图
function Treasure.waitBattle()
    local waitingTime = 30
    while true do
        if Common.checkBattle() then -- 正在战斗
            waitingTime = 30
            fwCloseView('recordBoard', 'record')
        else
            if not Common.checkMainPage() then -- 不在首页
                coroutine.yield('打宝图,页面异常', 'c2')
            else
                waitingTime = waitingTime - 1
                Common.record('倒计时: ' .. waitingTime)

                if waitingTime <= 20 then -- 有时候打宝图会莫名停住,防止停住了
                    local r, t, x, y = rightTask()
                    if r then
                        tap(x, y)
                    end
                end
                -- 超过1分钟没进入战斗,说明打宝图结束了
                if waitingTime == 0 then
                    break
                end
            end
        end
    end

    Common.blockCheckMainPage('宝图查询页面异常') -- 阻塞等待主页面

    -- 执行下一步,打开背包
    return 0
end

-- 打开背包
function Treasure.openBag()
    Common.blockCheckMainPage('宝图查询页面异常') -- 阻塞等待主页面

    -- 打开背包
    while true do
        if bag() then
            break
        elseif not Common.checkMainPage() then
            coroutine.yield('宝图-打开背包', 'c2')
        else
            -- 打开背包
            tap(1101, 523)
        end

        mSleep(1000)
    end

    -- 因为在背包页面才会break,所以不用判断.执行下一步,找宝图
    return 0
end

function Treasure.findMap()
    while true do
        if bag() then
            break
        end -- [确保在背包]
        coroutine.yield('宝图在背包查找页面异常', 'c2')
        mSleep(1000)
    end

    local ret, tim, x, y = treasureMap()
    if ret then
        -- 点击宝图
        tap(x, y)
        mSleep(1000)
        -- 点击使用
        tap(444, 408)
        mSleep(1000)
        -- 执行下一步
        return 0
    end

    ret =
        Common.move(
        function()
            ret, tim, x, y = treasureMap()
            if ret then
                -- 点击宝图
                tap(x, y)
                mSleep(1000)
                -- 点击使用
                tap(444, 408)
                mSleep(1000)
                return true
            end
            return false
        end,
        function()
            moveTo(729, 358, 729, 217, 2, 50)
        end,
        function()
            local p1 = getColor(606, 180)
            local p2 = getColor(686, 265)
            local p3 = getColor(769, 337)
            local p4 = getColor(841, 416)
            return p1, p2, p3, p4
        end,
        nil,
        function()
            return bag()
        end
    )

    if ret == 0 then
        Common.blockCheckMainPage('宝图在背包查找页面异常') -- 阻塞等待主页面
        return 0 -- 执行下一步
    elseif bag() then -- 确保是背包界面,并且没有宝图,直接结束
        Common.closeWindow() -- 关闭背包
        return -2
    else
        while true do
            if bag() then
                Common.closeWindow() -- 关闭背包
                return -2
            end
            coroutine.yield('找宝图异常', 'c2')
            mSleep(1000)
        end
    end
end

-- 挖宝
function Treasure.excute()
    Common.blockCheckMainPage('挖宝页面使用宝图异常')

    local waitingTime = 40
    while true do
        if Common.checkMainPage() then -- 在主页
            -- 右下角的使用宝图
            local ret, tim, x, y = useTreasureMap()
            -- 没有使用宝图
            if not ret then
                waitingTime = waitingTime - 1
                Common.record('结束挖宝: ' .. waitingTime)
            else
                waitingTime = 40
                -- 右下角 使用宝图
                tap(x, y)
                mSleep(1000)
            end
        end

        if waitingTime <= 0 then
            break
        end
        mSleep(1000)
    end

    Common.blockCheckMainPage('宝图在背包查找页面异常')

    -- 结束挖宝
    toast('结束挖宝', 2)
    mSleep(2000)

    return -2
end

function Treasure.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
        coroutine.yield('任务板查找任务异常', 'c2')
        mSleep(1000)
    end

    if TaskBoard.findTask() == -1 then -- 没有找到任务,那就是已经打完了
        tap(1014, 43) -- 关闭活动板
        mSleep(1000)

        while true do
            if Common.checkMainPage() then
                break
            end -- [确保在主页面]
            coroutine.yield('挖宝打开背包前页面异常', 'c2')
            mSleep(1000)
        end
        return 7 -- 执行打开背包
    end

    while true do
        if Common.userDialog() then
            break
        end -- 到了店小二
        coroutine.yield('等待去店小二', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

function Treasure.crashCallack()
    local crashNode = taskRecord.crashNode
    toast('crash num: ' .. crashNode['now'], 3)
    mSleep(3000)
    local crashStep = tonumber(crashNode['now'])

    if crashStep < 6 then
        return 1
    elseif crashStep == 6 then -- 等待打宝图
        while true do
            if Common.checkBattle() then
                return 6
            end -- 如果在战斗继续打宝图
            if Common.checkMainPage() then
                return 5
            end -- 在首页查找任务
            mSleep(2000)
        end
    elseif crashStep < 9 then
        Common.blockCheckMainPage('挖宝闪退重启游戏页面异常')
        return 7 -- 打开背包
    else
        while true do
            if Common.checkMainPage() then
                if useTreasureMap() then
                    return 9
                end -- 右下角的使用宝图
                return 7 -- 到了首页,执行打开背包
            end
            mSleep(1000)
        end
    end
end

return Treasure
