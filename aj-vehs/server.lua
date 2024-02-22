--- TABLE tunner

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling ( element ) 
        local value = handlingTable[property] 
 
        if value then
            return value
        end
    end
 
    return false
end

-- zapis pojazdu do bazy (nie usuwa poj zmapy)
function zapiszPoj(veh)
local veh_id = getElementData(veh,"vehicle:id") or 0;
local veh_przebieg = getElementData(veh,"vehicle:przebieg") or 0;
local veh_paliwo = getElementData(veh,"vehicle:paliwo") or 0;
local veh_vopis = getElementData(veh,"vehicle:vopis") or "";
local x,y,z = getElementPosition(veh)
local veh_poss = x..", "..y..", "..z;
local rx,ry,rz = getElementRotation(veh)
local veh_root = rx..", "..ry..", "..rz;
if isElementFrozen(veh) then veh_frozen = 1; else veh_frozen = 0; end
local colors = {getVehicleColor(veh, true) }
	colors = {
		color1 = {r = colors[1], g = colors[2], b = colors[3]},
		color2 = {r = colors[4], g = colors[5], b = colors[6]},
		color3 = {r = colors[7], g = colors[8], b = colors[9]},
		color4 = {r = colors[10], g = colors[11], b = colors[12]},
	}
    local r, g, b = getVehicleHeadLightColor(veh)
	veh_tune = getVehicleUpgrades(veh)
    if not veh_tune then veh_tune={} end
    veh_tune = table.concat(veh_tune, ",")
	veh_paintjob = getVehiclePaintjob(veh)
	local usz1={}
	for i=0,6 do table.insert(usz1, getVehiclePanelState(veh,i)) end
	veh_usz1=table.concat(usz1,",")
	local usz2={}
	for i=0,5 do table.insert(usz2, getVehicleDoorState(veh,i)) end
	veh_usz2=table.concat(usz2,",")
	veh_usz3 = getElementHealth(veh)
	local usz4={}
	for i=0,1 do table.insert(usz4, getVehicleLightState(veh,i)) end
	veh_usz4=table.concat(usz4,",")
    local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(veh)
    local veh_usz5 = frontLeft..", "..rearLeft..", "..frontRight..", "..rearRight;
	if tonumber(veh_id) <= 999999 then
	local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_reczny='"..veh_frozen.."', veh_color='"..toJSON(colors).."', veh_paintjob='"..veh_paintjob.."',veh_lampy='"..r..","..g..","..b.."', veh_tune='"..veh_tune.."', veh_przebieg='"..veh_przebieg.."', veh_paliwo='"..veh_paliwo.."', veh_vopis=?, veh_usz1='"..veh_usz1.."', veh_usz2='"..veh_usz2.."', veh_usz3='"..veh_usz3.."', veh_usz4='"..veh_usz4.."', veh_usz5='"..veh_usz5.."', veh_position=?, veh_root=? WHERE veh_id = '"..veh_id.."'",veh_vopis,veh_poss,veh_root);
	end   
end

-- wczytywanie poj (wersja delikatna nie robi poj a zmienia wartosci juz stwozonego poj)
function przeladujPoj(veh)
    local veh_id = getElementData(veh,"vehicle:id") or 0;
	local vehs_query = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."'")
	if #vehs_query > 0 then
		setElementData(veh,"vehicle:owner",vehs_query[1].veh_owner)
		setElementData(veh,"vehicle:maxpaliwo",vehs_query[1].veh_maxpaliwo)

        setVehiclePlateText(veh,veh_tablica.." "..veh_id.."")
        local lights = split(vehs_query[1].veh_lampy, ",")
		setVehicleHeadLightColor(veh, lights[1], lights[2], lights[3])	
	end
end

-- wczytywanie pojazdu pena wersja reset serwera
function respPojazdPoReboot(veh_id)
	if veh_id > 0 then
		local res2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."'")
		if(#res2 >= 1) then
		
			-- tablica
			veh_modelid = res2[1].veh_modelid;
			veh_owner = res2[1].veh_owner;
			veh_groupowner = res2[1].veh_groupowner;
			veh_przebieg = res2[1].veh_przebieg;
			veh_paliwo = res2[1].veh_paliwo;
			veh_maxpaliwo = res2[1].veh_maxpaliwo;
			veh_frakcja = res2[1].veh_frakcja;
			veh_color = res2[1].veh_color;
			veh_paintjob = res2[1].veh_paintjob;
			veh_variant1 = res2[1].veh_variant1;
			veh_variant2 = res2[1].veh_variant2;
			veh_lampy = res2[1].veh_lampy;
			veh_tune = res2[1].veh_tune;
			veh_tablica = res2[1].veh_tablica;
			veh_vopis = res2[1].veh_vopis;
			veh_usz1 = res2[1].veh_usz1;
			veh_usz2 = res2[1].veh_usz2;
			veh_usz3 = res2[1].veh_usz3;
			veh_usz4 = res2[1].veh_usz4;
			veh_usz5 = res2[1].veh_usz5;
			veh_mk1 = res2[1].veh_mk1;
			veh_mk2 = res2[1].veh_mk2;
			veh_mk3 = res2[1].veh_mk3;
			veh_SU1 = res2[1].veh_SU1;
			
			if res2[1].veh_reczny == 1 then	veh_frozen = true; else veh_frozen = false; end
			veh_poss = res2[1].veh_position;
			veh_root = res2[1].veh_root;
			
			if veh_poss then
				veh_poss = split(veh_poss, ",")
				veh_root = split(veh_root, ",")
				outputDebugString("Wyciągam auto ID: "..veh_id, 3)
			
				auto = createVehicle(veh_modelid, veh_poss[1], veh_poss[2], veh_poss[3], veh_root[1] or 0, veh_root[2] or 0, veh_root[3] or 0)
				
				setVehicleVariant(auto, veh_variant1, veh_variant2) -- var
					
				setVehiclePlateText(auto,veh_tablica.." "..veh_id.."")
				--setElementData(plr,"vehicle:testtest","true")
				-- pj
				setVehiclePaintjob(auto,veh_paintjob);
				
				local colors = fromJSON(veh_color)
				
				local lights=split(veh_lampy, ",")
				setVehicleHeadLightColor(auto, lights[1], lights[2], lights[3])
				setVehicleColor(auto, colors.color1.r, colors.color1.g, colors.color1.b, colors.color2.r, colors.color2.g, colors.color2.b, colors.color3.r, colors.color3.g, colors.color3.b, colors.color4.r, colors.color4.g, colors.color4.b)
				
				--addVehicleUpgrade (auto, "1073")
				for i,v in ipairs(split(veh_tune, ",")) do addVehicleUpgrade(auto, v) end
				
				-- for nie dziala jak powinien bo losuje losowe // do nizej
				-- uszkodzenia 1 (caro, zderzaki)
				local crsPanel = split(veh_usz1, ",")
				setVehiclePanelState(auto, 0, crsPanel[1])
				setVehiclePanelState(auto, 1, crsPanel[2])
				setVehiclePanelState(auto, 2, crsPanel[3])
				setVehiclePanelState(auto, 3, crsPanel[4])
				setVehiclePanelState(auto, 4, crsPanel[5])
				setVehiclePanelState(auto, 5, crsPanel[6])
				setVehiclePanelState(auto, 6, crsPanel[7])
				
				-- uszkodzenia 2 (dzwi, maski)
				local crsDoor = split(veh_usz2, ",")
				setVehicleDoorState(auto, 0, crsDoor[1])
				setVehicleDoorState(auto, 1, crsDoor[2])
				setVehicleDoorState(auto, 2, crsDoor[3])
				setVehicleDoorState(auto, 3, crsDoor[4])
				setVehicleDoorState(auto, 4, crsDoor[5])
				setVehicleDoorState(auto, 5, crsDoor[6])
				-- uszkodzenia 3 (silnik)
				setElementHealth(auto,veh_usz3);
				-- uszkodzenia 4 (lampy)
				local crslights = split(veh_usz4, ",")
				setVehicleLightState (auto, 0, crslights[1])
				setVehicleLightState (auto, 1, crslights[2])
				local crswheel = split(veh_usz5, ",")
				setVehicleWheelStates(auto, crswheel[1], crswheel[2], crswheel[3], crswheel[4])
				
				setElementData(auto,"vehicle:id", veh_id)
				setElementData(auto,"vehicle:owner", veh_owner)
				setElementData(auto,"vehicle:groupowner",veh_groupowner) -- odz
				setElementData(auto,"vehicle:paliwo", veh_paliwo) -- potem dodac odp. dane
				setElementData(auto,"vehicle:maxpaliwo", veh_maxpaliwo)
				setElementData(auto,"vehicle:przebieg", veh_przebieg) -- potem dodac odp. dane
				setElementData(auto,"vehicle:odznaczone",false) -- odz
				setElementData(auto,"vehicle:vopis",veh_vopis) -- odz
				setElementData(auto,"vehicle:frakcjaCODE",veh_frakcja) -- frakcja
				
				-- zgaszone lampy od wyciagniecia
				setVehicleOverrideLights(auto, 1)
				setVehicleEngineState(auto, false)
				setVehicleDamageProof(auto, true)
				setElementFrozen(auto, veh_frozen)
				
				exports["aj-vehsSirens"]:vehSirens(auto)
				exports["aj-vehsconfig"]:nadajHandingPoj(auto)
				exports["aj-vehstune"]:nadajTunePoj(auto)		
				--// dajemy znac bazie, ze auto jest wyciagniee

			else
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_parking = '1' WHERE veh_id = '"..veh_id.."'")
				-- brak poss
			end
		end
	end	
end



-- wczytywanie poj (wersja pełna PRZECHO)
function respPojazd(plr,carid,value,x,y,z,rxr)
        local veh_id = carid;
		local result_us = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_nickname = '"..getPlayerName(plr).."'")
--		local result_us = dbPoll(dbQuery(db, "SELECT * FROM server_users WHERE user_nickname = '"..getPlayerName(plr).."'"),-1);
		user_id = result_us[1].user_id;
		local plr_orgID = getElementData(plr,"player:orgID") or 0;
		local code = getElementData(plr,"player:frakcjaCODE") or false;
		local resdd = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."' ") --  AND veh_owner = '"..user_id.."' OR veh_groupowner = '"..plr_orgID.."'
--		local resdd = dbPoll(dbQuery(db, "SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."' AND ( veh_owner = '"..user_id.."' OR veh_groupowner = '"..plr_orgID.."')"),-1);
		if ( ( #resdd >= 1 and resdd[1].veh_owner == tonumber(user_id) ) or ( #resdd >= 1 and resdd[1].veh_groupowner == tonumber(plr_orgID) and tonumber(plr_orgID) > 0 ) or ( #resdd >=1 and resdd[1].veh_frakcja == tostring(code) and code ~= false ) ) then
		    local res2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."' AND veh_parking = '1'")
--			local res2 = dbPoll(dbQuery(db, "SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."' AND veh_parking = '1'"),-1);
			if(#res2 >= 1) then
			
				if getElementAlpha(plr) ~= 255 then
				setElementAlpha(plr,255)
				createBlipAttachedTo ( plr, 0, 2, 100, 100, 100 )
				end
			    
				veh_modelid = res2[1].veh_modelid;
				veh_owner = res2[1].veh_owner;
				veh_groupowner = res2[1].veh_groupowner;
				veh_przebieg = res2[1].veh_przebieg;
				veh_paliwo = res2[1].veh_paliwo;
				veh_maxpaliwo = res2[1].veh_maxpaliwo;
				veh_frakcja = res2[1].veh_frakcja;
				veh_color = res2[1].veh_color;
				veh_paintjob = res2[1].veh_paintjob;
				veh_variant1 = res2[1].veh_variant1;
				veh_variant2 = res2[1].veh_variant2;
				veh_lampy = res2[1].veh_lampy;
				veh_tune = res2[1].veh_tune;
				veh_tablica = res2[1].veh_tablica;
				veh_vopis = res2[1].veh_vopis;
				veh_usz1 = res2[1].veh_usz1;
				veh_usz2 = res2[1].veh_usz2;
				veh_usz3 = res2[1].veh_usz3;
				veh_usz4 = res2[1].veh_usz4;
				veh_usz5 = res2[1].veh_usz5;
				veh_mk1 = res2[1].veh_mk1;
				veh_mk2 = res2[1].veh_mk2;
				veh_mk3 = res2[1].veh_mk3;
				veh_SU1 = res2[1].veh_SU1;
							
				if value == "admwyjmij" then -- value (adm /wyjmij)
                local px,py,pz = getElementPosition(plr)
			    local rx,ry,rz = getElementRotation(plr)
				    auto = createVehicle(veh_modelid, px, py, pz, rx, ry, rz)
				else
					auto = createVehicle(veh_modelid, x, y, z, 0, 0, rxr)
				end
							
				warpPedIntoVehicle(plr,auto,0)
				
				setVehicleVariant(auto, veh_variant1, veh_variant2) -- var
				
				setVehiclePlateText(auto,veh_tablica.." "..veh_id.."")
				setElementData(plr,"vehicle:testtest","true")
				-- pj
				setVehiclePaintjob(auto,veh_paintjob);
				
				local colors = fromJSON(veh_color)
				
				local lights=split(veh_lampy, ",")
				setVehicleHeadLightColor(auto, lights[1], lights[2], lights[3])
				setVehicleColor(auto, colors.color1.r, colors.color1.g, colors.color1.b, colors.color2.r, colors.color2.g, colors.color2.b, colors.color3.r, colors.color3.g, colors.color3.b, colors.color4.r, colors.color4.g, colors.color4.b)
				
				--addVehicleUpgrade (auto, "1073")
				for i,v in ipairs(split(veh_tune, ",")) do addVehicleUpgrade(auto, v) end
				
				-- for nie dziala jak powinien bo losuje losowe // do nizej
				-- uszkodzenia 1 (caro, zderzaki)
				local crsPanel = split(veh_usz1, ",")
				setVehiclePanelState(auto, 0, crsPanel[1])
				setVehiclePanelState(auto, 1, crsPanel[2])
				setVehiclePanelState(auto, 2, crsPanel[3])
				setVehiclePanelState(auto, 3, crsPanel[4])
				setVehiclePanelState(auto, 4, crsPanel[5])
				setVehiclePanelState(auto, 5, crsPanel[6])
				setVehiclePanelState(auto, 6, crsPanel[7])
				
				-- uszkodzenia 2 (dzwi, maski)
				local crsDoor = split(veh_usz2, ",")
				setVehicleDoorState(auto, 0, crsDoor[1])
				setVehicleDoorState(auto, 1, crsDoor[2])
				setVehicleDoorState(auto, 2, crsDoor[3])
				setVehicleDoorState(auto, 3, crsDoor[4])
				setVehicleDoorState(auto, 4, crsDoor[5])
				setVehicleDoorState(auto, 5, crsDoor[6])
				-- uszkodzenia 3 (silnik)
				setElementHealth(auto,veh_usz3);
				-- uszkodzenia 4 (lampy)
                local crslights = split(veh_usz4, ",")
				setVehicleLightState (auto, 0, crslights[1])
				setVehicleLightState (auto, 1, crslights[2])
				local crswheel = split(veh_usz5, ",")
				setVehicleWheelStates(auto, crswheel[1], crswheel[2], crswheel[3], crswheel[4])
				
                setElementData(auto,"vehicle:id", veh_id)
				setElementData(auto,"vehicle:owner", veh_owner)
				setElementData(auto,"vehicle:groupowner",veh_groupowner) -- odz
				setElementData(auto,"vehicle:paliwo", veh_paliwo) -- potem dodac odp. dane
				setElementData(auto,"vehicle:maxpaliwo", veh_maxpaliwo)
				setElementData(auto,"vehicle:przebieg", veh_przebieg) -- potem dodac odp. dane
				setElementData(auto,"vehicle:odznaczone",false) -- odz
				setElementData(auto,"vehicle:vopis",veh_vopis) -- odz
				setElementData(auto,"vehicle:frakcjaCODE",veh_frakcja) -- frakcja
				
				-- zgaszone lampy od wyciagniecia
				setVehicleOverrideLights(auto, 1)
				setVehicleEngineState(auto, false)
				
				exports["aj-vehsSirens"]:vehSirens(auto)
				exports["aj-vehsconfig"]:nadajHandingPoj(auto,plr)
				exports["aj-vehstune"]:nadajTunePoj(auto,plr)		
				--// dajemy znac bazie, ze auto jest wyciagniee
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_parking = '0' WHERE veh_id = '"..veh_id.."'")
				
				triggerClientEvent("veh_kryptonim",plr,auto)

			else outputChatBox("* Błąd, pojazd jest już na mapie!",plr) end
		else outputChatBox("* Błąd, niepoprawne ID bądz pojazd nie jest Twój!",plr) end
end

-- zapis pojazdu (wersja pełna PRZECHO)
function zapiszPojazd(veh)
local veh_id = getElementData(veh,"vehicle:id") or 0;
local veh_przebieg = getElementData(veh,"vehicle:przebieg") or 0;
local veh_paliwo = getElementData(veh,"vehicle:paliwo") or 0;
local veh_vopis = getElementData(veh,"vehicle:vopis") or "";
if isElementFrozen(veh) then veh_frozen = 1; else veh_frozen = 0; end
local x,y,z = getElementPosition(veh)
local veh_poss = x..", "..y..", "..z;
local rx,ry,rz = getElementRotation(veh)
local veh_root = rx..", "..ry..", "..rz;
local colors = {getVehicleColor(veh, true) }
	colors = {
		color1 = {r = colors[1], g = colors[2], b = colors[3]},
		color2 = {r = colors[4], g = colors[5], b = colors[6]},
		color3 = {r = colors[7], g = colors[8], b = colors[9]},
		color4 = {r = colors[10], g = colors[11], b = colors[12]},
	}
    local r, g, b = getVehicleHeadLightColor(veh)
	veh_tune = getVehicleUpgrades(veh)
    if not veh_tune then veh_tune={} end
    veh_tune = table.concat(veh_tune, ",")
	-- pj
	veh_paintjob = getVehiclePaintjob(veh)
	-- uszkodzenia 1
	local usz1={}
	for i=0,6 do table.insert(usz1, getVehiclePanelState(veh,i)) end
	veh_usz1=table.concat(usz1,",")
	-- uszkodzenia 1
	local usz2={}
	for i=0,5 do table.insert(usz2, getVehicleDoorState(veh,i)) end
	veh_usz2=table.concat(usz2,",")
	-- uszkopdzenia 3 silnik
	veh_usz3 = getElementHealth(veh)
	-- uszkodzenia lampy
	local usz4={}
	for i=0,1 do table.insert(usz4, getVehicleLightState(veh,i)) end
	veh_usz4=table.concat(usz4,",")
	-- uszkodzenia wheels
    local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(veh)
    local veh_usz5 = frontLeft..", "..rearLeft..", "..frontRight..", "..rearRight;
	
	local var1, var2 = getVehicleVariant(veh) -- Get the info
		if tonumber(veh_id) > 999999 then
		destroyElement(veh)
--	    outputChatBox("* Pomyślnie usunięto pojazd z mapy.",source)
		else
		local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_parking='1', veh_reczny='"..veh_frozen.."', veh_color='"..toJSON(colors).."', veh_paintjob='"..veh_paintjob.."',veh_lampy='"..r..","..g..","..b.."', veh_tune='"..veh_tune.."', veh_przebieg='"..veh_przebieg.."', veh_paliwo='"..veh_paliwo.."', veh_vopis=?, veh_usz1='"..veh_usz1.."', veh_usz2='"..veh_usz2.."', veh_usz3='"..veh_usz3.."', veh_usz4='"..veh_usz4.."', veh_usz5='"..veh_usz5.."', veh_variant1='"..var1.."', veh_variant2='"..var2.."', veh_position=?, veh_root=? WHERE veh_id = '"..veh_id.."'",veh_vopis,veh_poss,veh_root);
		
		local hand = getVehicleHandling(veh)
		local engineAcceleration = hand.engineAcceleration;
		local maxVelocity = hand.maxVelocity;
		local mass = hand.mass;
		local turnMass = hand.turnMass;
		local tractionLoss = hand.tractionLoss;
		local brakeDeceleration = hand.brakeDeceleration;
		local steeringLock = hand.steeringLock;
		local numberOfGears = hand.numberOfGears;
		local suspensionDamping = hand.suspensionDamping;
		local tractionBias = hand.tractionBias;
		local driveType = hand.driveType;
		
		local handing_tunecfg = getElementData(veh,"vehicle:tunecfg") or false;
		if handing_tunecfg then
			if handing_tunecfg[1] and handing_tunecfg[2] and handing_tunecfg[3] and handing_tunecfg[4] and handing_tunecfg[5] and handing_tunecfg[6] and handing_tunecfg[7] and handing_tunecfg[8] then
				handing_tunecfg = tostring(handing_tunecfg[1]..","..handing_tunecfg[2]..","..handing_tunecfg[3]..","..handing_tunecfg[4]..","..handing_tunecfg[5]..","..handing_tunecfg[6]..","..handing_tunecfg[7]..","..handing_tunecfg[8]);
			else
				handing_tunecfg = 0;
			end
		else
			handing_tunecfg = 0;
		end
		
		local spr1 = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles_handing WHERE handing_vehid='"..veh_id.."'")
		if #spr1 > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles_handing SET handing_tunecfg=?, handing_engineAcceleration=?, handing_maxVelocity=?, handing_mass=?, handing_turnMass=?, handing_tractionLoss=?, handing_brakeDeceleration=?, handing_steeringLock=?, handing_numberOfGears=?, handing_suspensionDamping=?, handing_tractionBias=?, handing_driveType=? WHERE handing_vehid=?",handing_tunecfg,engineAcceleration,maxVelocity,mass,turnMass,tractionLoss,brakeDeceleration,steeringLock,numberOfGears,suspensionDamping,tractionBias,driveType,veh_id)
		else
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_vehicles_handing SET handing_vehid=?, handing_tunecfg=?, handing_engineAcceleration=?, handing_maxVelocity=?, handing_mass=?, handing_turnMass=?, handing_tractionLoss=?, handing_brakeDeceleration=?, handing_steeringLock=?, handing_numberOfGears=?, handing_suspensionDamping=?, handing_tractionBias=?, handing_driveType=?",veh_id,handing_tunecfg,engineAcceleration,maxVelocity,mass,turnMass,tractionLoss,brakeDeceleration,steeringLock,numberOfGears,suspensionDamping,tractionBias,driveType)
		end
		
		destroyElement(veh)
--	    outputChatBox("* Pomyślnie przeniesiono pojazd na parking.",source)
		end
end

addEventHandler("onResourceStop",root,function(res)
	if getResourceName(res) == "aj-vehs" then
		local vehicless = getElementsByType('vehicle')
		for _, veh in pairs(vehicless) do
			local v_id = getElementData(veh,"vehicle:id") or 0;
			if tonumber(v_id) > 0 and tonumber(v_id) < 999999 then
				local vehs_spr = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..v_id.."'");
				if vehs_spr[1].veh_parking == 0 then
					zapiszPoj(veh)
				end
			else
				destroyElement(veh)
			end
		end
		outputChatBox("* Zakończono synchronizacje "..#vehicless.." pojazdów...", root);
	end
end)

addEventHandler("onResourceStart",root,function(res)
	if getResourceName(res) == "aj-vehs" then
		local vehs_spr = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_parking = '0'");
		for _, veh in pairs(vehs_spr) do
			respPojazdPoReboot(veh.veh_id)
		end
		outputChatBox("* Zakończono wyciąganie "..#vehs_spr.." pojazdów...", root);
	end
end)





