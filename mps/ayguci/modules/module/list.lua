ret={}
input={}
result={}
--lfs= require("lfs")
_modules={}
_module_names={}

modules_path="/usr/milis/ayguci/modules"

for modul in lfs.dir(modules_path) do
	if modul ~= "." and modul ~= ".." and modul ~= "module" then
	  -- isimler sadece
	  table.insert(_module_names,modul)
	  -- işlevli moduller
	  _modules[modul]={}
	  for fn in lfs.dir(modules_path.."/"..modul) do
		 if fn ~= "." and fn ~= ".." then
		   _fn,_= fn:match("(.*).lua")
		   --print(modul..".".._fn)
		   if _fn then
		     table.insert(_modules[modul],_fn)
		   end
		 end
	  end
	end
end

function set()
	if input.data then
		data=json.decode(input.data)
		if data.modul then
			ret.data=_modules[_module_names[data.modul]]
			
			ret.ui={
				{type="form",left=60,top=20,val="İşlevler"},
				{type="list",val=_modules[_module_names[data.modul]],post="func",url="module/list"},
				{type="button",left=16,top=16,val="Geri"},
			}
		end
	else
		-- mevcut değer döndürülür-ses değeri vs gibi
		ret.data=_modules
		ret.ui={
			{type="form",left=60,top=20,val="Moduller"},
			{type="list",val=_module_names,post="modul",url="module/list"},
			{type="button",left=16,top=16,val="Exit"},
		}
	end
end

function get()
	result=json.encode(ret)
end

