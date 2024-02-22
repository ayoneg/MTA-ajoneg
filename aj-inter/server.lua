--[[
SKRYPT INTERAKCJ AUUTA
]]--

addEvent("panel:silnik", true)
addEventHandler("panel:silnik", root, function(wartosc)
	 local veh = getPedOccupiedVehicle(source)
	 if not veh then return end
	 local paliwo = getElementData(veh,"vehicle:paliwo") or 0;
	 if wartosc == "true" then
	 if paliwo <= 0.01 then 
	 --outputChatBox("* Silnik pojazdu nie może odpalć.",source) 
	 outputChatWithDistance(source, "silnik pojazdu nie może odpalić.", 35)
	 return end
	 if getElementHealth(veh) <= 400 then
	 -- POBAWIMY SIE W RNG, CZY ODPALI CZY NIE :)
	 losujemy_engine = math.random(1,5);
	 if losujemy_engine == 1 then outputChatBox("* Silnik pojazdu nie odpala.",source) return end
	 if losujemy_engine == 2 then outputChatBox("* Silnik pojazdu nie odpala.",source) return end
     if losujemy_engine == 3 then outputChatBox("* Silnik pojazdu nie odpala.",source) return end
	 if losujemy_engine == 4 then outputChatBox("* Silnik pojazdu nie odpala.",source) return end
	 if losujemy_engine == 5 then
	      setVehicleEngineState(veh, true)
		  setElementData(veh,"vehicle:engineState",true)
		  setVehicleDamageProof(veh, false)
		  --outputChatBox("* Uruchomiono silnik pojazdu.",source)
		  outputChatWithDistance(source, "uruchamia silnik.", 35)
     end
	 else
	      setVehicleEngineState(veh, true)
		  setElementData(veh,"vehicle:engineState",true)
		  setVehicleDamageProof(veh, false)
		  --outputChatBox("* Uruchomiono silnik pojazdu.",source)
		  outputChatWithDistance(source, "uruchamia silnik.", 35)
	 end
     else
	 	  setVehicleEngineState(veh, false)
		  setElementData(veh,"vehicle:engineState",false)
		  --outputChatBox("* Zgaszono silnik pojazdu.",source)
		  outputChatWithDistance(source, "gasi silnik.", 35)
	 end
end)
-- RECZNY
addEvent("panel:reczny", true)
addEventHandler("panel:reczny", root, function(wartosc2)
	local veh=getPedOccupiedVehicle(source)
	local sx,sy,sz = getElementVelocity(veh)
	speed = (sx^2 + sy^2 + sz^2)^(0.5);
	kmh = speed*180;
	if kmh > 40 then outputChatBox("* Nie możesz tego wykonać podczas jazdy!!!",source,255,0,0,true) return end
	if kmh < 40 and kmh > 25 then 
		local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(veh)
		local losowanieopony = math.random(1,2);
		-- przebijam oponę
		if losowanieopony == 1 then setVehicleWheelStates(veh, frontLeft, 2, frontRight, 2) end
		if losowanieopony == 2 then setVehicleWheelStates(veh, 2, rearLeft, 2, rearRight) end
		return
	end
	if wartosc2 == "true" then
		setElementFrozen(veh,true)
		outputChatWithDistance(source, "zaciąga hamulec ręczny.", 35)
	else
		setElementFrozen(veh,false)
		outputChatWithDistance(source, "zwalnia hamulec ręczny.", 35)
	end
end)
-- LAMPKI
addEvent("panel:lampy", true)
addEventHandler("panel:lampy", root, function(wartosc2)
	 local veh = getPedOccupiedVehicle(source)
	 if wartosc2 == "true" then
	      setVehicleOverrideLights(veh, 1)
     else
	      setVehicleOverrideLights(veh, 2)
	 end
end)
--ZAMEK
addEvent("panel:zamek", true)
addEventHandler("panel:zamek", root, function(wartosc2)
	 local veh = getPedOccupiedVehicle(source)
	 if wartosc2 == "true" then
	      setVehicleLocked(veh, true)
		 -- outputChatBox("* Zablokowano zamek auta.",source)
		  outputChatWithDistance(source, "zablokował zamek w pojeździe.", 35)
		  setVehicleDoorOpenRatio(veh, 0, 0, 1400)
		  setVehicleDoorOpenRatio(veh, 1, 0, 1400)
		  setVehicleDoorOpenRatio(veh, 2, 0, 1400)
		  setVehicleDoorOpenRatio(veh, 3, 0, 1400)
		  setVehicleDoorOpenRatio(veh, 4, 0, 1400)
		  setVehicleDoorOpenRatio(veh, 5, 0, 1400)
     else
	      setVehicleLocked(veh, false)
		  --outputChatBox("* Odblokowano zamek auta.",source)
		  outputChatWithDistance(source, "odblokował zamek w pojeździe.", 35)
	 end
end)
--MASKA
addEvent("panel:maska", true)
addEventHandler("panel:maska", root, function(wartosc2)
	 local veh = getPedOccupiedVehicle(source)
	 if wartosc2 == "true" then
		  setVehicleDoorOpenRatio(veh, 0, 1, 1400)
     else
		  setVehicleDoorOpenRatio(veh, 0, 0, 1400)
	 end
end)
--MASKA
addEvent("panel:bagaznik", true)
addEventHandler("panel:bagaznik", root, function(wartosc2)
	 local veh = getPedOccupiedVehicle(source)
	 if wartosc2 == "true" then
	     setVehicleDoorOpenRatio(veh, 1, 1, 1400)
     else
	     setVehicleDoorOpenRatio(veh, 1, 0, 1400)
	 end
end)

addEvent("panel:wysadz", true)
addEventHandler("panel:wysadz", root, function(plr)
local veh = getPedOccupiedVehicle(plr)
local sx,sy,sz = getElementVelocity(veh)
speed = (sx^2 + sy^2 + sz^2)^(0.5);
kmh = speed*180;
if kmh > 1 then outputChatBox("* Nie możesz tego wykonać podczas jazdy!!!",source) return end
    for i, player in pairs(getVehicleOccupants(veh)) do
        if i ~= 0 then
			local plr_dwa = getElementData(player,"player:dbid") or 0;
			if plr_dwa > 0 then
            	--setControlState(p, 'enter_exit', true);
--				setControlState(p, 'enter_exit', true)
				setControlState(player, 'enter_exit', true)
			end
        end
    end
setTimer(function()
    for i, player in pairs(getVehicleOccupants(veh)) do
        if i ~= 0 then
			local plr_dwa = getElementData(player,"player:dbid") or 0;
			if plr_dwa > 0 then
            	--setControlState(p, 'enter_exit', true);
				x,y,z = getElementPosition(player)
				removePedFromVehicle(player)
				setElementPosition(player, x,y,z+1)
--				outputChatBox("id: "..i,root)
			end
        end
    end
end, 2300, 1)
--outputChatWithDistance(source, "wysadza .", 35)
end)

addEvent("localInfoChat", true)
addEventHandler("localInfoChat", root, function(plr,text,obszar)
    outputChatWithDistance(plr,text,obszar)
end)

function getElementsWithinDistance(element, type, distance)
	local myPos = {getElementPosition(element)}
	local elements = {}
	for i,v in pairs(getElementsByType(type), true) do
		local vPos = {getElementPosition(v)}
		local dist = getDistanceBetweenPoints3D(myPos[1], myPos[2], myPos[3], vPos[1], vPos[2], vPos[3])
		if dist <= distance then
			table.insert(elements, v)
		end
	end
	return elements
end

function outputChatWithDistance(player, text, distance)
	local inShape = getElementsWithinDistance(player, 'player', distance)
	for i,v in pairs(inShape) do
		if (getElementData(player,"kominiarka") == false or getElementData(player,"kominiarka") == nil and getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v)) then
			outputChatBox('#e7d9b0* '..getPlayerName(player):gsub("#%x%x%x%x%x%x","")..' '..text, v, 255, 255, 255, true)
		end
	end
end