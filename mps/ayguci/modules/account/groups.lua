serpent=require("serpent")
local shell = util.shell
local get_content = util.get_content

ret={}
result={}

local file="/etc/group"
groups={}
local users={}

for line in get_content(file):gmatch("[^\r\n]+") do
	--group=line:match("([%w]+):")
	local name,x,id,_users = line:match("(['%w%d-_']+):(['%w']+):(['%d']+):(.*)")
	if _users ~= nil then
		for user in _users:gmatch("[^,\n]+") do table.insert(users,user) end
	end
	groups[name]={id=id,users=users}
	users={}
end

function get()
	ret.data=groups
	ret.ui={
		{type="form",left=60,top=20,val="Gruplar"},
		{type="textbox",left=1,top=1,width=45,height=18,val=serpent.block(ret.data),scroll=1},
		{type="button",left=49,top=16,val="Geri"},
	}
	result=json.encode(ret)
end
