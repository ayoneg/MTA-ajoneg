--[[
SKRYPT INTERAKCJ AUUTA
]]--

-- prm radia na 0
addEventHandler("onClientRender", root, function()
setRadioChannel(0)
end)


local screenW, screenH = guiGetScreenSize()
-- ROWERY
local cx = {
    [509]=true,
    [481]=true,
    [510]=true
}

-- LISTA KAT L+H
local KatLH = {[592]=true,[577]=true,[511]=true,[512]=true,[593]=true,[520]=true,[553]=true,[476]=true,[519]=true,[460]=true,[513]=true,[548]=true,[425]=true,[417]=true,[487]=true,[488]=true,[497]=true,[563]=true,[447]=true,[447]=true,[469]=true,}
--// GRACZ
gracz = localPlayer;

function gui_veh()
    --// ZAPIS
    veh_opt = getElementData(gracz,"wb") or "false";
	if veh_opt ~= "false" then 
    local veh = getPedOccupiedVehicle(gracz) or "false";
	if veh ~= "false" then 
	local sx,sy,sz = getElementVelocity(veh)
	speed = (sx^2 + sy^2 + sz^2)^(0.5);
	kmh = speed*180;
	
	local salon = getElementData(veh,"vehicle:salon") or false;
	local owner = getElementData(veh,"vehicle:owner") or "Serwer";

-- LISTA KTORA POJAWI SIE NA PANELU
--   veh_= varotosc FALSe ---------- veh_2 wartosc TRUE
local vehpanel={
{veh_=":aj-inter/car/wl_lampy.png",veh_2=":aj-inter/car/w_lampy.png"},
{veh_=":aj-inter/car/w_silnik.png",veh_2=":aj-inter/car/u_silnik.png"},
{veh_=":aj-inter/car/zw_reczny.png",veh_2=":aj-inter/car/z_reczny.png"},
{veh_=":aj-inter/car/o_zamek.png",veh_2=":aj-inter/car/z_zamek.png"},
{veh_=":aj-inter/car/z_maska.png",veh_2=":aj-inter/car/o_maska.png"},
{veh_=":aj-inter/car/z_bagaznik.png",veh_2=":aj-inter/car/o_bagaznik.png"},
{veh_=":aj-inter/car/pasazerowie.png",veh_2=":aj-inter/car/pasazerowie.png"},
}
-- tabela dla podgladu
local vepanel={
[1]=":aj-inter/car/lampy.png",
[2]=":aj-inter/car/silnik.png",
[3]=":aj-inter/car/reczny.png",
[4]=":aj-inter/car/zamek.png",
[5]=":aj-inter/car/maska.png",
[6]=":aj-inter/car/bagaznik.png",
[7]=":aj-inter/car/pasazerowie.png",
}
    --fro first table


    --general_backgound = guiCreateStaticImage(0.34, 0.94, 0.32, 0.05, ":prz2/background1.png", true)
    --general_desc = guiCreateStaticImage(0.02, 0.19, 0.97, 0.63, vehpanel[veh_opt], true, general_backgound)

	-- GENERUJEMY GRAFIKE
--	dxDrawImage(screenW * 0.3411, screenH * 0.9250, screenW * 0.3177, screenH * 0.0500, ":aj-inter/background1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(screenW * 0.3698, screenH * 0.8454, screenW * 0.2609, screenH * 0.0426, ":aj-inter/background1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
--    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, ":aj-inter/car/w_silnik.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	
	--all chodzi
	--dxDrawImage(screenW * 0.3411, screenH * 0.9250, screenW * 0.3177, screenH * 0.0500, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)

	--all (nie) chodzi
	--dxDrawImage(screenW * 0.3411, screenH * 0.9250, screenW * 0.3177, screenH * 0.0500, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)

	if veh_opt == 1 then
	if getVehicleOverrideLights(veh) ~= 2 then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 2 then
	if getVehicleEngineState(veh) == true then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 3 then
	if isElementFrozen(veh) == true then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 4 then
	if isVehicleLocked(veh) == true then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 5 then
	if getVehicleDoorOpenRatio(veh,0) == 1 then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 6 then
	if getVehicleDoorOpenRatio(veh,1) == 1 then 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else 
    dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	end
	
	if veh_opt == 7 then
	dxDrawImage(screenW * 0.3693, screenH * 0.8454, screenW * 0.2615, screenH * 0.0426, vehpanel[veh_opt].veh_, 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end

	
	-- screenW * 0.3411, screenH * 0.9250, screenW * 0.3177, screenH * 0.0500 ////zap
	
	--dxDrawText("Sterowanie panelem: UP oraz DOWN @ by AjonEG", screenW * 0.3411, screenH * 0.9769, screenW * 0.5552, screenH * 0.9907, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	local counter = 0
	for seat, player in pairs(getVehicleOccupants(veh)) do counter = counter + 1; end
	if kmh > 20 then setElementData(gracz,"max",4) else if counter > 1 then setElementData(gracz,"max",7) else setElementData(gracz,"max",6) end end
	
	if owner=="Serwer" then setElementData(gracz,"max",3) end
	if salon==true then setElementData(gracz,"max",2) end

    --if kmh > 20 and  getElementData(gracz,"max") == 4 then return end
	if veh_opt+1 > getElementData(gracz,"max") then else
    dxDrawImage(screenW * 0.3969, screenH * 0.8037, screenW * 0.2068, screenH * 0.0324, ":aj-inter/background1.png", 0, 0, 0, tocolor(255, 255, 255, 122), false)
	dxDrawImage(screenW * 0.3964, screenH * 0.8046, screenW * 0.2073, screenH * 0.0315, vepanel[veh_opt+1], 0, 0, 0, tocolor(255, 255, 255, 177), false)
	end
	
	if veh_opt-1 < 1 then else
    dxDrawImage(screenW * 0.3969, screenH * 0.8972, screenW * 0.2068, screenH * 0.0324, ":aj-inter/background1.png", 0, 0, 0, tocolor(255, 255, 255, 122), false)
    dxDrawImage(screenW * 0.3964, screenH * 0.8981, screenW * 0.2073, screenH * 0.0315, vepanel[veh_opt-1], 0, 0, 0, tocolor(255, 255, 255, 177), false)
	end
	
	
--    dxDrawImage(screenW * 0.3839, screenH * 0.8787, screenW * 0.2323, screenH * 0.0370, ":aj-inter/background1.png", 0, 0, 0, tocolor(255, 255, 255, 100), false)
--    dxDrawImage(screenW * 0.3953, screenH * 0.8843, screenW * 0.2099, screenH * 0.0259, vepanel[veh_opt+1], 0, 0, 0, tocolor(255, 255, 255, 100), false)

	
	--setElementData(gracz,"max",6)
	end
	end
end


function wb1(key,state)
	if state == "down" then
		if getElementData(gracz,"wb") == 1 then return end
		setElementData(gracz,"wb",getElementData(gracz,"wb")-1)
		if getElementData(gracz,"wb") == 1 then setElementData(gracz,"wb",1) end
	end
end
function wb2(key,state)
	if state == "down" then
		if getElementData(gracz,"wb") == getElementData(gracz,"max") then return end
		setElementData(gracz,"wb",getElementData(gracz,"wb")+1)
		if getElementData(gracz,"wb") >= 7 then setElementData(gracz,"wb",7) end
	end
end


function showint(value)
	local veh = getPedOccupiedVehicle(gracz)
	if veh and getVehicleController(veh) == gracz then
	-- rower odpalamy od razu :)
		if cx[getElementModel(veh)] then setVehicleEngineState(veh, true) return end
		if value == true then
		gocheck = getElementData(gracz,"wb") or "false";
		--if gocheck ==
			addEventHandler("onClientRender",root,gui_veh)
			bindKey("arrow_d","both",wb1)
			bindKey("arrow_u","both",wb2)
			bindKey("mouse_wheel_down","both",wb1)
			bindKey("mouse_wheel_up","both",wb2)
		elseif value == false then
			removeEventHandler("onClientRender",root,gui_veh)
			unbindKey("arrow_d","both",wb1)
			unbindKey("arrow_u","both",wb2)
			unbindKey("mouse_wheel_down","both",wb1)
			unbindKey("mouse_wheel_up","both",wb2)
		end
	end
end

bindKey("lshift", "both", function(key,state)
	if state == "down" then
		showint(true)
		setElementData(localPlayer,"player:GUIblock",true)
		setElementData(gracz,"wb",1) --// STOKOWA WARTOSC
	elseif state == "up" then
		sellect()
		setElementData(localPlayer,"player:GUIblock",false)
		showint(false)
	end
end)

function fexit(plr,seat)
	if plr ~= gracz then return end
	if seat ~= 0 then return end
	removeEventHandler("onClientRender",root,gui_veh)
	unbindKey("arrow_u","both",wybor1)
	unbindKey("arrow_d","both",wybor2)
	unbindKey("mouse_wheel_down","both",wb1)
	unbindKey("mouse_wheel_up","both",wb2)
	--setElementData(gracz,"wb","0")
end
addEventHandler("onClientVehicleStartExit",root,fexit)
addEventHandler("onClientVehicleExit",root,fexit)

function fexit_dead(plr,seat)
	if plr ~= gracz then return end
	if seat ~= 0 then return end
	removeEventHandler("onClientRender",root,gui_veh)
	unbindKey("arrow_u","both",wybor1)
	unbindKey("arrow_d","both",wybor2)
	unbindKey("mouse_wheel_down","both",wb1)
	unbindKey("mouse_wheel_up","both",wb2)
	--setElementData(gracz,"wb","0")
end
addEventHandler("onClientVehicleStartEnter",root,fexit_dead)
addEventHandler("onClientVehicleEnter",root,fexit_dead)

function sellect()
	local gthis = getElementData(gracz,"wb")
	local veh = getPedOccupiedVehicle(gracz)
	if not veh then return end
	if veh and getVehicleController(veh) == gracz then
    
	--// LAMPY
	if gthis == 1 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if getVehicleOverrideLights(veh) ~= 2 then
	      triggerServerEvent("panel:lampy", gracz, "false")
	 else
	      setVehicleOverrideLights(veh, 1)
		  triggerServerEvent("panel:lampy", gracz, "true")
	 end
	end
	--// SILNIK
	if gthis == 2 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if getVehicleEngineState(veh) == true then
          triggerServerEvent("panel:silnik", gracz, "false")
	 else
		  triggerServerEvent("panel:silnik", gracz, "true")
	 end
	end
	--// RECZNY
	if gthis == 3 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if KatLH[getElementModel(veh)] == true then
         if isVehicleOnGround(veh) == false then return end
	 end 
	 if isElementFrozen(veh) == true then
		  triggerServerEvent("panel:reczny", gracz, "false")
	 else
		  triggerServerEvent("panel:reczny", gracz, "true")
	 end
	end
	--// ZAMEK
	if gthis == 4 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if isVehicleLocked(veh) == true then
		  triggerServerEvent("panel:zamek", gracz, "false")
	 else
		  triggerServerEvent("panel:zamek", gracz, "true")
	 end
	end
	--// maska
	if gthis == 5 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if getVehicleDoorOpenRatio(veh,0) == 1 then
		  triggerServerEvent("panel:maska", gracz, "false")
	 else
		  triggerServerEvent("panel:maska", gracz, "true")
	 end
	end
	--// bagaznik
	if gthis == 6 then 
     local veh=getPedOccupiedVehicle(gracz)
	 if getVehicleDoorOpenRatio(veh,1) == 1 then
		  triggerServerEvent("panel:bagaznik", gracz, "false")
	 else
		  triggerServerEvent("panel:bagaznik", gracz, "true")
	 end
	end
	--// wysadz
	if gthis == 7 then 
    local veh = getPedOccupiedVehicle(gracz)
	triggerServerEvent("panel:wysadz", gracz, gracz)
	end
	
	end
end



