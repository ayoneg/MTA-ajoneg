--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt przechowywalni pojazdów.
]]--

addEventHandler("onVehicleExit", root, function(plr,seat)
    if seat ~= 0 then return end 
	if source then
--	if isVehicleLocked(source) == true then cancelEvent() return end
	-- TUTAJ DODAC ZAPIS AUTA
	-- TUTAJ DODAC ZAPIS AUTA
   	setVehicleEngineState(source, false)
	setVehicleDamageProof(source, true)
	
	--// last kierowca
	veh_id = getElementData(source,"vehicle:id") or 0;
	if tonumber(veh_id) > 0 and tonumber(veh_id) < 1000000 then
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_vehicle_driver SET driver_nickname='"..getPlayerName(plr).."', driver_carid='"..veh_id.."', driver_czas='"..(os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S")).."'");
	end
	
	triggerClientEvent(plr, "testtrigger22", plr, "wysiada")
	end
end)

addEventHandler("onVehicleEnter", root, function(plr,seat)
    if seat ~= 0 then return end
	if source then
	setVehicleEngineState(source, false)
	-- offanie silnika
	setVehicleDamageProof(source, false)
	setElementData(source,"vehicle:odznaczone",false)
	setElementData(source,"vehicle:testtest","false");
	--setElementData(source,"vehicle:driver",getPlayerName(plr))
	triggerClientEvent(plr, "testtrigger", plr, "wsiada")
	end
end)


addEventHandler ( "onVehicleEnter", getRootElement(), function(thePlayer, seat, jacked) 
	if seat==0 then
		if (getVehicleDoorState(source,2)==0) then
		    setVehicleDoorState(source,2,1)
		    setVehicleDoorState(source,2,0)
		end
	elseif seat==1 then
		if (getVehicleDoorState(source,3)==0) then
		    setVehicleDoorState(source,3,1)
		    setVehicleDoorState(source,3,0)
		end
	else
		    setVehicleDoorState(source,4,1)
		    setVehicleDoorState(source,4,0)
		    setVehicleDoorState(source,5,1)
		    setVehicleDoorState(source,5,0)
	end
end)


addEventHandler("onVehicleStartExit", root, function(plr,seat)
    if seat ~= 0 then return end
	if isVehicleLocked(source) == true then 
	    outputChatBox("* Zamek pojazdu jest zamknięty.",plr)
	    cancelEvent() 
	    return 
	end
	setElementData(source,"vehicle:testtest","true")
	
end)

-- SPRAWDZANIE WLASCICIELA AUTA <3

-- LISTA AUT NA KAT A
KatA = { [581]=true,[462]=true,[521]=true,[463]=true,[463]=true,[522]=true,[461]=true,[448]=true,[468]=true,[586]=true,[523]=true,}

-- LISTA AUT NA KAT B
KatB = { [602]=true,[496]=true,[401]=true,[518]=true,[527]=true,[589]=true,[419]=true,[587]=true,[533]=true,[526]=true,[474]=true,[545]=true,[517]=true,[410]=true,[600]=true,[436]=true,[439]=true,[549]=true,[491]=true,[445]=true,[604]=true,[507]=true,[585]=true,[466]=true,[492]=true,[546]=true,[551]=true,[516]=true,[467]=true,[426]=true,[547]=true,[405]=true,[580]=true,[409]=true,[550]=true,[566]=true,[540]=true,[421]=true,[529]=true,[416]=true,[490]=true,[470]=true,[596]=true,[598]=true,[599]=true,[597]=true,[531]=true,[459]=true,[422]=true,[482]=true,[605]=true,[572]=true,[530]=true,[418]=true,[482]=true,[413]=true,[440]=true,[543]=true,[583]=true,[478]=true,[554]=true,[579]=true,[400]=true,[404]=true,[489]=true,[505]=true,[479]=true,[442]=true,[458]=true,[536]=true,[575]=true,[534]=true,[567]=true,[535]=true,[576]=true,[412]=true,[402]=true,[542]=true,[603]=true,[475]=true,[429]=true,[541]=true,[415]=true,[480]=true,[562]=true,[565]=true,[434]=true,[494]=true,[502]=true,[503]=true,[411]=true,[559]=true,[561]=true,[560]=true,[506]=true,[451]=true,[558]=true,[555]=true,[477]=true,[568]=true,[424]=true,[504]=true,[457]=true,[483]=true,[508]=true,[571]=true,[500]=true,[444]=true,[556]=true,[557]=true,[471]=true,[495]=true,[539]=true,[485]=true,[438]=true,[420]=true,[525]=true,[552]=true,[574]=true,}

-- LISTA AUT NA KAT C
KatC = { [433]=true,[427]=true,[428]=true,[407]=true,[544]=true,[601]=true,[428]=true,[499]=true,[609]=true,[498]=true,[524]=true,[578]=true,[486]=true,[573]=true,[455]=true,[588]=true,[403]=true,[423]=true,[414]=true,[443]=true,[515]=true,[514]=true,[456]=true,[431]=true,[437]=true,[408]=true,}

-- LISTA AUT NA KAT S
KatS = { [432]=true,[532]=true,[406]=true,}

-- LISTA AUT NA KAT L
KatL = { [592]=true,[577]=true,[511]=true,[512]=true,[593]=true,[520]=true,[553]=true,[476]=true,[519]=true,[460]=true,[513]=true,}

-- LISTA AUT NA KAT H
KatH ={ [548]=true,[425]=true,[417]=true,[487]=true,[488]=true,[497]=true,[563]=true,[447]=true,[447]=true,[469]=true,}

addEventHandler("onVehicleStartEnter", root, function(plr,seat)
	if plr then 
	    if seat == 0 then
		if getElementAlpha(plr) ~= 255 then
			setElementAlpha(plr,255)
			createBlipAttachedTo ( plr, 0, 2, 100, 100, 100 );	
		end
		
	    local driver = getVehicleOccupant(source) or false
	    if driver~=plr then cancelEvent() return end
		
		local model = getElementModel(source);
		playerKatA = getElementData(plr,"player:katA"); -- podmianka potem
		playerKatB = getElementData(plr,"player:katB"); -- podmianka potem
		playerKatC = getElementData(plr,"player:katC"); -- podmianka potem
		
		playerKatL = getElementData(plr,"player:katL"); -- podmianka potem
		playerKatH = getElementData(plr,"player:katH"); -- podmianka potem
		playerKatS = 1; -- podmianka potem
		
	    if (getElementData(plr,"zakazy:prawko")) and ( KatB[model] or KatA[model] or KatC[model] or KatS[model] )  then
	    	outputChatBox("Posiadasz cofnięte prawa jazdy kat.: (A,B,C).",plr, 255,0,0)
			outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:prawko"),plr, 255,0,0)
			cancelEvent()
	    	return
	    end
		
	    if (getElementData(plr,"zakazy:latanie")) and ( KatL[model] or KatH[model] ) then
	    	outputChatBox("Posiadasz cofniętą licencję lotniczą: (L,H).",plr, 255,0,0)
			outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:latanie"),plr, 255,0,0)
			cancelEvent()
	    	return
	    end
		
		-- getElementModel(source)
		
		if (KatB[model] and playerKatB == 0) or (KatA[model] and playerKatA == 0) or (KatC[model] and playerKatC == 0) or (KatS[model] and playerKatS == 0) then 
			outputChatBox("* Nie masz prawa jazdy do prowadzenia tego pojazdu.", plr,255,0,0)
			cancelEvent() 
			return 
		end
		
		if (KatL[model] and playerKatL == 0) or (KatH[model] and playerKatH == 0) then 
			outputChatBox("* Nie posiadasz uprawnień, do pilotowania tego pojazdu.", plr,255,0,0)
			cancelEvent() 
			return 
		end
		
		if getElementData(source,"vehicle:owner") == getElementData(plr,"player:dbid") or getElementData(source,"vehicle:groupowner") == getElementData(plr,"player:orgID") or getElementData(source,"vehicle:owner") == "Serwer" then return end
			outputChatBox("* Nie posiadasz kluczyków do tego pojazdu.", plr)
			cancelEvent()
		end
	end
end)


function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local handlingTable = getVehicleHandling ( element ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
        
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
    
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end



--local oznacz_poz=createMarker(1910.2, 2291.09937, 8.82031, "cylinder", 6.4, 255,255,255,20)
--local dajprzecho = createColCuboid(1906.32410, 2290.08228, 8.82031, 6.4, 7.3, 6.2)

addEvent("GetRec", true)
addEventHandler("GetRec", root, function(vart)
    local uid = getElementData(source,"player:dbid") or 0;
    if not uid then return end
	local plr_orgID = getElementData(source,"player:orgID") or 0;
	
	if tonumber(vart) == 0 then 
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner='"..uid.."' AND veh_parking='1'");
    	if #result > 0 then
        	triggerClientEvent(source, "GetVehicles", source, result)
    	end
	end
	if tonumber(vart) == 1 then 
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_groupowner='"..plr_orgID.."' AND veh_parking='1'");
    	if #result > 0 then
        	triggerClientEvent(source, "GetVehicles", source, result)
    	end
	end
end)

local LVprz = createColCuboid(1976.205078125, 2441.380859375, 9.7, 36.5, 47.5, 5.0) 
addEventHandler("onVehicleExit", root, function(plr,seat)
    if seat ~= 0 then return end
	if source then
	local cuboidDP = getElementData(source,"vehicle:cuboidDP") or false;
	    if cuboidDP == true then
			local veh_siren = getElementData(source,"vehicle:syrenyON") or false;
			if veh_siren then
				setElementData(source,"vehicle:syrenyON",false)
			end
		    exports["aj-vehs"]:zapiszPojazd(source)
			outputChatBox("* Pojazd został przeniesiony na parking.", plr)
			triggerClientEvent(plr, "removeInfoOnDP", plr)
	    end
	end
end)

function shapeHit(veh,md)
if not md then return end
    if getElementType(veh) == "vehicle" then
    	local driver = getVehicleOccupant(veh) or false;
		if driver == false then return end
		local plr_uid = getElementData(driver,"player:dbid") or 0;
		local veh_id = getElementData(veh,"vehicle:id") or 0;
--		local veh_siren = getElementData(veh,"vehicle:syrenyON") or false;
--		if veh_siren then
--			setElementData(veh,"vehicle:syrenyON",false)
--		end
		if tonumber(veh_id) > 999999 then return end
		if tonumber(plr_uid) > 0 then
		    local car_owner = getElementData(veh,"vehicle:owner") or 0;
			if tonumber(car_owner) > 0 then
			     --if tonumber(plr_uid) == tonumber(car_owner) then
			     if driver then
				      setElementData(veh,"vehicle:cuboidDP",true)
--					  outputChatBox("* Wyjdź z pojazdu, aby przenieść go na parking.", driver)
					  triggerClientEvent(driver, "showInfoOnDP", driver)
				 end
			end
		end
	end
end
addEventHandler("onColShapeHit", LVprz, shapeHit)  

function shapeLeave(veh,md)
    if getElementType(veh) == "vehicle" then
    	local driver = getVehicleOccupant(veh) or false;
		if driver == false then return end
	    setElementData(veh,"vehicle:cuboidDP",false)
		triggerClientEvent(driver, "removeInfoOnDP", driver)
    end
end
addEventHandler("onColShapeLeave", LVprz, shapeLeave) 

addEvent("VehicleSpawn", true)
addEventHandler("VehicleSpawn", root, function(id,model)
    if not id then return end
--    if getElementData(source,"zakazy:prawko") then
--	    outputChatBox("Posiadasz cofnięte prawa jazdy kat.: (A,B,C).",source, 255,0,0)
--		outputChatBox("Blokada wygasa: ".. getElementData(source, "zakazy:prawko"),source, 255,0,0)
--		return 
--	end
--	vehicle = getPedOccupiedVehicle(source) or false
--	model = modelID;
	playerKatA = getElementData(source,"player:katA"); -- podmianka potem
	playerKatB = getElementData(source,"player:katB"); -- podmianka potem
	playerKatC = getElementData(source,"player:katC"); -- podmianka potem
		
	playerKatL = getElementData(source,"player:katL"); -- podmianka potem
	playerKatH = getElementData(source,"player:katH"); -- podmianka potem
	playerKatS = 1; -- podmianka potem
		
	 if (getElementData(source,"zakazy:prawko")) and ( KatB[model] or KatA[model] or KatC[model] or KatS[model] ) then
	    outputChatBox("Posiadasz cofnięte prawa jazdy kat.: (A,B,C).",source, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(source, "zakazy:prawko"),source, 255,0,0)
	    return
	end
		
	if KatL[model] or KatH[model] then
	    return
	end

	if (KatB[model] and playerKatB == 0) or (KatA[model] and playerKatA == 0) or (KatC[model] and playerKatC == 0) or (KatS[model] and playerKatS == 0) then 
		outputChatBox("* Nie masz prawa jazdy do prowadzenia tego pojazdu.", source,255,0,0)
		return 
	end
	
--	if (KatL[model] and playerKatL == 0) or (KatH[model] and playerKatH == 0) then 
--		outputChatBox("* Nie posiadasz uprawnień, do pilotowania tego pojazdu.", source,255,0,0)
--		return 
--	end
	
    local value = "przecho"
	local carid = tonumber(id)
	exports["aj-vehs"]:respPojazd(source,carid,value)
end)

