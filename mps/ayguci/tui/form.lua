#!/usr/bin/env lua5.3

local n = require('newt')


local F={}

F.msgbox={
	{type="form",left=60,top=20,val="Bilgi"},
	--{type="label",left=1,top=1,val="İlgili İşlev İçin Form Hazır Değil!"},
	{type="textbox",left=1,top=1,width=46,height=10,val="İlgili İşlev İçin Form Hazır Değil!"},
	{type="button",left=16,top=16,val="Geri"},
}


function F.generate(ui)

  n.Init()
  n.Cls()

  local msg = "test form"
  local cols, rows = n.GetScreenSize()
  n.DrawRootText((cols - #msg) / 2, rows / 2, msg)

  n.PushHelpLine(nil)
  form = n.Form()
  
  elements={
	  label={},
	  entry={},
	  radio={},
	  check={},
	  button={},
	  list={},
	  textbox={},
  }
  orders={
	  entry={},
	  check={},
  }
  
  for num,e in ipairs(ui) do
	if e.type=="form" then
		n.CenteredWindow(e.left,e.top,e.val)
	elseif e.type=="label" then
		table.insert(elements.label,n.Label(e.left,e.top,e.val))
	elseif e.type=="entry" then
		if e.len == nil then e.len=15 end
		table.insert(elements.entry,n.Entry(e.left,e.top,e.val,e.len))
		orders.entry[e.post]=#elements.entry
	elseif e.type=="check" then
		table.insert(elements.check,n.Checkbox(e.left,e.top,e.val,e.bool))
		orders.check[e.post]=#elements.check
	elseif e.type=="button" then
		table.insert(elements.button,n.Button(e.left,e.top,e.val))
	elseif e.type=="radio" then
		if not elements.radio[e.post] then
			elements.radio[e.post]={}
			table.insert(elements.radio[e.post],n.Radiobutton(e.left,e.top,e.val,(e.bool == "true" and true or false)))
		else
			table.insert(elements.radio[e.post],n.Radiobutton(e.left,e.top,e.val,(e.bool == "true" and true or false),elements.radio[e.post][#elements.radio[e.post]]))
		end
	elseif e.type=="list" then
		local cols, rows = n.GetScreenSize()
		local height = #e.val
		if #e.val > (rows - 15) then height = rows - 15 end
		local flags = n.FLAG_RETURNEXIT
		if height < #e.val then flags = flags + n.FLAG_SCROLL end
		-- konum şimdilik menu 1-1 sonra dinamik olacak
		local mlist = n.Listbox(1, 1, height, flags)
		mlist:AppendEntry(e.val)
		table.insert(elements.list,mlist)
	elseif e.type=="textbox" then	
		local scr=e.val:len()>e.width and -1 or 0
		if e.scroll then
			scr=e.scroll == 1 and -1 or 0
		end
		local tbox=n.Textbox(e.left, e.top,e.width,e.height,scr)
		tbox:SetText(e.val)
		table.insert(elements.textbox,tbox)
	end
	
  end
  
  form:AddComponents(elements.label, elements.entry, elements.check, elements.button, elements.list, elements.textbox)
  for _,val in pairs(elements.radio) do
	form:AddComponents(unpack(val))
  end
  --form:AddComponents(unpack(elements))

  r, v = form:Run()
  value={}
  value.post_url={}
  -- post edilecek sahaları value altında topla
  for _,e in ipairs(ui) do
	if e.type=="entry" and e.post then
		value[e.post]=elements.entry[orders.entry[e.post]]:GetValue()
	elseif e.type=="check" and e.post then
		value[e.post]=elements.check[orders.check[e.post]]:GetValue()	
	elseif e.type=="radio" and e.post then
		value[e.post]=elements.radio[e.post][1]:GetCurrent():Text()
	elseif e.type=="list" and e.post then
		value[e.post]=elements.list[1]:GetCurrent()
		if e.url then
			value.post_url[e.post]=e.url
		end
	elseif e.type=="button" and e.url then
		value.post_url[e.val]=e.url 
	end
  end
  
  form:Destroy()
  n.Finished()
  return r, v,value
end

return F


