-----------------------------------------------------------------------------------------------------------------------------------------
-- vRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
fuN = {}
Tunnel.bindInterface("bclothes",fuN)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMPT
-----------------------------------------------------------------------------------------------------------------------------------------
function fuN.prompt(title,table)
	local source = source
    vRP.prompt(source, title, table)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function fuN.hasPermissions(perms)
	local source = source 
	local user_id = vRP.getUserId(source)
	if perms then 
		for k,perm in pairs(perms) do 
			if vRP.hasPermission(user_id, perm) then 
				return true 
			end
		end
	end
	return false
end