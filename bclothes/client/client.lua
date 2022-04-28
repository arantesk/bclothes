-----------------------------------------------------------------------------------------------------------------------------------------
-- vRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
funS = Tunnel.getInterface("bclothes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local components = { 
    ["mascara"] = 1, ["maos"] = 3, ["calca"] = 4, ["mochila"] = 5, ["sapatos"] = 6, ["acessorios"] = 7, 
    ["blusa"] = 8, ["colete"] = 9, ["adesivo"] = 10, ["jaqueta"] = 11, ["chapeu"] = "p0", ["oculos"] = "p1" 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vroupas", function()
    local custom = vRP.getCustomization(source)
    local table = ""
    for component,_ in pairs(custom) do
        for model,draw in pairs(components) do 
            if component == draw then 
                table = table..model.." "..custom[component][1].."; "
            end
        end
    end
	funS.prompt("Etiquetas de suas roupas :",table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 2000
		local ped = PlayerPedId()
		for component,_ in pairs(cfg["bclothes"]) do 
			for draw,table in pairs(cfg["bclothes"][component]) do 
				if type(components[component]) == "number" then 
					if GetPedDrawableVariation(ped,components[component]) == draw then 
						SetPedVariation(ped, components[component], draw, table)
					end
				end

				if type(components[component]) == "string" then 
					if GetPedPropIndex(ped, parseInt(components[component]:gsub("p",""))) == draw then 
						SetPedVariation(ped, parseInt(components[component]:gsub("p","")), draw, table, true)
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPEDVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPedVariation(ped, component, draw, table, prop)
	for k,v in pairs(table["models"]) do 
		if GetPedModel(ped) == v then 
			if funS.hasPermissions(table["perms"]) then 
				return 
			end
		end
	end

	if prop then
		SetPedPropIndex(ped,component,draw+1,0,2) 
	else 
		SetPedComponentVariation(ped,component,draw+1,0,2) 
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPEDMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPedModel(ped)
	if IsPedModel(ped, "mp_m_freemode_01") then
		return "male"
	else
		return "female"
	end
end