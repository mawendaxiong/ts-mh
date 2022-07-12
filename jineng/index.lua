require('TSLib')
require('jineng.components')
local Common = require('Common.index')

local jineng = {}

-- 打开技能
function jineng.open()
    Common.blockCheckMainPage('打开技能板时页面异常')

    local r, t, x, y = logo()
    -- 展开选项
    if not r then
        tap(1101, 597)
        mSleep(3000)
    end

    -- 打开技能
    r, t, x, y = logo()
    -- 说明还没开技能,退出
    if not r then
        return -2
    end
    tap(x, y)

    while true do
        if jinengPage() then
            break
        end
        coroutine.yield('技能页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 升级技能
function jineng.sj()
    while true do
        if jinengPage() then
            break
        end
        coroutine.yield('技能页面异常', 'c2')
        mSleep(1000)
    end

    -- 点击人物技能
    tap(1017, 163)
    mSleep(1500)

    -- 随机次数点击一键升级
    local r = math.random(2, 4)
    for var = 1, r do
        tap(881, 569)
        mSleep(1000)
    end

    -- 关闭技能对话框
    tap(980, 43)

    Common.blockCheckMainPage('技能结束时页面异常')
    return -2
end

function jineng.crashCallack()
    return 1
end

return jineng
