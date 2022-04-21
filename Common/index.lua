require("TSLib")

Common = {}

-- 地图中的长安位置
local function changanLocation()
    offset = "59|5|0xc24e10,64|16|0xb6c3bb,3|18|0x96a29b,22|10|0xb62a09,32|10|0xbb290a"
    return findColorsUntil(0xb74519, offset, 90, 0, 0, 1135, 639, {orient = 2}, 1000, 5)
end

-- 顶部互动logo
local function huodongLogo()
    offset = "18|6|0xa9622c,153|4|0xac2946,207|-2|0x35d3a8,227|3|0x0a5ea5"
    return findColorsUntil(0x64120f, offset, 90, 201, 0, 631, 72, {orient = 2}, 500, 1)
end

-- 红色交叉,例如福利右上角
local function redCancle(rate, second)
    if rate == nil then
        rate = 1000
    end
    if second == nil then
        second = 1
    end
    offset = "-6|-6|0xc10000,6|-6|0xc90000,5|5|0xd80000,-6|6|0xd30000"
    return findColorsUntil(0xcf0000, offset, 90, 0, 0, 1136, 640, {orient = 2}, rate, second)
end

-- 红色交叉样式2,例如右下角弹出的使用物品
function Common.redCancle2(rate, second)
    if rate == nil then
        rate = 1000
    end
    if second == nil then
        second = 1
    end
    offset = "-7|-5|0xb80c00,8|-5|0xba0c00,8|5|0xc40e00,-5|6|0xc30c00"
    return findColorsUntil(0xbf1500, offset, 90, 994, 306, 1061, 466, {orient = 2}, rate, second)
end

-- 取消文字的弹窗
function Common.wordCancle(rate, second)
    if rate == nil then
        rate = 1000
    end
    if second == nil then
        second = 1
    end
    offset = "4|1|0xefc263,4|12|0xecbc5f,14|5|0xedc162,25|0|0x4a321f,48|9|0x48301e,35|7|0xe5b95e,35|16|0xebbb5e"
    return findColorsUntil(0x48301e, offset, 90, 0, 0, 1136, 640, {orient = 2}, rate, second)
end

-- 等待主页面,即 福利
function Common.checkMainPage(rate, second)
    if rate == nil then
        rate = 1000
    end
    if second == nil then
        second = 1
    end

    -- offset = "11|0|0xdecc57,17|9|0xb0631c,4|17|0xdb9132,8|23|0xebe4c0"
    -- return findColorsUntil(0xa20d12, offset, 90, 2, 4, 68, 179, {orient = 2}, rate, second)

    return findColorsUntil(
        0xa3e17b,
        "-5|9|0x87c24d,2|18|0x5a9a19,-9|22|0xff897d,11|33|0x893807",
        90,
        4,
        93,
        72,
        318,
        {orient = 2},
        rate,
        second
    )
end

-- 关闭弹窗
function Common.closeWindow()
    keepScreen(true)
    ret, tim, x, y = redCancle()
    if ret then
        tap(x, y)
        mSleep(1000)
    end
    ret, tim, x, y = Common.wordCancle()
    keepScreen(false)
    if ret then
        tap(x, y)
        mSleep(1000)
    end
    mSleep(1000)
end

function Common.move(breakFunction, moveFunction, pointFunction, resetFunction)
    point1 = 0xffffff
    point2 = 0xffffff
    point3 = 0xffffff
    point4 = 0xffffff

    retryTime = 1
    result = nil

    while true do
        if breakFunction ~= nil then
            if breakFunction() then
                result = 0
                break
            end
        end

        moveFunction()
        mSleep(1000)

        keepScreen(true)
        local p1, p2, p3, p4 = pointFunction()
        keepScreen(false)

        -- 拉到底了
        if (p1 == point1 and p2 == point2 and p3 == point3 and p4 == point4) then
            if resetFunction ~= nil then
                if retryTime < 2 then
                    retryTime = retryTime + 1
                    resetFunction()
                else
                    result = -1
                    mSleep(2000)
                    break
                end
            else
                result = -1
                mSleep(2000)
                break
            end
        end
        point1 = p1
        point2 = p2
        point3 = p3
        point4 = p4

        mSleep(1000)
    end

    return result
end

-- 回长安
function Common.b2a(step)
    if step == nil then
        step = 1
    end

    while true do
        keepScreen(true)
        ret = Common.checkMainPage()
        if ret then
            keepScreen(false)
            break
        end
        Common.closeWindow()
        mSleep(1000)
        keepScreen(false)
    end

    -- 可以看见活动的logo,就返回下一步
    if Common.checkMainPage() then
        return 0
    end

    -- 打开地图
    tap(35, 35)
    mSleep(1000)

    keepScreen(true)
    ret, tim, x, y = changanLocation()
    keepScreen(false)
    if ret then
        tap(x, y)
        mSleep(1000)
        -- 执行下一步
        return 0
    end
    -- 没在地图找到长安
    tap(1000, 60)
    mSleep(1000)
    return step
end

-- 白底红字 记录板
function Common.record(content)
    fwShowTextView("recordBoard", "record", content, "left", "FF0000", "FFFFFF", 10, 0, 0, 0, 155, 62, 1)
end

-- 重置右侧任务栏
function Common.resetRightTaskBoard()
    for i = 1, 3 do
        moveTo(1118, 163, 1118, 410, 20, 50, 1, 0)
        mSleep(1000)
    end
end

--[[
没有弹窗的战斗画面
战斗中右下角的小齿轮
]]
function Common.checkBattle(rate, second)
    if rate == nil then
        rate = 1000
    end

    if second == nil then
        second = 1
    end
    offset = "-18|-1|0xdd8a4e,20|-7|0xd26b2d,-17|15|0xc59074,24|15|0xc04048"

    return findColorsUntil(0xde8a55, offset, 90, 1050, 526, 1128, 623, {orient = 2}, rate, second)
end

-- 打开组队界面
function Common.commonOpenGroup()
    -- 先切换到队伍tab
    if not isColor(1068, 125, 0x2364d9, 100) then
        tap(1068, 125)
        mSleep(1000)
    end

    -- 打开队伍
    tap(1068, 125)
    mSleep(1000)

    -- 打开队伍tab
    tap(1018, 170)
    mSleep(1000)
end

-- 退出队伍
function Common.quitTeam(rate, second)
    if rate == nil then
        rate = 1000
    end

    if second == nil then
        second = 1
    end
    offset =
        "18|16|0xffffff,19|20|0xffffff,28|17|0xfcfaf9,48|16|0xfefdfd,43|12|0xeaac4d,72|-2|0xffffff,106|19|0xffffff,106|-1|0xffffff"

    return findColorsUntil(0xffffff, offset, 90, 0, 0, 1136, 640, {orient = 2}, rate, second)
end

--[[
与NPC对话,在底部的对话框,例如各个门派师傅
]]
function Common.userDialog(rate, second)
    if rate == nil then
        rate = 1000
    end

    if second == nil then
        second = 1
    end
    offset = "-14|16|0xf6d4ac,190|-1|0xfbdbb5,227|11|0xf1c896,-57|-478|0xb91b0a,-58|-484|0xa10b12"
    return findColorsUntil(0xfbdab3, offset, 90, 5, 77, 342, 633, {orient = 2}, rate, second)
end

-- 输入密码
function Common.inputPasswd(str)
    inputKey(str)
    tap(1, 1)
    mSleep(1000)
end

-- 输入文本
function Common.inputText(str)
    inputStr(str)
    tap(1, 1)
    mSleep(1000)
end

-- 限时活动的窗口
function Common.timeLimitedWindow()
    multiColTap(
        {
            {306, 251, 0x242f81},
            {760, 225, 0x363998},
            {402, 354, 0x67c3c8},
            {571, 274, 0xa90e16},
            {836, 215, 0xc21200}
        }
    )
    mSleep(1000)
end

return Common
