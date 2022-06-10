require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local unchartedState = container.uncharted

Uncharted = {}

-- 新的一周提示
local function newWeekSection()
    offset = '47|2|0x6e2b00,93|0|0x6e2b00,209|133|0xfdefe9,205|155|0xf95c7c'
    return findColorsUntil(0x6e2b00, offset, 90, 675, 94, 990, 412,
                           {orient = 2}, 500, 1)
end

local function openButton()
    offset =
        "8|0|0x553923,28|1|0x553923,48|1|0xf2d6af,59|6|0x553923,72|5|0x553923,87|-10|0x563a24"
    return findColorsUntil(0x553923, offset, 90, 813, 82, 1135, 491,
                           {orient = 2}, 500, 1)
end

-- 右边 [秘境降妖]
local function task()
    offset =
        "21|4|0xffff00,38|15|0xf9f901,57|3|0xffff00,76|8|0xffff00,71|17|0xffff00"
    return findColorsUntil(0xffff00, offset, 90, 898, 197, 1134, 284,
                           {orient = 2}, 500, 1)
end

-- 右侧 [地图]按钮
local function unchartedMap()
    offset = "0|16|0xeccf7b,25|3|0xf9edba,32|18|0xeacb74,44|16|0xeccf7b"
    return findColorsUntil(0xfbf3c7, offset, 90, 897, 246, 1132, 329,
                           {orient = 2}, 500, 1)
end

-- 失败
local function fail()
    offset = "22|18|0xc2e0f4,144|41|0xa1c1db,-89|19|0x404040,245|-6|0x9a2833"
    return findColorsUntil(0xd4e8f7, offset, 90, 307, 111, 805, 291,
                           {orient = 2}, 500, 1)
end

local function mijingPage()
    offset =
        '-482|34|0xa67f61,-496|-53|0xf2c35b,-441|-29|0xfef4bb,-340|-51|0xf5c157'
    return findColorsUntil(0xb91f28, offset, 90, 307, 111, 805, 291,
                           {orient = 2}, 500, 1)
end

local function mijingInnerPage()
    offset = '-426|-11|0xfbb718,-417|-7|0xf16c00,23|-17|0xd08126'
    return findColorsUntil(0xfb2220, offset, 90, 204, 4, 757, 96, {orient = 2},
                           500, 1)
end

-- 等云乐游
function Uncharted.waitNPC()
    ret, tim, x, y = Common.userDialog(1000, 10)
    -- 没有出现云乐游的对话框
    if not ret then
        coroutine.yield('没有出现云游乐', 'c2')
        if not Common.userDialog() then -- 二次确认,没有再次打开任务板
            return 2
        end
    end

    -- 点击进入
    ret, tim, x, y = openButton()
    if not ret then coroutine.yield('进入秘境被挡住了', 'c2') end
    tap(x, y)
    mSleep(2000)

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
    if not mijingPage() then
        coroutine.yield('秘境进入界面被弹窗挡住了', 'c2')
    end

    Common.move(nil, function() moveTo(410, 146, 913, 146, 50, 1000) end,
                function()
        local p1 = getColor(377, 347)
        local p2 = getColor(586, 483)
        local p3 = getColor(885, 326)
        local p4 = getColor(914, 504)
        return p1, p2, p3, p4
    end, nil, function() return mijingPage() end)

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
        coroutine.yield('秘境被弹窗挡住了', 'c2')
    end

    unchartedState.freq = 0
    pauseTime = 30
    isCount = false
    while true do
        ret = Common.checkBattle(200, 1)
        -- 正在战斗
        if ret then
            if not isCount then
                unchartedState.freq = unchartedState.freq + 1
                Common.record("秘境: " .. unchartedState.freq)
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
            Common.record("倒计时: " .. pauseTime)

            if isColor(894, 354, 0xf3d6b3, 90) then -- 需要点进入战斗
                Common.record("点击进入战斗")

                -- 点击进入战斗
                tap(894, 354)
                mSleep(1000)
            elseif fail() then -- 战斗失败
                Common.record("战斗失败")

                -- 消除失败提示
                tap(555, 555)
                mSleep(1000)

                -- 离开秘境
                tap(1075, 310)
                -- 结束
                return -2
            elseif pauseTime == 0 then
                coroutine.yield('秘境常规检查', 'c2')
                ret, tim, x, y = task()
                if ret then
                    tap(x, y)
                    mSleep(1000)
                end
                pauseTime = 30
            elseif not Common.checkMainPage() then
                coroutine.yield('秘境出现弹窗', 'c2')
            end
        end

    end

    while true do
        if Common.checkBattle() then -- 战斗中不做任何处理
        elseif Common.checkMainPage() then
            if fail() then -- 战斗失败,先清除战斗失败提示
                tap(555, 555)
                mSleep(1000)
            elseif not isColor(453, 19, 0xf35e6b) then -- 一直点离开,直到可以看到挂机的按钮
                tap(1067, 302)
                mSleep(1000)
            else
                -- 结束
                return -2
            end
        else
            coroutine.yield('秘境结束前常规检查', 'c2')
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
        if mijingInnerPage() then return 6 end
        return 2
    elseif nowNode["now"] == "6" then -- 计算次数
        return 6
    end
end

return Uncharted
