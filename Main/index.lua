require('TSLib')

Common = require('Common.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local log = container.log

Main = {}

local function randomTask()
    local replace = ''
    local task = {2, 3, 4, 5, 6, 7}
    local index = #task
    while true do
        if index == 0 then
            break
        end
        local randomIndex = math.random(1, index)
        local v = task[randomIndex]
        replace = replace .. v

        index = index - 1
    end
    return replace
end

-- 生成随机任务列表
function generateRandomTaskList(dev)
    if dev == nil then
        dev = false
    end
    local taskOrder = UISetting.taskOrder

    -- 练小号只执行登录和练小号功能
    if UISetting.lianxiaohao == 1 then
        if UISetting.lianxiaohaoType == 0 then -- 建号
            taskOrder = 'x'
        elseif UISetting.lianxiaohaoType == 1 then -- 不建号
            taskOrder = 'y'
        end
    else
        if taskOrder == 'schedule' then -- 每天5点定时执行科举三界
            taskOrder = '78'
        else -- 普通日常任务
            local zeroIndex = string.find(taskOrder, 'a')
            local oneIndex = string.find(taskOrder, 'b')

            -- 包含0和1,以0为准
            if zeroIndex ~= nil and oneIndex ~= nil then
                taskOrder = string.gsub(taskOrder, 'b', '')
            end

            if oneIndex ~= nil then
                local str = randomTask()
                taskOrder = string.gsub(taskOrder, 'b', str)
            end

            if zeroIndex ~= nil then
                local str = randomTask()
                taskOrder = string.gsub(taskOrder, 'a', str)
            end

            if zeroIndex ~= nil and oneIndex ~= nil then
                -- 插入运镖
                taskOrder = taskOrder .. '6'
            end
            -- 开发模式下不加入刮刮乐
            if not dev then
                -- 插入刮刮乐
                taskOrder = 'z' .. taskOrder
            end
        end

        if UISetting.money == 1 then
            taskOrder = taskOrder .. 'w'
        end
    end

    taskRecord.taskStr = taskOrder
end

function excute()
    while taskRecord.nextNode ~= nil do
        local class = taskRecord.currentNode['class']
        local method = taskRecord.currentNode['method']
        local step = taskRecord.currentNode['now']

        Common.record('step: ' .. step .. ' ' .. taskRecord.currentNode['name'])
        -- 打印日志
        wLog(log.name, '[DATE] step: ' .. step .. ' ' .. taskRecord.currentNode['name'])

        mSleep(1000)
        local ret, after = class[method]()
        if ret == 'c2' then
            -- 协程暂停
            local afterMsg = '无'
            if nil ~= after then
                local afterNode = taskRecord.currentPage['' .. after]
                afterMsg = afterNode['name']

                taskRecord.currentNode = afterNode
                taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode['next']]
            end
            coroutine.yield(taskRecord.taskName .. '|' .. method, 'c2', afterMsg)
        elseif ret == 0 then -- 直接执行next
            taskRecord.currentNode = taskRecord.nextNode
            taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode['next']]
        elseif ret == -2 then -- 一系类任务执行完毕
            wLog(log.name, '[DATE] ' .. taskRecord.taskName .. ' end!')
            break
        else -- 执行指定跳转的步骤
            taskRecord.currentNode = taskRecord.currentPage['' .. ret]
            taskRecord.nextNode = taskRecord.currentPage[taskRecord.currentNode['next']]
        end
    end
end

--[[
画面是否卡住
间隔1分钟,取四个点的值,如果5分钟都是相同,判断为画面卡住
然后通过关闭游戏,触发[游戏闪退线程]
]]
function Main.checkStuck()
    local point1 = nil
    local point2 = nil
    local point3 = nil
    local point4 = nil

    local checkTime = 0
    while true do
        local p1 = isColor(270, 143, 0x63594b)
        local p2 = isColor(974, 129, 0x61554c)
        local p3 = isColor(572, 48, 0x5c5244)
        local p4 = isColor(570, 450, 0x615752)

        if p1 == point1 and p2 == point2 and p3 == point3 and p4 == point4 then
            checkTime = checkTime + 1
            if checkTime == 6 then
                -- 关闭app,触发闪退线程的监测
                closeApp('com.netease.my')
                break
            end
            point1 = p1
            point2 = p2
            point3 = p3
            point4 = p4
        end
        mSleep(1000 * 60)
    end
end

function Main.login()
    taskRecord.taskName = 'login'

    -- 生成任务列表
    if taskRecord.currentStep == -1 then
        generateRandomTaskList()
    end
    local loginPage = require('denglu.ConstPage')

    local page = loginPage.index()

    -- 记录当前执行
    taskRecord.currentPage = page
    taskRecord.currentNode = page['1']
    taskRecord.nextNode = page[taskRecord.currentNode['next']]
    excute()

    wLog(log.name, '[DATE] 当前执行: 登录')
end

function Main.switchTaskPage(taskNum)
    local page = nil
    local taskName = ''
    wLog(log.name, '------------分割线------------')
    wLog(log.name, '------------分割线------------')
    if taskNum == '1' then -- 师门
        taskName = '执行: 师门'
        local sectPage = require('shimen.ConstPage')
        page = sectPage.index()
    elseif taskNum == '2' then -- 秘境
        taskName = '执行: 秘境'
        local unchartedPage = require('mijing.ConstPage')
        page = unchartedPage.index()
    elseif taskNum == '3' then -- 宝图
        taskName = '执行: 宝图'
        local treasurePage = require('baotu.ConstPage')
        page = treasurePage.index()
    elseif taskNum == '4' then -- 混队捉鬼
        taskName = '执行: 混队捉鬼'
        local ghostPage = require('zhuogui.ConstPage')
        page = ghostPage.joinTeam()
    elseif taskNum == '5' then -- 带队捉鬼
        taskName = '执行: 带队捉鬼'
        local ghostPage = require('zhuogui.ConstPage')
        page = ghostPage.leadTeam()
    elseif taskNum == '6' then -- 运镖
        taskName = '执行: 运镖'
        local escortPage = require('yunbiao.ConstPage')
        page = escortPage.index()
    elseif taskNum == '7' then -- 三界奇缘
        taskName = '执行: 三界'
        local sanjiePage = require('sanjie.ConstPage')
        page = sanjiePage.index()
    elseif taskNum == '8' then -- 科举
        taskName = '执行: 科举'
        local kejuPage = require('keju.ConstPage')
        page = kejuPage.index()
    elseif taskNum == '9' then -- 整理背包
        taskName = '执行: 整理背包'
        local bag = require('bag.ConstPage')
        page = bag.index()
    elseif taskNum == 'w' then -- 使用活力
        taskName = '执行: 使用活力'
        local money = require('money.ConstPage')
        page = money.index()
    elseif taskNum == 'x' then -- 建号练小号
        taskName = '执行: 练小号'
        local lianxiaohaoPage = require('lianxiaohao.ConstPage')
        page = lianxiaohaoPage.index()
    elseif taskNum == 'y' then -- 不建号练小号
        taskName = '执行: 练小号'
        local lianxiaohaoPage = require('lianxiaohao.ConstPage')
        page = lianxiaohaoPage.simple()
    elseif taskNum == 'z' then -- 刮刮乐
        taskName = '执行: 刮刮乐'
        local lotteryPage = require('guaguale.ConstPage')
        page = lotteryPage.index()
    end
    taskRecord.taskName = taskName
    Common.record(taskName)
    -- 打印日志
    wLog(log.name, '[DATE] 当前' .. taskName)
    if nil == page then
        wLog(log.name, '[DATE] page为空, ' .. taskName)
    end
    return page
end

function Main.excuteLocal(page, step)
    local node = page['' .. step]
    local nextNode = page[node['next']]

    while nextNode ~= nil do
        local class = node['class']
        local method = node['method']
        step = node['now']

        Common.record('step: ' .. step .. ' ' .. node['name'])
        -- 打印日志
        wLog(log.name, '[DATE] step: ' .. step .. ' ' .. node['name'])

        local ret = class[method]()

        if ret == 'c2' then
            -- 协程暂停
            afterMsg = '无'
            if nil ~= after then
                afterNode = page['' .. after]
                afterMsg = afterNode['name']

                node = afterNode
                node = page[node['next']]
            end
            coroutine.yield(node['name'] .. '|' .. method, 'c2', afterMsg)
        elseif ret == 0 then -- 直接执行next
            node = nextNode
            nextNode = page[node['next']]
        elseif ret == -2 then -- 一系类任务执行完毕
            break
        else -- 执行指定跳转的步骤
            node = page['' .. ret]
            nextNode = page[node['next']]
        end
    end
end

return Main
