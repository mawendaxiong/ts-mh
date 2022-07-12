require('TSLib')
require('zhuzhan.components')
Common = require('Common.index')

local zhuzhan = {}

-- 打开助战
function zhuzhan.open()
    Common.blockCheckMainPage('首页打开助战异常')

    -- 展开选项
    if not logo() then
        tap(1101, 597)
        mSleep(3000)
    end

    -- 打开助战
    local r, t, x, y = logo()
    if not r then
        Common.record('未开放助战功能')
        return -2
    end

    tap(x, y)

    while true do
        if zhuzhanPage() then
            break
        end
        coroutine.yield('打开助战页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 调整助战
function zhuzhan.adjust()
    while true do
        if zhuzhanPage() then
            break
        end
        coroutine.yield('打开助战页面异常', 'c2')
        mSleep(1000)
    end
    -- 选择第一个助战栏
    tap(962, 119)

    while (true) do
        local r, t, x, y = addLogo()
        if r then
            tap(x, y)
            mSleep(2000)

            r, t, x, y = addHelper()
            tap(x, y)
            mSleep(1000)
        else
            -- 关闭助战
            tap(1008, 46)
            break
        end
    end

    Common.blockCheckMainPage('关闭助战异常')
    return -2
end

function zhuzhan.crashCallack()
    return 1
end
return zhuzhan
