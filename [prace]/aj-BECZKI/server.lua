--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy beczkowozów.
]]--

-- tutaj premia zarobkow -- 
-- ##### 1 = default #####
local mnoznik_premii = 1
-- ##### 1 = default #####
local wymagane_pg = 600

local tankowanie = createColCuboid(1081.4169921875, 1250.4716796875, 10.8203125-1, 7, 7, 4) 
local visu_obszar = createMarker(1084.9775390625, 1253.9716796875, 10.8203125-1, "cylinder", 8, 255, 255, 255, 44)

--local rd_1 = createColCuboid(1053.87109375, 1337.408203125, 10.8203125-1, 8, 5, 4)
--local rd_2 = createColCuboid(1053.87109375, 1331.927734375, 10.8203125-1, 8, 5, 4)
--local rd_3 = createColCuboid(1053.87109375, 1326.609375, 10.8203125-1, 8, 5, 4)
local ubpops = createColCuboid(1053.87109375, 1326.609375, 10.8203125-1, 8, 16, 4)


--local obszar = createColCuboid(1017.1357421875, 1224.9501953125, 10.8203125-1, 81, 135, 18)

local praca = createBlipAttachedTo(ubpops, 51, 2, 0, 0, 0, 255, -100, 550)

local dunes = {
    {1058.0166015625, 1340.1181640625, 11.2203125, 90},
	{1058.0166015625, 1334.87109375, 11.220312, 90},
	{1058.0166015625, 1329.3330078125, 11.220312, 90}
}

--local p1 = createColSphere(2202.3955078125, 2475.3037109375, 10.8203125-1, 7)

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

--[[
setTimer(function()
    if #getElementsWithinColShape(obszar,"player")>0 then
	for i,v in ipairs(dunes) do
		if (#getElementsWithinColShape(rd_1,"vehicle")==0 and i==1) or (#getElementsWithinColShape(rd_2,"vehicle")==0 and i==2) or (#getElementsWithinColShape(rd_3,"vehicle")==0 and i==3) then
			local veh = createVehicle(573, v[1], v[2], v[3], 0, 0, v[4]);
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:paliwo", 25)
			setElementData(veh,"vehicle:przebieg", 90430)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:zapelnienie", 0)
			setElementData(veh,"vehicle:jobcode", "dune-lv")
			setElementData(veh,"vehicle:salon",true)
			--setElementData(veh,"vehicle:vopis","Zapełnienie: 0%")
			setVehiclePlateText(veh,"LV "..getElementData(veh,"vehicle:id").."")
			setVehicleColor(veh, 0, 22, 55, 255, 255, 255)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
--			addVehicleUpgrade(veh, 1025) -- offroad // srednio to weyglada
		end
	end
	end
end, 30000, 0)

]]--

local beczki = {}

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

function resetBECZKI()
	for i,v in pairs(dunes) do
		if not beczki[i] then	
			local pojazdy=getElementsWithinColShape(ubpops,"vehicle")
			local zwrot = unnA(pojazdy)
			if zwrot then
				setTimer(startDUNEtimer, 1000, 1)
				triggerEvent("addAdmNoti",root,"DUNE","Nie mogę zrespić nowego pojazdu, spawn zablokowany!")
				return
			end
			
			local veh = createVehicle(573, v[1], v[2], v[3], 0, 0, v[4]+0.2);
			setElementInterior(veh,0)
			setElementDimension(veh,0)
			setElementData(veh,"vehicle:spawnID",i)
			setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
			setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:paliwo", 25)
			setElementData(veh,"vehicle:przebieg", 90430)
			setElementData(veh,"vehicle:odznaczone",false)
			setElementData(veh,"vehicle:zapelnienie", 0)
			setElementData(veh,"vehicle:jobcode", "dune-lv")
			setElementData(veh,"vehicle:salon",true)
			setElementData(veh,"vehicle:ogranicznik",60)
			--setElementData(veh,"vehicle:vopis","Zapełnienie: 0%")
			setVehiclePlateText(veh,"LV "..getElementData(veh,"vehicle:id").."")
			setVehicleColor(veh, 0, 22, 55, 255, 255, 255)
			setElementFrozen(veh, true)
			setVehicleDamageProof(veh, true)
			beczki[i] = true;
		end
	end
end

function startDUNEtimer()
	if isTimer(beczkitimer) then return end
	beczkitimer=setTimer(resetBECZKI, 25000, 1)
end

addEventHandler("onResourceStart", root, startDUNEtimer)


local punkty={    -- x,y,z, mnoznik
{2202.3955078125, 2475.3037109375, 10.8203125, 1},
{2148.2666015625, 2747.884765625, 10.8203125, 1},
{2115.810546875, 920.2392578125, 10.8203125, 1},
{2640.240234375, 1106.5849609375, 10.8203125, 1},
{1100.8564453125, 1774.462890625, 10.8203125, 1},
{1595.845703125, 2199.0322265625, 10.8203125, 1},
{625.59765625, 1675.4365234375, 6.9921875, 1},

{61.4755859375, 1208.724609375, 18.528619766235, 1.1}, -- fc
{-1470.88671875, 1863.7783203125, 32.337173461914, 1.2}, -- Tierra robada
{-1329.0234375, 2677.6826171875, 49.76802444458, 1.3}, -- Tierra robada (osp)
{-2524.8115234375, 2346.1708984375, 4.7575497627258, 1.5}, -- bm
{-2407.970703125, 976.068359375, 45.002052307129, 1.6}, -- juniper hill sf
{-2029.154296875, 156.265625, 28.539974212646, 1.5}, -- doherty sf
{-1676.228515625, 412.38671875, 6.883918762207, 1.5}, -- easter basin sf
{-2244.357421875, -2560.9599609375, 31.626363754272, 1.8}, -- angel pine
{-1599.3759765625, -2704.6806640625, 48.243301391602, 1.9}, -- whetstone
{-92.0849609375, -1169.818359375, 2.1219177246094, 1.7}, -- flint county
{1002.9091796875, -940.0390625, 41.884014129639, 1.6}, -- temple ls
{1943.7177734375, -1772.9345703125, 13.094993591309, 1.6}, -- idlewood ls
{652.4765625, -565.1630859375, 16.035333633423, 1.4}, -- dillimore
{50.736328125, -195.423828125, 1.3577378988266, 1.4}, -- bb rc
{1379.876953125, 457.564453125, 19.621784210205, 1.2}, -- montgomery rc
}

addEventHandler("onColShapeHit", tankowanie, function(el,md)
    if (not md) then return end
	if getElementType(el) == "vehicle" then
		local veh_code = getElementData(el,"vehicle:jobcode") or false;
		if veh_code == "dune-lv" then
			local getzap = getElementData(el,"vehicle:zapelnienie") or 0;
			if getzap == 100 then
			-- no ma juz 100 to nie wykonaj wiecej
				return
			end
			local losowanie = math.random(19,28);
			getzap = getzap + losowanie
			if getzap >= 100 then 
				-- dajemy info i mozna jechac nadac C etc, ale to jutro bo ide sapc :)
				getzap = 100; 
				local plr = getVehicleOccupant(el)
				outputChatBox("#e7d9b0* Pojazd został uzupełniony, udaj się do punktu #EBB85DC#e7d9b0 na mapie.", plr, 255, 255, 255, true)
				
				delBlip(plr)
				delMarker(plr) -- del
				
				local plr_uid = getElementData(plr,"player:dbid") or 0;
				local code = "dune-sa";
				local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..plr_uid.."' AND joblog_code='"..code.."'");
				
				local ilosc = tonumber(spr_mnoznik[1].ilosc);
				if spr_mnoznik and ilosc >= 2000 then -- 4 poziom
					mnoznik_gracza = 1.35;
					setElementData(el,"vehicle:ogranicznik",95)
					setVehicleColor(el, 77, 0, 0, 255, 255, 255)
				end
				if spr_mnoznik and ilosc >= 1000 and ilosc < 2000 then  -- 3 poziom
					mnoznik_gracza = 1.25;
					setElementData(el,"vehicle:ogranicznik",90)
					setVehicleColor(el, 18, 18, 18, 255, 255, 255)
				end
				if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then  -- 2 poziom
					mnoznik_gracza = 1.15;
					setElementData(el,"vehicle:ogranicznik",85)
					setVehicleColor(el, 0, 22, 22, 255, 255, 255)
				end
				if spr_mnoznik and ilosc >= 0 and ilosc < 500 then  -- 1 poziom
					mnoznik_gracza = 1;
					setElementData(el,"vehicle:ogranicznik",75)
				end
				
				-- mnoznik na gracza
				setElementData(el,"vehicle:jobmnoznik",mnoznik_gracza)
				
				local lsow = math.random(1,#punkty) -- 
				for i,v in ipairs(punkty) do
				if lsow == i then -- jesli sie rowna, rob
					point = createMarker(v[1], v[2], v[3],"corona",5,233,22,44,166,plr)
					jobblip = createBlipAttachedTo(point, 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
					def_mnoznik = v[4] * mnoznik_premii;
					setElementData(point,"job:rafineria",true)
					setElementData(point,"job:mnoznik",def_mnoznik)
					setElementData(point,"job:graczid",getElementData(plr,"player:dbid"))
					setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
				end
				end
				
			end
			setElementData(el,"vehicle:zapelnienie",getzap)
		end
	end
end)

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
    if (not md) then return end
	if getElementType(el) == "vehicle" then
	    local code = getElementData(source,"job:rafineria") or false
		if code == true then
	    --local graczcod = getElementData(source,"job:graczid") or 0
--		if graczcod == getElementData(el,"player:did") then
		local veh_code = getElementData(el,"vehicle:jobcode") or false;
		if veh_code == "dune-lv" then
			local getzap = getElementData(el,"vehicle:zapelnienie") or 0;
			if getzap ~= 100 then
			-- no ma juz 100 to nie wykonaj wiecej
				return
			end
			local plr = getVehicleOccupant(el)
			outputChatBox(" ", plr, 255, 255, 255, true)
			outputChatBox("#e7d9b0* Stacja została uzupełniona, udaj się do rafinerii.", plr, 255, 255, 255, true)
			setElementData(el,"vehicle:zapelnienie",0)
			setElementData(el,"vehicle:ogranicznik",95)
			
			local mnoznik = getElementData(source,"job:mnoznik") or 1;
			local mnoznik_gracz = getElementData(el,"vehicle:jobmnoznik") or 1;
			local nev_money = (mnoznik * mnoznik_gracz) * 5250; -- 52,50$
			
			local money = string.format("%.2f", nev_money/100)
			
			local getPLRmoney = getPlayerMoney(plr)
			local sprvalue = getPLRmoney + nev_money;
			
			-- nadaj pg
			local uid = getElementData(plr,"player:dbid") or 0
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
				delBlip(plr)
				delMarker(plr) -- del
				return 
			end
			
			outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..money.."$#e7d9b0 za dostarczenie paliwa.", plr,231, 217, 176,true)
						
			givePlayerMoney(plr, nev_money)
			
			local get_nrkonta = getElementData(plr,"player:dbid") or 0
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..nev_money.." WHERE user_id = '"..get_nrkonta.."'");
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..nev_money.." WHERE user_id = '22'");
		
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..get_nrkonta.."', lbank_kwota='"..nev_money.."', lbank_data=NOW(), lbank_desc='Praca dorywcza BECZKI.', lbank_type='1'");
			local code = "dune-sa";
			--joblog statystyka do poziomow etc
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='1', joblog_userid='"..get_nrkonta.."'");
			
			delBlip(plr)
			delMarker(plr) -- del
			
			point = createMarker(1085.4169921875, 1254.2392578125, 11.470472335815,"corona",5,233,22,44,166,plr)
			jobblip = createBlipAttachedTo(point, 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(point,"job:graczid",getElementData(plr,"player:dbid"))
			setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
		end
--		end
		end
	end
end)

local antycheat = {}

function exitStartDune(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "dune-lv" then
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

function enterDune(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "dune-lv" then
			local plr_uid = getElementData(plr,"player:dbid") or 0;
			removeElementData(source,"vehicle:salon")
			local code = "dune-sa";
			local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..plr_uid.."' AND joblog_code='"..code.."'");
			local ilosc = tonumber(spr_mnoznik[1].ilosc);
				if spr_mnoznik and ilosc >= 2000 then poziom = "4 LVL"; end
				if spr_mnoznik and ilosc >= 1000 and ilosc < 2000 then poziom = "3 LVL"; end
				if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then poziom = "2 LVL"; end
				if spr_mnoznik and ilosc >= 0 and ilosc < 500 then poziom = "1 LVL"; end
			outputChatBox("#388E00✔#e7d9b0 Aktualnie w pracy dorywczej #EBB85Dcysterny#e7d9b0, posiadasz #EBB85D"..ilosc.."#e7d9b0 punktów (#EBB85D"..poziom.."#e7d9b0).", plr,231, 217, 176,true)
			
			point = createMarker(1085.4169921875, 1254.2392578125, 11.470472335815,"corona",5,233,22,44,166,plr)
			jobblip = createBlipAttachedTo(point, 12, 2, 0, 0, 0, 255, 10000, 10000, plr)
			setElementData(point,"job:graczid",getElementData(plr,"player:dbid"))
			setElementData(jobblip,"job:id",getElementData(plr,"player:dbid"))
			
			local gbid = getElementData(source,"vehicle:spawnID") or false;
			if gbid then
				beczki[gbid] = false;
				startDUNEtimer()
			end
		end
	end
end
addEventHandler("onVehicleEnter", root, enterDune)


function przerwijJobDune(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:jobcode") or false;
		if jobCode == "dune-lv" then
			delBlip(plr)
			delMarker(plr) -- del
			destroyElement(source)
			antycheat[plr] = getTickCount()+120000; -- 2 min zabezpieczenia
		end
	end
end
addEventHandler("onVehicleExit", root, przerwijJobDune)



function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
	    local vehicle = getPedOccupiedVehicle(source) or false
		if vehicle ~= false then
		local kiero = getVehicleOccupant(vehicle) or false
		if kiero==source then
			local jobCode = getElementData(vehicle,"vehicle:jobcode") or false;
			if jobCode == "dune-lv" then			
				delBlip(source)
				delMarker(source) -- del
				destroyElement(vehicle)
			end
		end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)
