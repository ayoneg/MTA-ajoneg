--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt frakcji SAPD beta.
]]--

local testowy = {}
local tims = {}
local trufals = {}


addEventHandler("onElementDataChange",root,function(eleData, _)
	if getElementType(source) ~= "vehicle" then return end
	if eleData == "vehicle:lightSirens" then
		local getData = getElementData(source,eleData)
		if getData == true then
			tims[source] = 100
			local kiero = getVehicleOccupant(source) or false;
			if kiero==client then
				testowy[source] = setTimer(timerStt, 200, 0, source)
			end
		else
			if isTimer(testowy[source]) then killTimer(testowy[source]) end
			sirensON(source,3)
			setVehicleHeadLightColor(source,255,255,255)
		end
	end
end)

addEventHandler("onElementDestroy",root,function()
	if getElementType(source) ~= "vehicle" then return end
	local getData = getElementData(source,"vehicle:lightSirens")
	if getData == true then
		if isTimer(testowy[source]) then killTimer(testowy[source]) end
		setVehicleHeadLightColor(source,255,255,255)
	end
end)


function timerStt(veh)
	if isElement(veh) then
    local times = tims[veh];
	local xxtte3 = trufals[veh];	
	if xxtte3 then
		trufals[veh] = false
		--setVehicleHeadLightColor(veh,0,0,255)
		setVehicleHeadLightColor(veh,255,255,255)
	else
		trufals[veh] = true
		--setVehicleHeadLightColor(veh,177,0,0)
		setVehicleHeadLightColor(veh,255,255,255)
	end	
	if times >= 0 and times < 43 then
		if xxtte3 then
			sirensON(veh,1)
		else
			sirensON(veh,2)
		end
		if times == 0 then 
			tims[veh] = 89
			trufals[veh] = false
			return
		end
	elseif times >= 43 and times < 50 then
		if xxtte3 then
			sirensON(veh,3)
			--setVehicleHeadLightColor(veh,177,0,0)
			setVehicleHeadLightColor(veh,255,255,255)
		else
			sirensON(veh,3)
			--setVehicleHeadLightColor(veh,0,0,255)
			setVehicleHeadLightColor(veh,255,255,255)
		end
	elseif times >= 50 and times < 90 then
		if xxtte3 then
			sirensON(veh,2)
		else
			sirensON(veh,1)
		end
	elseif times >= 90 then
		setVehicleHeadLightColor(veh,255,255,255)
		if xxtte3 then
			sirensON(veh,3)
		else
			sirensON(veh,4)
		end
	end
	local times = times - 1
	tims[veh] = tonumber(times)
	end
end

function sirensON(veh,var)
if isElement(veh) then
	if tonumber(var)==1 then
		-- left
		setVehicleLightState(veh, 3, 1)
		setVehicleLightState(veh, 0, 1)
		setVehicleLightState(veh, 2, 0)
		setVehicleLightState(veh, 1, 0)	
	elseif tonumber(var)==2 then
		--right
		setVehicleLightState(veh, 3, 0)
		setVehicleLightState(veh, 0, 0)
		setVehicleLightState(veh, 2, 1)
		setVehicleLightState(veh, 1, 1)
	elseif tonumber(var)==3 then
		--all
		setVehicleLightState(veh, 3, 0)
		setVehicleLightState(veh, 0, 0)	
		setVehicleLightState(veh, 2, 0)
		setVehicleLightState(veh, 1, 0)	
	elseif tonumber(var)==4 then
		--all
		setVehicleLightState(veh, 3, 1)
		setVehicleLightState(veh, 0, 1)	
		setVehicleLightState(veh, 2, 1)
		setVehicleLightState(veh, 1, 1)	
	end
end
end