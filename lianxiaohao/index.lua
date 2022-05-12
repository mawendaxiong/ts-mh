require("TSLib")

Common = require("Common.index")
TaskBoard = require("renwuban.index")

lxh = {}
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
    offset = "-1|11|0x644637,4|6|0x644637,15|6|0x644637,10|1|0x644637,10|12|0x644637"
    return findColorsUntil(0x644637, offset, 90, 922, 8, 1117, 58, {orient = 2}, 500, 1)
end

-- 福利-领装备
local function lingzhuangbei()
    offset = "32|-3|0x6c310a,55|-2|0x6c310a,85|6|0x6c310a,74|5|0xe9ab54,-17|5|0xe8a953"
    return findColorsUntil(0x6c310a, offset, 90, 169, 93, 353, 585, {orient = 2}, 500, 1)
end

-- 宠物引导
local function chongwuGuide()
    offset = "23|21|0xdd9922,7|-117|0xd9614e,9|-314|0xfef3b8,13|-298|0xf44326"
    return findColorsUntil(0x77dd33, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 技能引导
local function jinengGuide()
    offset = "16|17|0x88aabb,1|-120|0xd9614e,2|-327|0x43bdf0,17|-302|0x184ec9"
    return findColorsUntil(0xbbcccc, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 助战引导
local function zhuzhanGuide()
    offset = "12|3|0xddaa11,-5|-122|0xd9614e,-8|-327|0xeeee22,14|-309|0xeedd22"
    return findColorsUntil(0x332244, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 师门引导
local function shimenGuide()
    offset = "12|3|0xddaa11,-5|-122|0xd9614e,-8|-327|0xeeee22,14|-309|0xeedd22"
    return findColorsUntil(0xffee55, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 红尘试炼引导
local function hongchenGuide()
    offset = "9|-2|0xbb2222,-15|-137|0xd9614e,-7|-318|0xdd9955,-7|-326|0x110011"
    return findColorsUntil(0xcc2211, offset, 90, 474, 81, 632, 526, {orient = 2}, 500, 1)
end

-- 见面礼,充值
local function jianmianli()
    offset = "-253|22|0xe2535d,-294|212|0x2b1e20,-258|428|0x29b47a,-227|235|0x58d8cf"
    return findColorsUntil(0xffe03f, offset, 90, 292, 26, 895, 516, {orient = 2}, 500, 1)
end

-- 推荐师傅
local function zhaoshifu()
    offset = "-180|63|0x81522a,-433|173|0x80522a,-599|297|0x427bdd,-573|337|0xfff2a4,-597|369|0x301312"
    return findColorsUntil(0xffe7b8, offset, 90, 181, 96, 930, 573, {orient = 2}, 500, 1)
end

--跳过剧情
local function tiaoguojuqing()
    offset = "12|0|0x644637,-48|3|0x624436,-85|-1|0x644637,-178|-1|0x644637"
    return findColorsUntil(0x644637, offset, 90, 459, 8, 1132, 73, {orient = 2}, 500, 2)
end

-- 跳过对话
local function tiaoguoduihua()
    offset = "2|11|0x644637,18|6|0x644637,-34|2|0xeee1cf,-36|9|0xeee1cf"
    return findColorsUntil(0x644637, offset, 90, 869, 36, 1125, 75, {orient = 2}, 500, 1)
end

-- ,左上角可能会被服饰遮挡
-- "12|0|0x644637,-48|3|0x624436,-85|-1|0x644637,-178|-1|0x644637,-521|23|0x2f271e",
local function guideTap()
    offset = "0|7|0xffda35,-4|15|0xffda34,-14|17|0xffd933,0|12|0xffda34"
    return findColorsUntil(0xffdb35, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 2)
end

-- 师傅的来信
local function shifulaixin()
    offset = "-14|0|0x51e414,-14|-4|0x51e414,-92|-11|0x51e414,-92|-5|0x51e414,-80|-3|0x51e414"
    return findColorsUntil(0x51e414, offset, 90, 902, 147, 1134, 454, {orient = 2}, 500, 1)
end

-- 首页的任务tab
local function taskTab()
    offset = "16|-1|0xeaf1bc,16|12|0xb47872,-1|28|0x002a7b,23|24|0xad8329"
    return findColorsUntil(0xd2e6ae, offset, 90, 902, 86, 1029, 161, {orient = 2}, 500, 1)
end

-- 师门任务
local function shimenrenwu()
    offset = "12|5|0xfcf31c,17|5|0xfaf11d,32|1|0xfcf31c,32|9|0xfcf31c"
    return findColorsUntil(0xfcf31c, offset, 90, 912, 151, 1134, 463, {orient = 2}, 500, 2)
end

local function zhuangbeiButton()
    offset = "4|10|0x6c310a,28|10|0x6c310a,20|16|0x6c310a,17|12|0xecbe5f"
    return findMultiColorInRegionFuzzy(0x6e330b, offset, 90, 0, 0, 1136, 640, {orient = 2})
end

-- 提升引导
local function tishengGuide()
    offset = "-19|-306|0xd87315,-11|-301|0xd06212,-23|-126|0xd9614e,50|50|0xe69b5e"
    return findColorsUntil(0xff3377, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 1)
end

-- 推荐师傅
local function shifutuijian()
    offset = "32|-11|0x91c6ff,14|94|0xeeffe5,-14|64|0x301312,-47|95|0xa31d11,-91|83|0x76b93c"
    return findColorsUntil(0x62e2bd, offset, 90, 172, 405, 424, 575, {orient = 2}, 500, 2)
end

-- 一路同行,师傅来信后的弹窗
local function yilutongxing()
    offset = "19|95|0xc57448,33|208|0x698e7c,4|203|0x63917e,54|204|0xd29567"
    return findColorsUntil(0xb35b41, offset, 90, 176, 162, 305, 477, {orient = 2}, 500, 1)
end

-- 剧情难度提示
local function zhandounandu()
    offset = "31|-1|0x8d5d2c,52|5|0x8d5d2c,98|-4|0x8d5d2c,202|4|0x8d5d2c,274|6|0x8d5d2c"
    return findColorsUntil(0x8d5d2c, offset, 90, 375, 248, 765, 404, {orient = 2}, 500, 2)
end

-- 创建角色
local function chuangjianjuese()
    offset = "0|-12|0x67d70f,-13|0|0x53c712,14|1|0x51c612,0|14|0x3cb716,16|18|0xb98f69"
    return findColorsUntil(0x53c712, offset, 90, 335, 60, 1027, 620, {orient = 2}, 500, 1)
end

-- 创建角色下一步
local function xiayibu()
    offset = "2|10|0xf6b047,93|9|0xf6af46,93|-3|0xf5b245"
    return findColorsUntil(0xf5b146, offset, 90, 915, 574, 1080, 611, {orient = 2}, 500, 1)
end

-- 随机名字
local function randomName()
    offset = "-12|17|0xf4dab2,16|21|0xeec396,1|28|0xca6829"
    return findColorsUntil(0xff6220, offset, 90, 1045, 483, 1099, 536, {orient = 2}, 500, 1)
end

-- 佩戴领取回来的装备
local function chuanzhuangbei()
    -- 打开背包
    tap(1090, 517)
    mSleep(3000)

    -- 整理背包
    tap(883, 577)
    mSleep(2000)

    initX = 612
    initY = 178

    targetX = 0
    targetY = 0
    -- 从第一行找到第一个装备
    for region = 1, 5 do
        tap(initX, initY)
        mSleep(1000)

        -- 穿戴装备
        targetX, targetY = zhuangbeiButton()
        if targetX ~= -1 then
            tap(targetX, targetY)
            break
        end
        initX = initX + 80
    end

    -- 系统会自动提示下个装备,一直点装备即可
    while true do
        mSleep(3000)

        targetX, targetY = zhuangbeiButton()
        if targetX ~= -1 then
            tap(targetX, targetY)
        else
            break
        end
    end

    -- 关闭包裹
    tap(980, 43)
end

foo = {
    ["剑侠客"] = {["种族"] = {33, 253}, ["人物"] = {211, 142}, ["大唐"] = {910, 289}, ["方寸"] = {1000, 292}, ["化生"] = {1089, 291}},
    ["逍遥生"] = {["种族"] = {33, 253}, ["人物"] = {131, 298}, ["大唐"] = {910, 289}, ["方寸"] = {1000, 292}, ["化生"] = {1089, 291}},
    ["漠少君"] = {["种族"] = {33, 253}, ["人物"] = {155, 463}, ["大唐"] = {910, 289}, ["方寸"] = {1000, 292}, ["化生"] = {1089, 291}},
    ["巫蛮儿"] = {
        ["种族"] = {33, 253},
        ["人物"] = {157, 209},
        ["大唐"] = {899, 290},
        ["方寸"] = {969, 294},
        ["化生"] = {1033, 290},
        ["女儿"] = {1100, 292}
    },
    ["飞燕女"] = {
        ["种族"] = {33, 253},
        ["人物"] = {131, 381},
        ["大唐"] = {899, 290},
        ["方寸"] = {969, 294},
        ["化生"] = {1033, 290},
        ["女儿"] = {1100, 292}
    },
    ["英女侠"] = {
        ["种族"] = {33, 253},
        ["人物"] = {213, 537},
        ["大唐"] = {899, 290},
        ["方寸"] = {969, 294},
        ["化生"] = {1033, 290},
        ["女儿"] = {1100, 292}
    },
    ["龙太子"] = {
        ["种族"] = {33, 318},
        ["人物"] = {211, 142},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["玄彩娥"] = {
        ["种族"] = {33, 318},
        ["人物"] = {157, 209},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["神天兵"] = {
        ["种族"] = {33, 318},
        ["人物"] = {131, 298},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["舞天姬"] = {
        ["种族"] = {33, 318},
        ["人物"] = {131, 381},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["羽神灵"] = {
        ["种族"] = {33, 318},
        ["人物"] = {155, 463},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["梦玲珑"] = {
        ["种族"] = {33, 318},
        ["人物"] = {213, 537},
        ["龙宫"] = {899, 290},
        ["普陀"] = {969, 294},
        ["月宫"] = {1033, 290},
        ["花果"] = {1100, 292}
    },
    ["杀破狼"] = {
        ["种族"] = {33, 383},
        ["人物"] = {211, 142},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    },
    ["骨精灵"] = {
        ["种族"] = {33, 383},
        ["人物"] = {157, 209},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    },
    ["虎头怪"] = {
        ["种族"] = {33, 383},
        ["人物"] = {131, 298},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    },
    ["狐美人"] = {
        ["种族"] = {33, 383},
        ["人物"] = {131, 381},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    },
    ["巨魔王"] = {
        ["种族"] = {33, 383},
        ["人物"] = {155, 463},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    },
    ["喵千岁"] = {
        ["种族"] = {33, 383},
        ["人物"] = {213, 537},
        ["地府"] = {899, 290},
        ["狮驼"] = {969, 294},
        ["魔王"] = {1033, 290},
        ["雷音"] = {1100, 292}
    }
}

-- 创建角色,选择服务器那里
function lxh.createRole()
    r, t, x, y = chuangjianjuese()
    tap(x, y)

    return 0
end

-- 跳过动画
function lxh.skipCartoon()
    while true do
        -- 到了选人物的界面就停止
        if isColor(998, 583, 0xf5b447) then
            break
        else
            tap(1082, 32)
            mSleep(500)
        end
    end

    return 0
end

function lxh.xuanjuese()
    lianxiaohaoObj = UISetting.lianxiaohaoList[UISetting.currentAccountIndex]
    renwu = lianxiaohaoObj.renwu
    menpai = lianxiaohaoObj.menpai

    maintable = foo[renwu]
    point = maintable["种族"]
    tap(point[1], point[2])
    mSleep(2000)

    point = maintable["人物"]
    tap(point[1], point[2])
    mSleep(2000)

    point = maintable[menpai]
    tap(point[1], point[2])
    mSleep(2000)

    -- 点击下一步
    tap(1000, 590)

    return 0
end

-- 起名
function lxh.name()
    while true do
        if randomName() then
            -- 点击随机名字
            tap(1074, 516)

            --进入游戏
            tap(997, 592)
        else
            break
        end
    end

    return 0
end

function lxh.checkLevel()
    
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
function lxh.execute()
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
            else
                if not jingqingqidai() then
                    -- 点击剧情
                    tap(990, 209)
                else
                    r, t, x, y = shifulaixin() --师傅来信
                    if r then
                        tap(x, y)
                    end

                    r, t, x, y = shimenrenwu() --师门任务
                    if r then
                        -- todo 做师门升级了20,领取装备卡着了
                        tap(x, y)
                        mSleep(2000)
                        local shimenPage = require("shimen.ConstPage")
                        excuteLocal(sectPage.index(), 4)
                    else
                        local zhuoguiPage = require("zhuogui.ConstPage")
                        globalGhost.checkLevel = 1
                        excuteLocal(zhuoguiPage.leadTeam(), 1)
                        -- 捉鬼到37结束
                        return -2
                    end
                end
            end
        else
            if tiaoguojuqing() then --跳过剧情
                tap(1020, 36)
                mSleep(500)
                tap(1020, 36)
                mSleep(500)
            elseif tiaoguoduihua() then --跳过对话
                tap(600, 400)
            elseif Common.checkBattle() then
                r, t, x, y = guideTap()
                if r then
                    Common.record("guide!")
                    tap(x - 20, y - 40)
                    mSleep(1000)
                end
            elseif shifutuijian() then -- 推荐师傅
                -- 关闭师傅推荐
                tap(901, 135)
            elseif zhandounandu() then
                -- 点确定
                tap(663, 375)
            elseif jianmianli() then
                -- 关闭首冲
                tap(869, 73)
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
                mSleep(5000)

                -- 佩戴装备
                chuanzhuangbei()

                -- 升级技能
                local jinengPage = require("jineng.ConstPage")
                excuteLocal(jinengPage.index(), 1)
            elseif chongwuGuide() then -- 宠物引导 todo 第二步卡着不动
                -- 点击领取奖励
                tap(557, 427)
                -- 懒得写逻辑,直接等了8秒,一般够用了
                mSleep(5000)
                toast("???")

                -- 查看宠物
                -- 懒得写逻辑,直接等了8秒,一般够用了
                tap(656, 486)
                mSleep(5000)
                toast("!!!")

                -- 关闭宠物框
                tap(999, 43)
                mSleep(1000)
            elseif jinengGuide() then -- 师门技能引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)
                toast("???")

                -- 查看师门技能
                tap(656, 486)
                mSleep(1000)
                toast("!!!")

                local jinengPage = require("jineng.ConstPage")
                excuteLocal(jinengPage.index(), 1)
            elseif zhuzhanGuide() then -- 助战引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)
                toast("???")

                -- 查看师门技能
                tap(656, 486)
                mSleep(2000)
                toast("!!!")

                local zhuzhanPage = require("zhuzhan.ConstPage")
                excuteLocal(zhuzhanPage.index(), 1)
            elseif hongchenGuide() then -- 红尘引导
                -- 点击领取奖励
                tap(557, 427)
                mSleep(8000)
                toast("???")

                -- 关闭红尘的提示框
                tap(1016, 116)
                mSleep(2000)
                toast("!!!")
            elseif shimenGuide() then -- 师门引导
                -- 领取奖励
                tap(874, 278)
                mSleep(5000)
                toast("???")

                -- 去做师门
                tap(657, 486)
                mSleep(1000)
                toast("!!!")
            elseif tishengGuide() then --提升引导
                -- 领取奖励
                tap(874, 278)
                mSleep(8000)
                toast("???")

                -- 确定
                tap(656, 486)
                mSleep(2000)
                toast("!!!")
            elseif yilutongxing() then --一路同行,师傅来信之后的弹窗
                -- 关闭一路同行窗口
                tap(968, 112)
            end
        end
    end
end
return lxh
