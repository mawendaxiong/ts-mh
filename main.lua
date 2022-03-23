require("TSLib")

TaskBoard = require("TaskBoard.index")
Common = require("Common.index")

UI = require("UI.index")
Main = require("Main.index")

createGobalTable("UISetting")

createGobalTable("mainStatus")
createGobalTable("mainThread")

--[[
############variable##############
]]
createGobalTable("taskRecord")
-- 执行状态 -1:闪退
taskRecord.status = 1
-- 任务列表
taskRecord.taskList = nil
-- 当前正在做的任务
taskRecord.currentTaskIndex = 0

-- 是否闪退 true:闪退
mainStatus.isCrash = -1
-- 重启app成功 true:重启成功
mainStatus.restartSuccess = -1
-- 切换任务
mainStatus.isChangeTask = -1
-- 切换任务成功
mainStatus.changeTaskSuccess = -1
-- 是否需要切换账号
mainStatus.isNextAccount = -1
-- 登录成功
mainStatus.isLoginSuccess = -1

--[[
#################thread################
]]
-- 监测app闪退线程
mainThread.appThread = nil
-- 执行任务线程
mainThread.excuteThread = nil
-- 重启app线程
mainThread.restartAppThread = nil
-- 切换任务线程
mainThread.changeTaskThread = nil
-- 监测画面卡住线程
mainThread.stuckThread = nil

mainThread.loginThread = nil

-- 记录当前账号
UISetting.accountIndex = 1

threadCallbackTable = {
    callBack = function()
        --协程结束会调用，不论是错误、异常、正常结束
        toast("协程结束了", 0)
    end,
    errorBack = function(err)
        --协程错误结束，一般是引用空调用，err 是字符串
        toast("协程错误了:" .. err, 5)
    end,
    catchBack = function(exp)
        --协程异常结束，异常是脚本调用了 throw 激发的，exp 是 table,exp.message 是异常原因
        local ts = require("ts")
        local cjson = ts.json
        toast("协程异常了\n" .. json.encode(exp), 0)
    end
}
toast("starting...", 5)

uiret, uiValues = UI.show()

if uiret == 0 then
    return
end
UI.analysis(uiValues)

init(1)
fwShowWnd("recordBoard", 0, 394, 155, 456, 0)
local thread = require("thread")

function main()
    -- 登录线程重启游戏,并输入账号登录游戏
    thread.createSubThread(Main.login)

    while true do
        -- if mainStatus.isLoginSuccess ~= -1 then
        --     mainThread.excuteThread = thread.createSubThread(Main.excu, threadCallbackTable)
        -- end

        --[[
        需要切换任务
        停止 [执行游戏任务线程]
        启动 [切换任务线程]
        ]]
        if mainStatus.isChangeTask ~= -1 then
            mainStatus.isChangeTask = -1

            thread.stop(mainThread.excuteThread)
            mainThread.changeTaskThread = thread.createSubThread(Main.changeTask, threadCallbackTable)
        end

        --[[
        切换任务成功
        启动 [执行游戏任务线程]
        ]]
        if mainStatus.changeTaskSuccess ~= -1 then
            mainStatus.changeTaskSuccess = -1

            mainThread.excuteThread = thread.createSubThread(Main.excu, threadCallbackTable)
        end

        --[[
        游戏闪退
        启动 [重启游戏线程]
        ]]
        if mainStatus.isCrash ~= -1 then
            collectgarbage("collect")
            mainThread.restartAppThread = thread.createSubThread(Main.restartApp)
        end

        --[[
        重启app成功
        启动 [监测游戏闪退线程]
        启动 [执行游戏任务线程]
        启动 [监测页面卡死线程]
        ]]
        if mainStatus.restartSuccess ~= -1 then
            mainStatus.restartSuccess = -1

            -- 重启成功再继续执行
            mainThread.appThread = thread.createSubThread(Main.checkAppCrash)
            mainThread.excuteThread = thread.createSubThread(Main.excu)
            mainThread.stuckThread = thread.createSubThread(Main.checkStuck)
        end

        if mainStatus.isNextAccount ~= -1 then -- 登录下一个账号
            mainStatus.isNextAccount = -1

            mainThread.loginThread = thread.createSubThread(Main.login)
        end

        mSleep(8000)
    end
end
thread.create(main)
thread.waitAllThreadExit()
