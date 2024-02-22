--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy holiwników publicznych.
]]--
local antycheat = {}

addEvent("startJobTimerHolo", true)
addEventHandler("startJobTimerHolo", root, function(plr)
if localPlayer == plr then
	if isTimer(holorefresh) then return end
		holorefresh=setTimer(function()
			triggerServerEvent("odswiezamPojazduHolowane",localPlayer,localPlayer)
		end, 7000, 0) --- 7 sek
	end
end)

addEvent("endJobTimerHolo", true)
addEventHandler("endJobTimerHolo", root, function(plr)
	if localPlayer == plr then
		if isTimer(holorefresh) then killTimer(holorefresh) end
	--	killTimer(holorefresh)
	end
end)

function contrup()
	local vehicle = getPedOccupiedVehicle(localPlayer) or false
	if vehicle then
		local kiero = getVehicleOccupant(vehicle) or false
		if kiero == localPlayer then
			local shape = getElementData(vehicle,"vehicle:colshape") or false
			if shape then
				local pojazdy = getElementsWithinColShape(shape, "vehicle")
				if #pojazdy > 1 or #pojazdy < 1 then return end
				attachTrailerToVehicle(vehicle, pojazdy[1]) -- attach them
			end
		end
	end
	antycheat[localPlayer] = getTickCount()+500;
end

function test()
	if antycheat[localPlayer] and getTickCount() < antycheat[localPlayer] then return end
	if getControlState(localPlayer, "special_control_up") then -- getControlState(localPlayer, "special_control_up") // getAnalogControlState("special_control_up") == 1
		if isTimer(holoattach) then return end
		setTimer(contrup,1,500)
	end
	if getControlState(localPlayer, "special_control_down") then -- getControlState(localPlayer, "special_control_down") // getAnalogControlState("special_control_down") == 1
		--antycheat[localPlayer] = getTickCount()+500;
	end
end
addEventHandler("onClientRender",root,test)
