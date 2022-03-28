require("TSLib")

Common = require("Common.index")

Sect = {}

-- 检查有没有勾上字段选择
local function autoChoose()
    offset = "12|1|0x58be45,7|7|0x73bf1e,21|-9|0x22be9e"
    return findColorsUntil(0x8cd626, offset, 90, 451, 464, 489, 502, {orient = 2}, 500, 1)
end

-- 没有自动选择,要自行选择的小任务
local function unselectTask()
    offset = "63|-1|0xf8e3c4,63|21|0xf3d6ae,2|21|0xf3d6ae"
    return findColorsUntil(0xf8e3c4, offset, 90, 348, 362, 978, 420, {orient = 2}, 500, 1)
end
-- 药店和武器店的购买
local function weaponAndDrug()
    offset = "-5|19|0xecb146,142|26|0xeba950,144|-2|0xefb651"
    return findColorsUntil(0xeeb956, offset, 90, 755, 480, 977, 563, {orient = 2}, 500, 2)
end

-- 师门结束,师门任务类型选择的,右侧的关闭按钮
local function finish()
    offset = "-10|13|0xf07144,14|11|0xba2a18,4|24|0xd93518,3|12|0xffe7b8"
    return findColorsUntil(0xf26b44, offset, 90, 969, 102, 1015, 170, {orient = 2}, 500, 1)
end

-- 选择任务类型时的 继续任务
local function continueTask()
    offset = "9|0|0x6c310a,36|-2|0x6c310a,32|3|0x6c320b,40|10|0x6c310a"
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423, {orient = 2}, 500, 1)
end

-- 选择任务类型时的 去完成
local function startTask()
    offset = "7|6|0x6c310a,14|14|0x6c310a,28|-3|0x6c310a,31|15|0x6c320b"
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423, {orient = 2}, 500, 1)
end

-- 点击门派师傅首次领取任务的 门派任务 字样
local function chooseTask1()
    offset = "19|8|0x553923,25|4|0x553923,50|6|0x593d27,87|12|0x5f422b,81|5|0x553923"
    return findColorsUntil(0x553923, offset, 90, 822, 166, 1105, 481, {orient = 2}, 500, 1)
end

-- 师门任务 -> 选择执行那种类型的师门
local function chooseTask()
    offset = "0|22|0xf4d7b0,113|24|0xf3d6ae,110|2|0xf8e3c4"
    return findColorsUntil(0xf8e6c5, offset, 90, 347, 358, 989, 431, {orient = 2}, 500, 1)
end

local function rightTask()
    offset = "12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c"
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end

-- 使用道具
local function useProp()
    offset = "13|1|0x70350c,42|-1|0xeec363,48|15|0x6c310a,36|11|0x6c310a"
    return findColorsUntil(0x6c310a, offset, 90, 894, 329, 1049, 553, {orient = 2}, 500, 1)
end

-- 对话框跳出来的选项
local function dialogSelection()
    offset = "1|32|0xf3d095,55|19|0xf3d5af,-69|30|0xf2d09a"
    return findColorsUntil(0xf4dec0, offset, 90, 810, 81, 1111, 490, {orient = 2}, 500, 1)
end

-- 上交物品
local function handIn()
    offset = "-6|18|0x6c310a,7|18|0x6c310a,25|1|0x6c310a,26|14|0x6c310a,26|6|0xedc061"
    return findColorsUntil(0x6c310a, offset, 90, 750, 445, 1121, 548, {orient = 2}, 500, 1)
end

-- 摆摊购买
local function shopping()
    offset = "105|-126|0xea5419,145|-130|0xc72e1a,125|-100|0xf99804"
    return findColorsUntil(0xebb252, offset, 90, 799, 400, 1091, 618, {orient = 2}, 500, 1)
end

-- 右下角便携使用物品的关闭按钮
local function cancelButton()
    offset = "-7|-5|0xb90c00,8|-7|0xb80900,6|7|0xc60a00,-7|6|0xc10c00"
    return findColorsUntil(0xbf1500, offset, 90, 889, 301, 1055, 422, {orient = 2}, 500, 1)
end

-- 移动右侧任务栏并查找师门任务
local function moveAndFindRightTask()
    return Common.move(
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
end

-- 首页的任务tab
local function taskTab()
    offset = "16|-1|0xeaf1bc,16|12|0xb47872,-1|28|0x002a7b,23|24|0xad8329"
    return findColorsUntil(0xd2e6ae, offset, 90, 902, 86, 1029, 161, {orient = 2}, 500, 1)
end

-- 任务板查找任务
function Sect.findTaskOnTaskBoard()
    ret = TaskBoard.findTask()
    -- 找不到师门任务,直接结束
    if ret == -1 then
        return -2
    end

    return 0
end

-- 选择任务
function Sect.chooseTask()
    -- 勾上了自动选择
    if autoChoose() then
        -- 去完成
        ret, tim, x, y = startTask()
        -- 刚开始领任务
        if ret then
            tap(x, y)
            return 0
        elseif continueTask() then --继续任务
            -- 关闭选怎师门类型的窗口
            tap(991, 130)
            -- 从右侧找 师门任务
            return 6
        else --结束
            Common.record("师门已做完")
            tap(992, 130)
            return -2
        end
    else --没有自动选择
        -- 勾上自动选择
        tap(474, 486)
        mSleep(500)
        -- 选择第一个任务
        ret, tim, x, y = unselectTask()
        if ret then
            tap(x, y)
            return 0
        else
            Common.record("师门已做完")
            return -2
        end
    end
end

-- 等到师傅那里
function Sect.waitMaster()
    ret, tim, x, y = Common.userDialog(1000, 10)
    -- 没有出现门派师傅的对话框
    if not ret then
    -- todo 没出现怎么办
    end

    -- 先点击 师门任务
    ret, tim, x, y = chooseTask1()
    tap(x, y)
    mSleep(2500)

    -- 师门任务类型
    ret, tim, x, y = chooseTask()
    tap(x, y)
    mSleep(1000)

    return 0
end

function Sect.findRightTask()
    -- 先关闭右下角的物品快捷使用,以防挡住任务
    while true do
        ret, tim, x, y = Common.redCancle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    ret = moveAndFindRightTask()

    -- 成功领取任务
    if ret == 0 then
        return 0
    end
    -- 结束
    return -2
end

--[[
类型1: 巡逻 打怪
类型2: 使用物品
类型3: 找首席 -> 师门任务 -> 去其他地方 -> 答题
类型4: 购物 可能被购买了,再次点击 上交物品 可能会出现师门任务
类型5: 回去师傅,师门任务,师傅请 答题
]]
function Sect.excute()
    while (true) do
        -- fwCloseView("recordBoard", "record")
        -- keepScreen(true)
        toast("checking...", 1)

        if Common.checkMainPage() then -- 在首页
            -- keepScreen(false)
            if Common.userDialog() then --有对话框
                Common.record("对话")

                -- 点击第一个选项
                ret, tim, x, y = dialogSelection()
                if ret then -- 有选项的对话框
                    tap(x, y)
                    mSleep(1000)
                else --有对话,没有选项
                    -- 清除对话
                    tap(400, 600)
                    mSleep(1000)
                end
            elseif useProp() then --右下角使用道具
                mSleep(1000)

                -- 点击使用道具
                tap(967, 511)
                mSleep(2000)
            elseif taskTab() then --点击右边师门任务
                -- 点击师门任务
                ret, tim, x, y = rightTask()
                if ret then
                    toast("tap task...")
                    tap(x, y)
                    mSleep(1000)
                else --拉动右侧列表查找
                    Common.resetRightTaskBoard()
                end
            end
        elseif handIn() then -- 上交物品
            Common.record("上交物品")

            -- 上交
            tap(937, 518)
            mSleep(1000)
        elseif weaponAndDrug() then -- 药店或者武器店
            Common.record("药或者武器")

            -- 点击 购买
            tap(862, 524)
            mSleep(1000)
        elseif shopping() then -- 购物
            Common.record("商城购买")

            -- 点击第一个商品
            tap(526, 166)
            mSleep(200)
            -- 购买
            tap(892, 584)
            mSleep(1000)
        elseif finish() then
            toast("师门结束")
            Common.record("师门结束")

            tap(992, 130)
            -- 结束师门任务
            return -2
        else --等对话
            Common.record("等待")
            -- 跳过
            tap(464, 545)
            mSleep(1000)
        end
    end
end

-- 闪退补偿
function Sect.crashCallack()
    nowNode = taskRecord.currentNode
    toast("num: " .. nowNode["now"])
    if nowNode["now"] == "1" then --回长安
        return 2
    elseif nowNode["now"] == "2" then --打开活动面板
        return 2
    elseif nowNode["now"] == "3" then --查找任务并打开
        return 2
    elseif nowNode["now"] == "4" then --选择任务
        return 2
    elseif nowNode["now"] == "5" then --等师傅
        return 2
    elseif nowNode["now"] == "6" then --找任务
        return 6
    elseif nowNode["now"] == "7" then --执行
        return 6
    end
end
return Sect
