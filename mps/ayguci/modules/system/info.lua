local get_content = util.get_content
string.split=util.string.split
serpent=require("serpent")
ret={}
ret.data={}
input={}
result={}

-- one line content - fist line also
local function content(file)
	for _name in get_content(file):gmatch("[^\r\n]+") do
		return _name:gsub("%s+", "")
	end
end

local function get_cpu_info()
	local file="/proc/cpuinfo"
    ret.data.cpu={}
	for name in get_content(file):gmatch("[^\r\n]+") do
		if name:split(":")[1]:gsub("%s+", "") == "modelname" then
			ret.data.cpu.model=name:split(":")[2]
		end
		if name:split(":")[1]:gsub("%s+", "") == "cpucores" then
			ret.data.cpu.core=name:split(":")[2]
		end
	end
end

local function get_info()
	ret.data={
		hostname = content "/etc/hostname",
		uuid   = content "/sys/class/dmi/id/product_uuid",
		vendor = content "/sys/class/dmi/id/board_vendor",
		board = content "/sys/class/dmi/id/board_name",
		product = content "/sys/class/dmi/id/product_name",
		serial = content "/sys/class/dmi/id/product_serial",
		bios={
			vendor = content "/sys/class/dmi/id/bios_vendor",
			version = content "/sys/class/dmi/id/bios_version",
			release = content "/sys/class/dmi/id/bios_release",
			date = content "/sys/class/dmi/id/bios_date",
		},
	}
end



function get()
	-- tüm diskler hakkında
	get_info()
	get_cpu_info()
	ret.ui={
		{type="form",left=60,top=20,val="Sistem Özet Bilgi"},
		{type="textbox",left=1,top=1,width=45,height=18,val=serpent.block(ret.data),scroll=1},
		{type="button",left=49,top=16,val="Geri"},
	}
	result=json.encode(ret)
end
