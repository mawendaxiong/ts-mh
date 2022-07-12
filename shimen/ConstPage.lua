--[[
师门
]] require('TSLib')

local renwuban = require('renwuban.index')
local Common = require('Common.index')
local shimen = require('shimen.index')

local page = {}

function page.index()
    renwuban.new('shimen')

    page = {
        ['-1'] = {
            ['now'] = '-1',
            ['name'] = '闪退补偿',
            ['class'] = shimen,
            ['method'] = 'crashCallack'
        },
        ['1'] = {
            ['now'] = '1',
            ['name'] = '回长安',
            ['class'] = Common,
            ['method'] = 'b2a',
            ['next'] = '2'
        },
        ['2'] = {
            ['now'] = '2',
            ['name'] = '打开活动面板',
            ['class'] = renwuban,
            ['method'] = 'open',
            ['next'] = '3'
        },
        ['3'] = {
            ['now'] = '3',
            ['name'] = '查找任务并打开',
            ['class'] = shimen,
            ['method'] = 'findTaskOnTaskBoard',
            ['next'] = '4'
        },
        ['4'] = {
            ['now'] = '4',
            ['name'] = '选择任务',
            ['class'] = shimen,
            ['method'] = 'chooseTask',
            ['next'] = '5'
        },
        ['5'] = {
            ['now'] = '5',
            ['name'] = '等师傅',
            ['class'] = shimen,
            ['method'] = 'waitMaster',
            ['next'] = '6'
        },
        ['6'] = {
            ['now'] = '6',
            ['name'] = '找任务',
            ['class'] = shimen,
            ['method'] = 'findRightTask',
            ['next'] = '7'
        },
        ['7'] = {
            ['now'] = '7',
            ['name'] = '执行',
            ['class'] = shimen,
            ['method'] = 'excute',
            ['next'] = '1'
        }
    }

    return page
end

return page
