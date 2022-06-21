taskRecord = {}
UISetting = {}
mainStatus = {}
uncharted = {}
escort = {}
exception = {}
globalGhost = {}

mainStatus.isCrash = -1
mainStatus.needLogin = 1
mainStatus.logining = -1

-- 当前正在执行的任务
taskRecord.currentTaskIndex = 1
-- 当前任务正在执行的步骤
taskRecord.currentStep = -1
taskRecord.taskStr = ""
taskRecord.crashPage = nil
taskRecord.crashNode = nil

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

-- 秘境次数统计
uncharted.freq = 0
-- 运镖次数统计
escort.freq = 0

-- 上一次异常时间
exception.lastTime = 0
-- 异常次数
exception.freq = 0

-- 捉鬼
-- 捉鬼次数
globalGhost.ghostNum = 0
-- 练小号时的检查等级
globalGhost.checkLevel = nil

return {
    ["taskRecord"] = taskRecord,
    ["UISetting"] = UISetting,
    ["mainStatus"] = mainStatus,
    ["uncharted"] = uncharted,
    ["exception"] = exception,
    ["globalGhost"] = globalGhost,
}
