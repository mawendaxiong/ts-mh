require("TSLib")

Common = require("Common.index")
TaskBoard = require("TaskBoard.index")

Uncharted = {}

-- 新的一周提示
local function newWeekSection()
    offset = "48|10|0xf7d66e,153|10|0xf7d673,190|7|0xffd16d"
    return findColorsUntil(0xf3bf53, offset, 90, 414, 4, 704, 45, {orient = 2}, 500, 1)
end

local function openButton()
    offset = "8|0|0x553923,28|1|0x553923,48|1|0xf2d6af,59|6|0x553923,72|5|0x553923,87|-10|0x563a24"
    return findColorsUntil(0x553923, offset, 90, 813, 82, 1135, 491, {orient = 2}, 500, 1)
end

-- 右边 [秘境降妖]
local function task()
    offset = "21|4|0xffff00,38|15|0xf9f901,57|3|0xffff00,76|8|0xffff00,71|17|0xffff00"
    return findColorsUntil(0xffff00, offset, 90, 898, 197, 1134, 284, {orient = 2}, 500, 1)
end

-- 右侧 [地图]按钮
local function unchartedMap()
    offset = "0|16|0xeccf7b,25|3|0xf9edba,32|18|0xeacb74,44|16|0xeccf7b"
    return findColorsUntil(0xfbf3c7, offset, 90, 897, 246, 1132, 329, {orient = 2}, 500, 1)
end

-- 失败
local function fail()
    offset = "22|18|0xc2e0f4,144|41|0xa1c1db,-89|19|0x404040,245|-6|0x9a2833"
    return findColorsUntil(0xd4e8f7, offset, 90, 307, 111, 805, 291, {orient = 2}, 500, 1)
end

-- 等云乐游
function Uncharted.waitNPC()
    ret, tim, x, y = Common.userDialog(1000, 10)
    -- 没有出现云乐游的对话框
    if not ret then
    -- todo 没出现要怎么做
    end

    -- 点击进入
    ret, tim, x, y = openButton()
    tap(x, y)

    -- 新的一周,重新选择秘境,非日月之井
    if newWeekSection() then
        -- 进入左边的秘境
        tap(337, 564)
        mSleep(1000)
        -- 确定
        tap(695, 388)
        mSleep(1000)
    end

    return 0
end

-- 进入秘境
function Uncharted.getInto()
    Common.move(
        nil,
        function()
            moveTo(410, 377, 913, 377, 50, 1000)
        end,
        function()
            local p1 = getColor(377, 347)
            local p2 = getColor(586, 483)
            local p3 = getColor(885, 326)
            local p4 = getColor(914, 504)
            return p1, p2, p3, p4
        end
    )

    -- 点击猛如虎,69秘境
    tap(295, 308)
    mSleep(1000)

    -- 点击确认
    tap(609, 467)
    mSleep(1000)

    return 0
end

-- 计算次数
function Uncharted.count()
    ret, tim, x, y = task()
    if ret then
        tap(x, y)
        mSleep(1000)
    else
        Common.closeWindow()
    end

    uncharted.freq = 0

    isCount = false
    while true do
        ret = Common.checkBattle(200, 1)
        -- 正在战斗
        if ret then
            -- mSleep(500)
            if not isCount then
                uncharted.freq = uncharted.freq + 1
                Common.record("秘境: " .. uncharted.freq)
                if uncharted.freq == 15 then
                    -- 结束
                    break
                end
            end
            isCount = true
        else
            isCount = false

            keepScreen(true)
            if isColor(894, 354, 0xf3d6b3, 100) then --需要点进入战斗
                keepScreen(false)
                -- 点击进入战斗
                tap(894, 354)
                mSleep(1000)
            elseif fail() then -- 战斗失败
                keepScreen(false)
                -- 消除失败提示
                tap(555, 555)
                mSleep(1000)
                -- 回长安
                Common.b2a()
                -- 结束
                return -2
            else
                -- 关闭弹窗
                Common.closeWindow()
                keepScreen(false)
            end
        end
    end

    while true do
        if fail() then --战斗失败,先清除战斗失败提示
            tap(555, 555)
            mSleep(1000)
        elseif not isColor(453, 19, 0xf35e6b) then -- 一直点离开,直到可以看到挂机的按钮
            tap(1067, 302)
            mSleep(1000)
        else
            -- 结束
            return -2
        end
    end
end

-- 闪退补偿
function Uncharted.crashCallack()
    nowNode = taskRecord.currentNode
    toast("num: " .. nowNode["now"])
    if nowNode["now"] == "1" then -- 回长安
        return 2
    elseif nowNode["now"] == "2" then -- 打开活动面板
        return 2
    elseif nowNode["now"] == "3" then -- 查找任务并打开
        return 2
    elseif nowNode["now"] == "4" then -- 等云乐游
        return 2
    elseif nowNode["now"] == "5" then -- 进入秘境
        -- 在秘境里面
        if unchartedMap() then
            return 6
        end
        return 2
    elseif nowNode["now"] == "6" then -- 计算次数
        return 6
    end
end

return Uncharted
