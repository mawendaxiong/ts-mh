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
