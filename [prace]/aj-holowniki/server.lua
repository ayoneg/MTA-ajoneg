--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy holiwników publicznych.
]]--

--local obszar_dwa = createColCuboid(1903.89453125, 2324.0859375, 10.8203125-1, 10, 5, 4)
--local obszar_trzy = createColCuboid(1903.89453125, 2318.7509765625, 10.8203125-1, 10, 5, 4)

--local obszar = createColCuboid(1852.1982421875, 2285.0556640625, 10.979915618896-1, 70, 70, 10)
local visu_obszar = createMarker(1900.185546875, 2294.6435546875, 10.8203125-4, "cylinder", 10, 255, 255, 255, 44)

--local wytep = createColCuboid(1896.4169921875, 2287.4140625, 10.8203125-1, 10, 10, 4)
local wytep = createColSphere(1900.185546875, 2294.6435546875, 10.8203125, 5.3)

local pracaholo = createBlip(1908.8466796875, 2302.59765625, 10.8203125, 51, 2, 255, 0, 0, 155, -100, 500)

local holiwniki_lv = {
	{1909.12109375, 2326.478515625, 10.69, 90},
	{1909.12109375, 2321.5546875, 10.69, 90},
}

local ubpops = createColCuboid(1905.89453125, 2318.7509765625, 10.8203125-1, 8, 10.3, 4)
------------------------------------------------------

function createMarkerAttachedTo(element, mType, size, r, g, b, a, visibleTo, xOffset, yOffset, zOffset)
	mType, size, r, g, b, a, visibleTo, xOffset, yOffset, zOffset = mType or "checkpoint", size or 4, r or 0, g or 0, b or 255, a or 255, visibleTo or getRootElement(), xOffset or 0, yOffset or 0, zOffset or 0
	assert(isElement(element), "Bad argument @ 'createMarkerAttachedTo' [Expected element at argument 1, got " .. type(element) .. "]") assert(type(mType) == "string", "Bad argument @ 'createMarkerAttachedTo' [Expected string at argument 2, got " .. type(mType) .. "]") assert(type(size) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 3, got " .. type(size) .. "]") assert(type(r) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 4, got " .. type(r) .. "]")	assert(type(g) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 5, got " .. type(g) .. "]") assert(type(b) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 6, got " .. type(b) .. "]") assert(type(a) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 7, got " .. type(a) .. "]") assert(isElement(visibleTo), "Bad argument @ 'createMarkerAttachedTo' [Expected element at argument 8, got " .. type(visibleTo) .. "]") assert(type(xOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 9, got " .. type(xOffset) .. "]") assert(type(yOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 10, got " .. type(yOffset) .. "]") assert(type(zOffset) == "number", "Bad argument @ 'createMarkerAttachedTo' [Expected number at argument 11, got " .. type(zOffset) .. "]")
	local m = createMarker(0, 0, 0, mType, size, r, g, b, a, visibleTo)
	if m then if attachElements(m, element, xOffset, yOffset, zOffset) then return m end end return false
end

function liczPoj()
    vehs=getElementsByType('vehicle')
	local liczba = 0
    for i,v in pairs(vehs) do
		local veh = getElementData(v,"vehicle:odznaczone") or false;
		local veh_hol = getElementData(v,"vehicle:holowane") or false;
		if veh==true and veh_hol==false then
--		    destroyElement(v)
			liczba = liczba + 1
--			setElementData(v,"vehicle:odznaczone:liczba",liczba)
		end
    end	
	return liczba
end

----------------------------------------------------------------

function delBlip(gracz)
    blip=getElementsByType('blip')
    for i,v in pairs(blip) do
        local m = getElementData(v,"job:id") or 0
		local p = getElementData(gracz,"player:dbid") or 0
		if m > 0 and m == p then
		    destroyElement(v)
		end
    end	
end

function delMarker(gracz)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
        local m = getElementData(v,"job:graczid") or 0
		local p = getElementData(gracz,"player:dbid") or 0
		if m > 0 and m == p then
		    destroyElement(v)
		end
    end	
end

-- test
function getNearestVehicle(player,distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local veh = getElementData(v,"vehicle:odznaczone") or false
		local veh_hol = getElementData(v,"vehicle:holowane") or false
		if veh and not veh_hol then
			local bum = isVehicleBlown(v) or false;
			local model = getElementModel(v);
			if not bum and ( not KatA[model] or not KatL[model] or not KatH[model] ) then
				local vint,vdim = getElementInterior(v),getElementDimension(v)
				if vint == pint and vdim == pdim then
					local vx,vy,vz = getElementPosition(v)
					local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
					if dis < distance then
						if dis < lastMinDis then 
							lastMinDis = dis
							nearestVeh = v
						end
					end
				end
			end
		end
	end
	return nearestVeh
end


-------------------------------------------------------------------------
-- TESTY NOWEJ FUNK()

-- LISTA AUT NA KAT A
KatA = { [581]=true,[462]=true,[521]=true,[463]=true,[463]=true,[522]=true,[461]=true,[448]=true,[468]=true,[586]=true,[523]=true,}
-- LISTA AUT NA KAT L
KatL = { [592]=true,[577]=true,[511]=true,[512]=true,[593]=true,[520]=true,[553]=true,[476]=true,[519]=true,[460]=true,[513]=true,}
-- LISTA AUT NA KAT H
KatH ={ [548]=true,[425]=true,[417]=true,[487]=true,[488]=true,[497]=true,[563]=true,[447]=true,[447]=true,[469]=true,}

-------------------------------------------------------------------------


addEvent("odswiezamPojazduHolowane", true)
addEventHandler("odswiezamPojazduHolowane", root, function(plr)
	local vehicle = getPedOccupiedVehicle(plr) or false;
	if not vehicle then return end
	local sprtest = getVehicleTowedByVehicle(vehicle) or false -- omg kocham funkcja <3
	if sprtest then triggerClientEvent("endJobTimerHolo",root,plr) return end
    if liczPoj() > 0 then
		delBlip(plr) --del
		delMarker(plr) --del
		
		local wyjmej = getNearestVehicle(plr,250)
		if wyjmej then
			jobblip = createBlipAttachedTo(wyjmej, 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
				
			jobmarker = createMarkerAttachedTo (wyjmej, "arrow", 1.5, 255, 0, 0, 102, plr, 0, 0, 3)
			setElementData(jobmarker,"job:graczid",getElementData(plr,"player:dbid"))
		end
	end
end)


local holowniki = {}

local notidl = {}
addEvent("addAdmNoti", true)
addEventHandler("addAdmNoti", root, function(CODE,tresc)
	if notidl[CODE] and getTickCount() < notidl[CODE] then return end
	for i,v in ipairs(getElementsByType("player")) do
		local admin_poziom = getElementData(v, "admin:poziom") or 0;
		local admin_duty = getElementData(v, "admin:zalogowano") or "false";
		local cfg = getElementData(v,"admin:admnoti") or true;
	    if admin_poziom >= 5 and admin_duty=="true" and cfg then
			outputChatBox("#cf0000"..CODE..": #ffffff"..tresc, v, _, _, _, true)
			playSoundFrontEnd(v,33)
		end
	end
	notidl[CODE] = getTickCount()+(120000*5); -- 10 min
end)

function unnA(cars)
	if #cars > 0 then
		for i,v in pairs(cars) do
			local salon = getElementData(v,"vehicle:salon") or false;
			if not salon then
				return true
			end
		end
	end
	return false
end

function delColShape(id)
    shape=getElementsByType('colshape')
    for i,v in pairs(shape) do
		if getElementData(v,"vehicle") == id then
		    destroyElement(v)
		end
    end	
end


function resetHOLOWNIKI()
	for i,v in pairs(holiwniki_lv) do
		if not holowniki[i] then	
			local pojazdy=getElementsWithinColShape(ubpops,"vehicle")
			local zwrot = unnA(pojazdy)
			if zwrot then
				setTimer(startHOLtimer, 1000, 1)
				triggerEvent("addAdmNoti",root,"HOLOWNIK","Nie mogę zrespić nowego pojazdu, spawn zablokowany!")
				return
			end
			
			
			local veh = createVehicle(525, v[1], v[2], v[3], 0, 0, v[4]+0.1)
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			local id = math.random(1000000,9999999)
			setElementData(veh,"vehicle:id", id)
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:spawnID",i)
			setElementData(veh,"vehicle:paliwo", 25)
			setElementData(veh,"vehicle:przebieg", 73922)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:salon",true)
			setElementData(veh,"vehicle:jobcode", "holownik-sa")
			setVehiclePlateText(veh,"LV "..getElementData(veh,"vehicle:id").."")
			setVehicleColor(veh, 0, 22, 44, 255, 112, 51)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
			holowniki[i] = true;
			holcolshape = createColSphere(v[1]+4.7, v[2], v[3], 1.6)
			setElementData(holcolshape,"vehicle",id)
			setElementData(veh,"vehicle:colshape",holcolshape)
			attachElements(holcolshape,veh,0, -4.3, 0)
		end
	end
end

function startHOLtimer()
	if isTimer(holtimer) then return end
	holtimer=setTimer(resetHOLOWNIKI, 25000, 1)
end

addEventHandler("onResourceStart", root, startHOLtimer)

			
addEventHandler("onColShapeHit", wytep, function(el,md)
	if getElementType(el) == "vehicle" then
		local sprtest = getVehicleTowedByVehicle(el) or false -- omg kocham funkcja <3
		if sprtest then
			--outputChatBox("id pojazdu to: "..getElementData(sprtest,"vehicle:id"),root)
			local plr = getVehicleOccupant(el) or false;
			if not plr then return end
			local uid = getElementData(plr,"player:dbid") or 0;
			if uid > 0 then
			
			local money = 2790;
			local money_dwa = string.format("%.2f", money/100)
			
			local getPLRmoney = getPlayerMoney(plr)
			local sprvalue = getPLRmoney + money;
			
			if 99999999 < sprvalue then 
				outputChatBox("#841515✖#e7d9b0 Błąd, gracz osiągną limit gotówki przy sobie!", plr,231, 217, 176,true) 
				exports["aj-vehs"]:zapiszPojazd(sprtest)
				triggerClientEvent("startJobTimerHolo",root,plr)
				delBlip(plr)
				delMarker(plr)
--				lossPoj(plr)
				return 
			end
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..money.." WHERE user_id = '"..uid.."'");
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..money.." WHERE user_id = '22'");
		
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..uid.."', lbank_kwota='"..money.."', lbank_data=NOW(), lbank_desc='Praca dorywcza HOLOWNIKI.', lbank_type='1'");
			local code = "holownik-sa";
			--joblog statystyka do poziomow etc
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='1', joblog_userid='"..uid.."'");
			
			local value = 1;
			local variant = "plus";
			local kaplicacode = "holownik-sa";
			local plr_rep = getElementData(plr,"player:reputacja") or 0;
			
			triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,plr,variant) --visu rep info
			
            local nev_repo = plr_rep + value;
			setElementData(plr,"player:reputacja",nev_repo)
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja+'"..value.."' WHERE user_id='"..uid.."'");
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..uid.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
			
			givePlayerMoney(plr, money) -- kasa
			
			outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..money_dwa.."$#e7d9b0 oraz #EBB85D+1 reputacji#e7d9b0 za odholowanie pojazdu.", plr,231, 217, 176,true)
			
			exports["aj-vehs"]:zapiszPojazd(sprtest)
			delBlip(plr)
			delMarker(plr)
			
			triggerClientEvent("startJobTimerHolo",root,plr)
--			lossPoj(plr)
			end -- uid
		end
	end
end)		
			
function reattachTrailer(theTruck)
    if source then
	    removeElementData(source,"vehicle:holowane")
		local plr = getVehicleOccupant(theTruck) or false;
		triggerClientEvent("startJobTimerHolo",root,plr)
	end
end
addEventHandler("onTrailerDetach", getRootElement(), reattachTrailer)
			
function detachTrailer(theTruck)
    local veh_odznaczone = getElementData(source,"vehicle:odznaczone") or false;
	local model = getElementModel(source) or false
	if veh_odznaczone == true and model ~= 525 then -- model zeby nie holowac holownika
    	setTimer(detachTrailer2, 50, 1, theTruck, source)
	else
	    local plr = getVehicleOccupant(theTruck) or false;
		if isElementFrozen(source) == false then
			setElementFrozen(source, true) -- bo po co, co chwile frezowac auto :)
		end
		outputChatBox("#841515✖#e7d9b0 Nie możesz odholować tego pojazdu.", plr,231, 217, 176,true)
	end
end
addEventHandler("onTrailerAttach", getRootElement(), detachTrailer)

function detachTrailer2(theTruck, trailer)
    if (isElement(theTruck) and isElement(trailer)) then
        local plr = getVehicleOccupant(theTruck) or false;
		if plr then
			setElementFrozen(trailer, false)
			setVehicleDamageProof(trailer, true)
			setElementData(trailer,"vehicle:holowane", true)
			delBlip(plr) --del
			delMarker(plr) --del
			gdzieoddac = createBlipAttachedTo(visu_obszar, 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(gdzieoddac,"job:id",getElementData(plr,"player:dbid"))
		    triggerClientEvent("endJobTimerHolo",root,plr)
		end
    end
end


function enterHolo(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "holownik-sa" then
--			local plr_uid = getElementData(plr,"player:dbid") or 0;
--			local code = "holownik-sa";
--			local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..plr_uid.."' AND joblog_code='"..code.."'");
--			local ilosc = tonumber(spr_mnoznik[1].ilosc);
--				if spr_mnoznik and ilosc >= 2000 then poziom = "4 LVL"; end
--				if spr_mnoznik and ilosc >= 1000 and ilosc < 2000 then poziom = "3 LVL"; end
--				if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then poziom = "2 LVL"; end
--				if spr_mnoznik and ilosc >= 0 and ilosc < 500 then poziom = "1 LVL"; end
--			outputChatBox("#388E00✔#e7d9b0 Aktualnie w pracy dorywczej #EBB85Dcysterny#e7d9b0, posiadasz #EBB85D"..ilosc.."#e7d9b0 punktów (#EBB85D"..poziom.."#e7d9b0).", plr,231, 217, 176,true)
--			lossPoj(plr)
			triggerClientEvent("startJobTimerHolo",root,plr)
			removeElementData(source,"vehicle:salon")
			setElementData(source,"vehicle:ogranicznik",65)
			
			local gbid = getElementData(source,"vehicle:spawnID") or false;
			if gbid then
				holowniki[gbid] = false;
				startHOLtimer()
			end
		end
	end
end
addEventHandler("onVehicleEnter", root, enterHolo)

function przerwijJobHolo(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "holownik-sa" then
		local sprtest = getVehicleTowedByVehicle(source) or false -- omg kocham funkcja <3
		delBlip(plr)
		delMarker(plr)
		local vehid = getElementData(source,"vehicle:id")
		delColShape(vehid)
		destroyElement(source)
--		antycheat[plr] = getTickCount()+120000; -- 2 min zabezpieczenia
		removeElementData(plr,"player:vehicleogranicznik")
		if sprtest then
		    removeElementData(sprtest,"vehicle:holowane")
		end
		triggerClientEvent("endJobTimerHolo",root,plr)
		end
	end
end
addEventHandler("onVehicleExit", root, przerwijJobHolo)

function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
	    local vehicle = getPedOccupiedVehicle(source) or false
		if vehicle ~= false then
		local kiero = getVehicleOccupant(vehicle) or false
		if kiero==source then
			local jobCode = getElementData(vehicle,"vehicle:jobcode") or false;
			if jobCode == "holownik-sa" then
				delBlip(source)
				delMarker(source) -- del
				local wD = getElementData(vehicle,"vehicle:id")
				delColShape(vehid)
				destroyElement(vehicle)
				triggerClientEvent("endJobTimerHolo",root,source)
			end
		end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)