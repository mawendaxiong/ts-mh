require('TSLib')
require('bag.components')
Common = require('Common.index')
local container = require('Main.state')
local mainStatus = container.mainStatus
local taskRecord = container.taskRecord
local UISetting = container.UISetting

local can_store = true
local bagFunc = {}

-- 调整价格
local function fix_price()
    local initX = 0
    local initY = 0

    if not tuijianjiage() then -- 如果不是在原价,先调整到原价
        if up_tuijianjiage() then
            initX = 660
            initY = 424
        elseif down_tuijianjiage() then
            initX = 865
            initY = 424
        end

        while true do
            if tuijianjiage() then
                break
            end
            tap(initX, initY)
            mSleep(1000)
        end
    end

    local tap_times = UISetting.price_baitan
    if UISetting.price_baitan < 0 then -- 推荐价格以下,调整要按的按钮
        initX = 660
        initY = 424

        tap_times = -(tap_times)
    else
        initX = 865
        initY = 424
    end

    for i = 1, tap_times, 1 do
        tap(initX, initY)
        mSleep(1000)
    end
end

local function doubleClick(resFunc, x, y)
    local isOperate = 0
    if resFunc ~= nil then
        local r, t, tx, ty = resFunc()
        if r then
            isOperate = 1

            tap(tx, ty)
            mSleep(100)
            tap(tx, ty)
            mSleep(1000)
        end
    else
        tap(x, y)
        mSleep(100)
        tap(x, y)
        mSleep(1000)
    end
    return isOperate
end

local function find_store()
    if empty_store() then
        can_store = true
        return
    end
    tap(394, 93) -- 打开仓库选择页面

    local r, t, x, y = first_store()
    tap(x, y) -- 打开第一个仓库

    -- 记录五个格子的颜色,用于识别是不是扫完一遍仓库了
    local p1 = getColor(173, 177)
    local p2 = getColor(254, 260)
    local p3 = getColor(327, 338)
    local p4 = getColor(426, 417)
    local p5 = getColor(495, 511)
    local sameTime = 1

    Common.record('寻找有位置的仓库...')
    while sameTime <= 3 do
        if empty_store() then
            can_store = true
            return
        end
        tap(271, 588) -- 下一个仓库
        local new_p1 = getColor(173, 177)
        local new_p2 = getColor(254, 260)
        local new_p3 = getColor(327, 338)
        local new_p4 = getColor(426, 417)
        local new_p5 = getColor(495, 511)
        if new_p1 == p1 and new_p2 == p2 and new_p3 == p3 and new_p4 == p4 and new_p5 == p5 then
            sameTime = sameTime + 1
        end -- 5个点颜色一致,认为是回到了首页,防止是碰巧,相同3次才结束
    end
    can_store = false
end

local function store(resFunc)
    while true do
        if bag() then
            break
        end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    if not can_store then
        return
    end -- 因为是扫描全仓库,如果有一个确定了无法存储,其他的也无需存储了,节省时间

    local isOperate = 0
    while true do
        local r, t, x, y = resFunc()
        if r then
            isOperate = 1

            tap(1037, 284) -- 打开仓库
            mSleep(1500)
            find_store()

            if can_store then
                doubleClick(nil, x, y)
            end

            tap(1021, 171) -- 回到背包,继续下个物品
            mSleep(1000)
        else
            break
        end
    end

    while true do
        if bag() then
            break
        end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
    return isOperate
end

local function xiulian(resFunc)
    while true do
        if bag() then
            break
        end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    local isOperate = 0
    local r, t, x, y = resFunc()
    if r then
        isOperate = 1

        doubleClick(nil, x, y)
        mSleep(1500)
        while true do
            if xiulianPage() then
                break
            end
            coroutine.yield('修炼页面异常', 'c2')
            mSleep(1000)
        end
        tap(863, 562) -- 使用修炼丹or修炼果
        mSleep(1500)
        tap(980, 43) -- 关闭修炼页面
        mSleep(1500)
    end

    while true do
        if bag() then
            break
        end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end

    return isOperate
end

local function dropSth(resFunc)
    while true do
        if bag() then
            break
        end
        coroutine.yield('丢弃物品前异常', 'c2')
        mSleep(1000)
    end

    local isOperate = 0
    local r, t, x, y = resFunc()
    if r then
        isOperate = 1
        tap(x, y) -- 选中物品
        mSleep(1000)

        r, t, x, y = drop()
        if r then
            tap(x, y) -- 丢弃
            mSleep(1000)

            tap(665, 373) -- 确认丢弃
            mSleep(1000)
        else
            tap(1085, 489) -- 清除掉打开物品的窗口
        end
    end

    while true do
        if bag() then
            break
        end
        coroutine.yield('丢弃物品后异常', 'c2')
        mSleep(1000)
    end

    return isOperate
end

local function unlock_huaxiang()
    while true do
        if guiPage() then
            break
        end
        coroutine.yield('画像碎片页面异常', 'c2')
        mSleep(1000)
    end

    for i = 1, 4, 1 do -- 最多四个碎片
        local r, t, x, y = guilock()
        if r then
            tap(x, y)
        end
        mSleep(2000)
    end

    tap(1018, 61) -- 关闭
    mSleep(1000)

    while true do
        if bag() then
            break
        end
        coroutine.yield('存放仓库异常', 'c2')
        mSleep(1000)
    end
end
local str_jingtie = 1
local str_guiguzi = 2
local str_heibaoshi = 3
local str_taiyangshi = 4
local str_shenmishi = 5
local str_shelizi = 6
local str_feicuishi = 7
local str_hongwenshi = 8
local str_yueliangshi = 9
local str_guangmangshi = 10
local str_kunlunyu = 11
local str_qinglongshi = 12
local str_baihushi = 13
local str_zhuqueshi = 14
local str_xuanwushi = 15
local str_jiuzhuan = 16
local str_xiulianguo = 17
local str_juling = 18
local str_xinmobaozhu = 19
local str_canjuan = 20
local str_jieri = 21
local str_yuehualu = 22
local str_duanaoce = 23

local bag_table = {
    function()
        Common.record('精铁')
        mSleep(1000)
        store(jingtie_bag)
    end, -- 精铁(存储) 1
    function()
        Common.record('鬼谷子')
        mSleep(1000)
        store(guiguzi_bag)
    end, -- 鬼谷子(存储) 2
    function()
        Common.record('黑宝石')
        mSleep(1000)
        store(heibaoshi_bag)
    end, -- 黑宝石(存储) 3
    function()
        Common.record('太阳石')
        mSleep(1000)
        store(taiyangshi_bag)
    end, -- 太阳石(存储) 4
    function()
        Common.record('神秘石')
        mSleep(1000)
        store(shenmieshi_bag)
    end, -- 神秘石(存储) 5
    function()
        Common.record('舍利子')
        mSleep(1000)
        store(shelizi_bag)
    end, -- 舍利子(存储) 6
    function()
        Common.record('翡翠石')
        mSleep(1000)
        store(feicuishi_bag)
    end, -- 翡翠石(存储) 7
    function()
        Common.record('红纹石')
        mSleep(1000)
        store(hongwenshi_bag)
    end, -- 红纹石(存储) 8
    function()
        Common.record('月亮石')
        mSleep(1000)
        store(yueliangshi_bag)
    end, -- 月亮石(存储) 9
    function()
        Common.record('光芒石')
        mSleep(1000)
        store(guangmangshi_bag)
    end, -- 光芒石(存储) 10
    function()
        Common.record('昆仑玉')
        mSleep(1000)
        store(kunlunyu_bag)
    end, -- 昆仑玉(存储) 11
    function()
        Common.record('青龙石')
        mSleep(1000)
        return store(qinglongshi)
    end, -- 青龙石(存储) 12
    function()
        Common.record('白虎石')
        mSleep(1000)
        return store(baihushi)
    end, -- 白虎石(存储) 13
    function()
        Common.record('玄武石')
        mSleep(1000)
        return store(xuanwushi)
    end, -- 玄武石(存储) 14
    function()
        Common.record('朱雀石')
        mSleep(1000)
        return store(zhuqueshi)
    end, -- 朱雀石(存储) 15
    function()
        Common.record('九转金丹')
        mSleep(1000)
        return xiulian(jiuzhuan_bag)
    end, -- 九转金丹(修炼) 16
    function()
        Common.record('修炼果')
        mSleep(1000)
        return xiulian(xiulianguo_bag)
    end, -- 修炼果(修炼) 17
    function()
        Common.record('聚灵仙露')
        mSleep(1000)
        return doubleClick(juling_bag)
    end, -- 聚灵仙露(使用) 18
    function()
        Common.record('心魔宝珠')
        mSleep(1000)
        return doubleClick(xinmobaozhu)
    end, -- 心魔宝珠(使用) 19
    function()
        Common.record('阵法残卷')
        mSleep(1000)
        local ret = 0
        while true do
            if canjuan() then
                ret = dropSth(canjuan)
            else
                break
            end
            mSleep(1000)
        end
        return ret
    end, -- 阵法残卷(使用) 20
    function()
        Common.record('节日道具')
        mSleep(1000)
        dropSth(jieri)
    end, -- 节日道具(丢弃) 21
    function()
        Common.record('画像碎片')
        mSleep(1000)
        while true do
            local r, t, x, y = guiguaihuaxiang_bag()
            if r then
                doubleClick(nil, x, y)
                mSleep(1000)
                unlock_huaxiang()
                mSleep(1000)
            else
                break
            end
        end
    end -- 捉鬼碎片
}

function marketSellTable(setting)
    local sell_table = {}
    local bag_table_use = bag_table
    for i = #setting, 1, -1 do
        local num = setting[i]

        if num == '0' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 精铁')
                    return jingtie_market()
                end
            )
            table.remove(bag_table_use, str_jingtie)
        elseif num == '1' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 鬼谷子')
                    return guiguzi_market()
                end
            )
            table.remove(bag_table_use, str_guiguzi)
        elseif num == '2' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 黑宝石')
                    return heibaoshi_market()
                end
            )
            table.remove(bag_table_use, str_heibaoshi)
        elseif num == '3' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 太阳石')
                    return taiyangshi_market()
                end
            )
            table.remove(bag_table_use, str_taiyangshi)
        elseif num == '4' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 神秘石')
                    return shenmishi_market()
                end
            )
            table.remove(bag_table_use, str_shenmishi)
        elseif num == '5' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 舍利子')
                    return shelizi_market()
                end
            )
            table.remove(bag_table_use, str_shelizi)
        elseif num == '6' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 翡翠石')
                    return feicuishi_market()
                end
            )
            table.remove(bag_table_use, str_feicuishi)
        elseif num == '7' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 红纹石')
                    return hongwenshi_market()
                end
            )
            table.remove(bag_table_use, str_hongwenshi)
        elseif num == '8' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 月亮石')
                    return yueliangshi_market()
                end
            )
            table.remove(bag_table_use, str_yueliangshi)
        elseif num == '9' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 光芒石')
                    return guangmangshi_market()
                end
            )
            table.remove(bag_table_use, str_guangmangshi)
        elseif num == '10' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 昆仑玉')
                    return kunlunyu_market()
                end
            )
            table.remove(bag_table_use, str_kunlunyu)
        elseif num == '11' then
            -- table.remove(bag_table_use, str_yuehualu)
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 月华露')
                    return yuehualu_market()
                end
            )
        elseif num == '12' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 锻造册')
                    return duanzaoce_market()
                end
            )
        elseif num == '13' then
            table.insert(
                sell_table,
                function()
                    Common.record('出售: 制造书')
                    return zhizaoshu_market()
                end
            )
        end
    end
    return sell_table, bag_table_use
end

-- 商会出售
local function sell()
    if empty() then
        return
    end -- 商会没有可出售的
    local not_match = 0

    for i = 1, 2, 1 do -- todo 怎么识别列表的东西已经卖完了
        for j = 1, #UISetting.shanghui_list, 1 do
            local resFunc = UISetting.shanghui_list[j]
            while true do
                if not shanghui_logo() then
                    coroutine.yield('商会出售过程中页面异常', 'c2')
                    mSleep(1000)
                    goto continue
                end

                local r, t, x, y = resFunc()
                if r then
                    tap(x, y)
                    mSleep(1000)

                    tap(716, 586) -- 打开数量
                    mSleep(1000)

                    tap(662, 500) -- 点击数字9
                    mSleep(500)
                    tap(662, 500) -- 点击数字9
                    mSleep(500)

                    tap(896, 584) -- 出售
                    mSleep(1000)
                else
                    break
                end
                ::continue::
            end
            if empty() then
                toast('没东西出售了', 1)
                mSleep(1000)
                break
            end -- 商会没有可出售的

            mSleep(1000)
            tap(1, 1)
        end
    end
end

local function sell2User()
    local initX = 706
    local initY = 171

    -- 从第一行找到第一个物品
    for i = 1, 10, 1 do
        local lastColor = nil
        local color_match = 0
        while initX <= 946 do
            if not baitan_logo() then
                coroutine.yield('摆摊出售页面异常', 'c2')
                mSleep(1000)
                goto continue
            end

            mSleep(1500)
            if not isColor(582, 473, 0xdfc2a0) then -- 上架满了,无法上架了
                -- 看看有没有上架超时的,然后取回
                local initX_sale = 442
                local initY_sale = 491
                for i = 1, 8, 1 do -- 最多上架8个商品,检查有没有上架超时的
                    if i % 2 == 0 then
                        initX_sale = 442
                        initY_sale = initY_sale - 90
                    end -- 说明点完一行了,一行两个
                    tap(initX_sale, initY_sale)
                    mSleep(1000)
                    if expire() then
                        tap(653, 538) -- 点击取回
                    elseif isColor(888, 79, 0xbf1500) then -- 有红色叉叉就关闭掉
                        tap(888, 79) -- 关闭
                    end
                    mSleep(1500)
                    initX_sale = initX_sale - 250 -- 往前
                end
                if not isColor(582, 473, 0xdfc2a0) then -- 清理完超时后再次确认
                    toast('没位置上架了')
                    return
                end
            end

            local color = getColor(initX, initY)
            if color == 0xdfc2a0 then -- 说明没有东西可以上架了
                toast('没东西上架了')
                return
            end

            if color == lastColor then -- bug: 多个相同物品会跳格
                toast('match...', 1)
                mSleep(1000)
                color_match = color_match + 1
                if color_match >= 2 then
                    initX = initX + 80
                    color_match = 0
                    goto continue
                end
            end

            tap(initX, initY)
            mSleep(1000)
            if not baitanPage() then -- 说面点击了物品有变化
                -- 普通出售
                local r, t, x, y = simple()
                if not r then -- 不是普通物品出售
                    initX = initX + 80 -- 指向向下一个物品

                    r, t, x, y = zhenpin()
                    if r then -- 珍品装备出售
                        tap(x, y) -- 关闭窗口
                    else
                        tap(661, 561) -- 珍品,取消掉
                    end

                    if isColor(661, 561, 0xecbc5e) then
                        tap(661, 561)
                    end -- 有取消按钮点击取消
                else
                    fix_price() -- 调整价格
                    mSleep(1000)

                    tap(825, 555) -- 上架
                    mSleep(2000)
                end

                if shangjia_success1() then
                    Common.record('关闭上架成功提示')
                    tap(400, 437) -- 7天不提示
                    mSleep(1000)
                    tap(569, 497) -- 确定
                    mSleep(1000)
                end
            else
                initX = initX + 80 -- 指向向下一个物品
            end

            lastColor = color
            ::continue::
        end
        if i % 5 == 0 then
            moveTo(789, 513, 789, 121, 2, 50)
        end

        initX = 706 -- 复位,下一行第一个开始
        initY = initY + 80 -- 换到下一行
    end
end

local function cleanBag()
    local point1 = 0xffffff
    local point2 = 0xffffff
    local point3 = 0xffffff
    local point4 = 0xffffff

    while true do
        local p1 = getColor(606, 180)
        local p2 = getColor(686, 265)
        local p3 = getColor(769, 337)
        local p4 = getColor(841, 416)

        local removeTable = {} -- 记录清理过的物品
        for i = 1, #UISetting.bag_list, 1 do
            if not bag() then
                coroutine.yield('整理背包出现异常', 'c2')
                mSleep(1000)
                goto continue
            end

            local ret = UISetting.bag_list[i]()
            if ret == 1 then
                table.insert(removeTable, i)
            end
        end

        if #removeTable > 0 then -- 清理掉已经整理过的物品函数
            for i = #removeTable, 1, -1 do
                table.remove(UISetting.bag_list,removeTable[i])
            end
        end

        if (p1 == point1 and p2 == point2 and p3 == point3 and p4 == point4) then -- 拉到底
            break
        end
        point1 = p1
        point2 = p2
        point3 = p3
        point4 = p4
        moveTo(729, 499, 729, 153, 2, 50)
        ::continue::
    end

    tap(980, 42) -- 关闭背包
end

-- todo 背包的种子|打造书无法识别

function bagFunc.openMall()
    Common.blockCheckMainPage('打开商城异常')

    tap(34, 195) -- 打开商城

    while true do
        if baitanPage() then
            break
        end
        coroutine.yield('打开商城后页面异常', 'c2')
        mSleep(1000)
    end
    return 0
end

function bagFunc.switch_shanghui()
    while true do
        if baitanPage() then
            break
        end
        coroutine.yield('打开商城后页面异常', 'c2')
        mSleep(1000)
    end
    tap(1023, 172) -- 切换商会
    mSleep(1000)

    tap(407, 94) -- 切换到出售
    mSleep(1000)

    while true do
        if shanghui_logo() then
            break
        end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end
    return 0
end

function bagFunc.sell_shanghui()
    while true do
        if shanghui_logo() then
            break
        end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end

    sell()

    while true do
        if shanghui_logo() then
            break
        end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.switch_baitan()
    while true do
        if shanghui_logo() then
            break
        end
        coroutine.yield('切换商会异常', 'c2')
        mSleep(1000)
    end
    tap(1025, 272) -- 切换摆摊
    mSleep(1000)

    tap(401, 92) -- 切换到出售
    mSleep(1000)

    while true do
        if baitan_logo() then
            break
        end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.sell_baitan()
    while true do
        if baitan_logo() then
            break
        end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end
    sell2User()

    while true do
        if baitan_logo() then
            break
        end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.close_market()
    while true do
        if baitan_logo() then
            break
        end
        coroutine.yield('切换摆摊异常', 'c2')
        mSleep(1000)
    end

    tap(978, 40) -- 关闭商城
    mSleep(1500)

    Common.blockCheckMainPage('关闭商城异常')

    return 0
end

function bagFunc.open_bag()
    Common.blockCheckMainPage('打开背包异常')

    tap(1096, 522) -- 打开背包
    mSleep(1000)

    while true do
        if bag() then
            break
        end
        coroutine.yield('打开背包后页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

function bagFunc.clear_bag()
    while true do
        if bag() then
            break
        end
        coroutine.yield('打开背包后页面异常', 'c2')
        mSleep(1000)
    end

    tap(871, 572) -- 先点击一下整理背包
    mSleep(1000)

    cleanBag() -- 清空背包

    Common.blockCheckMainPage('清空背包后页面异常')

    return -2
end

function bagFunc.crashCallack()
    return 1
end

return bagFunc
