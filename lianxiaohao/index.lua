require("TSLib")

Main = require("Main.index")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

lianxiaohao = {}
-- 敬请期待
local function jingqingqidai()
    offset = "23|-1|0xe061fc,29|-7|0xe061fc,61|-2|0xde61f9,49|0|0xe061fc"
    return findColorsUntil(0xe061fc, offset, 90, 854, 91, 1134, 424, {orient = 2}, 500, 1)
end

-- 对话框跳出来的选项
local function dialogSelection()
    offset = "1|32|0xf3d095,55|19|0xf3d5af,-69|30|0xf2d09a"
    return findColorsUntil(0xf4dec0, offset, 90, 810, 81, 1111, 490, {orient = 2}, 500, 1)
end

-- 使用道具
local function useProp()
    offset = "13|1|0x70350c,42|-1|0xeec363,48|15|0x6c310a,36|11|0x6c310a"
    return findColorsUntil(0x6c310a, offset, 90, 894, 329, 1049, 553, {orient = 2}, 500, 1)
end

-- 点击跳过
local function skip()
    return findColorsUntil(
        0x644637,
        "-1|11|0x644637,4|6|0x644637,15|6|0x644637,10|1|0x644637,10|12|0x644637",
        90,
        922,
        8,
        1117,
        58,
        {orient = 2},
        500,
        1
    )
end

-- 福利-领装备
local function lingzhuangbei()
    return findColorsUntil(
        0x6c310a,
        "32|-3|0x6c310a,55|-2|0x6c310a,85|6|0x6c310a,74|5|0xe9ab54,-17|5|0xe8a953",
        90,
        169,
        93,
        353,
        585,
        {orient = 2},
        500,
        1
    )
end

-- 宠物引导
local function chongwuGuide()
    return findColorsUntil(
        0x77dd33,
        "23|21|0xdd9922,7|-117|0xd9614e,9|-314|0xfef3b8,13|-298|0xf44326",
        90,
        474,
        81,
        632,
        526,
        {orient = 2},
        500,
        1
    )
end

-- 技能引导
local function jinengGuide()
    return findColorsUntil(
        0xbbcccc,
        "16|17|0x88aabb,1|-120|0xd9614e,2|-327|0x43bdf0,17|-302|0x184ec9",
        90,
        474,
        81,
        632,
        526,
        {orient = 2},
        500,
        1
    )
end

-- 助战引导
local function zhuzhanGuide()
    return findColorsUntil(
        0x332244,
        "23|-9|0x660033,16|-140|0xd9614e,13|-329|0xff1918,38|-343|0xd27a1a",
        90,
        474,
        81,
        632,
        526,
        {orient = 2},
        500,
        1
    )
end

-- 师门引导
local function shimenGuide()
    return findColorsUntil(
        0xffee55,
        "12|3|0xddaa11,-5|-122|0xd9614e,-8|-327|0xeeee22,14|-309|0xeedd22",
        90,
        474,
        81,
        632,
        526,
        {orient = 2},
        500,
        1
    )
end

-- 红尘试炼引导
local function hongchenGuide()
    return findColorsUntil(
        0xcc2211,
        "9|-2|0xbb2222,-15|-137|0xd9614e,-7|-318|0xdd9955,-7|-326|0x110011",
        90,
        474,
        81,
        632,
        526,
        {orient = 2},
        500,
        1
    )
end

-- 见面礼,充值
local function jianmianli()
    return findColorsUntil(
        0xffe03f,
        "-253|22|0xe2535d,-294|212|0x2b1e20,-258|428|0x29b47a,-227|235|0x58d8cf",
        90,
        292,
        26,
        895,
        516,
        {orient = 2},
        500,
        1
    )
end

-- 推荐师傅
local function zhaoshifu()
    return findColorsUntil(
        0xffe7b8,
        "-180|63|0x81522a,-433|173|0x80522a,-599|297|0x427bdd,-573|337|0xfff2a4,-597|369|0x301312",
        90,
        181,
        96,
        930,
        573,
        {orient = 2},
        500,
        1
    )
end

-- 跳过对话
local function tiaoguoduihua()
    return findColorsUntil(
        0x644637,
        "2|11|0x644637,18|6|0x644637,-34|2|0xeee1cf,-36|9|0xeee1cf",
        90,
        869,
        36,
        1125,
        75,
        {orient = 2},
        500,
        1
    )
end

-- 战斗中的指引,取的右下角,左上角可能会被服饰遮挡
local function guideTap()
    return findColorsUntil(
        0xffdb35,
        "0|7|0xffda35,-4|15|0xffda34,-14|17|0xffd933,0|12|0xffda34",
        90,
        0,
        0,
        1136,
        640,
        {orient = 2},
        500,
        2
    )
end

-- 师傅的来信
local function shifulaixin()
    return findColorsUntil(
        0x51e414,
        "-14|0|0x51e414,-14|-4|0x51e414,-92|-11|0x51e414,-92|-5|0x51e414,-80|-3|0x51e414",
        90,
        902,
        147,
        1134,
        454,
        {orient = 2},
        500,
        1
    )
end

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
function lianxiaohao.execute()
    while (true) do
        if Common.checkMainPage() then
            if Common.userDialog() then --有对话框
                Common.record("对话")
                mSleep(1000)

                ret, tim, x, y = dialogSelection()
                if ret then -- 有选项的对话框
                    -- 点击第一个选项
                    tap(x, y)
                    mSleep(1000)
                else --有对话,没有选项
                    -- 清除对话
                    tap(500, 400)
                    mSleep(1000)
                end
            elseif useProp() then --右下角使用道具
                mSleep(1000)

                -- 点击使用道具
                tap(967, 511)
                mSleep(2000)
            elseif not jingqingqidai() then --不是敬请期待,可以执行剧情
                -- 点击剧情
                tap(990, 209)
            else
                if shifulaixin() then -- 执行师门任务
                    local shimenPage = require("shimen.ConstPage")
                    Main.excuteLocal(sectPage.index(), 4)
                end
            end
        else
            if tiaoguoduihua() then --跳过对话
                tap(600, 400)
            elseif Common.checkBattle() then
                r, t, x, y = guideTap()
                if r then
                    Common.record("guide!")
                    tap(x - 20, y - 40)
                    mSleep(1000)
                end
            elseif chongwuGuide() then -- 宠物引导 todo 第二步卡着不动
                -- 点击领取奖励
                -- 懒得写逻辑,直接等了8秒,一般够用了
                tap(557, 427)
                mSleep(8000)

                -- 查看宠物
                -- 懒得写逻辑,直接等了8秒,一般够用了
                tap(656, 486)
                mSleep(8000)

                -- 关闭宠物框
                tap(999, 43)
                mSleep(1000)
            elseif jinengGuide() then -- 师门技能引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)

                -- 查看师门技能
                tap(656, 486)
                mSleep(1000)

                local jinengPage = require("jineng.ConstPage")
                Main.excuteLocal(jinengPage.index(), 1)
            elseif zhuzhanGuide() then -- 助战引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)

                -- 查看师门技能
                tap(656, 486)
                mSleep(2000)

                local zhuzhanPage = require("zhuzhan.ConstPage")
                Main.excuteLocal(zhuzhanPage.index(), 1)
            elseif hongchenGuide() then -- 红尘引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)

                -- 关闭红尘的提示框
                tap(1016, 116)
                mSleep(2000)
            elseif lingzhuangbei() then -- 每10级领取装备
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
                mSleep(8000)

                -- 升级技能
                local jinengPage = require("jineng.ConstPage")
                Main.excuteLocal(jinengPage.index(), 1)
            elseif shimenGuide() then -- 师门引导
                -- 领取奖励
                tap(874, 278)
                mSleep(8000)

                -- 去做师门
                tap(657, 486)
                mSleep(1000)
            end
        end
    end
end
return lianxiaohao
