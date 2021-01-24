ret={}

input={}
result={}

shell=util.shell
check_command=util.check_command

function get_volume()
	local val=0
	local get_cmd="amixer get Master"
	local line=shell(get_cmd)
	for ret in line:gmatch("%S+") do
		if ret:match("%[(%d+)%%%]") ~=nil then
			val=ret:match("%[(%d+)%%%]")
		end
	end
	return val
end

function set()
	if check_command("amixer") then
		if input.data then
			data=json.decode(input.data)
			local set_cmd="amixer sset Master %s"
			shell(set_cmd:format(data.volume))
		end
	end
end

function get()
	if check_command("amixer") then
		ret.data=get_volume()
		ret.ui={
			{type="form",left=60,top=20,val="Ses Seviye Ayarlama"},
			{type="label",left=1,top=1,val="Aktif Ses Seviyesi"},
			{type="entry",left=23,top=1,val=ret.data,len=5,post="volume"},
			{type="button",left=16,top=16,val="Geri"},
			{type="button",left=34,top=16,val="Tamam",url="sound/volume"},
		}
	else
		ret.data={error="amixer command not found"}
		ret.ui={
			{type="form",left=60,top=20,val="Hata Bilgisi"},
			{type="label",left=1,top=3,val=ret.data.error},
			{type="button",left=16,top=16,val="Geri"},
		}
	end
	result=json.encode(ret)
end
