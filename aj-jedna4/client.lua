

local jedna4 = createBlip(907.388671875, 2051.388671875, 10.378155708313, 53, 2, 255, 0, 0, 155, 1, 500)

--local tableInfoMila = createPickup(899.8076171875, 2061.0419921875, 10.8203125, 3, 1239, 150)   


local start_jedna4 = createColCuboid(902.3564453125, 2056.8203125, 9.8, 10, 5, 3) 
--local spr_start_jedna4 = createColCuboid(902.3564453125, 2063.8203125, 9.8, 10, 5, 3) 
local spr_start_jedna4 = createColCuboid(902.3564453125, 2063.8203125, 9.8, 10, 2, 3) 

local meta_jedna4 = createColCuboid(902.3564453125, 2402.8203125, 9.8, 10, 5, 3) 

local ops_jedna4 = createColCuboid(902.314453125, 2053.2978515625, 9.8, 10, 356, 3) 

--local ogranicznik_jedna4 = createColCuboid(902.3564453125, 2425.2, 9.8, 10, 4, 3) 
--local ogranicznik2_jedna4 = createColCuboid(902.3564453125, 2431.8203125, 9.8, 10, 6, 3) 

local czas_jedna4mili = {}

function jedna4miliHit(veh,md)
if not md then return end
	if source == start_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
				local plr_uid = getElementData(driver,"player:dbid") or 0;
				local veh_id = getElementData(veh,"vehicle:id") or 0;
				setElementData(driver,"player:jedna4mili",1)
		end
	end
	if source == spr_start_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
				local plr_uid = getElementData(driver,"player:dbid") or 0;
				local plr_jedna4mili = getElementData(driver,"player:jedna4mili") or 0;
				local veh_id = getElementData(veh,"vehicle:id") or 0;
				if tonumber(plr_jedna4mili) > 0 then
	    			local vx,vy,vz=getElementVelocity(veh)
					local ograniczenie = 50;
					local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5) *1.0*180
					if actualspeed > ograniczenie then
						outputChatBox("#841515✖#e7d9b0 Błąd, aby wykonać prawidłowy pomiar, należy zatrzymać pojazd przed #EBB85Dbiałą linią#e7d9b0.",231, 217, 176,true)
					else
						--local czas = getTickCount()
						czas_jedna4mili[driver] = getTickCount()
						setElementData(driver,"player:jedna4milistart",1)
						--outputChatBox("* gz", driver)
					end

				end
		end
	end
	if source == meta_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
				local plr_uid = getElementData(driver,"player:dbid") or 0;
				local plr_jedna4mili_meta = getElementData(driver,"player:jedna4milistart") or 0;
				local veh_id = getElementData(veh,"vehicle:id") or 0;
				if tonumber(plr_jedna4mili_meta) > 0 then
					local newtime = getTickCount() - czas_jedna4mili[driver]
					local newtime_outh = getTickCount() - czas_jedna4mili[driver]
					local newtime = string.format("%.3f", newtime/1000)
					local veh_name = getVehicleName(veh);
					
				    if tonumber(newtime_outh) > 12000 then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
				    if tonumber(newtime_outh) <= 12000 and tonumber(newtime_outh) > 10000 then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Świetnieee! Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
					if tonumber(newtime_outh) <= 10000 and tonumber(newtime_outh) > 8000 then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Wspaniale #EBB85D"..getPlayerName(localPlayer).."#e7d9b0! Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
					if tonumber(newtime_outh) <= 8000 and tonumber(newtime_outh) > 7000 then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Wow #EBB85D"..getPlayerName(localPlayer).."#e7d9b0! Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
					if tonumber(newtime_outh) <= 7000 and tonumber(newtime_outh) > 6000  then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Awww... ♥ Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
					if tonumber(newtime_outh) <= 6000 then 
						outputChatBox("#7AB4EAⒾ#e7d9b0 Niesamowite #EBB85D"..getPlayerName(localPlayer).."#e7d9b0! Twój czas na 1/4 mili to #EBB85D"..newtime.."#e7d9b0 sekundy!",255,255,255,true) 
					end
					
					triggerServerEvent("nadajCzasJednej4doDB",root,newtime_outh,plr_uid,veh_name,localPlayer)
					setElementData(driver,"player:jedna4milistart",0)
					czas_jedna4mili[driver] = nil
				end
		end
	end
	if source == ogranicznik_jedna4 or source == ogranicznik2_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
			setElementData(driver,"player:vehicleogranicznik",20)
	end
end
end
addEventHandler("onClientColShapeHit", root, jedna4miliHit)  

function jedna4miliLeave(veh,md)
	if source == spr_start_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
				local plr_uid = getElementData(driver,"player:dbid") or 0;
				local veh_id = getElementData(veh,"vehicle:id") or 0;
				setElementData(driver,"player:jedna4mili",0)
		end
	end
	if source == ops_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
				local plr_uid = getElementData(driver,"player:dbid") or 0;
--				local veh_id = getElementData(veh,"vehicle:id") or 0;
				setElementData(driver,"player:jedna4milistart",0)
				setElementData(driver,"player:jedna4mili",0)
				czas_jedna4mili[driver] = nil
		end
	end
	if source == ogranicznik_jedna4 or source == ogranicznik2_jedna4 then
    	if getElementType(veh) == "vehicle" then
    		local driver = getVehicleOccupant(veh) or false;
			if driver == false then return end
			if driver ~= localPlayer then return end
			setElementData(driver,"player:vehicleogranicznik",0)
	end
end
end
addEventHandler("onClientColShapeLeave", root, jedna4miliLeave) 

function odMrozVehvehicle(vehicle)
    setElementFrozen(vehicle, false)
end

addEventHandler("onClientRender", root, function()

    local spr_ludka22 = getElementData(localPlayer,"player:vehicleogranicznik") or 0;
	if spr_ludka22 > 0 then
	    local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
	    	local vx,vy,vz=getElementVelocity(vehicle)
			local ograniczenie = getElementData(localPlayer,"player:vehicleogranicznik");
			local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5) *1.0*180
			if actualspeed > ograniczenie then
				setElementVelocity(vehicle,vx*0.9,vy*0.9,vz*0.9)
				setElementVelocity(vehicle,vx*0.9,vy*0.9,vz*0.9)
			end
		else
		    setElementData(localPlayer,"player:vehicleogranicznik",0)
		end
	end
	
    local spr_ludka = getElementData(localPlayer,"player:jedna4milistart") or 0;
	if spr_ludka > 0 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if not vehicle then
				setElementData(localPlayer,"player:jedna4milistart",0)
				setElementData(localPlayer,"player:jedna4mili",0)
				czas_jedna4mili[localPlayer] = nil
		return end
--		local kierowca = getVehicleOccupant(vehicle,0) or "brak";
--		if kierowca ~= localPlayer then return end
	
		local newtime = getTickCount() - czas_jedna4mili[localPlayer]
		local time_limit = 169; -- sekund
		local time_limit = time_limit*1000; -- sekund
			if newtime > time_limit then -- zakoncz wyscig
				setElementData(localPlayer,"player:jedna4milistart",0)
				setElementData(localPlayer,"player:jedna4mili",0)
				czas_jedna4mili[localPlayer] = nil
			end
		local newtime = string.format("%.3f", newtime/1000)
        dxDrawText("Czas: "..newtime, 1246 + 1, 497 + 1, 1658 + 1, 574 + 1, tocolor(0, 0, 0, 255), 1.30, "default", "left", "center", false, false, false, false, false)
        dxDrawText("Czas: "..newtime, 1246, 497, 1658, 574, tocolor(255, 255, 255, 255), 1.30, "default", "left", "center", false, false, false, false, false)
	end
end)

addEventHandler("onClientRender", root,function()
local rootx, rooty, rootz = getCameraMatrix()
for i, v in ipairs(getElementsByType("ped")) do
--			setPlayerNametagShowing(v,false);
			--//DYSTANS RENDERU//--
			rendering = 26; --// TUTAJ ZMIEN //--
			--//DYSTANS RENDERU//--
			local x,y,z = getPedBonePosition(v,1)
			if x ~= 0 and y ~= 0 and z ~= 0 then -- wazne, bo potem wyswietla sie pod mapa na 0,0,0 nie weim czemu.
			local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
		    local sx, sy = getScreenFromWorldPosition(x, y, z+8.7) -- 3.7
			if sx then -- // JEŚLI TAK POKAZ, JEŚLI =/= POKAZ
            local flX = math.floor(sx)
            local flY = math.floor(sy)
			local skala_textu = 1.10;
			local sksh = 1.1;
			opacity = 255;
			if distance > 26 then skala_textu = 1; opacity = 177; end

			--//SPRAWDZAMY DYSTANS RENDERU
			if distance < rendering then
		
			local pedname = getElementData(v,"ped:listajedna4") or "";
			--// IF JEST DUTY
			--// NORMALNY NICK + COL ID
		    dxDrawText(""..pedname:gsub("#%x%x%x%x%x%x","").."", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, "default-bold", "center", "center",false,false,false,true,true)
		    dxDrawText("#ffffff"..pedname:gsub("#%x%x%x%x%x%x","").."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, "default-bold", "center", "center",false,false,false,true,true)
			
			end
			end
		end
end
end)


local gameView={"Logi serwerowe:"}

addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text)
dbid = getElementData(localPlayer,"player:dbid") or 0;
if dbid > 0 then
	table.insert(gameView, text)	
	if #gameView > 14 then
		table.remove(gameView, 2)
	end
end
end)
