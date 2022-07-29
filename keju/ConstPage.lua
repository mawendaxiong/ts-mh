--[[
科举
]]
require('TSLib')

local keju = require('keju.index')
local renwuban = require('renwuban.index')
local Common = require('Common.index')

local page = {}
function page.index()
    renwuban.new('keju')
    page = {
        ['-1'] = {['now'] = '-1', ['name'] = '闪退补偿', ['class'] = keju, ['method'] = 'crashCallack'},
        ['1'] = {['now'] = '1', ['name'] = '检查时间', ['class'] = keju, ['method'] = 'checkTime', ['next'] = '2'},
        ['2'] = {['now'] = '2', ['name'] = '检查页面', ['class'] = Common, ['method'] = 'b2a', ['next'] = '3'},
        ['3'] = {['now'] = '3', ['name'] = '打开活动面板', ['class'] = renwuban, ['method'] = 'open', ['next'] = '4'},
        ['4'] = {
            ['now'] = '4',
            ['name'] = '查找任务并打开',
            ['class'] = keju,
            ['method'] = 'findTaskOnTaskBoard',
            ['next'] = '5'
        },
        ['5'] = {['now'] = '5', ['name'] = '答题', ['class'] = keju, ['method'] = 'answer', ['next'] = '1'}
    }
    return page
end
return page
