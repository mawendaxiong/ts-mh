require("TSLib")

Common = require("Common.index")
TaskBoard = require("TaskBoard.index")

Treasure = {}
-- 领取宝图任务
local function getTask()
    offset = "3|0|0xf3d7b4,16|6|0x553923,27|0|0xf3d7b4,39|-7|0x5c402a,72|4|0x553923,75|2|0xf3d5b1"
    return findColorsUntil(0x553923, offset, 90, 806, 204, 1119, 492, {orient = 2}, 1000, 2)
end

-- 领取任务后,右侧的任务
local function rightTask()
    offset = "7|4|0xf6ed1c,19|14|0xf8ef1c,34|-1|0xfcf31c,28|9|0xfcf31c,205|44|0xc31b09,196|46|0xd02310"
    return findColorsUntil(0xfcf31c, offset, 90, 913, 144, 1134, 456, {orient = 2}, 500, 1)
end

-- 宝图道具
local function treasureMap()
    offset = "-5|7|0x4ebb77,12|9|0x44bb77,4|10|0xff5f55,0|28|0xb58d6a"
    return findColorsUntil(0xff5555, offset, 90, 555, 126, 972, 543, {orient = 2}, 500, 1)
end

-- 右下角使用宝图
local function useTreasureMap()
    offset = "-15|-109|0xeedd66,-5|-105|0xff4444,6|-99|0x44bb77,19|-103|0xffdd66"
    return findColorsUntil(0xedbf60, offset, 90, 895, 325, 1047, 550, {orient = 2}, 500, 1)
end

-- 背包
local function bag()
    offset = "-166|136|0xf9d847,43|133|0xd0d8d9,81|6|0xf6dcba"
    return findColorsUntil(0x926848, offset, 90, 122, 423, 414, 606, {orient = 2}, 500, 1)
end

-- 等去到店小二那里
function Treasure.waitWaiter()
    -- 出现店小二的对话框
    ret, tim, x, y = Common.userDialog(1000, 10)
    if not ret then
    -- todo 没出现怎么做
    end
    return 0
end

-- 领取任务
function Treasure.getTask()
    ret, tim, x, y = getTask()
    if ret then
        -- 领取任务
        tap(x, y)
        mSleep(1000)
    end

    -- 清除和店小二的对话框
    tap(600, 400)
    mSleep(1000)
    return 0
end

-- 右侧查询任务
function Treasure.findTask()
    -- 激活右侧任务tab
    if not isColor(931, 122, 0xcde5ac, 100) then
        tap(931, 122)
        mSleep(1000)
    end

    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        ret, tim, x, y = Common.redCancle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    ret, tim, x, y = rightTask()
    -- 找到任务
    if ret then
        tap(x, y)
        -- 执行
        return 0
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
        end
    )
    -- 找到了宝图任务
    if ret == 0 then
        -- 执行下一步,等待打宝图
        return 0
    end

    -- 打开背包找宝图
    return 8
end

-- 等待打完宝图
function Treasure.waitBattle()
    waitingTime = 30
    while (true) do
        isBattle = Common.checkBattle()

        -- 正在战斗
        if isBattle then
            waitingTime = 30
            fwCloseView("recordBoard", "record")
        else
            -- 是否在首页
            isMainPage = Common.checkMainPage()
            if not isMainPage then
                -- 关闭弹窗
                Common.closeWindow()
            else
                waitingTime = waitingTime - 1
                Common.record("倒计时: " .. waitingTime)

                -- 超过1分钟没进入战斗,说明打宝图结束了
                if waitingTime == 0 then
                    break
                end
            end
        end
    end
    -- 执行下一步,打开背包
    return 0
end

-- 打开背包
function Treasure.openBag()
    while true do
        if not Common.checkMainPage() then
            -- 关闭弹窗
            Common.closeWindow()
        else
            break
        end
        mSleep(1000)
    end

    -- 打开背包
    while true do
        ret, tim, x, y = bag()
        if ret then
            break
        end
        -- 打开背包
        tap(1101, 523)
        mSleep(1000)
    end

    -- 执行下一步,找宝图
    return 0
end

function Treasure.findMap()
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
            moveTo(729, 458, 729, 217, 2, 50)
        end,
        function()
            local p1 = getColor(606, 180)
            local p2 = getColor(686, 265)
            local p3 = getColor(769, 337)
            local p4 = getColor(841, 416)
            return p1, p2, p3, p4
        end
    )

    if ret == 0 then
        -- 执行下一步
        return 0
    end

    -- 背包没有宝图,直接结束
    return -2
end

-- 挖宝
function Treasure.excute()
    waitingTime = 40
    while true do
        ret = Common.checkMainPage()
        -- 在主页
        if ret then
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

        if waitingTime == 0 then
            break
        end
        mSleep(1000)
    end

    -- 结束挖宝
    toast("结束挖宝")
    return -2
end

function Treasure.findTaskOnTaskBoard()
    ret = TaskBoard.findTask()
    -- 没有找到任务,那就是已经打完了

    if ret == -1 then
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)
        -- 执行打开背包
        return 8
    end
    -- 执行下一步
    return 0
end

function Treasure.crashCallack()
    nowNode = taskRecord.currentNode
    toast("num: " .. nowNode["now"], 3)
    mSleep(3000)
    if nowNode["now"] == "1" then --回长安
        return 2
    elseif nowNode["now"] == "2" then --打开活动面板
        return 2
    elseif nowNode["now"] == "3" then --查找任务并打开
        return 2
    elseif nowNode["now"] == "4" then --等店小二
        return 2
    elseif nowNode["now"] == "5" then --领取任务
        return 2
    elseif nowNode["now"] == "6" then --右侧查找任务
        ret, tim, x, y = rightTask()
        -- 找到任务
        if ret then
            tap(x, y)
            return 7
        end
        -- 打开背包
        return 8
    elseif nowNode["now"] == "7" then --等待打宝图
        ret, tim, x, y = rightTask()
        -- 找到任务
        if ret then
            tap(x, y)
            return 7
        end
        -- 打开背包
        return 8
    elseif nowNode["now"] == "8" then --打开背包
        return 8
    elseif nowNode["now"] == "9" then --查找宝图
        return 8
    elseif nowNode["now"] == "10" then --使用宝图
        return 8
    end
end

return Treasure
