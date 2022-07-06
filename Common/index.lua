require("TSLib")
local timer = require("Common.timer")

Common = {}

-- 地图中的长安位置
local function changanLocation()
    local offset =
        "59|5|0xc24e10,64|16|0xb6c3bb,3|18|0x96a29b,22|10|0xb62a09,32|10|0xbb290a"
    return findColorsUntil(0xb74519, offset, 90, 0, 0, 1135, 639, {orient = 2},
                           1000, 5)
end

-- 顶部互动logo
local function huodongLogo()
    local offset = "18|6|0xa9622c,153|4|0xac2946,207|-2|0x35d3a8,227|3|0x0a5ea5"
    return findColorsUntil(0x64120f, offset, 90, 201, 0, 631, 72, {orient = 2},
                           500, 1)
end

-- 红色交叉,例如福利右上角
local function redCancle(rate, second)
    if rate == nil then rate = 1000 end
    if second == nil then second = 1 end
    local offset = "-6|-6|0xc10000,6|-6|0xc90000,5|5|0xd80000,-6|6|0xd30000"
    return findColorsUntil(0xcf0000, offset, 90, 0, 0, 1136, 640, {orient = 2},
                           rate, second)
end

-- 红色交叉样式2,例如右下角弹出的使用物品
function Common.redCancle2(rate, second)
    if rate == nil then rate = 1000 end
    if second == nil then second = 1 end
    local offset = "-7|-5|0xb80c00,8|-5|0xba0c00,8|5|0xc40e00,-5|6|0xc30c00"
    return findColorsUntil(0xbf1500, offset, 90, 994, 306, 1061, 466,
                           {orient = 2}, rate, second)
end

-- 取消文字的弹窗
function Common.wordCancle(rate, second)
    if rate == nil then rate = 1000 end
    if second == nil then second = 1 end
    local offset =
        "4|1|0xefc263,4|12|0xecbc5f,14|5|0xedc162,25|0|0x4a321f,48|9|0x48301e,35|7|0xe5b95e,35|16|0xebbb5e"
    return findColorsUntil(0x48301e, offset, 90, 0, 0, 1136, 640, {orient = 2},
                           rate, second)
end

-- 等待主页面,即 福利
function Common.checkMainPage(rate, second)
    if rate == nil then rate = 1000 end
    if second == nil then second = 1 end

    -- if Common.userDialog() then -- 有用户对话框
    --     tap(600, 400) -- 关闭对话框
    -- end

    return findColorsUntil(0xa3e17b,
                           "-5|9|0x87c24d,2|18|0x5a9a19,-9|22|0xff897d,11|33|0x893807",
                           90, 4, 93, 72, 318, {orient = 2}, rate, second)
end

-- 关闭弹窗
function Common.closeWindow()
    local ret, tim, x, y = redCancle()
    if ret then
        tap(x, y)
        mSleep(1000)
    end
    ret, tim, x, y = Common.wordCancle()
    if ret then
        tap(x, y)
        mSleep(1000)
    end
    mSleep(1000)
end

function Common.move(breakFunction, moveFunction, pointFunction, resetFunction,
                     pageFunction)
    local point1 = 0xffffff
    local point2 = 0xffffff
    local point3 = 0xffffff
    local point4 = 0xffffff

    local retryTime = 1
    local result = nil

    while true do
        if breakFunction ~= nil then
            if breakFunction() then
                result = 0
                break
            end
        end

        if nil ~= pageFunction and not pageFunction() then
            coroutine.yield('Common.move 移动中出现异常', 'c2')
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
    if step == nil then step = 1 end

    Common.blockCheckMainPage('回长安页面异常')

    -- 打开地图
    tap(35, 35)
    mSleep(1000)

    local ret, tim, x, y = changanLocation()
    if ret then
        tap(x, y)
        mSleep(1000)
        -- 执行下一步
        return 0
    end
    -- 没在地图找到长安
    tap(1000, 60)
    mSleep(1000)

    Common.blockCheckMainPage('回长安页面异常2')

    return step
end

-- 白底红字 记录板
function Common.record(content)
    fwShowTextView("recordBoard", "record", content, "left", "FF0000", "FFFFFF",
                   10, 0, 0, 0, 155, 62, 1)
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
    if rate == nil then rate = 1000 end

    if second == nil then second = 1 end
    local offset =
        "-18|-1|0xdd8a4e,20|-7|0xd26b2d,-17|15|0xc59074,24|15|0xc04048"

    return findColorsUntil(0xde8a55, offset, 90, 1050, 526, 1128, 623,
                           {orient = 2}, rate, second)
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
    if rate == nil then rate = 1000 end

    if second == nil then second = 1 end
    local offset =
        "18|16|0xffffff,19|20|0xffffff,28|17|0xfcfaf9,48|16|0xfefdfd,43|12|0xeaac4d,72|-2|0xffffff,106|19|0xffffff,106|-1|0xffffff"

    return findColorsUntil(0xffffff, offset, 90, 0, 0, 1136, 640, {orient = 2},
                           rate, second)
end

--[[
与NPC对话,在底部的对话框,例如各个门派师傅
]]
function Common.userDialog(rate, second, type)
    if rate == nil then rate = 1000 end

    if second == nil then second = 1 end
    -- 1是先检测普通对话框 2是先检测剧情对话框
    if type == nil then type = 1 end
    if type == 1 then
        -- 普通对话框
        local offset2 =
            '-239|2|0x222323,-254|13|0xe8dd9c,18|14|0xe8e09b,-224|-6|0xddc697,-170|-6|0xdfc798,-23|-6|0xdec698'
        return findColorsUntil(0x222323, offset2, 90, 33, 582, 329, 619,
                               {orient = 2}, 500, 1)

    else
        -- 剧情对话框
        local offset1 =
            '11|0|0xdec697,46|0|0xdec697,90|0|0xdec698,184|15|0xe4d399,-25|18|0xe8dc9b'
        return findColorsUntil(0xdec698, offset1, 90, 0, 447, 1133, 635,
                               {orient = 2}, 500, 1)
    end

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

-- 全民争霸赛
local function quanmin_zhengbasai()
    offset =
        '66|-12|0xffdd66,132|1|0xffee77,152|8|0xffee88,177|-10|0xffdd66,207|15|0xffff99,209|14|0xffff99'
    return findMultiColorInRegionFuzzy(0xffee77, offset, 90, 475, 319, 756, 375,
                                       {orient = 2})
end
-- x9联赛
local function x9_match()
    offset =
        '31|28|0xb58d6a,-169|-6|0xb58d6a,-123|28|0xb58d6a,-66|129|0xeaac4e,-46|124|0xffffff,-27|133|0xffffff,-11|132|0xffffff'
    return findMultiColorInRegionFuzzy(0xb58d6a, offset, 90, 434, 374, 698, 558,
                                       {orient = 2})
end
-- 限时活动的窗口
function Common.timeLimitedWindow()
    if quanmin_zhengbasai() then -- 全民争霸赛
        tap(1016, 27)
        mSleep(1000)
    end

    if x9_match() then -- x9联赛
        tap(958, 74)
        mSleep(1000)
    end
end

-- 组队的页面
function Common.teamPage()
    local offset =
        '-464|-7|0x764a2c,-450|-7|0x764a2c,-410|-3|0x764a2c,-395|5|0x815a3f,-396|-15|0x835b3f,-764|77|0xecb75b'
    return findColorsUntil(0xcd0000, offset, 90, 93, 17, 1015, 136,
                           {orient = 2}, 500, 1)
end

-- 便捷组队页面
function Common.easyGroupPage()
    local offset =
        '-494|-9|0x764a2c,-425|-9|0x764a2c,-404|-17|0x764a2c,-418|-15|0x764a2c,-903|11|0xb4692d,-917|4|0xf8debd'
    return findColorsUntil(0xce0000, offset, 90, 72, 6, 1055, 105, {orient = 2},
                           500, 1)
end

-- 阻塞检查主页面,因为很多地方用,所以包装起来复用
function Common.blockCheckMainPage(tip)
    Common.blockCheck(Common.checkMainPage, tip)
end

-- 阻塞检查页面
function Common.blockCheck(func, tip)
    while true do
        if func() then break end
        coroutine.yield(tip, 'c2')
        mSleep(1000)
    end
end

return Common
