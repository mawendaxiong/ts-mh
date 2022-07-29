--[[
助战
]]
require('TSLib')

local zz = require('zhuzhan.index')
local Common = require('Common.index')

local page = {}

function page.index()
    page = {
        ['-1'] = {['now'] = '-1', ['name'] = '闪退补偿', ['class'] = zz, ['method'] = 'crashCallack'},
        ['1'] = {['now'] = '1', ['name'] = '检查页面', ['class'] = Common, ['method'] = 'b2a', ['next'] = '2'},
        ['2'] = {
            ['now'] = '2',
            ['name'] = '打开助战',
            ['class'] = zz,
            ['method'] = 'open',
            ['next'] = '3'
        },
        ['3'] = {['now'] = '3', ['name'] = '调整助战', ['class'] = zz, ['method'] = 'adjust', ['next'] = '1'}
    }
    return page
end
return page
