

util = {}
util.string = {}


function util.get_content(filename)
	local f = assert(io.open(filename, "r"))
	local t = f:read('*all')
	f:close()
	return t
end

function util.shell(command)
	local handle=io.popen(command.." 2>&1")
	local result=handle:read('*all')
	handle:close()
	-- komut çıktısı sonu yeni satır karakterin silinmesi - en sondaki \n
	if result:sub(-1) == "\n" then
		--result=result:gsub("\n", "")
		result=result:sub(1,-2)
	end
	return result
end

function util.check_command(command)
	local check_cmd="LC_ALL=C type %s"
	local state=util.shell(check_cmd:format(command))
	if state:find("not found") then
		return nil
	end
	return 1
end

function util.string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

return util
