--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt cygana pojazdów.
]]--

local cygan = createBlip(3.36328125, 1362.9501953125, 8.8772020339966, 37, 2, 255, 0, 0, 155, -100, 500)
--local cygan = createBlip(2127.69921875, 2366.638671875, 10.8203125, 37, 2, 255, 0, 0, 155, 1, 500) 
local cygan = createBlip(2129.6962890625, 1402.9443359375, 11.1328125, 37, 2, 255, 0, 0, 155, -100, 500) 

function sprPojSalon(carID)
    vehicle=getElementsByType('vehicle')
    for i,veh in pairs(vehicle) do
        local vehic = getElementData(veh,"vehicle:salonCarID") or 0
		if vehic > 0 and vehic == carID then
		    return true
		end
    end	
	return false
end

local lastRespTimer = {}

local dosteponePojazdy = {
-- 1 = cały nowy furra jak ta lala
-- 2 = lekko uszkodzony (komis?/cygan)
-- 3 = srednio uszkodzony (cygan)
-- 4 = mocno uszkodzony, wzywac hola czy adm? (cygan)
-- pj id // x, y, z, rZ, cost, cost mnoznik, przebieg, prz.mnoznik, resp (ms), opis pojazdu, resp ID =/= i, +/- resp (ms), rozwalony? (1-4), TABLICA, dostępność 0/1

-- CYGAN FC POLE
{404, 9.125, 1341.0380859375, 8.871875, -39, 478, 10, 167900, 1000, 3600000, "\nPojazd jest mocno zużyty, widać ile przeszedł.", 1, 600000, 4, "FC", 1}, --1h
{543, 22.80078125, 1348.2705078125, 8.971875, 115, 1255, 155, 177900, 10000, 7200000, "\nPojazd jest w dobrym stanie, idealny na pierwszy pojazd.", 2, 1800000, 3, "FC", 1}, --2h
{549, 25.5166015625, 1363.771484375, 8.971875, 122, 2500, 550, 124000, 6500, 10800000, "\nŚwietny pojazd, wystarczy na kilka dobrych lat.", 3, 2700000, 2, "FC", 1}, -- 4h
{540, 1.5166015625, 1344.693359375, 8.971875, -22, 3255, 550, 184000, 6500, 10800000, "\nŚwietny pojazd, wystarczy na kilka dobrych lat.", 4, 2700000, 2, "FC", 1}, -- 4h
{478, -22.9853515625, 1350.36328125, 9.071875, -82, 2799, 655, 104000, 16500, 7200000, "\nŚwietny dostawczak, idealny w wiejskie okolice.", 5, 1800000, 2, "FC", 1}, -- 2h
--{418, 10.416015625, 1376.98828125, 9.211875, 115, 900, 95, 157444, 1000, 3600000, "\nPojazd jest mocno zużyty, widać ile przeszedł.", 6, 600000, 4}, --1h

-- SALON / KASYNO -- The Emerald Isle
--{480, 2132.1025390625, 2369.9970703125, 10.5203125, 146, 41200, 0, 0, 0, 10800000, "\nLuksusowy pojazd, świetnie sprawdzi się do czillowania na drogach SA.", 6, 2700000, 1, "SA", 1}, -- 4h
--{559, 2122.994140625, 2369.9658203125, 10.5203125, -146, 34000, 0, 0, 0, 10800000, "\nIdealny pierwszy luksusowy pojazd.", 7, 2700000, 1, "SA", 1}, -- 4h
--{405, 2127.5556640625, 2374.09765625, 10.7203125, 180, 23700, 0, 0, 0, 10800000, "\nŚwietny pojazd 4 osobowy.", 8, 2700000, 1, "SA", 1}, -- 4h

-- SALON / KASYNO - Royal Casino LV
{480, 2119.9384765625, 1409.044921875, 10.5203125, 0, 41200, 0, 0, 0, 10800000, "\nLuksusowy pojazd, świetnie sprawdzi się do czillowania na drogach SA.", 6, 2700000, 1, "SA", 1}, -- 4h
{559, 2136.091796875, 1409.044921875, 10.5203125, 0, 34000, 0, 0, 0, 10800000, "\nIdealny pierwszy luksusowy pojazd.", 7, 2700000, 1, "SA", 1}, -- 4h
{405, 2145.5263671875, 1409.044921875, 10.7003125, 0, 23700, 0, 0, 0, 10800000, "\nŚwietny pojazd 4 osobowy.", 8, 2700000, 1, "SA", 1}, -- 4h
{426, 2132.8046875, 1397.615234375, 10.5903125, 180, 16900, 0, 0, 0, 10800000, "\nElegancki pojazd rodzinny.", 9, 2700000, 1, "SA", 1}, -- 4h
{579, 2116.51953125, 1397.615234375, 10.7903125, 180, 44900, 0, 0, 0, 10800000, "\nWytrzymały pojazd terenowy.", 10, 2700000, 1, "SA", 1}, -- 4h
{475, 2104.0517578125, 1397.615234375, 10.5903125, 180, 20900, 0, 0, 0, 10800000, "\nNiezawodny muscle car.", 11, 2700000, 1, "SA", 1}, -- 4h
}

function delCuboid(cubID)
    colshape=getElementsByType('colshape')
    for i,v in pairs(colshape) do
        local m = getElementData(v,"cuboid:salonID") or 0
		if m > 0 and m == cubID then
		    destroyElement(v)
		end
    end	
end

function delPojDWA(cubID)
	local pojazdy = getElementsWithinColShape(cubID,"vehicle")
	if #pojazdy<1 then
		return
	end
	if #pojazdy>0 then
		for i,veh in pairs(pojazdy) do
			local vehid = getElementData(veh,"vehicle:id") or 0;
			if vehid > 0 then
				outputDebugString("Wytepano pojazd "..getVehicleName(veh).."/"..getElementData(veh,"vehicle:id").." : blokada respa SALON/CYGAN")
				exports["aj-vehs"]:zapiszPojazd(veh)
			end
		end
	end
end

-- spec visu
local wykluczoneCzesci = {
	[1008]=true, -- nitro
	[1009]=true, -- nitro
	[1010]=true, -- nitro
	[1086]=true, -- stereo a po chuj to
}
function saprcunt(veh)
    local cunt=0
	for i,v in ipairs(getVehicleCompatibleUpgrades(veh)) do
		if not wykluczoneCzesci[v] then
			cunt=cunt+1
		end
	end
	return cunt
end

function saprcunt2(veh,vr)
	if not vr then vr = 20 end
	rn1 = math.random(0,16)
	if rn1 ~= tonumber(vr) then
    	local cunt=0
		for i2,v2 in ipairs(getVehicleCompatibleUpgrades(veh, rn1)) do
			if not wykluczoneCzesci[v2] then
				cunt=cunt+1
			end
		end
		return cunt
	else
		return saprcunt2(veh,vr)
	end
end

local tunefor = { -- spec table
	-- jester
	{559, 1173, 1},
	{559, 1160, 1},
	{559, 1161, 1},
	{559, 1159, 1},
	{559, 1067, 1},
	{559, 1068, 1},
	{559, 1066, 1},
	{559, 1065, 1},
	{559, 1069, 1},
	{559, 1070, 1},
	{559, 1071, 1},
	{559, 1072, 1},	
	{559, 1162, 1},
	{559, 1158, 1},
	--nitro [all]
--	{559, 1008, 1},
--	{559, 1009, 1},
--	{559, 1010, 1},	
}

local tuneFels = { -- spec table
	{1025, 1},
	{1073, 1},
	{1074, 1},
	{1075, 1},
	{1076, 1},
	{1077, 1},
	{1078, 1},
	{1079, 1},
	{1080, 1},
	{1081, 1},
	{1082, 1},
	{1083, 1},
	{1084, 1},
	{1085, 1},
	{1096, 1},
	{1097, 1},
	{1098, 1},
}

function wybtb(poj) --
	licz = #tunefor
	sprlicz = tonumber(math.random(1,licz))
	for i,v in pairs(tunefor) do
		if tonumber(getElementModel(poj))==v[1] and sprlicz==i then --and tostring(eid)==v[3]
			return v[2]
		end
	end
	return false
end

function wybfl() --
	licz = #tuneFels
	sprlicz = tonumber(math.random(1,licz))
	for i,v in pairs(tuneFels) do
		if sprlicz==i then --and tostring(eid)==v[3]
			return v[1]
		end
	end
	return false
end

function respPoj()
for i,v in pairs(dosteponePojazdy) do
if sprPojSalon(i) ~= true then -- sprawdza czy nie istnieje już ten pojazd na mapie
if lastRespTimer[v[12]] and getTickCount() < lastRespTimer[v[12]] then else -- 12 pamietaj

	kuppojazdinfo = createColCuboid(v[2]-2.5, v[3]-2.5, v[4]-0.9, 5, 5, 3)
	setElementData(kuppojazdinfo,"cuboid:nameID","salon")
	setElementData(kuppojazdinfo,"cuboid:salonID",v[12])
	setElementData(kuppojazdinfo,"cuboid:cubID",kuppojazdinfo)
	delPojDWA(kuppojazdinfo)
	
    veh = createVehicle(v[1], v[2], v[3], v[4], 0, 0, v[5])
	
	los = math.random(-v[7],v[7]);
	los_p = math.random(-v[9],v[9]);
	veh_cost = v[6] + los;
	veh_przebieg = v[8] + los_p;
	veh_desc = v[11] or "";
	money_2 = veh_cost * 100
	money_2 = string.format("%.2f", money_2/100)
    setElementData(veh,'vehicle:desc','#388E00'..money_2..'$#ffffff\n'..getVehicleNameFromModel(v[1])..' #767676('..veh_przebieg..' km)#ffffff'..veh_desc..'')
	--\etc
    setVehicleOverrideLights(veh, 1)
    setElementFrozen(veh,true)
	col_1 = math.random(1,255);
	col_2 = math.random(1,255);
	col_3 = math.random(1,255);
	setVehicleColor(veh, col_1, col_2, col_3, col_2, col_1, col_3)
    setVehicleDamageProof(veh, true)
	
	setElementData(veh,"vehicle:id", math.random(1000000,9999999))
	setElementData(veh,"vehicle:owner", "Serwer")
	setElementData(veh,"vehicle:paliwo", 10)
	setElementData(veh,"vehicle:przebieg", veh_przebieg)
	setElementData(veh,"vehicle:odznaczone", false)
	setElementData(veh,"vehicle:salon",true)
	setElementData(veh,"vehicle:salonCost", veh_cost)
	setElementData(veh,"vehicle:salonTablica", v[15])
	setElementData(veh,"vehicle:salonKupno", v[16])	
	
	
	-- spec visu
	los1 = tonumber(math.random(0,1000))
	los2 = tonumber(math.random(0,1000))
	if los1>=290 then
		spid = wybtb(veh)
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	if los1>=460 then
		spid = wybtb(veh)
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	if los1>=760 then
		spid = wybtb(veh)
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	if los1>=899 then
		spid = wybtb(veh)
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	if los1>=960 then
		spid = wybtb(veh)
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	--spec felgi
	if los2>=0 and los2<100 and v[14]==1 then
		spid = wybfl()
		if spid then
			addVehicleUpgrade(veh,tonumber(spid))
		end
	end
	-- end spec visu
	
	if v[14] == 4 then  -- big dmg poj.
		rand_numb = math.random(0,3)
		rand_numb2 = math.random(0,2)
		rand_numb3 = math.random(0,3)
		rand_numb4 = math.random(0,1)
		rand_numb5 = math.random(0,1)
		rand_engine = math.random(410,575)
		setVehiclePanelState(veh, 0, rand_numb)
		setVehiclePanelState(veh, 1, rand_numb2)
		setVehiclePanelState(veh, 2, rand_numb)
		setVehiclePanelState(veh, 3, rand_numb3)
		setVehiclePanelState(veh, 4, rand_numb)
		setVehiclePanelState(veh, 5, rand_numb3)
		setVehiclePanelState(veh, 6, rand_numb2)
		
		setVehicleDoorState(veh, 0, rand_numb)
		setVehicleDoorState(veh, 1, rand_numb3)
		setVehicleDoorState(veh, 2, rand_numb2)
		setVehicleDoorState(veh, 3, rand_numb3)
		setVehicleDoorState(veh, 4, rand_numb2)
		setVehicleDoorState(veh, 5, rand_numb)
		
		setVehicleLightState(veh, 0, rand_numb3)
		setVehicleLightState(veh, 1, rand_numb2)
		
		setVehicleWheelStates(veh, rand_numb5, rand_numb4, rand_numb2, rand_numb4)
		
		setElementHealth(veh, rand_engine);
	end
	
	if v[14] == 3 then  -- big dmg poj.
		rand_numb = math.random(0,2)
		rand_numb2 = math.random(0,2)
		rand_numb3 = math.random(0,2)
		rand_numb4 = math.random(0,1)
		rand_numb5 = math.random(0,1)
		rand_engine = math.random(666,744)
		setVehiclePanelState(veh, 0, rand_numb)
		setVehiclePanelState(veh, 1, rand_numb2)
		setVehiclePanelState(veh, 2, rand_numb)
		setVehiclePanelState(veh, 3, rand_numb3)
		setVehiclePanelState(veh, 4, rand_numb)
		setVehiclePanelState(veh, 5, rand_numb3)
		setVehiclePanelState(veh, 6, rand_numb2)
		
		setVehicleDoorState(veh, 0, rand_numb)
		setVehicleDoorState(veh, 1, rand_numb3)
		setVehicleDoorState(veh, 2, rand_numb2)
		setVehicleDoorState(veh, 3, rand_numb3)
		setVehicleDoorState(veh, 4, rand_numb2)
		setVehicleDoorState(veh, 5, rand_numb)
		
		setVehicleLightState(veh, 0, rand_numb3)
		setVehicleLightState(veh, 1, rand_numb2)
		
		setVehicleWheelStates(veh, rand_numb5, rand_numb4, rand_numb5, 0)
		
		setElementHealth(veh, rand_engine);
	end
	
	if v[14] == 2 then  -- big dmg poj.
		rand_numb = math.random(0,2)
		rand_numb2 = math.random(0,2)
		rand_numb3 = math.random(0,2)
		rand_numb4 = math.random(0,1)
		rand_numb5 = math.random(0,1)
		rand_engine = math.random(800,999)
		setVehiclePanelState(veh, 0, rand_numb4)
		setVehiclePanelState(veh, 1, rand_numb2)
		setVehiclePanelState(veh, 2, rand_numb5)
		setVehiclePanelState(veh, 3, rand_numb4)
		setVehiclePanelState(veh, 4, rand_numb)
		setVehiclePanelState(veh, 5, rand_numb3)
		setVehiclePanelState(veh, 6, rand_numb2)
		
		setVehicleDoorState(veh, 0, rand_numb5)
		setVehicleDoorState(veh, 1, rand_numb3)
		setVehicleDoorState(veh, 2, rand_numb2)
		setVehicleDoorState(veh, 3, rand_numb4)
		setVehicleDoorState(veh, 4, rand_numb5)
		setVehicleDoorState(veh, 5, rand_numb)
		
		setVehicleLightState(veh, 0, 0)
		setVehicleLightState(veh, 1, 0)
		
		setVehicleWheelStates(veh, 0, 0, 0, 0)
		
		setElementHealth(veh, rand_engine);
	end
	
	los_1Time = math.random(-v[13],v[13]) -- +/- czas ponownego zrespienia auta (achhh to RNG <3)
	new_Time = v[10] + los_1Time;
	setElementData(veh,"vehicle:salonReSpawn", new_Time)
	setElementData(veh,"vehicle:salonCarID", i)

end
end
end
end

setTimer(respPoj, 300000, 0) --300000

addCommandHandler("kuppojazd",function(plr,cmd)
local plr_id = getElementData(plr,"player:dbid") or 0;
if plr_id > 0 then
	local vehicle = getPedOccupiedVehicle(plr) or false
	if vehicle then
	local salon = getElementData(vehicle,"vehicle:salon") or false;
	if not salon then return end
	local veh_seat = getPedOccupiedVehicleSeat(plr) or false
	if veh_seat ~= 0 then
--		outputChatBox("#841515✖#e7d9b0 Aby zakupić pojazd, musisz usiąść jako kierowca!", plr,231, 217, 176,true) 
		outputChatBox("#841515✖#e7d9b0 Aby zakupić pojazd, musisz znajdować się na siedzeniu kierowcy!", plr,231, 217, 176,true) 
		return
	end
		local ceh_prop = getElementData(vehicle,"vehicle:salon") or false;
		local ceh_prop2 = getElementData(vehicle,"vehicle:salonCarID") or 0;
		local ceh_prop3 = getElementData(vehicle,"vehicle:salonKupno") or 0;
		if ceh_prop and ceh_prop2 then
		if ceh_prop3 == 0 then
			outputChatBox("#841515✖#e7d9b0 Błąd, pojazd nie jest jeszcze dostępny do zakupu!", plr,231, 217, 176,true) 
			return
		end
			local plr_money = getPlayerMoney(plr) or 0;
			local car_cost = getElementData(vehicle,"vehicle:salonCost")
			local car_cost_spr = car_cost * 100; -- * 100
			if car_cost_spr > plr_money then
				outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz tyle gotówki!", plr,231, 217, 176,true) 
				return
			end
			local vehondp = exports["aj-dbcon"]:wyb("SELECT IFNULL(COUNT(veh_id),0) veh_count FROM server_vehicles WHERE veh_owner='"..plr_id.."'");
			local plr_cars = vehondp[1].veh_count + 1;
			local plr_carSlot = getElementData(plr,"player:carSlot") or 0;
			if plr_cars > plr_carSlot then
				outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz miejsca na kolejny pojazd!", plr,231, 217, 176,true) 
				return
			end
			local costspr = car_cost*100;
			takePlayerMoney(plr, costspr)
			
			setElementData(vehicle,"vehicle:owner", plr_id)
			
			removeElementData(vehicle,"vehicle:salon")
			removeElementData(vehicle,"vehicle:salonCost")
			removeElementData(vehicle,"vehicle:salonCarID")
			removeElementData(vehicle,"vehicle:salonKupno")
			removeElementData(vehicle,"vehicle:desc")
			
			local veh_modelid = getElementModel(vehicle)
			local veh_przebieg = getElementData(vehicle,"vehicle:przebieg") or 0;
			local colors = {getVehicleColor(vehicle, true) }
			colors = {
				color1 = {r = colors[1], g = colors[2], b = colors[3]},
				color2 = {r = colors[4], g = colors[5], b = colors[6]},
				color3 = {r = colors[7], g = colors[8], b = colors[9]},
				color4 = {r = colors[10], g = colors[11], b = colors[12]},
			}
			local r, g, b = getVehicleHeadLightColor(vehicle)
			local veh_tablica = getElementData(vehicle,"vehicle:salonTablica") or "FC";
			
			removeElementData(vehicle,"vehicle:salonTablica")
			
			local usz1={}
			for i=0,6 do table.insert(usz1, getVehiclePanelState(vehicle,i)) end
			veh_usz1=table.concat(usz1,",")
			local usz2={}
			for i=0,5 do table.insert(usz2, getVehicleDoorState(vehicle,i)) end
			veh_usz2=table.concat(usz2,",")
			veh_usz3 = getElementHealth(vehicle)
			local usz4={}
			for i=0,1 do table.insert(usz4, getVehicleLightState(vehicle,i)) end
			veh_usz4=table.concat(usz4,",")
    		local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates(vehicle)
    		local veh_usz5 = frontLeft..", "..rearLeft..", "..frontRight..", "..rearRight;
			
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_vehicles SET veh_owner='"..plr_id.."', veh_modelid='"..veh_modelid.."', veh_przebieg='"..veh_przebieg.."', veh_paliwo='10', veh_maxpaliwo='25', veh_parking='0', veh_owner2='"..plr_id.."', veh_color='"..toJSON(colors).."', veh_paintjob='3', veh_lampy='"..r..","..g..","..b.."', veh_tablica='"..veh_tablica.."', veh_usz1='"..veh_usz1.."', veh_usz2='"..veh_usz2.."', veh_usz3='"..veh_usz3.."', veh_usz4='"..veh_usz4.."', veh_usz5='"..veh_usz5.."'");
			
			local sprid = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner='"..plr_id.."' ORDER BY veh_id DESC");
			local veh_idNew = sprid[1].veh_id;
			setElementData(vehicle,"vehicle:id",veh_idNew)
			
			local veh_respawnTime = getElementData(vehicle,"vehicle:salonReSpawn") or 0;
			lastRespTimer[ceh_prop2] = getTickCount()+veh_respawnTime;
			
			delCuboid(ceh_prop2) -- del
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-'"..costspr.."' WHERE user_id='"..plr_id.."'");
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+'"..costspr.."' WHERE user_id='22'");
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..plr_id.."', lbank_touserid = '22', lbank_kwota='"..costspr.."', lbank_data=NOW(), lbank_desc='Zakup pojazdu (cygan/salon).', lbank_type='1'");
			
			local money = string.format("%.2f", costspr/100)
			
    		local transfer_text=('[SALON/CYGAN] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' kupił: '..getVehicleName(vehicle)..' (ID:'..veh_idNew..') za '..money..'$')	
			outputServerLog(transfer_text)
	
			local desc22 = 'SALON/CYGAN: '..getPlayerName(plr)..'/'..getElementData(plr,"id")..' kupił: '..getVehicleName(vehicle)..' (ID:'..veh_idNew..') za '..money..'$'
			triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
			
			outputChatBox("#388E00✔#e7d9b0 Pomyślnie zakupiono pojazd marki "..getVehicleName(vehicle)..".", plr,231, 217, 176,true)
		end
	end
end
end)






