require("TSLib")
local thread = require("thread")
val = 1

function t2_function()
    while true do
        mSleep(2000)
        toast("22222", 1)
    end
end

function t1_function()
    while true do
        mSleep(3000)
        -- val = val + 1
        -- toast("sub thread-1 over---" .. val, 3)
        toast("11111", 1)
    end
end

init(1)
tid =
    thread.create(
    function()
        local sub_t2 =
            thread.createSubThread(
            function()
                t2_function()
            end
        )

        local sub_t1 = thread.createSubThread(t1_function)

        while (true) do
            toast("main thread")
            mSleep(5000)
        end
    end
)

thread.waitAllThreadExit()
