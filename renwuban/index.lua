require("TSLib")

Common = require("Common.index")

TaskBoard = {}

function TaskBoard.checkTaskBoard()
    offset =
        '-805|-18|0x9d591f,-873|477|0x6a0500,-787|489|0xf8d6a3,-794|549|0xf7d5a1'
    return findColorsUntil(0xce0000, offset, 90, 66, 9, 1067, 619, {orient = 2},
                           1000, 2)
end

-- 任务参加按钮的多点位置
TaskBoard.taskContainer = {
    ["baotu"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-267|-5|0xff5555,-255|2|0x55bb77,-263|7|0xff3344"
        }
    },
    ["mijing"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-258|-19|0x229933,-253|5|0x118822,-278|-12|0x229933"
        }
    },
    ["zhuogui"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-269|-4|0xd0e8db,-257|3|0xc33722,-249|11|0x3522aa,-269|17|0xb38231"
        }
    },
    ["shimen"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-271|-16|0xeeff22,-241|-4|0xffaa33,-257|19|0xdd5500"
        }
    },
    ["yunbiao"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-272|-10|0xbbcccc,-255|-20|0xeeffff,-263|11|0x88aabb"
        }
    },
    ["sanjie"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-258|7|0xae1511,-250|6|0x990404,-244|3|0x8c1111"
        }
    },
    ["keju"] = {
        ["all"] = {
            ["color"] = 0xedbe5f,
            ["posandcolors"] = "-254|-6|0x48ccfb,-262|3|0xfbfbee,-262|9|0x8cd0f2"
        }
    }
}

function TaskBoard.new(targetTask) TaskBoard.task = targetTask end

function TaskBoard.open()
    Common.blockCheckMainPage('打开任务板时被挡住了')


    ret = multiColTap({
        {36, 115, 0xe5d45b}, {315, 28, 0xd79a50}, {327, 31, 0xdab291},
        {313, 41, 0x91471d}
    })

    tap(200, 119) -- 打开日常活动

    while true do
        if TaskBoard.checkTaskBoard() then break end -- [确保任务板页面]
        coroutine.yield('打开任务板后页面异常', 'c2')
        mSleep(1000)
    end

    return 0
end

-- 重置任务板
local function resetTaskBoard()
    for index = 1, 3, 1 do
        moveTo(650, 79, 650, 310, 20, 50, 1, 0)
        mSleep(500)
    end
end

function TaskBoard.findTask(step)
    -- todo 暂时默认为2
    if nil == step then step = 2 end
    local taskObject = TaskBoard.taskContainer[TaskBoard.task]
    if not TaskBoard.checkTaskBoard() then
        coroutine.yield('任务板|查找任务', 'c2')
    end
    local x, y = findMultiColorInRegionFuzzy(taskObject.all.color,
                                             taskObject.all.posandcolors, 90,
                                             291, 81, 1015, 440)

    if x ~= -1 then
        tap(x, y)
        mSleep(1000)
        -- 执行下一步
        return 0
    end

    if not TaskBoard.checkTaskBoard() then -- 这种情况一般是人为关掉了
        return 'c2', step
    end

    resetTaskBoard()

    ret = Common.move(function()
        x, y = findMultiColorInRegionFuzzy(taskObject.all.color,
                                           taskObject.all.posandcolors, 90, 291,
                                           81, 1015, 440)
        if x ~= -1 then
            tap(x, y)
            mSleep(1000)
            return true
        end
        return false
    end, function() moveTo(650, 380, 650, 80, 2, 50) end, function()
        local p1 = getColor(330, 433)
        local p2 = getColor(701, 434)
        local p3 = getColor(702, 118)
        local p4 = getColor(339, 117)
        return p1, p2, p3, p4
    end, function() resetTaskBoard() end,
                      function() return TaskBoard.checkTaskBoard() end)

    return ret
end

return TaskBoard
