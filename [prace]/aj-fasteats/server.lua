--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt pracy dostawcy pizzy.
]]--

--######################
-- PREMIA GLOBALNA
local global_premia = 0
-- PREMIA GLOBALNA
--######################

local pracapizza = createBlip(2328.2490234375, 2525.0166015625, 10.8203125, 29, 2, 255, 0, 0, 155, -1, 500)

local pizza_test_visu = createMarker(2330.703125, 2532.2158203125, 10.8203125-1, "cylinder", 2, 255,255,255,50)
--    setElementInterior(visu_markC, 3)
--	setElementDimension(visu_markC, 500)
local pizza_test = createColSphere(2330.703125, 2532.2158203125, 10.8203125, 1)
    setElementInterior(pizza_test, 0)
	setElementDimension(pizza_test, 0)
local ajoneatsrespfure = createColCuboid(2318.7490234375, 2521.5869140625, 10.8203125-1, 5, 10, 4)


function delMarker(gracz)
    marker=getElementsByType('marker')
    for i,v in pairs(marker) do
		if getElementData(v,"pizzaLV:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

function delBlip(gracz)
    blip=getElementsByType('blip')
    for i,v in pairs(blip) do
		if getElementData(v,"pizzaLV:player") == getElementData(gracz,"player:dbid") then
		    destroyElement(v)
		end
    end	
end

local antycheat2 = {}
local postep_pracy = {}

local pizza_lista = { -- 111
{2225.255859375, 2522.8759765625, 11.222219467163},
{2214.1103515625, 2526.1875, 10.8203125},
{2244.736328125, 2525.068359375, 10.8203125},
{2270.5947265625, 2540.4951171875, 10.8203125},
{2388.9970703125, 2465.7646484375, 10.8203125},
{2447.5419921875, 2373.1923828125, 12.163512229919},
{2405.64453125, 2366.568359375, 10.8203125},
{2394.6201171875, 2306.3134765625, 8.140625},
{2374.88671875, 2306.375, 8.140625},
{2362.3154296875, 2306.3447265625, 8.140625},
{2348.3662109375, 2294.2646484375, 8.1477851867676},
{2348.3828125, 2275.3466796875, 8.1477851867676},
{2348.4443359375, 2261.42578125, 8.1477851867676},
{2277.783203125, 2342.880859375, 10.8203125},
{2290.1279296875, 2432.0166015625, 10.8203125},
{2246.849609375, 2396.66796875, 11.895137786865},
{2247.4111328125, 2396.1875, 10.8203125},
{2127.521484375, 2380.0859375, 10.8203125},
{2102.3193359375, 2259.6416015625, 11.0234375},
{2101.8935546875, 2228.8251953125, 11.0234375},
{2097.9248046875, 2224.6611328125, 11.0234375},
{2090.283203125, 2224.69140625, 11.0234375},
{2083.2783203125, 2224.6826171875, 11.0234375},
{2107.78125, 2155.8681640625, 10.8203125},
{2104.8251953125, 2128.0703125, 10.8203125},
{2094.9677734375, 2122.8134765625, 10.8203125},
{2087.763671875, 2122.806640625, 10.8203125},
{2080.5576171875, 2122.8486328125, 10.8203125},
{2073.18359375, 2122.849609375, 10.812517166138},
{2066.341796875, 2122.62109375, 10.812517166138},
{2059.2177734375, 2122.85546875, 10.812517166138},
{2051.802734375, 2122.85546875, 10.8203125},
{2052.9345703125, 2096.5458984375, 11.132436752319},
{2064.33203125, 2096.560546875, 11.057899475098},
{2076.2705078125, 2096.5537109375, 11.057899475098},
{2085.6806640625, 2090.7392578125, 11.057899475098},
{2085.7216796875, 2075.3173828125, 11.0546875},
{2085.712890625, 2067.4033203125, 11.057899475098},
{2085.6875, 2055.5380859375, 11.057899475098},
{2080.0361328125, 2046.1181640625, 11.057899475098},
{2056.0888671875, 2046.1318359375, 11.057899475098},
{1942.1474609375, 2185.458984375, 10.8203125},
{1937.779296875, 2306.244140625, 10.8203125},
{1937.0302734375, 2318.5966796875, 10.8203125},
{1961.8212890625, 2448.517578125, 11.178249359131},
{2108.5927734375, 2652.67578125, 10.37394618988},
{2103.8193359375, 2678.328125, 10.38533115387},
{2056.12109375, 2664.1240234375, 10.387358665466},
{2037.4404296875, 2663.1787109375, 10.384377479553},
{2017.970703125, 2664.259765625, 10.806942939758},
{1988.970703125, 2663.5322265625, 10.386754989624},
{1969.626953125, 2663.8515625, 10.384926795959},
{1950.517578125, 2664.1962890625, 10.720601081848},
{1921.7177734375, 2663.5341796875, 10.383334159851},
{1928.6552734375, 2774.50390625, 10.387610435486},
{1951.02734375, 2724.919921875, 10.386646270752},
{1967.8115234375, 2764.79296875, 10.381799697876},
{1969.5859375, 2722.2294921875, 10.793956756592},
{1992.71484375, 2763.138671875, 10.387335777283},
{2018.44140625, 2724.1943359375, 10.383524894714},
{2018.9365234375, 2763.6494140625, 10.381729125977},
{2037.130859375, 2723.53125, 10.417945861816},
{2039.6494140625, 2763.9111328125, 10.388048171997},
{2049.8310546875, 2761.8720703125, 10.385552406311},
{2066.5146484375, 2723.923828125, 10.382989883423},
{2150.2197265625, 2733.896484375, 10.743912696838},
{2180.564453125, 2759.7216796875, 10.387719154358},
{2540.94921875, 2297.7197265625, 10.380598068237},
{2515.4990234375, 2297.841796875, 10.389619827271},
{2541.734375, 2272.7763671875, 10.382543563843},
{2628.658203125, 2349.529296875, 10.384394645691},
{2536.892578125, 2260.0341796875, 10.386092185974},
{2637.25, 2351.947265625, 10.389886856079},
{2616.5419921875, 2196.98828125, 10.378660202026},
{2634.400390625, 2196.4287109375, 10.398627281189},
{2646.6845703125, 2241.173828125, 10.326643943787},
{2646.564453125, 2259.568359375, 10.359404563904},
{2506.84765625, 2120.5712890625, 10.407214164734},
{2492.419921875, 2162.6083984375, 10.384954452515},
{2475.6923828125, 2162.875, 10.38977432251},
{2450.9384765625, 2162.8642578125, 10.388731956482},
{2417.2041015625, 2163.61328125, 10.386539459229},
{2400.001953125, 2163.5732421875, 10.386039733887},
{2372.638671875, 2167.015625, 10.391810417175},
{2330.7158203125, 2165.40625, 10.389675140381},
{2085.7880859375, 2091.1865234375, 10.605952262878},
{2085.7275390625, 2075.806640625, 10.62816619873},
{2085.919921875, 2066.7109375, 10.623652458191},
{2085.849609375, 2055.7783203125, 10.632833480835},
{2056.947265625, 2045.8984375, 10.63963508606},
{2032.03125, 2045.9970703125, 10.624077796936},
{1928.986328125, 2774.3486328125, 10.387920379639},
{1792.92578125, 2744.2041015625, 10.915398597717},
{1840.7265625, 2751.076171875, 10.908143043518},
{1838.9794921875, 2749.3154296875, 10.918694496155},
{1873.408203125, 2783.8486328125, 10.909194946289},
{1881.4970703125, 2792.4296875, 10.911374092102},
{1810.5400390625, 2811.98046875, 10.905908584595},
{1813.7548828125, 2822.6982421875, 10.911128997803},
{1783.8876953125, 2868.6513671875, 10.904366493225},
{1772.544921875, 2871.271484375, 10.902936935425},
{1749.9580078125, 2867.4150390625, 10.905737876892},
{1720.037109375, 2820.9169921875, 10.909605979919},
{1726.2216796875, 2798.2060546875, 10.905470848083},
{1731.0009765625, 2776.2724609375, 10.867688179016},
{1741.4609375, 2742.18359375, 10.922904968262},
{1735.8388671875, 2692.251953125, 10.389013290405},
{1703.685546875, 2689.4755859375, 10.385573387146},
{1678.1044921875, 2691.4580078125, 10.388517379761},
{2495.8896484375, 2779.9130859375, 10.380436897278},
}

addEventHandler("onColShapeHit", pizza_test, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    local uid = getElementData(el,"player:dbid")
    if not uid then return end
	if antycheat2[el] and getTickCount() < antycheat2[el] then
		local odlicz_time = antycheat2[el] - getTickCount();
		local newtime = odlicz_time / 1000;
		local newtime = math.floor(newtime)
		outputChatBox("#841515✖#e7d9b0 Błąd, odczekaj #EBB85D"..newtime.."#e7d9b0 sekund, zanim rozpoczniesz ponownie pracę.", el,231, 217, 176,true)
--		cancelEvent()
	    return 
	end
	local spr100 = getElementData(el,"player:job") or false;
	if spr100 == "FastEats" then
--		cancelEvent()
	    return 
	end
	local duty = getElementData(el,"player:frakcja") or false;
	if duty then
		-- ???
	    return 
	end
	if #getElementsWithinColShape(ajoneatsrespfure,"vehicle") > 0 then
	-- na terenie egzaminu jest gracz rob pojazd - nie mozemy zaczac
	    outputChatBox("* Na terenie wyjazdu znajduje się już pojazd!", el, 222, 0, 0, true)
	return false
    end
	local code = "FastEats"
	local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..uid.."' AND joblog_code='"..code.."'");
	local ilosc = tonumber(spr_mnoznik[1].ilosc);
	
--	if spr_mnoznik and ilosc >= 2000 then 
--	vehid = 401; 
--	ogranicznik = 120;
--	dat_poziom = 4;
--	max_rand = 2;
--	end
	if spr_mnoznik and ilosc >= 1000 then --and ilosc < 2000
--	vehid = 401; 
	ogranicznik = 85;
	dat_poziom = 3;
	price =  3560;
	max_pizza = 4;
	end
	if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then 
--	vehid = 448; 
	ogranicznik = 75;
	dat_poziom = 2;
	price =  1950;
	max_pizza = 2;
	end
	if spr_mnoznik and ilosc >= 0 and ilosc < 500 then
--	vehid = 448;
    ogranicznik = 60;	
	dat_poziom = 1;
	price =  920;
	max_pizza = 1;
	end
	
    local veh = createVehicle(448, 2321.14453125, 2526.7734375, 10.8203125, 0, 0, 180);
	setElementData(veh,"vehicle:ogranicznik",ogranicznik)
	setElementData(el,"player:max_pizza",max_pizza)
	setElementData(el,"player:poziomPizza",dat_poziom)
	setElementData(el,"player:pricePizza",price)
	setElementModel(el, 155)
	
setElementInterior(veh,0)
setElementDimension(veh,0)
setElementInterior(el,0)
setElementDimension(el,0)
warpPedIntoVehicle(el,veh)

setVehicleEngineState(veh, true)

setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
setElementData(veh,"vehicle:owner", uid)
setElementData(veh,"vehicle:paliwo", 25)
--setElementData(veh,"vehicle:przebieg", 90430)
setElementData(veh,"vehicle:odznaczone",true)
setElementData(veh,"vehicle:vopis","Praca dorywcza - FastEats")
setVehiclePlateText(veh,"FastEats "..getElementData(veh,"vehicle:id").."")
setVehicleColor(veh, 103, 10, 10, 255, 255, 255)
setElementFrozen(veh, false)

setElementData(el,"player:job","FastEats")
setElementData(el,"player:jobRand",#pizza_lista)
setElementData(veh,"vehicle:job","FastEats")

antycheat2[el] = getTickCount()+35000; -- 2 min zabezpieczenia

local randomiser = math.random(1,#pizza_lista)
postep_pracy[el] = 0
losowaniePunktu(el,poziom)

local sprzab = getElementData(el,"player:jobNoti") or false;
if sprzab == false then
local code = "FastEats";
local spr_mnoznik = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) ilosc FROM server_jobslog WHERE joblog_userid='"..uid.."' AND joblog_code='"..code.."'");
local ilosc = tonumber(spr_mnoznik[1].ilosc);
	if spr_mnoznik and ilosc >= 1000 then poziom = "3 LVL"; end
	if spr_mnoznik and ilosc >= 500 and ilosc < 1000 then poziom = "2 LVL"; end
	if spr_mnoznik and ilosc >= 0 and ilosc < 500 then poziom = "1 LVL"; end
outputChatBox("#388E00✔#e7d9b0 Aktualnie w pracy dorywczej #EBB85DFastEats#e7d9b0, posiadasz #EBB85D"..ilosc.."#e7d9b0 punktów (#EBB85D"..poziom.."#e7d9b0).", el,231, 217, 176,true)
setElementData(el,"player:jobNoti",true)
end

end)

function losowaniePunktu(plr,poziom)
    if postep_pracy[plr] == 0 then -- 0 no to pokaz pizzernie aby wrocil
	    trasa = createMarker(2372.0380859375, 2549.4638671875, 10.8203125, "checkpoint", 3, 0, 0, 177, 255, plr)
		bliptrasy = createBlip(2372.0380859375, 2549.4638671875, 10.8203125, 12, 0, 0, 0, 0, 255, 1, 4000, plr)
		setElementData(trasa,"pizzaLV:player",getElementData(plr,"player:dbid"))
		setElementData(bliptrasy,"pizzaLV:player",getElementData(plr,"player:dbid"))
		playSoundFrontEnd(plr, 20)
	else -- jesli nie 0 no to losujemy dostawe

    for i,v in pairs(pizza_lista) do
	    if i==postep_pracy[plr] then
		    trasa = createMarker(v[1], v[2], v[3], "checkpoint", 1, 0, 0, 177, 255, plr)
			bliptrasy = createBlip(v[1], v[2], v[3], 12, 0, 0, 0, 0, 255, 1, 4000, plr)
			setElementData(trasa,"pizzaLV:player",getElementData(plr,"player:dbid"))
			setElementData(bliptrasy,"pizzaLV:player",getElementData(plr,"player:dbid"))
			playSoundFrontEnd(plr, 20)
			return
		end
	end
	
	end
end

addEventHandler("onMarkerHit", resourceRoot, function(el,md)
local sprID = getElementData(source,"pizzaLV:player") or 0;
if sprID > 0 then
local uid = getElementData(el,"player:dbid") or 0;
if uid > 0 then
if sprID==uid then
    sprpostee = postep_pracy[el] or 0
    if (not md) then return end
    local spregzam = getElementData(el,"player:job") or false
	if spregzam == "FastEats" then
	if sprpostee == 0 then 
        if getElementType(el) ~= "player" then return end
		
        if isPedInVehicle(el) then
			local vehicle = getPedOccupiedVehicle(el) or false
			local veh_data = getElementData(vehicle,"vehicle:job") or false;
			if veh_data == "FastEats" then
				delMarker(el)
				delBlip(el)
				local plr_randget = getElementData(el,"player:jobRand") or 1;
				randomiser = math.random(1,plr_randget)
				postep_pracy[el] = randomiser -- if 0 niech wraca na baze po pizze
	    		losowaniePunktu(el)
				
				local poziom = getElementData(el,"player:poziomPizza") or 1;
				if poziom == 1 then
					setElementData(el,"player:max_pizza",1)
				elseif poziom == 2 then
					setElementData(el,"player:max_pizza",2)
				else
					setElementData(el,"player:max_pizza",3)
				end
				
				outputChatBox("* Oderano zamówienia, dostarcz je na podany adres GPS.", el)
			else
				outputChatBox("* Aby odebrać następną dostawę Pizzy, musisz znajdować się w pojeździe służbowym.", el)
			end
		end

	else
		delMarker(el)
		delBlip(el)

		-- NEF TEST
		local max_pizza = getElementData(el,"player:max_pizza") or 0;
		local max_pizza = max_pizza - 1;
		if max_pizza == 0 then
			postep_pracy[el] = 0 -- if 0 niech wraca na baze po pizze
			text_add22 = "udaj się po następne zamówienia";
		else
			local plr_randget = getElementData(el,"player:jobRand") or 1;
			randomiser = math.random(1,plr_randget)
			postep_pracy[el] = randomiser
			
--			max_pizza = max_pizza - 1;
			setElementData(el,"player:max_pizza",max_pizza)
			text_add22 = "dostarcz następne";
		end

		
--		postep_pracy[el] = 0 -- if 0 niech wraca na baze po pizze
		poziom = 1 -- nie dziala
	    losowaniePunktu(el,poziom)
--		outputChatBox("* Dostarczono pizze, udaj się po kolejne zamówienia.", el)
		
		-- nadaje kase
--		local uid = getElementData(el,"player:dbid") or 0;
		local code = "FastEats"
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='1', joblog_userid='"..uid.."'");

		local sprawdzamy = math.random(1,100);
		if tonumber(sprawdzamy) >= 1 and tonumber(sprawdzamy) < 51 then
			napiwek = math.random(55,1000);
			money_test = string.format("%.2f", napiwek/100)
			text_add = " + #388E00"..money_test.."$#e7d9b0 napiwku";
		else
			text_add = "";
			napiwek = 0
		end
		
		local losowaniepg = math.random(1,1000)
		if losowaniepg >= 50 and losowaniepg < 150 then -- 10% szans
			local ilosc = math.random(1,4)
			local premium = getElementData(el,"player:premium") or 0;
			if premium==1 then ilosc = ilosc * 2; end
			
			local tresc = "Dodatkowe punkty gry z pracy.";
			triggerClientEvent("onPlayerGetPG", el, tresc, ilosc)
			-- nadajemy do bazy 
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_pghistory SET pgh_admin=?, pgh_ilosc=?, pgh_data=NOW(), pgh_desc=?, pgh_foruser=?, pgh_job=1",22,ilosc,tresc,uid)
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_pg=user_pg+'"..ilosc.."' WHERE user_id='"..uid.."'")	
			local PGgraczaTeraaz = getElementData(el,"player:PG");
			local nowePG = PGgraczaTeraaz + ilosc;
			setElementData(el,"player:PG",nowePG)		
		end
		
		local getprince = getElementData(el,"player:pricePizza") or 370;
		
		local nevmoney = getprince + global_premia or 0;
		money = nevmoney + napiwek or 0;
		
		local money_dwa = string.format("%.2f", nevmoney/100)
		
		
		local getPLRmoney = getPlayerMoney(el)
		local sprvalue = getPLRmoney + money;
		
		
			
		if 99999999 < sprvalue then 
			outputChatBox("#841515✖#e7d9b0 Błąd, gracz osiągną limit gotówki przy sobie!", el,231, 217, 176,true) 
			outputChatBox("Udaj się po kolejne zamówienia.", el)
			return 
		end
			
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..money.." WHERE user_id = '"..uid.."'");
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..money.." WHERE user_id = '22'");
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..uid.."', lbank_kwota='"..money.."', lbank_data=NOW(), lbank_desc='Praca dorywcza FastEats.', lbank_type='1'");
		

		
		givePlayerMoney(el, money) -- kasa
		outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..money_dwa.."$#e7d9b0"..text_add.." za dostarczenie zamówienia, "..text_add22..".", el,231, 217, 176,true)
--		outputChatBox("Udaj się po kolejne zamówienia.", el)
    end
	end
end
end
end
end)

function odliczamyCzasPizza(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:job") or false;
		local jobCode2 = getElementData(plr,"player:job") or false;
		if jobCode == "FastEats" and jobCode2 == "FastEats" then
			--triggerClientEvent("killTimerClientSideC",root,el)
			triggerClientEvent("startTimerToEndJob",root,plr,jobCode,source)
			outputChatBox("#e7d9b0* Masz #EBB85D20 sekund#e7d9b0, aby powrócić do pojazdu.", plr, 231, 217, 176,true)
			setElementData(source,"vehicle:salon",true)
		end
	end
end
addEventHandler("onVehicleExit", root, odliczamyCzasPizza)

function onWejdziePoj(plr, seat, jacked)
    if seat ~= 0 then return end
	if source then
		local jobCode = getElementData(source,"vehicle:job") or false;
		local jobCode2 = getElementData(plr,"player:job") or false;
		if jobCode == "FastEats" and jobCode2 == "FastEats" then
			local plr_uid = getElementData(plr,"player:dbid") or 0;
			triggerClientEvent("endTimerToEndJob",root,plr)
			removeElementData(source,"vehicle:salon")
		end
	end
end
addEventHandler("onVehicleEnter", root, onWejdziePoj)

addEvent("endPlayerJob", true)
addEventHandler("endPlayerJob", root, function(plr,jobCode,car)
	
	delMarker(plr)
	delBlip(plr)
	postep_pracy[plr] = 0 -- if 0 niech wraca na baze po pizze
	removeElementData(plr,"player:job")
	removeElementData(plr,"player:poziomPizza")
	removeElementData(plr,"player:jobRand")
	removeElementData(plr,"player:pricePizza")
	removeElementData(plr,"player:jobNoti")
	destroyElement(car)
	setElementModel(plr, getElementData(plr,"player:skinid") or 0)
	outputChatBox("* Praca została przerwana.", plr)
	
end)


function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
	    local vehicle = getPedOccupiedVehicle(source) or false
		if vehicle ~= false then
		local kiero = getVehicleOccupant(vehicle) or false
		if kiero==source then
			local jobCode = getElementData(vehicle,"vehicle:job") or false;
			if jobCode == "FastEats" then
			delBlip(source)
			delMarker(source) -- del
			destroyElement(vehicle)
			setElementModel(source, getElementData(source,"player:skinid") or 0)
			end
		end
		else
--			local plrjob = getElementData(source,"player:")
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)

