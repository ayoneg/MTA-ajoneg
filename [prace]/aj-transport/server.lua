--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy transportera pojazdów.
]]--
local pracatransport = createBlip(2822.857421875, 936.2109375, 16.397619247437, 51, 2, 255, 0, 0, 155, -100, 500)

local wymagane_pg = 1000

--local obszar = createColCuboid(2777.6328125, 833.623046875, 10.8984375-1, 130, 200, 10)

--local obszar_dwa = createColCuboid(2849.28125, 924.28125, 10.75-1, 8, 15, 4)
--local obszar_trzy = createColCuboid(2857.27734375, 924.2607421875, 10.75-1, 8, 15, 4)
--local obszar_cztery = createColCuboid(2865.30078125, 924.1845703125, 10.75-1, 8, 15, 4)

local ubpops = createColCuboid(2851.28125, 926.28125, 10.75-1, 19.6, 11, 4)

local lawety_lv = {
{2853.2685546875, 931.408203125, 10.75, 180},
{2861.0849609375, 931.408203125, 10.75, 180},
{2869.056640625, 931.408203125, 10.75, 180},
}

local punkty_ladowania = {
{2804.3330078125, 965.130859375, 10.75},
{2804.251953125, 985.0927734375, 10.75},
{2831.5146484375, 990.4541015625, 10.75},
{2836.3828125, 990.560546875, 10.75},
}

local punkty_dostaw = {
{2811.626953125, 2589.7197265625, 9.9278020858765},
{2790.421875, 2571.0146484375, 10.078592300415},
{2784.126953125, 2564.927734375, 10.088073730469},
{2354.2060546875, 2816.8974609375, 10.525806427002},
{2417.115234375, 2814.8251953125, 10.525673866272}, --5
{1024.5712890625, 2110.5146484375, 10.524404525757},
{1053.1708984375, 2190.6728515625, 10.524384498596},
{1079.2021484375, 2070.0078125, 10.524696350098},
{978.8994140625, 2094.3115234375, 10.524537086487},
{1124.6865234375, 1963.365234375, 10.524384498596},
{1591.3955078125, 2367.7314453125, 10.524765014648},
{1638.19921875, 2340.2900390625, 9.9618091583252},
{1637.080078125, 2312.4970703125, 10.055260658264},
{1637.2314453125, 2303.0068359375, 10.042608261108},
{1692.830078125, 2293.3662109375, 10.52508354187},
{1682.181640625, 2303.2060546875, 10.003524780273},
{1682.3603515625, 2312.4365234375, 10.018005371094},
{1682.3173828125, 2339.986328125, 10.015049934387},
{1425.353515625, 1067.2529296875, 9.9882860183716},
{1424.5556640625, 1039.240234375, 10.056374549866},
{1424.6435546875, 1029.927734375, 10.047793388367},
{1424.5556640625, 974.5517578125, 9.9823303222656},
{1452.4931640625, 974.619140625, 9.9877138137817},
{1461.7490234375, 974.4814453125, 9.9773149490356},
{1469.3173828125, 1029.8037109375, 9.9757423400879},
{1469.03515625, 1039.26171875, 9.9520788192749},
{1469.75390625, 1066.873046875, 10.012167930603},
--{-1733.3994140625, 190.0078125, 3.2587640285492}, -- doki sf ??
{2507.92578125, -2628.787109375, 13.350746154785},
{2548.3828125, -2483.9794921875, 13.350299835205},
{2793.8349609375, -2520.986328125, 13.334380149841},

{2224.9462890625, -2461.939453125, 13.139142036438},
{2401.771484375, -2262.02734375, 13.081789016724},
{2694.0458984375, -2227.181640625, 13.253367424011},
{2291.3525390625, -2344.9169921875, 13.251236915588},
{2283.6572265625, -2350.9521484375, 13.251289367676},
{2298.1083984375, -2337.154296875, 13.252062797546},
{2178.15234375, -2304.9794921875, 13.251310348511},
{90.216796875, -303.69140625, 1.2822521924973},
{159.7353515625, -22.23828125, 1.2834410667419},
{214.541015625, 24.1708984375, 2.2789614200592},

{-520.6572265625, -501.4599609375, 24.931396484375},
{-529.685546875, -502.61328125, 24.83504486084},
{-557.5380859375, -502.271484375, 24.863605499268},
}

-- info
for i,v in ipairs(punkty_ladowania) do
	t = createElement("text")
	setElementData(t,"name","Punkt załadunku, nie zastawiać!")
	setElementData(t,"scale",1)
	setElementData(t,"distance",20)
	setElementPosition(t,v[1],v[2],v[3]+3)
end


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

function delObject(gracz)
    object=getElementsByType('object')
    for i,v in pairs(object) do
        local m = getElementData(v,"job:PojazdNaLawecie") or 0
		local p = getElementData(gracz,"player:dbid") or 0
		if m > 0 and p==m and isElementAttached(v)==true then
		    destroyElement(v)
		end
    end	
end
--- new

local transport = {}

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

function resetLAWETY()
	for i,v in pairs(lawety_lv) do
		if not transport[i] then	
			local pojazdy=getElementsWithinColShape(ubpops,"vehicle")
			local zwrot = unnA(pojazdy)
			if zwrot then
				setTimer(startTRANStimer, 1000, 1)
				triggerEvent("addAdmNoti",root,"TRANSPORT","Nie mogę zrespić nowego pojazdu, spawn zablokowany!")
				return
			end
			
			local veh=createVehicle(578, v[1], v[2], v[3]+0.63, 0, 0, v[4])
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:spawnID",i)
			setElementData(veh,"vehicle:paliwo", 25)
			setElementData(veh,"vehicle:przebieg", 73922)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:salon",true)
			setElementData(veh,"vehicle:jobcode", "lawety-lv")
			setVehiclePlateText(veh,"LV "..getElementData(veh,"vehicle:id").."")
			setVehicleColor(veh, 0, 77, 222, 255, 112, 51)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
			transport[i] = true;
		end
	end
end

function startTRANStimer()
	if isTimer(transtimer) then return end
	transtimer=setTimer(resetLAWETY, 25000, 1)
end

addEventHandler("onResourceStart", root, startTRANStimer)


--[[
setTimer(function()
    if #getElementsWithinColShape(obszar,"player")>0 then
	for i,v in ipairs(lawety_lv) do
		if (#getElementsWithinColShape(obszar_dwa,"vehicle")==0 and i==1) or (#getElementsWithinColShape(obszar_trzy,"vehicle")==0 and i==2) or (#getElementsWithinColShape(obszar_cztery,"vehicle")==0 and i==3) then
		
			veh=createVehicle(578, v[1], v[2], v[3]+0.63, 0, 0, v[4])
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:paliwo", 25)
			setElementData(veh,"vehicle:przebieg", 73922)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:salon",true)
			--setElementData(veh,"vehicle:zapelnienie", 0)
			setElementData(veh,"vehicle:jobcode", "lawety-lv")
			--setElementData(veh,"vehicle:vopis","Zapełnienie: 0%")
			setVehiclePlateText(veh,"LV "..getElementData(veh,"vehicle:id").."")
			setVehicleColor(veh, 0, 77, 222, 255, 112, 51)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
--			addVehicleUpgrade(veh, 1025) -- offroadff
		
		end
	end
	end
end, 30000, 0)
]]--

function losowanieMiejscaDostawy(plr)
	local randomiser = math.random(1,#punkty_dostaw);
	for i,v in ipairs(punkty_dostaw) do
		if i==randomiser then
			jobblip = createBlip(v[1], v[2], v[3], 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
			
			jobmarker = createMarker(v[1], v[2], v[3], "checkpoint", 3, 255, 0, 0, 102, plr, 0, 0, 3)
			setElementData(jobmarker,"job:graczid",getElementData(plr,"player:dbid"))
			setElementData(jobmarker,"job:czyToDostawa",true)
			
			outputChatBox("#e7d9b0* Pojazd został załadowany, udaj się do punktu #EBB85DC#e7d9b0 na mapie.", plr, 255, 255, 255, true)
		end
	end
end

function losowaniePojDostawy()
	local randomiser = math.random(1,3);
	if tonumber(randomiser) == 1 then return 2932 end
	if tonumber(randomiser) == 2 then return 2934 end
	if tonumber(randomiser) == 3 then return 2935 end
--	if tonumber(randomiser) == 4 then return 2991 end
--	if tonumber(randomiser) == 5 then return 922 end
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
if not md then return end
local sprmarker = getElementData(source,"job:graczid") or 0;
if sprmarker > 0 then 
	if getElementType(el) == "vehicle" then
	    local sprveh = getElementData(el,"vehicle:jobcode") or false;
		if sprveh == "lawety-lv" then
		local plr = getVehicleOccupant(el) or false;
		if not plr then return end
		local getElm = getElementData(el,"job:PojazdNaLawecie") or 0;
		local getElmdwa = getElementData(source,"job:czyToDostawa") or false;
		if getElm == 0 then
		
		local _,_,rz=getElementRotation(el)
--		if (rz>32 and rz<326) then
		if (rz>217 or rz<145) then
	    	outputChatBox("#841515✖#e7d9b0 Błąd, aby załadować pojazd, musisz wjechać tyłem.", plr,231, 217, 176,true)
	    	return
		end
		
		if losowaniePojDostawy() > 700 then
			veh = createObject(losowaniePojDostawy(), 0, 0, -50, 0, 0, 0)
		else
			veh = createVehicle(losowaniePojDostawy(), 0, 0, -50, 0, 0, 0)
		end
			local afid = math.random(1000000,9999999);
			setElementData(el,"job:PojazdNaLawecie",afid)
			setElementData(veh,"job:PojazdNaLawecie",getElementData(plr,"player:dbid") or 0)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
			attachElements(veh, el, 0, -1.8, 1.1, 0, 0, 0)
			
			delBlip(plr)
			delMarker(plr)
			losowanieMiejscaDostawy(plr)
			setElementData(el,"vehicle:ogranicznik",100) -- org
		end
		if getElm > 0 and getElmdwa==true then	
			delBlip(plr)
			delMarker(plr)
			delObject(plr)
			removeElementData(el,"job:PojazdNaLawecie")
			removeElementData(el,"vehicle:ogranicznik") -- remove
			-- nadaj kase etc
			
			local uid = getElementData(plr,"player:dbid") or 0;
			local code = "lawety-sa";
			local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..uid.."' AND joblog_code='"..code.."'");
			
			local ilosc = tonumber(spr_mnoznik[1].ilosc);
			if spr_mnoznik and ilosc >= 2000 then -- 4 poziom
				mnoznik_gracza = 1.35;
			end
			if spr_mnoznik and ilosc >= 1000 and ilosc < 2000 then  -- 3 poziom
				mnoznik_gracza = 1.25;
			end
			if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then  -- 2 poziom
				mnoznik_gracza = 1.15;
			end
			if spr_mnoznik and ilosc >= 0 and ilosc < 500 then  -- 1 poziom
				mnoznik_gracza = 1;
			end
						
			local nev_money = math.random(4400,9700) * mnoznik_gracza ;-- 44/97$
			
			
			local money = string.format("%.2f", nev_money/100)
			
			local getPLRmoney = getPlayerMoney(plr)
			local sprvalue = getPLRmoney + nev_money;
			
			
			local losowaniepg = math.random(1,1000)
			if losowaniepg >= 50 and losowaniepg < 150 then -- 10% szans
				local ilosc = math.random(1,4)
				local premium = getElementData(plr,"player:premium") or 0;
				if premium==1 then ilosc = ilosc * 2; end
			
				local tresc = "Dodatkowe punkty gry z pracy.";
				triggerClientEvent("onPlayerGetPG", plr, tresc, ilosc)
				-- nadajemy do bazy 
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_pghistory SET pgh_admin=?, pgh_ilosc=?, pgh_data=NOW(), pgh_desc=?, pgh_foruser=?, pgh_job=1",22,ilosc,tresc,uid)
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_pg=user_pg+'"..ilosc.."' WHERE user_id='"..uid.."'")	
				local PGgraczaTeraaz = getElementData(plr,"player:PG");
				local nowePG = PGgraczaTeraaz + ilosc;
				setElementData(plr,"player:PG",nowePG)		
			end
			
			
			if 99999999 < sprvalue then 
				outputChatBox("#841515✖#e7d9b0 Błąd, gracz osiągną limit gotówki przy sobie!", plr,231, 217, 176,true) 
				losujPunktLadowania(plr) -- new
				return 
			end
			
			outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..money.."$#e7d9b0 za dostarczenie kontenera, udaj się po następny.", plr,231, 217, 176,true)
						
			givePlayerMoney(plr, nev_money)
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..nev_money.." WHERE user_id = '"..uid.."'");
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..nev_money.." WHERE user_id = '22'");
		
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..uid.."', lbank_kwota='"..nev_money.."', lbank_data=NOW(), lbank_desc='Praca dorywcza BECZKI.', lbank_type='1'");
			local code = "lawety-sa";
			--joblog statystyka do poziomow etc
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='1', joblog_userid='"..uid.."'");
			
			-- new point ress
			losujPunktLadowania(plr)
--			outputChatBox("#e7d9b0* Kontener został dostarczony, udaj się załadować następny.", plr, 255, 255, 255, true)
		end
		end
	end
end
end)

function losujPunktLadowania(plr)
	local randomiser = math.random(1,4);
	for i,v in ipairs(punkty_ladowania) do
		if i==randomiser then
			jobblip = createBlip(v[1], v[2], v[3], 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
			
			jobmarker = createMarker(v[1], v[2], v[3], "checkpoint", 3, 255, 0, 0, 102, plr, 0, 0, 3)
			setElementData(jobmarker,"job:graczid",getElementData(plr,"player:dbid"))
--		    outputChatBox("#e7d9b0* Podjedź tyłem we wskazane miejsce, aby załadować kontener.", plr,231, 217, 176,true)
		end
	end
end

function enterLaweta(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "lawety-lv" then
			removeElementData(source,"vehicle:salon")
			losujPunktLadowania(plr)
			local code = "lawety-sa";
			local plr_uid = getElementData(plr,"player:dbid") or 0;
			local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..plr_uid.."' AND joblog_code='"..code.."'");
			local ilosc = tonumber(spr_mnoznik[1].ilosc);
				if spr_mnoznik and ilosc >= 2000 then poziom = "4 LVL"; end
				if spr_mnoznik and ilosc >= 1000 and ilosc < 2000 then poziom = "3 LVL"; end
				if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then poziom = "2 LVL"; end
				if spr_mnoznik and ilosc >= 0 and ilosc < 500 then poziom = "1 LVL"; end
			outputChatBox("#388E00✔#e7d9b0 Aktualnie w pracy dorywczej #EBB85Dtransporter#e7d9b0, posiadasz #EBB85D"..ilosc.."#e7d9b0 punktów (#EBB85D"..poziom.."#e7d9b0).", plr,231, 217, 176,true)
			
			local gbid = getElementData(source,"vehicle:spawnID") or false;
			if gbid then
				transport[gbid] = false;
				startTRANStimer()
			end
		end
	end
end
addEventHandler("onVehicleEnter", root, enterLaweta)

local antycheat = {}

function exitStartDune(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "lawety-lv" then
			if antycheat[plr] and getTickCount() < antycheat[plr] then
				local odlicz_time = antycheat[plr] - getTickCount();
				local newtime = odlicz_time / 1000;
				local newtime = math.floor(newtime)
				outputChatBox("#841515✖#e7d9b0 Błąd, odczekaj #EBB85D"..newtime.."#e7d9b0 sekund, zanim rozpoczniesz ponownie pracę.", plr,231, 217, 176,true)
				cancelEvent()
	            return 
			end
			local duty = getElementData(plr,"player:frakcja") or false;
			if duty then
				cancelEvent()
				return 
			end
			-- Pg ver
			local PG = getElementData(plr,"player:PG") or 0;
			if PG < wymagane_pg then
				outputChatBox("#841515✖#e7d9b0 Posiadasz niewystarczającą ilość PG, aby rozpocząć tutaj pracę.", plr,231, 217, 176,true)
				cancelEvent()
				return 
			end
		end
	end
end
addEventHandler("onVehicleStartEnter", root, exitStartDune)

function przerwijJobLaweta(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "lawety-lv" then
		delBlip(plr)
		delMarker(plr)
		delObject(plr)
		destroyElement(source)
		antycheat[plr] = getTickCount()+120000; -- 2 min zabezpieczenia
		end
	end
end
addEventHandler("onVehicleExit", root, przerwijJobLaweta)

function przerwijJobLaweta2(plr, seat, jacked) -- fixed
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "lawety-lv" then
			delObject(plr)
		end
	end
end
addEventHandler("onVehicleStartExit", root, przerwijJobLaweta2)

function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
	    local vehicle = getPedOccupiedVehicle(source) or false
		if vehicle ~= false then
		local kiero = getVehicleOccupant(vehicle) or false
		if kiero==source then
			local jobCode = getElementData(vehicle,"vehicle:job") or false;
			if jobCode == "lawety-lv" then	
			delBlip(plr)
			delMarker(plr)
			delObject(plr)
			destroyElement(source)
			end
		end
		else
--			local plrjob = getElementData(source,"player:")
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)
