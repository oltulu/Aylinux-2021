serpent=require("serpent")
local shell = util.shell
local get_content = util.get_content

ret={}
result={}

local file="/etc/passwd"
users={}
for line in get_content(file):gmatch("[^\r\n]+") do
	local name,x,id,gid,desc,home,shell = line:match("(['%w%d-_']+):(['%w']+):(['%d']+):(['%d']+):(['%w%d%s-_']+):(['%w%d-_/']+):(['%w/']+)")
	if name == nil then
		name,x,id,gid,desc,home,shell = line:match("(['%w%d-_']+):(['%w']+):(['%d']+):(['%d']+)(['::']+)(['%w%d-_/']+):(['%w/']+)")	
		desc=""
	end
	--print(name,x,id,gid,desc,home,shell)
	users[name]={id=id,gid=gid,desc=desc,home=home,shell=shell}
end

function get()
	ret.data=users
	ret.ui={
		{type="form",left=60,top=20,val="Kullanıcılar"},
		{type="textbox",left=1,top=1,width=45,height=18,val=serpent.block(ret.data),scroll=1},
		{type="button",left=49,top=16,val="Geri"},
	}
	result=json.encode(ret)
end
