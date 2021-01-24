ret={}
default_value="EXAMPLE"

input={}
result={}

function set()
	if input.data then
		data=json.decode(input.data)
		ret.data=data.word:lower()
		ret.ui={
			{type="form",left=60,top=20,val="Kelime İşlem Bilgi"},
			
			{type="label",left=1,top=1,val="işlem yapıldı"},
			{type="label",left=1,top=2,val="-------------"},
			{type="label",left=1,top=3,val=ret.data},
			
			{type="button",left=20,top=10,val="Tamam"},
		}
	else
		-- mevcut değer döndürülür-ses değeri vs gibi
		ret.data=default_value
		ret.ui={
			{type="form",left=60,top=20,val="Kelime İşlem Formu"},
			
			{type="label",left=1,top=1,val="Girdi"},
			
			{type="entry",left=10,top=1,val=default_value,len=30,post="word"},
			
			{type="button",left=34,top=16,val="Tamam",url="string/lower"},
			{type="button",left=16,top=16,val="Geri"},
		}
	end
end

function get()
	result=json.encode(ret)
end

