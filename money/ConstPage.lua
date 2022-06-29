--[[
使用体力
]] require("TSLib")

mijing = require("money.index")
Common = require("Common.index")

page = {}

function page.index()
    renwuban.new("mijing")

    page = {
        ["-1"] = {
            ["now"] = "-1",
            ["name"] = "闪退补偿",
            ["class"] = mijing,
            ["method"] = "crashCallack"
        },
        ["1"] = {
            ["now"] = "1",
            ["name"] = "回长安",
            ["class"] = Common,
            ["method"] = "b2a",
            ["next"] = "2"
        }

    }

    return page
end

return page
