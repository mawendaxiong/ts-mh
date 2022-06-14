require("TSLib")

local timer = {}
timer.startTime = 0
timer.schedule = 0

function timer.start(schedule)
    if schedule == nil then schedule = 5 end
    timer.startTime = os.time()
    timer.schedule = schedule
end

function timer.check()
    if os.time() - timer.startTime >= timer.schedule then return true end
    return false
end

function timer.detail() return timer.schedule - (os.time() - timer.startTime) end

return timer
