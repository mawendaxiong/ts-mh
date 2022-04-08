require("TSLib")
init(1)

t1 = {1, 2, 3, 4, 5, 6, 7, 8}
for var = 1, #t1 do
    toast(var, 2)
    mSleep(2000)
    toast(t1[var], 2)
    mSleep(2000)
    var = 5
end
