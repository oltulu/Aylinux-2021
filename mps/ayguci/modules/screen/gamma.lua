ret={}

input={}
result={}

shell=util.shell

function get_gamma()
	local devices = shell("xrandr --query | awk '/\\<connected\\>/ {print $1}'")
	local device_table = {}
	for device in devices:gmatch("%S+") do
		str = shell("xrandr --verbose | sed -n '/"..device.."/ {p;n;n;n;n;p}' | awk '/Gamma:/ {print $2}'")
		if str == "1.0:1.0:1.0" then
			str = "day"
		end
		-- else if kullaninca hata aliyorum cidden
		-- sebebini bilmiyorum ama baya test ettim. sebebi else if 
		if str == "0.91:1.3:1.7" then
			str = "night"
		end
		device_table[device] = str
	end
	return device_table
end

function set()
	if input.data then
		data=json.decode(input.data)
		for device, gamma in pairs(data) do
			b = gamma == "day" or gamma == "night"
			if gamma == "day" then
				gamma = "1:1:1"
			end
			if gamma == "night" then
				gamma = "1.1:0.8:0.6"
			end
			if not b then
				gamma = gamma:match("%d.?%d?:%d.?%d?:%d.?%d?")
			end
			if gamma ~= nil then
				shell("xrandr --output "..device.." --gamma "..gamma)
			end
		end
	end
end

function get()
	ret.data = get_gamma()
	ret.ui={
		{type="form", left=60, top=20, val="Ekran Renk Ayarlama"},
		{type="label", left=1, top=1, val="Aktif Ekran Renk Seviyesi"},
	}
	i = 0
	for device, gamma in pairs(ret.data) do
		table.insert(ret.ui, {type="label", left=1, top=i+3, val=device})
		table.insert(ret.ui, {type="entry", left=20, top=i+3, val=gamma, post=device})
		i = i + 1
	end
	table.insert(ret.ui, {type="label",  left=i+16, top=i+12, val="Ornek: day veya night veya 1.1:0.8:0.6 gibi"})
	table.insert(ret.ui, {type="button", left=i+16, top=i+16, val="Geri"})
	table.insert(ret.ui, {type="button", left=i+34, top=i+16, val="Tamam", url="screen/gamma"})
	result=json.encode(ret)
end
