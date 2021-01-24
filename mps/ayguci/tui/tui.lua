#!/usr/bin/env lua5.3
tui_path="/usr/milis/ayguci/tui"
package.cpath = tui_path.."/?.so" .. ";".. package.cpath
package.path  = tui_path.."/?.lua"    .. ";".. package.path
local serpent = require('serpent')
local json = require('json')
local ms = require ("minisock")

track_menu=""
last_url="module/list"

function _err(msg)
	print("error:",msg)
	os.exit(1)
end

function start(request)
	sockpath = "/tmp/ayguci.sock"
	addr = "\1\0" .. sockpath .. "\0\0\0\0\0"
	if request then
	  req=request
	else
	  req = "module/list"
	end
	-- ensure server has enough time to start listening
	ms.msleep(50)

	sfd, msg = ms.connect(addr)
	if not sfd then _err("socket is not available") end
	
	-- write request to socket
	r, msg = ms.write(sfd, req)
	print("client sent: ".. sfd .. ":", req)
	-- get response from socket
	resp, msg = ms.read(sfd)
	print("client recv: ".. sfd .. ":", resp,":@:")
	
	--generate ui from response
	print("gelen ui:",serpent.line(json.decode(resp)["ui"]))
	local f = require('form')
	local ui_data={}
	if json.decode(resp).ui then
		ui_data=json.decode(resp).ui
	else
		print("hazır olmayan form")
		ui_data=f.msgbox
	end
	local ok, r, v,value  = xpcall(f.generate, debug.traceback,ui_data)
	if not ok then
	  print(r)
	  _err("form is not available")
	else
	  print("serialize:",serpent.line(value))
	  print("json:",json.encode(value))
	  --
	  print("r:",r)
	  print("v:",v:Text())
	  print("ok",ok)
	  --önce özel işlevli tuşlar işlenecek
	  if v:Text() == 'Exit' then
			ms.close(sfd)
			os.exit()
	  elseif v:Text() == 'Geri' then
			print("last:",last_url)
			start(last_url)
	  -- sonra post_url var mı bakılacak.
	  elseif next(value.post_url) ~= nil then
			-- modul listesi mi
			if value.modul then
				for _,e in pairs(ui_data) do
					if e.type=="list" then
					  track_menu=e.val[value.modul]
					end
				end
				last_url=value.post_url["modul"]
				start(value.post_url["modul"].." "..json.encode(value)) 
			-- işlev listesi mi
			elseif value.func then
				for _,e in pairs(ui_data) do
					if e.type=="list" then
					  track_menu=track_menu.."/"..e.val[value.func]
					end
				end
				--track_menu=track_menu.."/"..ui_data.val
				start(track_menu)	
			-- Aktif edilen düğme var mı
			elseif v:Text() then
				-- if there is redirecting url
				-- start new form recursively until value.post is not exist
				start(value.post_url[v:Text()].." "..json.encode(value))
			-- Liste olup seçilen var mı
			elseif next(value.post_url) ~= nil then
				-- if there is redirecting url
				-- start new form recursively until value.post is not exist
				local _,url = next(value.post_url)
				start(url.." "..json.encode(value))
			-- Belirsiz post
			else
				print("value.post_url içerik bulunamadı!")
				os.exit()
			end
	  --elseif v:Text() == 'Çıkış' or v:Text() == 'İptal' or v:Text() == 'Tamam'  then	
	  else
			ms.close(sfd)
			os.exit()
	  end
	end
	-- close socket
	r, msg = ms.close(sfd)
end

start(arg[1])


