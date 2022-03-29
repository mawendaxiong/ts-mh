require("TSLib")
init(1)

ret = -2

function main()
    local thread = require("thread")

    thread.create(
        function()
            index = 1
            while (true) do
                index = index + 1
                if index == 10 then
                    ret = -2
                    break
                end
                toast(index, 1)
                mSleep(1500)
            end
        end
    )
    thread.waitAllThreadExit()
end

while ret == -2 do
    main()
    toast("round...", 1)
    mSleep(1000)
end
-- thread.waitAllThreadExit()
