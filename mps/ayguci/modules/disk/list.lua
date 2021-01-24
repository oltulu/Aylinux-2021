local shell = util.shell
string.split=util.string.split
serpent=require("serpent")
ret={}
input={}
result={}

local function get_info()
	local infos={}
	local info={}
	local k,v=""
	local komut="lsblk -P -no PATH,SIZE,FSTYPE"
	for line in shell(komut):gmatch("[^\r\n]+") do 
		for val in line:gmatch("%S+") do
			k=val:split("=")[1]
			v=val:split("=")[2]
			info[k:lower()]=v:gsub('"',"")
		end
		table.insert(infos,info) 
		info={}
	end 
	return infos
end

function get()
	-- tüm diskler hakkında
	ret.data=get_info()
	ret.ui={
		{type="form",left=60,top=20,val="Seçili Disk Bilgi"},
		{type="textbox",left=1,top=1,width=45,height=18,val=serpent.block(ret.data),scroll=1},
		{type="button",left=49,top=16,val="Geri"},
	}
	result=json.encode(ret)
end
