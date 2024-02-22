-----------------------------------------------------------------
local prawko_wejscieC = createMarker(1707.3427734375, 950.3154296875, 11.5203125, "arrow", 1.2, 255,255,0,50)
local prawko_wejscie_gpC = createColSphere(1707.3427734375, 950.3154296875, 10.8203125, 1)
local prawko_wyjscieC = createMarker(-2029.689453125, -119.62109375, 1035.7, "arrow", 1.2, 255,255,255,50)
    setElementInterior(prawko_wyjscieC, 3)
	setElementDimension(prawko_wyjscieC, 500)
	
createBlipAttachedTo(prawko_wejscie_gpC, 36, 2, 0, 0, 0, 255, -100, 500)
	
addEventHandler("onColShapeHit", prawko_wejscie_gpC, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 3, -2029.7607421875, -117.705078125, 1035.171875)
	setElementDimension(el, 500)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,0,"default",true)
		setCameraTarget(el, el)
end)
-- // wyjscie urzad lv
addEventHandler("onMarkerHit", prawko_wyjscieC, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 0, 1703.8505859375, 949.3291015625, 10.8203125)
	setElementDimension(el, 0)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,90,"default",true)
		setCameraTarget(el, el)
end)
-----------------------------------------------------------------

local terenREspaFury = createColCuboid(1692.5927734375, 956.6201171875, 10.784565925598-1, 17, 10, 4)

local aktualny_postepC = {}

local egzamin_trasaC = {
	{1682.66015625, 961.6201171875, 10.733322143555, 3.5},
	{1664.962890625, 944.916015625, 10.671875, 3.5},
	{1575.4384765625, 935.46875, 10.427215576172, 3.5},
	{1566.22265625, 919.828125, 10.454296112061, 3.5},
	{1510.013671875, 920.0234375, 10.377800941467, 3.5},
	{1510.05859375, 1123.24609375, 10.383017539978, 3.5},
	{1445.6806640625, 1191.3173828125, 10.376389503479, 3.5},
	{1245.2119140625, 1194.986328125, 12.617444992065, 3.5},
	{1022.2392578125, 1195.8232421875, 10.453783035278, 3.5},
	{1010.126953125, 1338.587890625, 10.377309799194, 3.5}, --10
	{1010.3974609375, 1640.9306640625, 10.477554321289, 3.5},
	{1009.3984375, 1809.6796875, 10.517985343933, 3.5},
	{1009.056640625, 1950.03125, 10.691086769104, 3.5},
	{1103.55859375, 1952.4296875, 10.374886512756, 3.5},
	{1110.6064453125, 2048.0693359375, 10.47861289978, 3.5},	
	{1297.1025390625, 2050.3935546875, 10.554366111755, 3.5},
	{1527.8701171875, 2055.228515625, 10.562346458435, 3.5},
	{1532.3564453125, 2168.4912109375, 10.377103805542, 3.5},
	{1569.5732421875, 2176.58984375, 10.53621673584, 3.5},
	{1568.529296875, 2387.498046875, 10.375776290894, 3.5},--20
	{1481.8984375, 2396.88671875, 10.483667373657, 3.5},
	{1483.0458984375, 2586.3154296875, 10.594278335571, 3.5},
	{1588.736328125, 2593.599609375, 10.553427696228, 3.5},
	{1587.1484375, 2676.15234375, 10.376783370972, 3.5},
	{1548.328125, 2728.8984375, 10.501143455505, 3.5},
	{1683.5751953125, 2727.900390625, 10.46302986145, 3.5},
	{1904.123046875, 2708.5263671875, 10.477207183838, 3.5},
	{1907.1337890625, 2647.8193359375, 10.376824378967, 3.5},
	{2086.34375, 2646.36328125, 10.376595497131, 3.5},
	{2091.5458984375, 2768.62109375, 10.377011299133, 3.5},--30
	{2224.115234375, 2767.1337890625, 10.48508644104, 3.5},
	{2229.216796875, 2714.8671875, 10.376702308655, 3.5},
	{2382.8486328125, 2708.8798828125, 10.492713928223, 3.5},
	{2384.7578125, 2521.6015625, 10.415349960327, 3.5},
	{2364.95703125, 2502.779296875, 10.397242546082, 3.5},
	{2364.8623046875, 2421.3154296875, 10.418727874756, 3.5},
	{2522.943359375, 2409.248046875, 10.489085197449, 3.5},
	{2525.1064453125, 2243.46484375, 10.414202690125, 3.5},
	{2524.5966796875, 2117.24609375, 10.459577560425, 3.5},-- ogra
	{2632.6435546875, 2107.8662109375, 10.572136878967, 3.5},-- ogra --40
	{2699.3916015625, 1987.083984375, 6.4434280395508, 3.5},
	{2705.939453125, 1644.3154296875, 6.4398055076599, 3.5},
	{2701.0908203125, 1075.9453125, 6.4398670196533, 3.5},
	{2418.19921875, 860.6728515625, 6.4389863014221, 3.5},-- 46
	{2298.9736328125, 922.705078125, 10.347544670105, 3.5},-- off ogr --46
	{2290.224609375, 965.6298828125, 10.425217628479, 3.5},
	{2083.333984375, 975.4521484375, 10.375819206238, 3.5},
	{2012.6689453125, 974.578125, 10.376620292664, 3.5},
	{2001.82421875, 937.427734375, 10.376420974731, 3.5}, --50
	{1872.2412109375, 936.7724609375, 10.375852584839, 3.5},
	{1865.162109375, 1132.6298828125, 10.37621307373, 3.5},
	{1565.9970703125, 1135.576171875, 10.494789123535, 3.5},
	{1565.142578125, 949.8017578125, 10.379283905029, 3.5},
	{1667.7763671875, 936.80078125, 10.376651763916, 3.5},
	{1654.59375, 966.9423828125, 10.52367401123, 3.5},
	{1635.5625, 981.607421875, 10.523654937744, 3.5}, -- end --57
}

function sprEgzamin(gracz,iD)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
	    local m = getElementData(v,"markerC:step") or 0
		if m > 0 and m == iD and getElementData(v,"markerC:player") == getElementData(gracz,"player:dbid") then
		    return true
		else
		    return false
		end
    end	
end

function delMarker(obID,gracz)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
        local m = getElementData(v,"markerC:step") or 0
		if m > 0 and m == obID and getElementData(v,"markerC:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

function delBlip(obID,gracz)
    blip=getElementsByType('blip')
    for i,v in pairs(blip) do
        local m = getElementData(v,"blipC:step") or 0
		if m > 0 and m == obID and getElementData(v,"blipC:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

function punktPlus(gracz)
	sp = aktualny_postepC[gracz]
	sp = sp + 1;
	for i,v in ipairs(egzamin_trasaC) do
		if i == sp then 
			return v
		end
	end
	return false
end

function pokazTrase(gracz)
	for i,v in ipairs(egzamin_trasaC) do
		if i == aktualny_postepC[gracz] then 
		    trasa = createMarker(v[1], v[2], v[3], "checkpoint", v[4], 0, 0, 177, 255, gracz)
			bliptrasy = createBlip(v[1], v[2], v[3], 12, 0, 0, 0, 0, 255, 1, 2000, gracz)
			mark = punktPlus(gracz)
			if mark then
				setMarkerTarget(trasa, mark[1], mark[2], mark[3])
			end
			setElementData(trasa,"markerC:step",i)
			setElementData(trasa,"markerC:player",getElementData(gracz,"player:dbid"))
			setElementData(bliptrasy,"blipC:step",i)
			setElementData(bliptrasy,"blipC:player",getElementData(gracz,"player:dbid"))
			playSoundFrontEnd(gracz, 20)
		end
	end
end -- 4,5 min

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
    sprpostee = aktualny_postepC[el] or 0
    if (sprpostee < 1 ) then return end
    if (not md) then return end
--    if (not isElementVisibleTo(source, el)) then return end
    local spregzam = getElementData(el,"player:egzamin") or false
	if spregzam == "prawkoC" then
		local sprstep = getElementData(source,"markerC:step") or 0;
		if sprstep == aktualny_postepC[el] then
		    delMarker(aktualny_postepC[el],el)
			delBlip(aktualny_postepC[el],el)
		    aktualny_postepC[el] = aktualny_postepC[el] + 1
	        pokazTrase(el)
			local veh = getPedOccupiedVehicle(el)
			if aktualny_postepC[el] == 41 then
			    setElementData(veh,"vehicle:ogranicznik",140)
			end
			if aktualny_postepC[el] == 46 then
			    setElementData(veh,"vehicle:ogranicznik",60)
			end
			if aktualny_postepC[el] == 57 then
			    local vehicle = getPedOccupiedVehicle(el)
			    local egzaminator = getVehicleOccupant(vehicle, 1) or false;
				
				triggerClientEvent("killTimerClientSideC",root,el)
				
			    destroyElement(vehicle)
			    destroyElement(egzaminator)
		
			    outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został pomyślnie ukończony!", el, 255, 255, 255, true)
				outputChatBox("#e7d9b0Gratulacje, otrzymałeś prawa jazdy #EBB85Dkat. C#e7d9b0!", el, 255, 255, 255, true)
				removeElementData(el,"player:egzamin")
			    wytepaGraczaC(el)
			    delMarker(aktualny_postepC[el],el)
				delBlip(aktualny_postepC[el],el)
				aktualny_postepC[el] = 0
				
				setElementData(el,"player:katB", 1)
				local uid = getElementData(el,"player:dbid") or 0;
				if uid > 0 then
				    local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_katC='1' WHERE user_id='"..uid.."'");
				end
			end
		end
	end
end)

addEvent("respPojazdPrawkaC", true)
addEventHandler("respPojazdPrawkaC", root, function(plr)
    local uid = getElementData(plr,"player:dbid")
    if not uid then return end
	if #getElementsWithinColShape(terenREspaFury,"vehicle") > 0 then
	-- na terenie egzaminu jest gracz rob pojazd - nie mozemy zaczac
	    outputChatBox("* Na terenie egzaminu znajduje się już pojazd!", plr, 222, 0, 0, true)
		return 
    end
	local katC = getElementData(plr,"player:katC") or 0;
	if katC > 0 then
	    outputChatBox("* Posiadasz już zaliczony ten egzamin!", plr, 222, 0, 0, true)
		return
    end
	local code = "UM-4"
	local query = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_userid=? AND joblog_code=?",uid,code);
	if #query == 0 then
	    outputChatBox("* Aby przystąpić do egzaminu praktycznego, najpierw zdaj część teoretyczną w urzędzie!", plr, 222, 0, 0, true)
		return
    end
local veh = createVehicle(573, 1699.9384765625, 961.3583984375, 11.3, 0, 0, 90);
setVehicleVariant(veh, 0, 1)

setElementInterior(veh,0)
setElementDimension(veh,0)
setElementInterior(plr,0)
setElementDimension(plr,0)
warpPedIntoVehicle(plr,veh)
			
setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
setElementData(veh,"vehicle:owner", "Egzamin")
setElementData(veh,"vehicle:paliwo", 25)
setElementData(veh,"vehicle:przebieg", 90430)
setElementData(veh,"vehicle:odznaczone",true)
setElementData(veh,"vehicle:vopis","EGZAMIN")
setVehiclePlateText(veh,"EGZAMIN "..getElementData(veh,"vehicle:id").."")
exports["aj-vehsSirens"]:vehSirens(veh)
setVehicleColor(veh, 255, 255, 255, 255, 255, 255)
setElementFrozen(veh, true)

setElementData(plr,"player:egzamin","prawkoC")
--setElementData(plr,"player:egzaminID",getElementData(veh,"vehicle:id"))
local egzaminator = createPed(9, 0, 0, -30, 0)
setElementData(egzaminator,"ped:name","Egzaminator")
warpPedIntoVehicle(egzaminator, veh, 1)


local text = "Czas na ukończenie egzaminu miną, oblałeś/aś."
rozpocznijCzasEgzaminu(plr,text)

local czas = 0
local value = 1
local text = "Zaraz ruszamy, zciągnij ręczny, odpal światła mijania oraz odpal silnik."
pokazText(czas,text,plr,value)

local czas = 300
local value = 0
local text = "Podążaj za wyznaczonymi punktami."
pokazText(czas,text,plr,value)

setElementData(veh,"vehicle:ogranicznik",60)

end)

function pokazText(czas,text,plr,value)
setTimer(function()
    outputChatBox("#EBB85DEgzaminator#e7d9b0: "..text, plr, 255, 255, 255, true)  
	if tonumber(value) == 0 then
	aktualny_postepC[plr] = 1
	pokazTrase(plr)
	end
end, czas, 1)
end


function rozpocznijCzasEgzaminu(plr,text)
if plr then
	local vehicle = getPedOccupiedVehicle(plr)
	if not vehicle then return end
	if getElementData(vehicle,"vehicle:owner") ~= "Egzamin" then return end
	
	local sprtimer = getElementData(plr,"player:egzamin") or false
	if sprtimer == "prawkoC" then
	
	triggerClientEvent("startTimerClientSideC",root,plr,text)
	
    end
end
end

addEvent("removeEgzaminServerSideC", true)
addEventHandler("removeEgzaminServerSideC", root, function(plr,text)

    outputChatBox("#EBB85DEgzaminator#e7d9b0: "..text, plr, 255, 255, 255, true)  
	local vehicle = getPedOccupiedVehicle(plr)
	local egzaminator = getVehicleOccupant(vehicle, 1) or false;
	destroyElement(vehicle)
	destroyElement(egzaminator)
	removeElementData(plr,"player:egzamin")
	wytepaGraczaC(plr)
	delMarker(aktualny_postepC[plr],plr)
	delBlip(aktualny_postepC[plr],plr)
	aktualny_postepC[plr] = 0
	
end)



addCommandHandler("postep", function(plr,cmd)
   local uid = getElementData(plr,"player:dbid") or 0;
   if uid > 0 then
      outputChatBox(aktualny_postepC[plr], plr)
   end
end)

function przerwijegzamin(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
    local spregzam = getElementData(plr,"player:egzamin") or false
	if spregzam == "prawkoC" then
	local spregzamincar = getElementData(source,"vehicle:owner") or 0;
	if spregzamincar == "Egzamin" then
		local egzaminator = getVehicleOccupant(source, 1) or false;
		destroyElement(source)
		destroyElement(egzaminator)
		
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", plr, 255, 255, 255, true)
		removeElementData(plr,"player:egzamin")
		wytepaGraczaC(plr)
		delMarker(aktualny_postepC[plr],plr)
		delBlip(aktualny_postepC[plr],plr)
		aktualny_postepC[plr] = 0
		
		triggerClientEvent("killTimerClientSideC",root,plr)
	end
	end
	end
end
addEventHandler("onVehicleExit", root, przerwijegzamin)

local czas_uszkoC = {}

function dajInfoJakElkaUdezy(loss)
if source then
    local plr = getVehicleOccupant(source) or false
	if plr then
	local spregzamincar = getElementData(source,"vehicle:owner") or 0;
    local spregzam = getElementData(plr,"player:egzamin") or false
	if spregzam == "prawkoC" then
	if spregzamincar == "Egzamin" then
	if czas_uszkoC[plr] and getTickCount() < czas_uszkoC[plr] then
	    return 
	end
	if getElementHealth(source) < 949 then
		local egzaminator = getVehicleOccupant(source, 1) or false;
		destroyElement(source)
		destroyElement(egzaminator)
		
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", plr, 255, 255, 255, true)
		removeElementData(plr,"player:egzamin")
		wytepaGraczaC(plr)
		delMarker(aktualny_postepC[plr],plr)
		delBlip(aktualny_postepC[plr],plr)
		aktualny_postepC[plr] = 0
		
		triggerClientEvent("killTimerClientSideC",root,plr)
	    return 
	end
    if (plr) then -- Check there is a player in the vehicle
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Uszkodzenie pojazdu poniżej #EBB85D95%#e7d9b0 spowoduje przerwanie egzaminu.", plr, 255, 255, 255, true)
		czas_uszkoC[plr] = getTickCount()+5000; -- 5 sek zabezpieczenia
    end
	end
	end
	end
end
end
addEventHandler("onVehicleDamage", root, dajInfoJakElkaUdezy)


function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
    	local sprgracz = getElementData(source,"player:egzamin") or false;
		if sprgracz == "prawkoC" then 
	    	local vehicle = getPedOccupiedVehicle(source) or false
			if vehicle ~= false then
				local egzaminator = getVehicleOccupant(vehicle, 1) or false;
				destroyElement(vehicle)
				destroyElement(egzaminator)

				outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", source, 255, 255, 255, true)
				removeElementData(source,"player:egzamin")
				delMarker(aktualny_postepC[source],source)
				delBlip(aktualny_postepC[source],source)
				aktualny_postepC[source] = 0
				
				triggerClientEvent("killTimerClientSideC",root,source)
			end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)


function wytepaGraczaC(plr)
    setTimer(function()
        setElementPosition(plr, 1701.4716796875, 946.47265625, 10.8203125)
    end, 50, 1)
end