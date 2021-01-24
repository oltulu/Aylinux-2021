local ret={}
ret.data="Account-add verisi"

ret.ui={
	{type="form",left=60,top=20,val="Kullanıcı Ekleme"},
	
	{type="label",left=1,top=1,val="İsim"},
	{type="label",left=1,top=2,val="Tam İsim"},
	{type="label",left=1,top=3,val="Şifre"},
	
	{type="entry",left=13,top=1,val="ali",len=30,post="name"},
	{type="entry",left=13,top=2,val="ali ince",len=30,post="fname"},
	{type="entry",left=13,top=3,val="12345",len=30,post="passwd"},
	
	{type="radio",left=1,top=6,val="Red",bool="false",post="radio1"},
	{type="radio",left=1,top=7,val="Blue",bool="false",post="radio1"},
	{type="radio",left=1,top=8,val="Green",bool="true",post="radio1"},
	
	{type="radio",left=1,top=10,val="low",bool="false",post="radio2"},
	{type="radio",left=1,top=11,val="med",bool="true",post="radio2"},
	{type="radio",left=1,top=12,val="high",bool="false",post="radio2"},
	
	{type="check",left=15,top=6,val="Ev dizini",bool="true",post="home_dir"},
	{type="check",left=15,top=7,val="Wheel grubunda",bool="true",post="wheel_status"},
	{type="check",left=15,top=8,val="Giriş yok",bool="false",post="enter_status"},
	
	--{type="button",left=16,top=16,val="İptal",url="user/add"},
	{type="button",left=16,top=16,val="İptal"},
	{type="button",left=35,top=16,val="Tamam"},
	{type="button",left=44,top=16,val="Çıkış"},
	--{type="button",left=44,top=16,val="Çıkış",event="exit"},

}

result=json.encode(ret)
