local time=getTickCount()

function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=speed*180
	kmh = tonumber(math.floor(kmh));
	return kmh
end


function getVehicleRPM(vehicle)
    local vehicleRPM = 0
    if (vehicle) then
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            end
        else
            vehicleRPM = 0
        end

        return tonumber(vehicleRPM)
    else
        return 0
    end
end

local function spr(veh)
if isElement(veh) then
	if getTickCount()-time>5000 then
		time = getTickCount()
		local kierowca = getVehicleOccupant(veh,0) or false;
		if kierowca ~= localPlayer then return end
		local paliwo = getElementData(veh, "vehicle:paliwo") or 0;
		local przebieg = getElementData(veh, "vehicle:przebieg") or 0;
		local vx,vy,vz = getElementVelocity(veh);
		local kmh = ((vx^2 + vy^2 + vz^2)^(0.5)/2);
		if kmh > 0 then
			-- spalanie wzgledem RPM silnika
			local RPM = getVehicleRPM(veh)
			local RPM = string.format("%.4f", RPM*0.001)
			local RPM = RPM/100;
			-- dodaje mase
			local hand = getVehicleHandling(veh)
			local mass = hand.mass*0.00001 -- 
			if mass > 0.4 then mass=0.4 end
			-- eco drive (premium)
			local eco = getElementData(kierowca,"player:premium") or 0;
			if eco==1 then
				RPM = RPM*0.10 -- eco 10%
--				RPM = (RPM+mass)*0.10 -- eco 10% ver 2.0 [spalanie nie dziala dobrze]
			elseif eco==2 then
				RPM = RPM*0.20 -- eco 20%
--				RPM = (RPM+mass)*0.20 -- eco 20% ver 2.0 [spalanie nie dziala dobrze]
			end
			RPM = paliwo-(RPM+mass)
--			RPM = paliwo-RPM -- ver 2.0 [spalanie nie dziala dobrze]
			setElementData(veh, "vehicle:paliwo", RPM);
			przebieg = przebieg+(kmh);
			setElementData(veh, "vehicle:przebieg", przebieg);
		end
	end
end
end

addEventHandler("onClientRender", root, function()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	if getElementModel(vehicle) == 509 or getElementModel(vehicle) == 481 or getElementModel(vehicle) == 510 then return end
	if not getVehicleEngineState(vehicle) then return end
	local kierowca = getVehicleOccupant(vehicle,0) or "brak";
	if kierowca ~= localPlayer then return end	
	-- DODAJEMY ZMIENNE --
	wez_paliwo = getElementData(vehicle,"vehicle:paliwo");
	wez_przebieg = getElementData(vehicle,"vehicle:przebieg");	
	-- SPRAWDZAMY --
	if wez_paliwo or wez_przebieg then
		spr(vehicle);
		if getElementData(vehicle,"vehicle:paliwo") <= 0.01 then
			outputChatBox("* Silnik nagle się wyłączył."); 
			setElementData(vehicle,"vehicle:paliwo",0)
			setVehicleEngineState(vehicle, false);
		end
	end	
end)










