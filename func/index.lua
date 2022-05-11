require("TSLib")
Common = require("Common.index")

function excuteLocal(page, step)
    node = page["" .. step]
    nextNode = page[node["next"]]

    while nextNode ~= nil do
        class = node["class"]
        method = node["method"]
        step = node["now"]

        Common.record("step: " .. step .. " " .. node["name"])
        mSleep(1500)
        ret = class[method]()
        toast("ret: " .. ret)
        if ret == nil then
            toast("[" .. method .. "]执行失败")
            mSleep(1000)
            break
        elseif ret == 0 then --直接执行next
            node = nextNode
            nextNode = page[node["next"]]
            mSleep(2000)
        elseif ret == -2 then -- 一系类任务执行完毕
            break
        else --执行指定跳转的步骤
            node = page["" .. ret]
            nextNode = page[node["next"]]
            mSleep(2000)
        end
    end
end
