--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pojazdów publicznych.
]]--

local location = {
	{1890, 2436, 10.9, -90},
	{1890, 2434, 10.9, -90},
	{1890, 2432, 10.9, -90},
	{1890, 2430, 10.9, -90},
	{1890, 2428, 10.9, -90},	
	--um lv
	{2503, 1001, 10.4, 90},
	{2503, 999, 10.4, 90},
	{2503, 997, 10.4, 90},	
	--bank lv
	{2441, 2342, 10.4, 90},
	{2441, 2340, 10.4, 90},
	{2441, 2338, 10.4, 90},	
	--FC przecho
	{-37, 1181, 19.1, -90},
	{-37, 1183, 19.1, -90},
	{-37, 1185, 19.1, -90},
	{-37, 1187, 19.1, -90},
	--mech LV
	{1052, 1789, 10.4, -90},
	{1052, 1787, 10.4, -90},
	{1052, 1785, 10.4, -90},
	--dune LV
	{1064, 1385, 10.4, 180},
	{1062, 1385, 10.4, 180},
	{1060, 1385, 10.4, 180},
	{1058, 1385, 10.4, 180},
	--prawko C LV
	{1654, 945, 10.4, 0},
	{1652, 945, 10.4, 0},
	{1650, 945, 10.4, 0},
	{1648, 945, 10.4, 0},
	--gielda LV
	{1635, 1824, 10.4, 0},
	{1633, 1824, 10.4, 0},
	{1631, 1824, 10.4, 0},
	{1629, 1824, 10.4, 0},
	--taxo LV
	{2823, 1992, 10.4, -90},
	{2823, 1994, 10.4, -90},
	{2823, 1996, 10.4, -90},
}

local vehs = {
	[510]=true,
	[509]=true,
	[481]=true,
}

local bikes = {}
local blips = {}

function resetBIKES()
	for i,v in pairs(location) do
		if not bikes[i] then
			
			local losrower = math.random(1,3)
			if losrower==1 then 
				veh_id = 510;
				vel = 47;
			elseif losrower==2 then
				veh_id = 509;
				v[3] = v[3] - 0.1;
				vel = 35;
			else
				veh_id = 481;
				v[3] = v[3] - 0.1;
				vel = 35;
			end

			local veh = createVehicle(veh_id, v[1], v[2], v[3], 0, 0, v[4]);
			if not blips[i] then
				local blip = createBlip(v[1], v[2], v[3], 0, 1, 230, 204, 255, 88, -1, 220)
				blips[i] = true;
			end
			
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:spawnID", i)
			setElementData(veh,"vehicle:paliwo", 0)
			setElementData(veh,"vehicle:przebieg", 90430)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:zapelnienie", 0)
			setElementData(veh,"vehicle:salon",true)
			setElementData(veh,"vehicle:vopis","Publiczny")
			setVehicleColor(veh, math.random(0,255), math.random(0,255), math.random(0,255), 255, 255, 255)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
			setVehicleHandling(veh, "maxVelocity", vel)
			bikes[i] = true;
		end
	end
end

function startBIKEStimer()
	if isTimer(bikestimer) then return end
	bikestimer=setTimer(resetBIKES, 10000, 1)
end


function enterBIKE(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local mid = getElementModel(source) or false;
		if vehs[mid] then
			setElementData(source,"vehicle:salon",false)
			setElementFrozen(source, false)
			setVehicleEngineState(source, true)
			
			local gbid = getElementData(source,"vehicle:spawnID") or false;
			if gbid then
				bikes[gbid] = false;
				startBIKEStimer()
			end
		end
	end
end
addEventHandler("onVehicleEnter", root, enterBIKE)

function exitBIKE(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local mid = getElementModel(source) or false;
		if vehs[mid] then
			local gbid = getElementData(source,"vehicle:spawnID") or false;
			if gbid then
				removeElementData(source,"vehicle:spawnID")
			end
		end
	end
end
addEventHandler("onVehicleExit", root, exitBIKE)

addEventHandler("onResourceStart", root, startBIKEStimer)