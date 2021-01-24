string.split=util.string.split
serpent=require("serpent")

ret={}

input={}
result={}

local _disk_names={}

local function get_info()
	local infos={}
	local info={}
	local k,v=""
	local komut="lsblk -P -no TYPE,NAME,LABEL,PATH,MOUNTPOINT,FSSIZE,FSTYPE,FSUSED,FSUSE%,SIZE,UUID"
	for line in util.shell(komut):gmatch("[^\r\n]+") do 
		for val in line:gmatch("%S+") do
			k=val:split("=")[1]
			v=val:split("=")[2]
			info[k:lower()]=v:gsub('"',"")
		end
		table.insert(_disk_names,info.name)
		table.insert(infos,info) 
		info={}
	end 
	return infos
end

function set()
	if input.data then
		data=json.decode(input.data)
		local disks=get_info()
		ret.data=disks[data.disk]
	end
end

function get()
	local default_val=_disk_names
	-- tüm diskler hakkında
	if not ret.data then
		ret.data=get_info()
		ret.ui={
			{type="form",left=60,top=20,val="Disk Bilgi"},
			{type="list",val=default_val,post="disk",url="disk/info"},
			{type="button",left=16,top=16,val="Geri"},
		}
	-- disk bölümü hakkında bilgi
	else
		--print(".......................",serpent.line(ret.data),"------------------")
		ret.ui={
			{type="form",left=60,top=20,val="Seçili Disk Bilgi"},
			--{type="label",left=1,top=1,val=serpent.dump(ret.data),post="disk"},
			{type="textbox",left=1,top=1,width=55,height=18,val=serpent.block(ret.data),scroll=0},
			{type="button",left=16,top=16,val="Geri"},
		}
	end
	
	result=json.encode(ret)
end
