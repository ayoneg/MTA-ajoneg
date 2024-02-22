--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt stacji paliw.
]]--
local gracz = false
local cena = 0
local pokaz = false
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender",root,function()
	if gracz ~= localPlayer then return end
	if pokaz then
		local cena = string.format("%.2f", cena/100)
		local veh = getPedOccupiedVehicle(gracz) or false;	
		if veh then
			local paliwo = tonumber(getElementData(veh,"vehicle:paliwo") or 0);
			local paliwo = string.format("%.1f", paliwo)
		
			local fontsize = 1.37;		
			dxDrawText("Ⓘ Aktualna cena: "..cena.."$ za litr.\n\n(space - tankowanie)", (screenW * 0.3182) + 1, (screenH * 0.6833) + 1, (screenW * 0.6818) + 1, (screenH * 0.7028) + 1, tocolor(0, 0, 0, 255), fontsize, "default", "center", "center", false, false, false, false, false)
			dxDrawText("#7AB4EAⒾ #ffffffAktualna cena: #388E00"..cena.."$#ffffff za litr.\n\n#808080(space - tankowanie)", screenW * 0.3182, screenH * 0.6833, screenW * 0.6818, screenH * 0.7028, tocolor(255, 255, 255, 255), fontsize, "default", "center", "center", false, false, false, true, false)
		end
	end
end)
	
function pok(plr,cost)
	gracz = plr
	cena = cost
end
	
addEvent("cpn:panel",true)
addEventHandler("cpn:panel",root,function(plr,cost)
if plr == localPlayer then
	if not pokaz then
		pok(plr,cost)
		pokaz = true
	else
		pokaz = false
	end
end
end)

--pokaz()