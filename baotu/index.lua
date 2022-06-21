require("TSLib")

Common = require("Common.index")
timer = require("Common.timer")
TaskBoard = require("renwuban.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

Treasure = {}

-- 领取宝图任务
local function getTask()
    offset =
        "3|0|0xf3d7b4,16|6|0x553923,27|0|0xf3d7b4,39|-7|0x5c402a,72|4|0x553923,75|2|0xf3d5b1"
    return findColorsUntil(0x553923, offset, 90, 806, 204, 1119, 492,
                           {orient = 2}, 1000, 2)
end

-- 领取任务后,右侧的任务
local function rightTask()
    offset =
        "7|4|0xf6ed1c,19|14|0xf8ef1c,34|-1|0xfcf31c,28|9|0xfcf31c,205|44|0xc31b09,196|46|0xd02310"
    return findColorsUntil(0xfcf31c, offset, 90, 913, 144, 1134, 456,
                           {orient = 2}, 500, 1)
end

-- 宝图道具
local function treasureMap()
    offset = "-5|7|0x4ebb77,12|9|0x44bb77,4|10|0xff5f55,0|28|0xb58d6a"
    return findColorsUntil(0xff5555, offset, 90, 555, 126, 972, 543,
                           {orient = 2}, 500, 1)
end

-- 右下角使用宝图
local function useTreasureMap()
    offset =
        "-15|-109|0xeedd66,-5|-105|0xff4444,6|-99|0x44bb77,19|-103|0xffdd66"
    return findColorsUntil(0xedbf60, offset, 90, 895, 325, 1047, 550,
                           {orient = 2}, 500, 1)
end

-- 背包
local function bag()
    offset = "-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba"
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606,
                           {orient = 2}, 500, 1)
end

-- 领取任务
function Treasure.getTask()
    while true do
        if Common.userDialog() then break end
        coroutine.yield('领取宝图任务异常', 'c2')
        mSleep(1000)
    end

    ret, tim, x, y = getTask()
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

    while true do
        if Common.checkMainPage() then break end -- [确保在首页]
        coroutine.yield('宝图领取任务异常', 'c2')
        mSleep(1000)
    end
    return 0
end

-- 右侧查询任务
function Treasure.findTask()
    while true do
        if Common.checkMainPage() then break end
        coroutine.yield('宝图查询页面异常', 'c2')
        mSleep(1000)
    end

    -- 激活右侧任务tab
    if not isColor(931, 122, 0xcde5ac, 100) then
        tap(931, 122)
        mSleep(1000)
    end

    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        ret, tim, x, y = Common.redCancle2()
        if not ret then break end
        tap(x, y)
        mSleep(1000)
    end

    ret, tim, x, y = rightTask()
    -- 找到任务
    if ret then
        tap(x, y)

        while true do
            if Common.checkMainPage() then break end -- [确保在首页]
            coroutine.yield('宝图查询页面异常', 'c2')
            mSleep(1000)
        end
        return 0 -- 执行
    end

    -- 重置右侧任务栏
    Common.resetRightTaskBoard()

    ret = Common.move(function()
        ret, tim, x, y = rightTask()
        if ret then
            tap(x, y)
            mSleep(1000)
            return true
        end
        return false
    end, function() moveTo(1107, 350, 1102, 178, 2, 50) end, function()
        local p1 = getColor(713, 222)
        local p2 = getColor(726, 220)
        local p3 = getColor(711, 212)
        local p4 = getColor(723, 224)
        return p1, p2, p3, p4
    end, function() Common.resetRightTaskBoard() end,
                      function() return Common.checkMainPage() end -- 确保查找右侧任务栏都在首页
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
        while true do
            if Common.checkMainPage() then return 7 end -- [确保在首页] 然后打开背包
            coroutine.yield('宝图查询页面异常', 'c2')
            mSleep(1000)
        end
    end

end

-- 等待打完宝图
function Treasure.waitBattle()
    waitingTime = 30
    while true do

        if Common.checkBattle() then -- 正在战斗
            waitingTime = 30
            fwCloseView("recordBoard", "record")
        else

            if not Common.checkMainPage() then -- 不在首页
                coroutine.yield('打宝图,页面异常', 'c2')
            else
                waitingTime = waitingTime - 1
                Common.record("倒计时: " .. waitingTime)

                -- 超过1分钟没进入战斗,说明打宝图结束了
                if waitingTime == 0 then break end
            end
        end
    end

    while true do
        if Common.checkMainPage() then break end -- [确保在首页]
        coroutine.yield('宝图查询页面异常', 'c2')
        mSleep(1000)
    end

    -- 执行下一步,打开背包
    return 0
end

-- 打开背包
function Treasure.openBag()
    while true do
        if Common.checkMainPage() then break end -- [确保在首页]
        coroutine.yield('宝图查询页面异常', 'c2')
        mSleep(1000)
    end

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
        if bag() then break end -- [确保在背包]
        coroutine.yield('宝图在背包查找页面异常', 'c2')
        mSleep(1000)
    end

    ret, tim, x, y = treasureMap()
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

    ret = Common.move(function()
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
    end, function() moveTo(729, 358, 729, 217, 2, 50) end, function()
        local p1 = getColor(606, 180)
        local p2 = getColor(686, 265)
        local p3 = getColor(769, 337)
        local p4 = getColor(841, 416)
        return p1, p2, p3, p4
    end, nil, function() return bag() end)

    if ret == 0 then

        while true do
            if Common.checkMainPage() then
                return 0 -- 执行下一步
            end -- [确保在主页]
            coroutine.yield('宝图在背包查找页面异常', 'c2')
            mSleep(1000)
        end

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
    while true do
        if Common.checkMainPage() then break end
        coroutine.yield('挖宝页面使用宝图异常', 'c2')
        mSleep(1000)
    end
    
    waitingTime = 40
    while true do

        if Common.checkMainPage() then -- 在主页
            -- 右下角的使用宝图
            ret, tim, x, y = useTreasureMap()
            -- 没有使用宝图
            if not ret then
                waitingTime = waitingTime - 1
                Common.record("结束挖宝: " .. waitingTime)
            else
                waitingTime = 40
                -- 右下角 使用宝图
                tap(x, y)
                mSleep(1000)
            end
        end

        if waitingTime <= 0 then break end
        mSleep(1000)
    end

    while true do
        if Common.checkMainPage() then break end -- [确保在首页]
        coroutine.yield('宝图在背包查找页面异常', 'c2')
        mSleep(1000)
    end

    -- 结束挖宝
    toast("结束挖宝", 2)
    mSleep(2000)

    return -2
end

function Treasure.findTaskOnTaskBoard()

    while true do
        if TaskBoard.checkTaskBoard() then break end
        coroutine.yield('任务板查找任务异常', 'c2')
        mSleep(1000)
    end

    if TaskBoard.findTask() == -1 then -- 没有找到任务,那就是已经打完了

        tap(1014, 43) -- 关闭活动板
        mSleep(1000)

        while true do
            if Common.checkMainPage() then break end -- [确保在主页面]            
            coroutine.yield('挖宝打开背包前页面异常', 'c2')
            mSleep(1000)
        end
        return 7 -- 执行打开背包
    end

    while true do
        if Common.userDialog() then break end -- 到了店小二
        coroutine.yield('等待去店小二', 'c2')
        mSleep(1000)
    end

    -- 执行下一步
    return 0
end

function Treasure.crashCallack()
    nowNode = taskRecord.crashNode
    toast("crash num: " .. nowNode["now"], 3)
    mSleep(3000)
    if nowNode["now"] == "1" then -- 回长安
        return 2
    elseif nowNode["now"] == "2" then -- 打开活动面板
        return 2
    elseif nowNode["now"] == "3" then -- 查找任务并打开
        return 2
    elseif nowNode["now"] == "4" then -- 领取任务
        return 2
    elseif nowNode["now"] == "5" then -- 右侧查找任务
        return 2
    elseif nowNode["now"] == "6" then -- 等待打宝图
        while true do
            if Common.checkBattle() then return 6 end -- 如果在战斗继续打宝图
            if Common.checkMainPage() then return 5 end -- 在首页查找任务
            mSleep(2000)
        end
    elseif nowNode["now"] == "7" then -- 打开背包
        return 7
    elseif nowNode["now"] == "8" then -- 查找宝图
        return 7
    elseif nowNode["now"] == "9" then -- 使用宝图
    else -- 7,8,9 逻辑一样
        while true do -- 到了首页,执行打开背包
            if Common.checkBattle() then return 6 end -- 如果在战斗继续打宝图
            if Common.checkMainPage() then return 7 end
            mSleep(2000)
        end
    end
end

return Treasure
