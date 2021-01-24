ret={}

input={}
result={}

shell=util.shell

function get_brightness()
	local int_cmd="ls /sys/class/backlight/"
	local interface=shell(int_cmd)
	local max_brg=shell("cat /sys/class/backlight/"..interface.."/max_brightness")
	local cmd="cat /sys/class/backlight/%s/brightness"
	local val=shell(cmd:format(interface))
	val = math.floor(tonumber(val) / tonumber(max_brg) * 100)
	return interface, max_brg, val
end

function set()
	interface,max_brg,ret.data=get_brightness()
	if input.data then
		data=json.decode(input.data)
		--print("gelen data:",data.brightness)
		val=tonumber(data.brightness)
		if val>99 then val=99 end
		val = val /100 * tonumber(max_brg)
		val = math.floor(val + 0.5 - (val + 0.5) % 1)+1
		local set_cmd="echo %s > /sys/class/backlight/%s/brightness"
		shell(set_cmd:format(val,interface))
	end
end

function get()
	ret.data={}
	ret.data.interface,max_brg,ret.data.brightness=get_brightness()
	ret.ui={
		{type="form",left=60,top=20,val="Ekran Parlaklık Ayarlama"},
		{type="label",left=1,top=1,val="Aktif Parlaklık Seviyesi"},
		{type="label",left=1,top=3,val=ret.data.interface},
		{type="entry",left=20,top=3,val=ret.data.brightness,len=3,post="brightness"},
		{type="button",left=16,top=16,val="Geri"},
		{type="button",left=34,top=16,val="Tamam",url="screen/brightness"},
	}
	result=json.encode(ret)
end

--./client 'screen/brightness {"brightness":"85"}'
