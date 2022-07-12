local taskRecord = {}
local UISetting = {}
local mainStatus = {}
local uncharted = {}
local escort = {}
local exception = {}
local globalGhost = {}
local log = {}
local dev = {}

mainStatus.isCrash = -1

-- 当前正在执行的任务
taskRecord.currentTaskIndex = 1
-- 当前任务正在执行的步骤
taskRecord.currentStep = -1
taskRecord.taskStr = ""
taskRecord.crashPage = nil
taskRecord.crashNode = nil
taskRecord.taskName = ''

-- 当前正在执行任务的账号
UISetting.currentAccountIndex = 1
UISetting.accountList = {}
UISetting.lianxiaohaoList = {}
UISetting.lianxiaohao = nil
UISetting.lianxiaohaoType = nil
UISetting.lianxiaohaoLevel = 37
UISetting.taskOrder = nil
UISetting.schedule = nil
UISetting.restart = nil

UISetting.g1 = 20
UISetting.g2 = 20
-- 打工消耗活力
UISetting.money = 0
-- 商会出售列表
UISetting.shanghui_list = {}
-- 背包整理列表
UISetting.bag_list = {}
-- 摆摊价格
UISetting.price_baitan = -1

-- 秘境次数统计
uncharted.freq = 0
-- 运镖次数统计
escort.freq = 0

-- 页面卡住次数
exception.freq = 20
-- 四个点的记录
exception.cache_points = {}
-- 检测点的位置
exception.check_points = {
    {313, 124}, {791, 141}, {374, 206}, {740, 213}, {482, 294}, {641, 303},
    {377, 367}, {735, 373}, {336, 434}, {111, 343}, {1120, 204}, {1033, 595},
    {496, 587}, {736, 31}, {887, 470}
}

-- 捉鬼
-- 捉鬼次数
globalGhost.ghostNum = 0
-- 练小号时的检查等级
globalGhost.checkLevel = nil

log.name = "mh-debug-" .. os.date("%Y-%m-%d %X")

dev.status = 0

return {
    ["taskRecord"] = taskRecord,
    ["UISetting"] = UISetting,
    ["mainStatus"] = mainStatus,
    ["uncharted"] = uncharted,
    ["exception"] = exception,
    ["globalGhost"] = globalGhost,
    ["escort"] = escort,
    ["log"] = log,
    ["dev"] = dev
}
