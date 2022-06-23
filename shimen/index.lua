require("TSLib")

Common = require("Common.index")
local container = require("Main.state")
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

Sect = {}

-- 检查有没有勾上字段选择
local function autoChoose()
    offset = "12|1|0x58be45,7|7|0x73bf1e,21|-9|0x22be9e"
    return findColorsUntil(0x8cd626, offset, 90, 451, 464, 489, 502,
                           {orient = 2}, 500, 1)
end

-- 没有自动选择,要自行选择的小任务
local function unselectTask()
    offset = "63|-1|0xf8e3c4,63|21|0xf3d6ae,2|21|0xf3d6ae"
    return findColorsUntil(0xf8e3c4, offset, 90, 348, 362, 978, 420,
                           {orient = 2}, 500, 1)
end
-- 药店和武器店的购买
local function weaponAndDrug()
    offset = "-5|19|0xecb146,142|26|0xeba950,144|-2|0xefb651"
    return findColorsUntil(0xeeb956, offset, 90, 755, 480, 977, 563,
                           {orient = 2}, 500, 2)
end

-- 师门结束,师门任务类型选择的,右侧的关闭按钮
local function finish()
    offset = "-10|13|0xf07144,14|11|0xba2a18,4|24|0xd93518,3|12|0xffe7b8"
    return findColorsUntil(0xf26b44, offset, 90, 969, 102, 1015, 170,
                           {orient = 2}, 500, 1)
end

-- 选择任务类型时的 继续任务
local function continueTask()
    offset = "9|0|0x6c310a,36|-2|0x6c310a,32|3|0x6c320b,40|10|0x6c310a"
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423,
                           {orient = 2}, 500, 1)
end

-- 选择任务类型时的 去完成
local function startTask()
    offset = "7|6|0x6c310a,14|14|0x6c310a,28|-3|0x6c310a,31|15|0x6c320b"
    return findColorsUntil(0x6c310a, offset, 90, 352, 356, 980, 423,
                           {orient = 2}, 500, 1)
end

-- 点击门派师傅首次领取任务的 门派任务 字样
local function chooseTask1()
    offset =
        "19|8|0x553923,25|4|0x553923,50|6|0x593d27,87|12|0x5f422b,81|5|0x553923"
    return findColorsUntil(0x553923, offset, 90, 822, 166, 1105, 481,
                           {orient = 2}, 500, 1)
end

-- 师门任务 -> 选择执行那种类型的师门
local function chooseTask()
    offset = "0|22|0xf4d7b0,113|24|0xf3d6ae,110|2|0xf8e3c4"
    return findColorsUntil(0xf8e6c5, offset, 90, 804, 6, 1107, 610,
                           {orient = 2}, 500, 1)
end

local function rightTask()
    offset = "12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c"
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463,
                           {orient = 2}, 500, 2)
end

-- 使用道具
local function useProp()
    offset = "13|1|0x70350c,42|-1|0xeec363,48|15|0x6c310a,36|11|0x6c310a"
    return findColorsUntil(0x6c310a, offset, 90, 894, 329, 1049, 553,
                           {orient = 2}, 500, 1)
end

-- 对话框跳出来的选项
local function dialogSelection()
    offset = "1|32|0xf3d095,55|19|0xf3d5af,-69|30|0xf2d09a"
    return findColorsUntil(0xf4dec0, offset, 90, 810, 81, 1111, 490,
                           {orient = 2}, 500, 1)
end

-- 上交物品
local function handIn()
    offset =
        "-6|18|0x6c310a,7|18|0x6c310a,25|1|0x6c310a,26|14|0x6c310a,26|6|0xedc061"
    return findColorsUntil(0x6c310a, offset, 90, 750, 445, 1121, 548,
                           {orient = 2}, 500, 1)
end

-- 摆摊购买
local function shopping()
    offset = "105|-126|0xea5419,145|-130|0xc72e1a,125|-100|0xf99804"
    return findColorsUntil(0xebb252, offset, 90, 799, 400, 1091, 618,
                           {orient = 2}, 500, 1)
end

-- 右下角便携使用物品的关闭按钮
local function cancelButton()
    offset = "-7|-5|0xb90c00,8|-7|0xb80900,6|7|0xc60a00,-7|6|0xc10c00"
    return findColorsUntil(0xbf1500, offset, 90, 889, 301, 1055, 422,
                           {orient = 2}, 500, 1)
end

-- 工坊
local function workshop()
    offset = '489|7|0xe2392a,414|8|0xffdc66,123|19|0xf4bf50,246|-8|0xa6612d'

    return findColorsUntil(0xe53c2c, offset, 90, 117, 4, 1048, 71, {orient = 2},
                           500, 1)
end

-- 移动右侧任务栏并查找师门任务
local function moveAndFindRightTask()
    return Common.move(function()
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
                       function() return Common.checkMainPage() end)
end

-- 首页的任务tab
local function taskTab()
    offset = "16|-1|0xeaf1bc,16|12|0xb47872,-1|28|0x002a7b,23|24|0xad8329"
    return findColorsUntil(0xd2e6ae, offset, 90, 902, 86, 1029, 161,
                           {orient = 2}, 500, 1)
end

-- 购买宠物
local function buyPet()
    return findColorsUntil(0xebb252,
                           "-255|16|0x9e5f30,94|-531|0xce0000,-507|19|0x8d5d2c",
                           90, 116, 28, 1029, 617, {orient = 2}, 500, 1)
end

-- 福利-领装备
local function lingzhuangbei()
    return findColorsUntil(0x6c310a,
                           "32|-3|0x6c310a,55|-2|0x6c310a,85|6|0x6c310a,74|5|0xe9ab54,-17|5|0xe8a953",
                           90, 169, 93, 353, 585, {orient = 2}, 500, 1)
end

-- 检查是不是在选择任务的界面
local function checkChoosePage()
    offset = "6|6|0xef3d47,48|-362|0xffe7b8,59|-365|0xc5311b,7|-18|0xff5362"
    return findColorsUntil(0xa84407, offset, 90, 876, 81, 1015, 538,
                           {orient = 2}, 500, 1)
end

-- 推荐师傅
local function shifutuijian()
    offset =
        "32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c"
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575,
                           {orient = 2}, 500, 2)
end

-- 任务板查找任务
function Sect.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then break end
        coroutine.yield('任务板查找任务异常', 'c2')
        mSleep(1000)
    end

    -- 找不到师门任务,直接结束
    if TaskBoard.findTask() == -1 then
        -- 关闭活动板
        tap(1014, 43)
        mSleep(1000)

        Common.blockCheckMainPage('师门提前结束页面异常')
        return -2 -- 结束
    end

    while true do
        if checkChoosePage() then -- [确保是师门选择任务的页面]
            break
        end
        coroutine.yield('师门任务查找任务异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 选择任务
function Sect.chooseTask()
    while true do
        if checkChoosePage() then break end
        coroutine.yield('师门任务选择任务页面异常', 'c2')
        mSleep(1000)
    end
    -- 如果不是选择任务的界面,直接进行下一步,因为可能是[新手的师门任务]
    if not checkChoosePage() then
        coroutine.yield('师门任务前置检查', 'c2')
        if not checkChoosePage() then return 0 end -- 再次确认没有选择任务界面
    end
    -- 勾上了自动选择
    if autoChoose() then

        ret, tim, x, y = startTask() -- [去完成]字样的按钮
        if ret then -- 今天首次领取任务
            tap(x, y)
            mSleep(2000)

            while true do
                if Common.userDialog() then break end -- [保证到了门派师傅]
                coroutine.yield('师门任务选择后页面异常', 'c2')
                mSleep(1000)
            end

            return 0
        elseif continueTask() then -- [继续任务]字样的按钮

            tap(991, 130) -- 关闭选择师门类型的窗口
            mSleep(1000)

            Common.blockCheckMainPage('师门任务继续任务页面异常')

            -- 从右侧找 师门任务
            return 6
        else -- 结束
            tap(992, 130) -- 关闭选择师门类型的窗口
            mSleep(1000)

            Common.blockCheckMainPage('师门任务继续任务页面异常')

            Common.record("师门已做完")
            return -2
        end
    else -- 没有自动选择

        tap(474, 486) -- 勾上自动选择
        mSleep(500)
        -- 选择第一个任务
        ret, tim, x, y = unselectTask()
        if ret then
            tap(x, y)
            mSleep(1000)

            Common.blockCheckMainPage('师门任务选择后页面异常')

            return 0
        else
            Common.blockCheckMainPage('师门任务选择后页面异常')
            Common.record("师门已做完")
            return -2
        end
    end
end

-- 到达师傅那里
function Sect.waitMaster()
    while true do
        if Common.userDialog() then break end
        coroutine.yield('没门派师傅对话框', 'c2')
        mSleep(1000)
    end

    -- 师傅对话框中的师门任务选项
    while true do
        ret, tim, x, y = chooseTask()
        if ret then
            tap(x, y)
            mSleep(1000)
            break
        end
        coroutine.yield('门派师傅没有选项', 'c2')
    end

    Common.blockCheckMainPage('师门任务领取后页面异常')

    return 0
end

function Sect.findRightTask()

    Common.blockCheckMainPage('主页查找师门任务异常')

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

    -- 成功领取任务
    if moveAndFindRightTask() == 0 then

        Common.blockCheckMainPage('开始师门任务后页面异常')

        return 0
    end

    Common.blockCheckMainPage(
        '主页找不到师门任务,结束时页面异常')

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

    Common.blockCheckMainPage('师门任务执行前页面异常')

    while true do
        mSleep(1000)
        fwCloseView("recordBoard", "record")

        if Common.checkMainPage() then -- 在首页
            if Common.userDialog() then -- 有对话框
                Common.record("对话")
                mSleep(1000)
                -- 点击第一个选项
                ret, tim, x, y = dialogSelection()
                toast(x .. ',' .. y, 1)
                mSleep(1000)
                if ret then -- 有选项的对话框
                    tap(x, y)
                    mSleep(1000)
                else -- 有对话,没有选项

                    tap(500, 400) -- 清除对话
                    mSleep(1000)
                end
            elseif useProp() then -- 右下角使用道具
                mSleep(1000)

                -- 点击使用道具
                tap(967, 511)
                mSleep(2000)
            elseif taskTab() then -- 点击右边师门任务
                mSleep(3000)
                -- 点击师门任务
                ret, tim, x, y = rightTask()
                if ret then
                    Common.record("点击任务")
                    tap(x, y)
                    mSleep(1000)
                else -- 拉动右侧列表查找
                    Common.resetRightTaskBoard()
                end
            end
        elseif handIn() then -- 上交物品
            Common.record("上交物品")

            -- 上交
            tap(937, 518)
            mSleep(1000)
        elseif buyPet() then -- 购买宠物
            Common.record("买宠物")
            -- 购买
            tap(917, 573)
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
        elseif workshop() then
            Common.record("工坊购买")

            -- 点击第一个商品
            tap(526, 166)
            mSleep(200)
            -- 购买
            tap(892, 584)
            mSleep(1000)

        elseif lingzhuangbei() then -- 领取福利
            while (true) do
                if isColor(874, 276, 0xedbf60) then
                    -- 领取装备
                    tap(874, 278)
                    mSleep(8000)
                else
                    break
                end
            end

            -- 关闭福利
            tap(969, 65)
            mSleep(5000)

            -- 升级技能
            local jinengPage = require("jineng.ConstPage")
            Main.excuteLocal(jinengPage.index(), 1)
        elseif shifutuijian() then -- 推荐师傅
            -- 关闭师傅推荐
            tap(901, 135)
        elseif finish() then -- 结束
            Common.record("师门结束")

            while useProp() do -- 把门派任务获得的道具使用光
                -- 点击使用道具
                tap(967, 511)
                mSleep(2000)
                mSleep(1000)
            end

            tap(992, 130)
            mSleep(1000)

            Common.blockCheckMainPage('师门正常结束时页面异常')

            return -2 -- 结束师门任务
        else -- 等对话
            coroutine.yield('师门任务常规检查', 'c2')
            Common.record("等待")
            -- 跳过
            tap(464, 545)
            mSleep(1000)
        end
    end
end

-- 闪退补偿
function Sect.crashCallack()
    crashNode = taskRecord.crashNode
    toast("crash num: " .. crashNode["now"], 3)
    mSleep(3000)
    crashStep = tonumber(crashNode["now"])
    if crashStep < 6 then
        return 1
    elseif crashStep == 6 then
        while true do if Common.checkMainPage() then break end end
        return 6
    elseif crashStep == 7 then
        while true do if Common.checkMainPage() then break end end
        return 7
    end
    if nowNode["now"] == "1" then -- 回长安
        return 2
    elseif nowNode["now"] == "2" then -- 打开活动面板
        return 2
    elseif nowNode["now"] == "3" then -- 查找任务并打开
        return 2
    elseif nowNode["now"] == "4" then -- 选择任务
        return 2
    elseif nowNode["now"] == "5" then -- 等师傅
        return 2
    elseif nowNode["now"] == "6" then -- 找任务
        return 6
    elseif nowNode["now"] == "7" then -- 执行
        return 6
    end
end
return Sect
