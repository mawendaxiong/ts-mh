require('TSLib')
require('shimen.components')
Common = require('Common.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

Sect = {}

-- 移动右侧任务栏并查找师门任务
local function moveAndFindRightTask()
    return Common.move(
        function()
            local ret, tim, x, y = rightTask()
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
        end
    )
end

-- 任务板查找任务
function Sect.findTaskOnTaskBoard()
    while true do
        if TaskBoard.checkTaskBoard() then
            break
        end
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
        if checkChoosePage() then
            break
        end
        coroutine.yield('师门任务选择任务页面异常', 'c2')
        mSleep(1000)
    end
    -- 如果不是选择任务的界面,直接进行下一步,因为可能是[新手的师门任务]
    if not checkChoosePage() then
        coroutine.yield('师门任务前置检查', 'c2')
        if not checkChoosePage() then
            return 0
        end -- 再次确认没有选择任务界面
    end
    -- 勾上了自动选择
    if autoChoose() then
        local ret, tim, x, y = startTask() -- [去完成]字样的按钮
        if ret then -- 今天首次领取任务
            tap(x, y)
            mSleep(2000)

            while true do
                if Common.userDialog() then
                    break
                end -- [保证到了门派师傅]
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

            Common.record('师门已做完')
            return -2
        end
    else -- 没有自动选择
        tap(474, 486) -- 勾上自动选择
        mSleep(500)
        -- 选择第一个任务
        local ret, tim, x, y = unselectTask()
        if ret then
            tap(x, y)
            mSleep(1000)

            Common.blockCheckMainPage('师门任务选择后页面异常')

            return 0
        else
            Common.blockCheckMainPage('师门任务选择后页面异常')
            Common.record('师门已做完')
            return -2
        end
    end
end

-- 到达师傅那里
function Sect.waitMaster()
    while true do
        if Common.userDialog() then
            break
        end
        coroutine.yield('没门派师傅对话框', 'c2')
        mSleep(1000)
    end

    -- 师傅对话框中的师门任务选项
    while true do
        local ret, tim, x, y = chooseTask()
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
        local ret, tim, x, y = Common.redCancle2()
        if not ret then
            break
        end
        tap(x, y)
        mSleep(1000)
    end

    -- 成功领取任务
    if moveAndFindRightTask() == 0 then
        Common.blockCheckMainPage('开始师门任务后页面异常')

        return 0
    end

    Common.blockCheckMainPage('主页找不到师门任务,结束时页面异常')

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
    while true do -- 执行前先把右下角道具清空,防止出现其他画面
        if useProp() then
            tap(1029, 349) -- 关闭右下角道具
            mSleep(2000)
        else
            break
        end
    end

    while true do
        mSleep(1000)
        fwCloseView('recordBoard', 'record')

        if Common.checkMainPage() then -- 在首页
            if Common.userDialog() then -- 有对话框
                Common.record('对话')
                mSleep(1000)
                -- 点击第一个选项
                local ret, tim, x, y = dialogSelection()
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
                local ret, tim, x, y = rightTask()
                if ret then
                    Common.record('点击任务')
                    tap(x, y)
                    mSleep(1000)
                else -- 拉动右侧列表查找
                    Common.resetRightTaskBoard()
                end
            end
        elseif handIn() then -- 上交物品
            Common.record('上交物品')

            -- 上交
            tap(937, 518)
            mSleep(1000)
        elseif buyPet() then -- 购买宠物
            Common.record('买宠物')
            -- 购买
            tap(917, 573)
            mSleep(1000)
        elseif shangjiaochongwu() then
            tap(752, 525) -- 上交宠物
            mSleep(1000)
        elseif weaponAndDrug() then -- 药店或者武器店
            Common.record('药或者武器')

            -- 点击 购买
            tap(862, 524)
            mSleep(1000)
        elseif shopping() then -- 购物
            Common.record('商城购买')

            -- 点击第一个商品
            tap(526, 166)
            mSleep(200)
            -- 购买
            tap(892, 584)
            mSleep(1000)

            if shopping() then -- 有可能没买到,然后还是在摆摊页面,先关掉
                tap(979, 39) -- 关闭商城
                mSleep(1000)
            end

            if no_money() then -- 没钱了
                tap(762, 211) -- 关闭提示
                mSleep(1500)

                tap(979, 39) -- 关闭商城
                mSleep(1000)

                Common.blockCheckMainPage('不够钱买摆摊道具做师门提前结束')
                return -2
            end
        elseif workshop() then
            Common.record('工坊购买')

            -- 点击第一个商品
            tap(526, 166)
            mSleep(200)
            -- 购买
            tap(892, 584)
            mSleep(1000)

            if workshop() then -- 有可能没买到,然后还是在工坊页面,先关掉
                tap(1033, 123) -- 关闭工坊
                mSleep(1000)
            end

            if no_money() then -- 没钱了
                tap(762, 211) -- 关闭提示
                mSleep(1500)

                tap(1033, 123) -- 关闭工坊
                mSleep(1500)

                Common.blockCheckMainPage('不够钱买工坊做师门提前结束')
                return -2
            end
        elseif lingzhuangbei() then -- 领取福利
            while true do
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
            local jinengPage = require('jineng.ConstPage')
            Main.excuteLocal(jinengPage.index(), 1)
        elseif shifutuijian() then -- 推荐师傅
            -- 关闭师傅推荐
            tap(901, 135)
        elseif finish() then -- 结束
            Common.record('师门结束')

            while useProp() do -- 把门派任务获得的道具使用光
                -- 点击使用道具
                tap(967, 511)
                mSleep(1000)
            end

            tap(992, 130)
            mSleep(1000)

            Common.blockCheckMainPage('师门正常结束时页面异常')

            return -2 -- 结束师门任务
        else -- 等对话
            coroutine.yield('师门任务常规检查', 'c2')
            Common.record('等待')
            -- 跳过
            tap(464, 545)
            mSleep(1000)
        end
    end
end

-- 闪退补偿
function Sect.crashCallack()
    local crashNode = taskRecord.crashNode
    toast('crash num: ' .. crashNode['now'], 3)
    mSleep(3000)
    local crashStep = tonumber(crashNode['now'])
    if crashStep < 6 then
        return 1
    elseif crashStep == 6 then
        while true do
            if Common.checkMainPage() then
                break
            end
        end
        return 6
    elseif crashStep == 7 then
        while true do
            if Common.checkMainPage() then
                break
            end
        end
        return 7
    end
end
return Sect
