-- 观战
function watchBattle()
    local offset = '0|7|0xd8a557,10|1|0xd8a85b,22|10|0xd8a659,19|16|0xd7a355'
    return findColorsUntil(0xd8a95c, offset, 90, 1074, 558, 1130, 609, {orient = 2}, 500, 1)
end

-- 打开队伍情况下的战斗
function battleWithTeamWindow()
    local offset = '21|9|0x4e2916,42|-2|0x572f1a,11|28|0x481a0d,-107|6|0xeda847'

    return findColorsUntil(0x60432b, offset, 90, 813, 538, 1126, 625, {orient = 2}, 500, 1)
end

-- 检查战斗的是不是捉鬼
function checkGhostBattle()
    local offset = '-6|-16|0xf8dea6,8|-8|0xe4ae74,6|-5|0xf1cea1,1|-7|0xf6e4c9'
    return findColorsUntil(0xe7a274, offset, 90, 351, 0, 405, 62, {orient = 2}, 1000, 1)
end

-- 便捷组队,日常任务[展开]的按钮
function easyGroupPageDailyTaskOpen()
    local offset = '-6|5|0xba6825,6|5|0xbb6826,-97|1|0x6c310a,-72|2|0x6c310a,-49|1|0x6c310a,-28|4|0x6c310a'
    return findColorsUntil(0xa45d23, offset, 90, 127, 73, 350, 449, {orient = 2}, 500, 1)
end

-- 便捷组队,日常任务[合上]的按钮
function easyGroupPageDailyTaskClose()
    local offset = '-4|-4|0xa25b1f,5|-4|0xa55d22,-104|-9|0x6c310a,-89|7|0x6e340d,-104|7|0x723912,-89|-9|0x6c310a'
    return findColorsUntil(0xb36625, offset, 90, 127, 73, 350, 449, {orient = 2}, 500, 1)
end

-- 便捷组队,捉鬼任务的按钮
function easyGroupPageGhostTask()
    local offset = '36|-2|0x6c310a,21|-5|0x6c310a,102|-70|0xa45d23,97|-66|0xb46524,107|-66|0xb46524,29|5|0x6c310a'
    return findColorsUntil(0x6c310a, offset, 90, 127, 73, 350, 449, {orient = 2}, 500, 1)
end

--[[
右侧任务 -> 捉鬼任务
]]
function ghostTaskGuide()
    local offset = '25|0|0xfcf31c,34|14|0xfbf21c,41|15|0xfcf31c,199|4|0xffed00,204|49|0xbc1b09'
    return findColorsUntil(0xe5de1e, offset, 90, 906, 153, 1133, 460, {orient = 2}, 1000, 2)
end

-- 点击钟馗后弹出的选项中的 捉鬼任务
function ghostTask()
    local offset = '31|3|0x553923,32|10|0x553923,40|1|0x553923,58|7|0x553923,83|8|0x62462f,-11|6|0xf3d5b1,53|9|0xf2d5ac'
    return findColorsUntil(0x553923, offset, 90, 807, 82, 1108, 459, {orient = 2}, 1000, 5)
end

-- 不足5人 警告
function notFullTeamWarn()
    local offset = '-5|6|0xe01601,0|7|0xe1220d,0|13|0xe1240f,-2|15|0xe1230e,-5|13|0xe23d29'
    return findColorsUntil(0xe1210d, offset, 90, 355, 198, 777, 439, {orient = 2}, 1000, 5)
end

-- 没有辅助 警告
function noSupWarn()
    local offset =
        '0|7|0xe45743,5|13|0xe23723,5|4|0xe1240f,9|1|0xe01b06,13|1|0xe01b06,17|7|0xe01500,15|16|0xe01500,11|5|0xe01500'
    return findColorsUntil(0xe01500, offset, 90, 355, 198, 777, 439, {orient = 2}, 1000, 5)
end

-- 是否提示一轮鬼结束了
function roundOverTip()
    local offset =
        '0|11|0x9f764c,33|0|0xede0cf,33|4|0xede0cf,36|-2|0x8d5d2c,43|11|0x906131,-45|63|0xf3ca69,174|82|0xedc061'
    return findColorsUntil(0x9f764c, offset, 90, 376, 269, 756, 402, {orient = 2}, 1000, 5)
end

function fixLevelPage()
    local offset = '-60|184|0x553923,-64|189|0x553923,-44|370|0x875832,-135|562|0xecbe5f'
    return findColorsUntil(0xc01500, offset, 90, 288, 6, 845, 619, {orient = 2}, 1000, 5)
end

-- 作为队长时的
function leadTeamPage()
    local offset = '222|-62|0xcc0000,54|6|0x875832,114|2|0x6c310a,185|0|0x6c310a,204|-4|0x6c310a'
    return findColorsUntil(0x875832, offset, 90, 86, 19, 1014, 125, {orient = 2}, 500, 1)
end
