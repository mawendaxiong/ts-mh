local main_callback = {
    callBack = function()
       if global_app_exit_reason == "userExit" then
			dialog("用户退出", time)
		else
			dialog("发生未知异常", time)
		end
    end,
    errorBack = function(err)
        dialog("协程错误了:"..err,0)
    end,
    catchBack = function(exp)
        local sz = require('sz')
        local json = sz.json
		if exp.msg ~= "userExit" then
			dialog("协程异常了\n"..json.encode(exp),0)
		else
			global_app_exit_reason = "userExit"
		end
    end
}
local click_callback = {
    callBack = function()
    end,
    errorBack = function(err)
    
        dialog("协程错误了:"..err,0)
    end,
    catchBack = function(exp)
		if exp.msg == "timeout" then 
			dialog("用户取消死循环任务了", 10)
		else
			local sz = require"sz"
			dialog(sz.json.encode(exp))
		end
    end
}
	thread = require("thread")
	local function simulate()  --模拟响应某个按钮时是死循环
		while (true) do
			toast("假装这是个死循环")
			mSleep(1000)
		end
		global_clicked_tid = nil  --事先约定好了存储这个任务tid的变量 任务完成后将这个变量变为nil
	end
	local function drawView()
		init(1)
		fwShowWnd("wid",0,0,600,100,1) 
		fwShowButton("wid","id1","点击","","FFDAB9","",15,0,0,100,100)
		fwShowButton("wid","id2","停止","","FFDAB9","",15,100,0,200,100)
		fwShowButton("wid","id3","关闭","","FFDAB9","",15,200,0,300,100)
	end
	function UIApplicationMain()
		drawView()
		toast("begin",1)
		local command = fwGetPressedButton()
		while (true) do
	        if command == "id1" then   --派发子协程,这里是模拟了一个死循环任务
				toast("click",1)
			    global_clicked_tid = thread.createSubThread(simulate,click_callback)
				mSleep(2000)
		    end
		    if command == "id2" then   
				toast("cancel",1)
				--dialogInput("取消哪个", "1", "cancel")
				if global_clicked_tid  then  --如果存在说明这个任务没完成
					thread.setTimeout(10,global_clicked_tid) --将他的超时时间设为极短。这样会因为超时引发click_callback回调
				end
		    end 
			if command == "id3" then  --需要停止,直接抛出一个约定的异常。这个异常会被判断为用户取消
				thread.throw("userExit")
		    end
			mSleep(2000)
			command = fwGetPressedButton()
			toast("get next",1)
		end
	end
local function isColor(x,y,c,s)
    local fl,abs = math.floor,math.abs
    s = fl(0xff*(100-s)*0.01)
    local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
    local rr,gg,bb = getColorRGB(x,y)
    if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
        return true
    end
end
local function click(x,y,time)
	touchDown(0, x, y)
	mSleep(time or 50)
	touchUp(0, x, y)
end
local function killdialog()
	while true do
		 if (isColor( 570,  440, 0xd3ced0, 85) and isColor( 650,  463, 0x007aff, 85)) then
			toast("发现弹窗",1)
			--mSleep(500)
			click(610,461)
			mSleep(300)
		else
			toast("没有弹窗",1)
			mSleep(1000)
		end 
	end
end
	local function main()
		local tid = thread.create(UIApplicationMain,main_callback)
		local kill_tid = thread.create(killdialog,main_callback)
		thread.waitAllThreadExit()
	end
	main()