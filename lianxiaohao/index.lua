require('TSLib')
require('lianxiaohao.components')
local Common = require('Common.index')
local timer = require('Common.timer')
local TaskBoard = require('renwuban.index')
local Main = require('Main.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting
local log = container.log
local globalGhost = container.globalGhost

local lxh = {}

-- 佩戴领取回来的装备
local function chuanzhuangbei()
    while true do
        mSleep(1000)
        if bag() then
            break
        end
        coroutine.yield('佩戴装备打开背包异常', 'c2')
        tap(1090, 517) -- 打开背包
    end

    -- 整理背包
    tap(883, 577)
    mSleep(2000)

    local initX = 612
    local initY = 178

    local targetX = 0
    local targetY = 0
    -- 从第一行找到第一个装备
    for region = 1, 5 do
        tap(initX, initY)
        mSleep(1000)

        -- 穿戴装备
        r, t, targetX, targetY = zhuangbeiButton()
        if r then
            tap(targetX, targetY)
            break
        end
        initX = initX + 80
    end

    -- 系统会自动提示下个装备,一直点装备即可
    while true do
        mSleep(3000)

        r, t, targetX, targetY = zhuangbeiButton()
        if targetX ~= -1 then
            tap(targetX, targetY)
        else
            break
        end
    end

    -- 关闭包裹
    tap(980, 43)

    Common.blockCheckMainPage('佩戴装备结束关闭背包异常')
end

foo = {
    ['剑侠客'] = {
        ['种族'] = {33, 253},
        ['人物'] = {211, 142},
        ['大唐'] = {910, 289},
        ['方寸'] = {1000, 292},
        ['化生'] = {1089, 291}
    },
    ['逍遥生'] = {
        ['种族'] = {33, 253},
        ['人物'] = {131, 298},
        ['大唐'] = {910, 289},
        ['方寸'] = {1000, 292},
        ['化生'] = {1089, 291}
    },
    ['漠少君'] = {
        ['种族'] = {33, 253},
        ['人物'] = {155, 463},
        ['大唐'] = {910, 289},
        ['方寸'] = {1000, 292},
        ['化生'] = {1089, 291}
    },
    ['巫蛮儿'] = {
        ['种族'] = {33, 253},
        ['人物'] = {157, 209},
        ['大唐'] = {899, 290},
        ['方寸'] = {969, 294},
        ['化生'] = {1033, 290},
        ['女儿'] = {1100, 292}
    },
    ['飞燕女'] = {
        ['种族'] = {33, 253},
        ['人物'] = {131, 381},
        ['大唐'] = {899, 290},
        ['方寸'] = {969, 294},
        ['化生'] = {1033, 290},
        ['女儿'] = {1100, 292}
    },
    ['英女侠'] = {
        ['种族'] = {33, 253},
        ['人物'] = {213, 537},
        ['大唐'] = {899, 290},
        ['方寸'] = {969, 294},
        ['化生'] = {1033, 290},
        ['女儿'] = {1100, 292}
    },
    ['龙太子'] = {
        ['种族'] = {33, 318},
        ['人物'] = {211, 142},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['玄彩娥'] = {
        ['种族'] = {33, 318},
        ['人物'] = {157, 209},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['神天兵'] = {
        ['种族'] = {33, 318},
        ['人物'] = {131, 298},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['舞天姬'] = {
        ['种族'] = {33, 318},
        ['人物'] = {131, 381},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['羽神灵'] = {
        ['种族'] = {33, 318},
        ['人物'] = {155, 463},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['梦玲珑'] = {
        ['种族'] = {33, 318},
        ['人物'] = {213, 537},
        ['龙宫'] = {899, 290},
        ['普陀'] = {969, 294},
        ['月宫'] = {1033, 290},
        ['花果'] = {1100, 292}
    },
    ['杀破狼'] = {
        ['种族'] = {33, 383},
        ['人物'] = {211, 142},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    },
    ['骨精灵'] = {
        ['种族'] = {33, 383},
        ['人物'] = {157, 209},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    },
    ['虎头怪'] = {
        ['种族'] = {33, 383},
        ['人物'] = {131, 298},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    },
    ['狐美人'] = {
        ['种族'] = {33, 383},
        ['人物'] = {131, 381},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    },
    ['巨魔王'] = {
        ['种族'] = {33, 383},
        ['人物'] = {155, 463},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    },
    ['喵千岁'] = {
        ['种族'] = {33, 383},
        ['人物'] = {213, 537},
        ['地府'] = {899, 290},
        ['狮驼'] = {969, 294},
        ['魔王'] = {1033, 290},
        ['雷音'] = {1100, 292}
    }
}

-- 创建角色,选择服务器那里
function lxh.createRole()
    while true do
        if createRolePage() then
            break
        end
        coroutine.yield('创建角色时页面异常', 'c2')
        mSleep(1000)
    end

    r, t, x, y = chuangjianjuese()
    if not r then -- 说明这个号创建角色满了
        return -2
    end

    tap(x, y)

    while true do
        if isColor(538, 55, 0x000000) then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 跳过动画
function lxh.skipCartoon()
    while true do
        if isColor(538, 55, 0x000000) then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    timer.start(10000)
    while true do
        -- 到了选人物的界面就停止
        if isColor(998, 583, 0xf5b447) then
            break
        elseif timer.check() then -- 定时器到点,防止一直死循环
            break
        else
            tap(1082, 32)
            mSleep(500)
        end
    end

    while true do
        if chooseRolePage() then
            break
        end
        coroutine.yield('创建角色时页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function lxh.xuanjuese()
    while true do
        if chooseRolePage() then
            break
        end
        coroutine.yield('创建角色时页面异常', 'c2')
        mSleep(1000)
    end

    lianxiaohaoObj = UISetting.lianxiaohaoList[UISetting.currentAccountIndex]
    renwu = lianxiaohaoObj.renwu
    menpai = lianxiaohaoObj.menpai

    maintable = foo[renwu]
    point = maintable['种族']
    tap(point[1], point[2])
    mSleep(2000)

    point = maintable['人物']
    tap(point[1], point[2])
    mSleep(2000)

    point = maintable[menpai]
    tap(point[1], point[2])
    mSleep(2000)

    -- 点击下一步
    tap(1000, 590)

    while true do
        if qimingPage() then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 起名
function lxh.name()
    while true do
        if qimingPage() then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    while true do
        r, t, x, y = qimingPage()
        if r then
            -- 点击随机名字
            tap(x, y)

            -- 进入游戏
            tap(997, 592)
        elseif tip() then -- 随机名字重复了
            tap(568, 377)
            mSleep(1000)
        else
            break
        end
    end

    while true do
        if isColor(538, 55, 0x000000, 100) then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function lxh.checkLevel()
end

local methodContainer = {
    {
        -- 选择引导人,选好角色后,选择吉里吉里 主角团 还是张艺兴那个
        ['func'] = function()
            return '选择引导人', chooseGuide()
        end,
        ['after'] = function()
            Common.record('选择引导人')
            -- 选择引导人
            tap(569, 518)
        end,
        ['remove'] = 1
    },
    {
        -- 新手调查,初次战斗结束后,我是老手 我是新手的选择
        ['func'] = function()
            return '新手调查', investigation()
        end,
        ['after'] = function()
            Common.record('新手调查')
            -- 选择有经验
            tap(447, 439)
        end,
        ['remove'] = 1
    },
    {
        -- 主页面
        ['func'] = function()
            return '主页面', Common.checkMainPage()
        end,
        ['after'] = function()
            while true do
                mSleep(1500)
                if not Common.checkMainPage() then
                    break
                end

                if Common.userDialog() then -- 有对话框
                    Common.record('对话')
                    mSleep(1000)

                    ret, tim, x, y = dialogSelection()
                    if ret then -- 有选项的对话框
                        -- 点击第一个选项
                        tap(x, y)
                        mSleep(1000)
                    else -- 有对话,没有选项
                        -- 清除对话
                        tap(500, 400)
                        mSleep(1000)
                    end
                elseif useProp() then -- 右下角使用道具
                    mSleep(1000)

                    -- 点击使用道具
                    tap(967, 511)
                    mSleep(2000)
                else
                    if not jingqingqidai() then
                        -- 点击剧情
                        tap(990, 209)
                    else
                        keepScreen(true)
                        r1, t1, x1, y1 = shifulaixin() -- 师傅来信
                        r2, t2, x2, y2 = qujianshifu() -- 去见师傅
                        r3, t3, x3, y3 = shimenrenwu() -- 师门任务
                        keepScreen(false)

                        if r1 then
                            tap(x1, y1)
                        elseif r2 then
                            tap(x2, y2)
                            while true do
                                if Common.userDialog() then
                                    break
                                end
                                coroutine.yield('去见师傅页面异常', 'c2')
                                mSleep(1000)
                            end
                        elseif r3 then
                            -- todo 做师门升级了20,领取装备卡着了
                            tap(x3, y3)
                            mSleep(2000)
                            local shimenPage = require('shimen.ConstPage')
                            local step = 1
                            keepScreen(true)
                            if shimenTypeChoosePage() then
                                step = 4
                            end
                            if Common.userDialog() then
                                tap(600, 400) -- 清除对话框
                            end
                            keepScreen(false)

                            Main.excuteLocal(shimenPage.index(), step)
                        else
                            local zhuoguiPage = require('zhuogui.ConstPage')
                            globalGhost.checkLevel = 1
                            Main.excuteLocal(zhuoguiPage.leadTeam(), 1)
                            -- 捉鬼到37结束
                            return -2
                        end
                    end
                end
            end
        end,
        ['remove'] = 0
    },
    {
        -- 首次师门任务
        ['func'] = function()
            return '首次师门任务', shimenTypeChoosePage()
        end,
        ['after'] = function()
            while true do
                if shimenTypeChoosePage() then
                    break
                end
                coroutine.yield('首次师门任务异常', 'c2')
                mSleep(1000)
            end

            local shimenPage = require('shimen.ConstPage')
            Main.excuteLocal(shimenPage.index(), 4)
        end,
        ['remove'] = 1
    },
    {
        -- 跳过剧情
        ['func'] = function()
            return '跳过剧情', tiaoguojuqing()
        end,
        ['after'] = function()
            Common.record('跳过剧情')
            tap(1020, 36)
            mSleep(500)
            tap(1020, 36)
            mSleep(500)

            while true do
                if not tiaoguojuqing() then
                    break
                end
                coroutine.yield('等待跳过剧情', 'c2')
                mSleep(1000)
            end
        end,
        ['remove'] = 0
    },
    {
        -- 人物属性,要放在跳过对话的前面,因为跳过对话会识别成人物属性
        ['func'] = function()
            return '打开了人物属性', statusPage()
        end,
        ['after'] = function()
            Common.record('关闭人物属性')
            tap(980, 43)

            Common.blockCheckMainPage('等待关闭人物属性')
        end
    },
    {
        -- 跳过对话
        ['func'] = function()
            return '跳过对话', Common.userDialog(nil, nil, 2)
        end,
        ['after'] = function()
            while true do
                mSleep(1000)

                if not Common.userDialog(nil, nil, 2) then
                    break
                end

                Common.record('跳过对话')
                tap(600, 400)
            end
        end,
        ['remove'] = 0
    },
    {
        -- 跳过动画
        ['func'] = function()
            return '跳过动画', isColor(538, 55, 0x000000)
        end,
        ['after'] = function()
            while true do
                if not skipCartoon() then
                    break
                end
                tap(1082, 32)
                mSleep(1000)
            end
        end
    },
    {
        -- 战斗
        ['func'] = function()
            return '战斗', Common.checkBattle()
        end,
        ['after'] = function()
            while true do
                mSleep(1000)

                if not Common.checkBattle() then
                    break
                end

                r, t, x, y = guideTap()
                if r then
                    Common.record('点击引导目标')
                    tap(x - 20, y - 40)
                    mSleep(1000)
                end
            end
        end,
        ['remove'] = 0
    },
    {
        -- 推荐师傅
        ['func'] = function()
            return '推荐师傅', shifutuijian()
        end,
        ['after'] = function()
            Common.record('推荐师傅')
            -- 关闭师傅推荐
            tap(901, 135)

            Common.blockCheckMainPage('等待关闭师傅推荐')
            while true do
                if not shifutuijian() then
                    break
                end

                mSleep(1000)
            end
        end,
        ['remove'] = 0
    },
    {
        -- 剧情难度提示
        ['func'] = function()
            return '剧情难度提示', zhandounandu()
        end,
        ['after'] = function()
            Common.record('难度提示')
            -- 点确定
            tap(663, 375)

            while true do
                if Common.checkBattle() then
                    break
                end
                coroutine.yield('等待进入剧情战斗异常', 'c2')
                mSleep(1000)
            end
        end,
        ['remove'] = 0
    },
    {
        -- 首冲页面
        ['func'] = function()
            return '首冲', jianmianli()
        end,
        ['after'] = function()
            Common.record('首冲')
            -- 关闭首冲
            tap(869, 73)

            Common.blockCheckMainPage('等待关闭首冲')
        end,
        ['remove'] = 0
    },
    {
        -- 每10级领取装备
        ['func'] = function()
            return '领取装备', lingzhuangbei()
        end,
        ['after'] = function()
            Common.record('领装备')
            while true do
                if isColor(874, 276, 0xedbf60) then
                    -- 领取装备
                    tap(874, 278)
                    mSleep(3500)
                else
                    break
                end
            end

            -- 关闭福利
            tap(969, 65)
            mSleep(3500)

            Common.blockCheckMainPage('等待关闭领取装备')

            -- 佩戴装备
            chuanzhuangbei()

            Common.blockCheckMainPage('等待关闭领取装备')

            wLog(log.name, '[DATE] 领取装备后升级技能...')
            -- 升级技能
            local jinengPage = require('jineng.ConstPage')
            Main.excuteLocal(jinengPage.index(), 1)
        end,
        ['remove'] = 0
    },
    {
        -- 战斗失败可能会跳出助战页面
        ['func'] = function()
            return '助战页面', zhuzhanPage()
        end,
        ['after'] = function()
            while true do
                if zhuzhanPage() then
                    break
                end
                coroutine.yield('助战页面异常', 'c2')
                mSleep(1000)
            end

            wLog(log.name, '[DATE] 调整助战...')
            local zhuzhanPage = require('zhuzhan.ConstPage')
            Main.excuteLocal(zhuzhanPage.index(), 3)
        end
    },
    {
        -- 宠物引导
        ['func'] = function()
            return '宠物引导', chongwuGuide()
        end,
        ['after'] = function()
            Common.record('宠物引导')
            -- 点击领取奖励
            tap(557, 427)
            mSleep(2000)

            while true do
                mSleep(1000)
                if chongwu2() then -- 查看宠物
                    tap(656, 486)
                elseif chongwu3() then -- 关闭宠物框
                    tap(999, 43)
                    break
                end
                Common.record('宠物引导...')
                wLog(log.name, '[DATE] 宠物引导...')
            end

            Common.blockCheckMainPage('等待关闭宠物引导')
        end,
        ['remove'] = 1
    },
    {
        -- 技能引导
        ['func'] = function()
            return '技能引导', jinengGuide()
        end,
        ['after'] = function()
            Common.record('技能引导')
            -- 点击领取奖励
            tap(557, 427)
            mSleep(2000)

            while true do
                mSleep(1000)
                if jineng2() then
                    -- 查看师门技能
                    tap(656, 486)
                    break
                end
                Common.record('技能引导...')
                wLog(log.name, '[DATE] 技能引导...')
            end

            Common.blockCheckMainPage('等待关闭关闭技能引导')

            wLog(log.name, '[DATE] 技能升级...')
            local jinengPage = require('jineng.ConstPage')
            Main.excuteLocal(jinengPage.index(), 1)
        end,
        ['remove'] = 1
    },
    {
        -- 助战引导
        ['func'] = function()
            return '助战引导', zhuzhanGuide()
        end,
        ['after'] = function()
            Common.record('助战引导')
            -- 点击领取奖励
            tap(557, 427)
            mSleep(2000)

            while true do
                mSleep(1000)
                if zhuzhan22() then
                    tap(656, 486) -- 打开助战
                    break
                end
                Common.record('助战引导...')
                wLog(log.name, '[DATE] 助战引导...')
            end

            wLog(log.name, '[DATE] 调整助战...')
            local zhuzhanPage = require('zhuzhan.ConstPage')
            Main.excuteLocal(zhuzhanPage.index(), 1)
        end,
        ['remove'] = 1
    },
    {
        -- 红尘引导
        ['func'] = function()
            return '红尘引导', hongchenGuide()
        end,
        ['after'] = function()
            Common.record('红尘引导')
            -- 点击领取奖励
            tap(557, 427)
            mSleep(2000)

            while true do
                mSleep(1000)
                if hongchen2() then
                    -- 关闭红尘的提示框
                    tap(1016, 116)
                    break
                end
                Common.record('红尘引导...')
                wLog(log.name, '[DATE] 红尘引导...')
            end
        end,
        ['remove'] = 1
    },
    {
        -- 师门引导
        ['func'] = function()
            return '师门引导', shimenGuide()
        end,
        ['after'] = function()
            Common.record('师门引导')
            -- 领取奖励
            tap(874, 278)
            mSleep(2000)

            while true do
                mSleep(1000)
                if shimen2() then
                    -- 去做师门
                    tap(657, 486)
                    break
                end
                Common.record('师门引导...')
                wLog(log.name, '[DATE] 师门引导...')
            end
        end,
        ['remove'] = 1
    },
    {
        -- 提升引导
        ['func'] = function()
            return '提升引导', tishengGuide()
        end,
        ['after'] = function()
            Common.record('提升引导')
            -- 领取奖励
            tap(874, 278)
            mSleep(2000)

            while true do
                mSleep(1000)
                if tisheng2() then
                    -- 确定
                    tap(656, 486)
                    break
                end
                Common.record('提升引导...')
                wLog(log.name, '[DATE] 提升引导...')
            end
        end,
        ['remove'] = 1
    },
    {
        -- 一路同行,师傅来信之后的弹窗那个
        ['func'] = function()
            return '一路同行', yilutongxing()
        end,
        ['after'] = function()
            Common.record('一路同行')
            -- 关闭一路同行窗口
            tap(968, 112)
        end,
        ['remove'] = 1
    }
}
--[[
1.在主页
1.1 检查有没有主线任务
1.1.1 有主线任务,走师门那套逻辑

1.2 没有师门任务
1.2.1 看看有没有师门任务
1.2.2 捉鬼

2.不在主页
2.1 检查各种引导
]]
function lxh.execute()
    while true do
        if isColor(538, 55, 0x000000, 100) or Common.checkMainPage() then
            break
        end
        coroutine.yield('创建角色完毕页面异常', 'c2')
        mSleep(1000)
    end

    while true do
        mSleep(1500)
        local removeNum = -1

        local errorHold = 0
        for i = 1, #methodContainer, 1 do
            local methodObj = methodContainer[i]
            local msg, r, t, x, y = methodObj.func()
            if r then
                wLog(log.name, '[DATE] 练小号 ' .. msg)

                methodObj.after()
                if methodObj.remove == 1 then
                    removeNum = i
                end
                break -- 结束for循环
            else
                errorHold = errorHold + 1
            end
        end

        if errorHold == #methodContainer then
            coroutine.yield('练小号页面异常', 'c2')
            errorHold = 0
        end

        if removeNum ~= -1 then
            table.remove(methodContainer, removeNum)
            removeNum = -1
            wLog(log.name, '[DATE] 函数size: ' .. #methodContainer)
        end
    end
end

-- 闪退了直接执行第五步
function lxh.crashCallack()
    return 5
end

return lxh
-- todo 战斗失败跳配置助战
