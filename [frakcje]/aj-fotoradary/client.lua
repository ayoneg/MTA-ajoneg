
--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt fotoradarów.
]]--

local screenW, screenH = guiGetScreenSize()
local blysk = false
local zapisTICK = {}
local opacity = 255

function zakoncz()
	blysk = false
	opacity = 255
end

--==
local widocznosc = false
function zakonczinfo()
	widocznosc = false
end

addEventHandler("onClientRender", root, function()
	if blysk and localPlayer then
		if zapisTICK[localPlayer] and zapisTICK[localPlayer] > getTickCount() then
		else
			opacity = opacity - 25
			if opacity <= 0 then opacity = 0 end
			zapisTICK[localPlayer] = getTickCount() + 50
		end
		dxDrawRectangle((screenW - screenW) / 2, (screenH - screenH) / 2, screenW, screenH, tocolor(255, 255, 255, opacity), false)
	end
	
	
	if widocznosc then
		dxDrawText("Pojazd: "..vehname.."\nPrędkość: "..speed.." km/h\nKwota mandatu: "..money.."$", 1186 + 1, 480 + 1, 1444 + 1, 637 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "center", false, false, false, false, false)
		dxDrawText("Pojazd: #EBB85D"..vehname.."#ffffff\nPrędkość: #EBB85D"..speed.." km/h#ffffff\nKwota mandatu: #388E00"..money.."$#ffffff", 1186, 480, 1444, 637, tocolor(255, 255, 255, 255), 1.20, "default", "left", "center", false, false, false, true, false)
		dxDrawText("[FOTORADAR]", 1186 + 1, 480 + 1, 1444 + 1, 527 + 1, tocolor(0, 0, 0, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		dxDrawText("[FOTORADAR]", 1186, 480, 1444, 527, tocolor(255, 0, 0, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		dxDrawText("["..code.."#"..cash.."]", 1186 + 1, 590 + 1, 1444 + 1, 637 + 1, tocolor(0, 0, 0, 100), 1.00, "default", "right", "bottom", false, false, false, false, false)
		dxDrawText("["..code.."#"..cash.."]", 1186, 590, 1444, 637, tocolor(72, 68, 68, 100), 1.00, "default", "right", "bottom", false, false, false, false, false)
	end
end)

addEvent("fotoradar:info",true)
addEventHandler("fotoradar:info",root,function(plr,veh,spe,mon,cas,cod)
	if plr and localPlayer then
		if plr == localPlayer then
			vehname = veh
			speed = spe
			money = mon
			cash = cas
			code = cod
			widocznosc = true
			if isTimer(radar) then killTimer(radar) end
			radar = setTimer(zakonczinfo, 10500, 1)
		end
	end
end)

addEvent("fotoradar:blysk",true)
addEventHandler("fotoradar:blysk",root,function(gracz)
	if gracz and localPlayer then
		if gracz == localPlayer then
			blysk = true
			test = false
			setTimer(zakoncz, 1500, 1)
		end
	end
end)
