--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy dostawcy pizzy.
]]--

addEvent("startTimerToEndJob", true)
addEventHandler("startTimerToEndJob", root, function(plr,jobCode,car)
if localPlayer == plr then
    if jobCode=="FastEats" then jobTimer = 20000; end -- 20sek
    jobTimer=setTimer(function()
	    triggerServerEvent("endPlayerJob",localPlayer,localPlayer,jobCode,car)
	end, jobTimer, 1) --- 540000
end
end)

addEvent("endTimerToEndJob", true)
addEventHandler("endTimerToEndJob", root, function(plr)
if localPlayer == plr then
    killTimer(jobTimer)
end
end)

addEventHandler("onClientRender", root, function()
	local vehicle = getPedOccupiedVehicle(localPlayer) or false
	if vehicle then
	    local vx,vy,vz=getElementVelocity(vehicle)
		local ograniczenie = getElementData(vehicle,"vehicle:ogranicznik") or 0;
		if not isVehicleOnGround(vehicle) then return end
		if tonumber(ograniczenie) > 0 then
		local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5) *1.0*180
		if actualspeed > ograniczenie then
			setElementVelocity(vehicle,vx*0.9,vy*0.9,vz*0.9)
			setElementVelocity(vehicle,vx*0.9,vy*0.9,vz*0.9)
		end
		end
	end
end)