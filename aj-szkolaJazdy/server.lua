-----------------------------------------------------------------
local prawko_wejscie = createMarker(-145.7158203125, 1172.439453125, 20.3421875, "arrow", 1.2, 255,255,0,50)
local prawko_wejscie_gp = createColSphere(-145.7158203125, 1172.439453125, 19.7421875, 1)
local prawko_wyjscie = createMarker(-2029.689453125, -119.62109375, 1035.7, "arrow", 1.2, 255,255,255,50)
    setElementInterior(prawko_wyjscie, 3)
	setElementDimension(prawko_wyjscie, 100)
	
createBlipAttachedTo(prawko_wejscie_gp, 36, 2, 0, 0, 0, 255, -100, 500)
	
addEventHandler("onColShapeHit", prawko_wejscie_gp, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 3, -2029.7607421875, -117.705078125, 1035.171875)
	setElementDimension(el, 100)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,rotZ-90,"default",true)
		setCameraTarget(el, el)
end)
-- // wyjscie urzad lv
addEventHandler("onMarkerHit", prawko_wyjscie, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 0, -145.451171875, 1176.5537109375, 19.7421875)
	setElementDimension(el, 0)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,rotZ+180,"default",true)
		setCameraTarget(el, el)
end)
-----------------------------------------------------------------

local terenREspaFury = createColCuboid(-139.41796875, 1177.455078125, 19.749988555908-1, 5, 10, 4)

local aktualny_postep = {}

local egzamin_trasa = {
{-141.1953125, 1198.4697265625, 19.296449661255},
{-192.6904296875, 1200.416015625, 19.297826766968},
{-262.3017578125, 1200.9033203125, 19.299795150757},
{-277.474609375, 1159.7060546875, 19.296688079834},
{-337.541015625, 1150.6318359375, 19.298360824585},
{-348.013671875, 1107.1689453125, 19.297807693481},
{-329.439453125, 1095.689453125, 19.289806365967},
{-316.6318359375, 1065.86328125, 19.297035217285},
{-287.810546875, 1061.01953125, 19.298851013184},
{-276.650390625, 1021.8984375, 19.299272537231},
{-205.794921875, 1015.9912109375, 19.292222976685},
{-197.0712890625, 987.0107421875, 19.017063140869},
{-213.267578125, 879.642578125, 9.9820823669434},
{-283.37109375, 819.880859375, 13.95606803894},
{-244.3466796875, 786.5791015625, 17.358543395996},
{-126.7841796875, 819.5615234375, 20.527803421021},
{103.04296875, 884.5615234375, 22.097314834595},
{215.552734375, 961.65234375, 27.895784378052},
{348.7685546875, 1006.1201171875, 28.146036148071},
{745.0419921875, 1109.3193359375, 28.152656555176},
{836.48046875, 1186.92578125, 27.156408309937},
{792.3046875, 1312.7314453125, 24.997774124146},
{821.189453125, 1519.1552734375, 17.729808807373},
{832.3701171875, 1727.3984375, 4.7915992736816},
{815.1064453125, 1811.548828125, 3.3260588645935},
{747.720703125, 1850.234375, 5.2477235794067},
{669.2265625, 1865.123046875, 5.1670112609863},
{639.833984375, 1763.8955078125, 4.651312828064},
{473.0205078125, 1648.7783203125, 14.806705474854},
{384.45703125, 1544.4013671875, 13.963520050049},
{314.681640625, 1299.9072265625, 11.806549072266},
{191.638671875, 1161.2109375, 14.471056938171},
{112.2685546875, 1211.9072265625, 19.13471031189},
{-112.1796875, 1259.9306640625, 16.601737976074},
{-118.5380859375, 1185.7236328125, 19.299802780151},
{-141.591796875, 1161.490234375, 19.452222824097},
}

function sprEgzamin(gracz,iD)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
	    local m = getElementData(v,"markerB:step") or 0
		if m > 0 and m == iD and getElementData(v,"markerB:player") == getElementData(gracz,"player:dbid") then
		    return true
		else
		    return false
		end
    end	
end

function delMarker(obID,gracz)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
        local m = getElementData(v,"markerB:step") or 0
		if m > 0 and m == obID and getElementData(v,"markerB:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

function delBlip(obID,gracz)
    blip=getElementsByType('blip')
    for i,v in pairs(blip) do
        local m = getElementData(v,"blipB:step") or 0
		if m > 0 and m == obID and getElementData(v,"blipB:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

function punktPlus(gracz)
	sp = aktualny_postep[gracz]
	sp = sp + 1;
	for i,v in ipairs(egzamin_trasa) do
		if i == sp then 
			return v
		end
	end
	return false
end

function pokazTrase(gracz)
	for i,v in ipairs(egzamin_trasa) do
		if i == aktualny_postep[gracz] then 
		    trasa = createMarker(v[1], v[2], v[3], "checkpoint", 3, 0, 0, 177, 255, gracz)
			bliptrasy = createBlip(v[1], v[2], v[3], 12, 0, 0, 0, 0, 255, 1, 2000, gracz)
			mark = punktPlus(gracz)
			if mark then
				setMarkerTarget(trasa, mark[1], mark[2], mark[3])
			end
			setElementData(trasa,"markerB:step",i)
			setElementData(trasa,"markerB:player",getElementData(gracz,"player:dbid"))
			setElementData(bliptrasy,"blipB:step",i)
			setElementData(bliptrasy,"blipB:player",getElementData(gracz,"player:dbid"))
			playSoundFrontEnd(gracz, 20)
		end
	end
end -- 4,5 min

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
    sprpostee = aktualny_postep[el] or 0
    if (sprpostee < 1 ) then return end
    if (not md) then return end
    local spregzam = getElementData(el,"player:egzamin") or false
	if spregzam == "prawkoB" then
		local sprstep = getElementData(source,"markerB:step") or 0;
		if sprstep == aktualny_postep[el] then
		    delMarker(aktualny_postep[el],el)
			delBlip(aktualny_postep[el],el)
		    aktualny_postep[el] = aktualny_postep[el] + 1
	        pokazTrase(el)
			local veh = getPedOccupiedVehicle(el)
			if aktualny_postep[el] == 12 then
				setElementData(veh,"vehicle:ogranicznik",90)
			end
			if aktualny_postep[el] == 35 then
				setElementData(veh,"vehicle:ogranicznik",60)
			end
			if aktualny_postep[el] == 37 then
			    local vehicle = getPedOccupiedVehicle(el)
			    local egzaminator = getVehicleOccupant(vehicle, 1) or false;
				
				triggerClientEvent("killTimerClientSideB",root,el)
				
			    destroyElement(vehicle)
			    destroyElement(egzaminator)
		
			    outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został pomyślnie ukończony!", el, 255, 255, 255, true)
				outputChatBox("#e7d9b0Gratulacje, otrzymałeś prawa jazdy #EBB85Dkat. B#e7d9b0!!", el, 255, 255, 255, true)
				removeElementData(el,"player:egzamin")
			    wytepaGracza(el)
			    delMarker(aktualny_postep[el],el)
				delBlip(aktualny_postep[el],el)
				aktualny_postep[el] = 0
				
				setElementData(el,"player:katB", 1)
				local uid = getElementData(el,"player:dbid") or 0;
				if uid > 0 then
				    local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_katB='1' WHERE user_id='"..uid.."'");
				end
			end
		end
	end
end)

addEvent("respPojazdPrawka", true)
addEventHandler("respPojazdPrawka", root, function(plr)
    local uid = getElementData(plr,"player:dbid")
    if not uid then return end
	if #getElementsWithinColShape(terenREspaFury,"vehicle") > 0 then
	-- na terenie egzaminu jest gracz rob pojazd - nie mozemy zaczac
	    outputChatBox("* Na terenie egzaminu znajduje się już pojazd!", plr, 222, 0, 0, true)
		return
    end
	local katB = getElementData(plr,"player:katB") or 0;
	if katB > 0 then
	    outputChatBox("* Posiadasz już zaliczony ten egzamin!", plr, 222, 0, 0, true)
		return
    end
	local code = "UM-3"
	local query = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_userid=? AND joblog_code=?",uid,code);
	if #query == 0 then
	    outputChatBox("* Aby przystąpić do egzaminu praktycznego, najpierw zdaj część teoretyczną w urzędzie!", plr, 222, 0, 0, true)
		return
    end
local veh = createVehicle(589, -137.34375, 1182.244140625, 19.449988555908, 0, 0, 0);
setVehicleVariant(veh, 5, 0)

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

setElementData(plr,"player:egzamin","prawkoB")

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
	aktualny_postep[plr] = 1
	pokazTrase(plr)
	end
end, czas, 1)
end


function rozpocznijCzasEgzaminu(plr,text)
if plr then

	local vehicle = getPedOccupiedVehicle(plr)
	if not vehicle then return end
	if getElementData(vehicle,"vehicle:owner") ~= "Egzamin" then return end
	
	local sprtimer = getElementData(plr,"player:egzamin") or false;
	if sprtimer == "prawkoB" then
	
	triggerClientEvent("startTimerClientSideB",root,plr,text)

    end
end
--270000
end

addEvent("removeEgzaminServerSideB", true)
addEventHandler("removeEgzaminServerSideB", root, function(plr,text)

    outputChatBox("#EBB85DEgzaminator#e7d9b0: "..text, plr, 255, 255, 255, true)  
	local vehicle = getPedOccupiedVehicle(plr)
	local egzaminator = getVehicleOccupant(vehicle, 1) or false;
	destroyElement(vehicle)
	destroyElement(egzaminator)

	removeElementData(plr,"player:egzamin")
	wytepaGracza(plr)
	delMarker(aktualny_postep[plr],plr)
	delBlip(aktualny_postep[plr],plr)
	aktualny_postep[plr] = 0
	
end)


addCommandHandler("postep", function(plr,cmd)
   local uid = getElementData(plr,"player:dbid") or 0;
   if uid > 0 then
      outputChatBox(aktualny_postep[plr], plr)
   end
end)

function przerwijegzamin(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
    local spregzam = getElementData(plr,"player:egzamin") or false
	if spregzam == "prawkoB" then
	local spregzamincar = getElementData(source,"vehicle:owner") or 0;
	if spregzamincar == "Egzamin" then
		local egzaminator = getVehicleOccupant(source, 1) or false;
		destroyElement(source)
		destroyElement(egzaminator)
		
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", plr, 255, 255, 255, true)

		removeElementData(plr,"player:egzamin")
		wytepaGracza(plr)
		delMarker(aktualny_postep[plr],plr)
		delBlip(aktualny_postep[plr],plr)
		aktualny_postep[plr] = 0
		
		triggerClientEvent("killTimerClientSideB",root,plr)
	end
	end
	end
end
addEventHandler("onVehicleExit", root, przerwijegzamin)

local czas_uszko = {}

function dajInfoJakElkaUdezy(loss)
if source then
    local plr = getVehicleOccupant(source) or false
	if plr then
	local spregzamincar = getElementData(source,"vehicle:owner") or 0;
    local spregzam = getElementData(plr,"player:egzamin") or false
	if spregzam == "prawkoB" then
	if spregzamincar == "Egzamin" then
	if czas_uszko[plr] and getTickCount() < czas_uszko[plr] then
	    return 
	end
	if getElementHealth(source) < 949 then
		local egzaminator = getVehicleOccupant(source, 1) or false;
		destroyElement(source)
		destroyElement(egzaminator)
		
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", plr, 255, 255, 255, true)

		removeElementData(plr,"player:egzamin")
		wytepaGracza(plr)
		delMarker(aktualny_postep[plr],plr)
		delBlip(aktualny_postep[plr],plr)
		aktualny_postep[plr] = 0
		
		triggerClientEvent("killTimerClientSideB",root,plr)
	    return 
	end
    if (plr) then -- Check there is a player in the vehicle
		outputChatBox("#EBB85DEgzaminator#e7d9b0: Uszkodzenie pojazdu poniżej #EBB85D95%#e7d9b0 spowoduje przerwanie egzaminu.", plr, 255, 255, 255, true)
		czas_uszko[plr] = getTickCount()+5000; -- 5 sek zabezpieczenia
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
		if sprgracz == "prawkoB" then 
	    	local vehicle = getPedOccupiedVehicle(source) or false
			if vehicle ~= false then
				local egzaminator = getVehicleOccupant(vehicle, 1) or false;
				destroyElement(vehicle)
				destroyElement(egzaminator)

				outputChatBox("#EBB85DEgzaminator#e7d9b0: Egzamin został przerwany, żegnam...", source, 255, 255, 255, true)
--				removeElementData(source,"player:vehicleogranicznik")
				removeElementData(source,"player:egzamin")
				delMarker(aktualny_postep[source],source)
				delBlip(aktualny_postep[source],source)
				aktualny_postep[source] = 0
				
				triggerClientEvent("killTimerClientSideB",root,source)
			end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)


function wytepaGracza(plr)
    setTimer(function()
        setElementPosition(plr, -153.072265625, 1177.8486328125, 19.7421875)
    end, 50, 1)
end