-- 用户中心的黑底用户logo
function userLogo()
    local offset = '0|53|0xffffff,-34|433|0xfb4f4f,518|204|0xfb4f4f,-51|203|0xffffff'
    return findColorsUntil(0xd2d2d2, offset, 90, 0, 0, 1136, 640, {orient = 2}, 500, 1)
end

-- 有没有勾上同意协议
function aggrement()
    local offset = '-7|15|0xe50113,8|15|0xe50113,-2|11|0xffffff'
    return findColorsUntil(0xe50113, offset, 90, 331, 489, 385, 549, {orient = 2}, 500, 1)
end

-- 选择服务器页面
function serverPage()
    local offset =
        '-841|52|0xb9b4ad,-805|43|0xb9b4ad,-466|-19|0x6c310a,-445|-11|0x6c310a,-411|-11|0x6c310a,-385|-7|0x6c310a,-386|-19|0x6c310a'
    return findColorsUntil(0xce0000, offset, 90, 88, 25, 1085, 271, {orient = 2}, 500, 1)
end

-- 选择账号类型界面
function switchAccount()
    local offset = '-289|0|0x000000,184|-4|0x4892ff,252|11|0xae9885'
    return findColorsUntil(0xd41d13, offset, 90, 256, 419, 877, 490, {orient = 2}, 500, 1)
end

-- 登录的角色
function loginRole()
    local offset = '0|9|0x916333,22|5|0x8d5d2c,40|5|0x8d5d2c,42|13|0x8d5d2c,67|0|0x8d5d2c'
    return findColorsUntil(0x8d5d2c, offset, 90, 328, 32, 1032, 616, {orient = 2}, 500, 2)
end

-- 右上角小红人
function miniRedManLogo()
    local offset = '-29|15|0xbfe7f8,-26|22|0xc0e8f8,2|29|0xa7442c'
    return findColorsUntil(0xb3454f, offset, 90, 1041, 10, 1119, 77, {orient = 2}, 500, 1)
end

-- 选择账号时的游戏logo
function gameLogo()
    local offset = '9|8|0xe50113,16|6|0xe50113,32|7|0xe50113,44|17|0xe50113,61|-14|0xe50113'
    return findColorsUntil(0xe50113, offset, 90, 435, 115, 527, 191, {orient = 2}, 500, 1)
end

function input_account_passwd_page()
    local offset = '-237|-9|0xfb4f4f,124|-103|0xd2d0d0,143|-103|0xd2d0d0,81|75|0xfb4f4f,115|81|0xfb4f4f,152|88|0xfb4f4f'
    return findColorsUntil(0xfb4f4f, offset, 90, 272, 260, 878, 519, {orient = 2}, 500, 1)
end

-- 账号已退出和资源更新提醒
function loginTip()
    local offset = '-132|-122|0xe9d5ba,201|-94|0xeddfce,200|-2|0xeddfcd,-129|-3|0xeddfcc'
    return findColorsUntil(0xedc060, offset, 90, 352, 218, 787, 422, {orient = 2}, 500, 1)
end

-- 更新公告,星期二下午和星期三更新完都可能会出现
function updateNotice()
    local offset = '347|-532|0xcd0000,340|-539|0xbf0000,261|-533|0xd58943,-406|-534|0xd68a43'
    return findColorsUntil(0xebb252, offset, 90, 79, 13, 1038, 638, {orient = 2}, 500, 1)
end

-- 回归挑战
function huigui_tiaozhan()
    local offset =
        '-218|-156|0xaf5309,-216|-145|0xc0641a,-24|-93|0xb58d6a,-48|-119|0xb58d6a,-6|-75|0xb58d6a,-83|-73|0xb58d6a'
    return findColorsUntil(0xeebd5b, offset, 90, 321, 249, 664, 457, {orient = 2}, 500, 1)
end
-- 全新回归挑战
function quanxin_huigui_tiaozhan()
    local offset =
        '-3|21|0xffffff,4|47|0xfffffe,4|48|0xfffffe,9|21|0xffffff,46|43|0xfff1b1,72|40|0xfff1b2,47|88|0xfff1ae,72|95|0xfff1ae'
    return findColorsUntil(0xffffff, offset, 90, 524, 250, 630, 392, {orient = 2}, 500, 1)
end

-- 九转天阶
function jiuzhuan_tianjie()
    local offset = '-1|-36|0x8c3d0e,-41|-20|0xefdb8c,13|31|0xefdb8c,10|-73|0xefdb8c,154|-218|0xffffff'
    return findColorsUntil(0x682703, offset, 90, 787, 122, 1016, 472, {orient = 2}, 500, 1)
end
-- 三界热点,再次确认
function zaici_queren_sanjie_redian()
    local offset = '9|-2|0x6c310a,20|4|0x6c310a,28|3|0x6c310a,45|2|0x6c310a,11|-269|0x02ae00,73|-258|0x0cb008'
    return findColorsUntil(0xedc161, offset, 90, 486, 149, 661, 440, {orient = 2}, 500, 1)
end

-- 三界热点
function sanjie_redian()
    local offset =
        '-20|1|0xffd57c,-52|1|0xffd57c,-71|1|0xffd57c,-140|-26|0xffffc9,-100|-27|0xffffcd,-51|-27|0xffffcd,-17|-22|0xffffb6'
    return findColorsUntil(0xffd67f, offset, 90, 475, 5, 660, 54, {orient = 2}, 500, 1)
end
