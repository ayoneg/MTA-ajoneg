--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2023 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt zebrakow meneli na mapie
]]--
local maxMapa = 45
local naMapie = 0

local lista = {
	-- X, Y, Z, rootZ, name, special_skin, mnoznik_rep
{2508.6015625, 982.9833984375, 10.8203125, -90, "Pijaczyna Euraniusz", 137, 2},
{2441.6201171875, 969.22265625, 10.8203125, 180, "Miro z G."},
{2500.59765625, 923.3291015625, 11.0234375, 0},
{2499.2490234375, 1127.0126953125, 10.8203125, 180},
{2546.03515625, 1972.6552734375, 10.8203125, 180},
{2513.2783203125, 2320.75, 10.8203125, 90},
{2253.6875, 2333.296875, 10.8203125, 90},
{2222.4990234375, 2537.5771484375, 10.8203125, 0},
{2113.7568359375, 2499.2392578125, 11.078125, 180},
{1841.904296875, 2389.046875, 10.822194099426, 180, "Eustachy", 79, 2},
{1949.0869140625, 2326.2001953125, 10.8203125, 90},
{1877.1513671875, 2287.794921875, 10.979915618896, 0},
{1988.80078125, 2063.783203125, 10.8203125, 0},
{2194.890625, 1987.7060546875, 12.296875, 270},
{2386.47265625, 2001.390625, 10.82031, 0},
{2406.193359375, 2130.4736328125, 10.821436882019, 0},
{2091.5224609375, 2146.9580078125, 10.8203125, 180},
{1796.681640625, 2063.5087890625, 10.818742752075, 35},
{1644.87109375, 1975.34765625, 11.0234375, 180},
{1673.3193359375, 1795.13671875, 10.8203125, 0},
{2019.544921875, 988.2294921875, 10.8203125, 180},
{1857.0390625, 933.8173828125, 10.8203125, 90},
{1681.73046875, 1112.71484375, 10.728981971741, 90},
{1665.9560546875, 912.0703125, 10.715308189392, 90},
{1650.791015625, 893.2177734375, 10.731140136719, 180},
{1528.80859375, 981.296875, 10.8203125, 180},
{1532.3935546875, 931.4306640625, 10.8203125, 90},
{1165.0068359375, 1221.3515625, 10.8203125, 180},
{1084.751953125, 1201.830078125, 10.8203125, 0},
{1105.806640625, 1382.33984375, 10.8203125, 180},
{1036.50390625, 1394.0615234375, 5.8203125, 0},
{942.2099609375, 1738.9443359375, 8.8515625, -90},
{1048.4755859375, 1793.53515625, 10.8203125, 180},
{1111.60546875, 1787.5029296875, 10.8203125, 0},
{1062.3505859375, 1978.9794921875, 10.8203125, -90},
{897.9677734375, 2030.55859375, 10.8203125, 90},
{1018.69921875, 2333.7783203125, 10.8203125, 0},
{1350.1103515625, 2354.767578125, 10.8203125, 0, "Mietas", 79, 5}, --special x5
{1347.1591796875, 2372.2724609375, 10.702172279358, 180},
{1479.697265625, 2363.7734375, 10.8203125, 180},
{1429.7099609375, 2619.962890625, 11.392614364624, 90},
{1440.5615234375, 2659.8212890625, 11.392612457275, 0},
{2106.7783203125, 2650.0732421875, 10.812969207764, -90},
{2180.7138671875, 2750.1513671875, 10.8203125, -90},
{2200.21875, 2792.53125, 10.8203125, 180},
{2367.4453125, 2759.826171875, 10.8203125, 180},
{2339.3583984375, 2531.5751953125, 10.8203125, 180},
{2298.9833984375, 2531.6767578125, 10.8203125, 180},
{2158.853515625, 2488.0205078125, 10.8203125, -90},
{2239.662109375, 2240.8427734375, 10.8203125, -90},
{1585.33984375, 665.611328125, 10.8203125, -0},
{1438.7900390625, 673.7119140625, 10.8203125, -90},
{175.15234375, 1174.4482421875, 14.7578125, -38},
{53.0224609375, 1211.3427734375, 18.895280838013, 180},
{-204.4228515625, 1185.87890625, 19.7421875, -90},
{-87.87890625, 1378.5986328125, 10.2734375, -90},
{-208.5498046875, 1037.7734375, 19.734390258789, 180},
{-638.384765625, 1448.9453125, 13.6171875, 90},
{-304.1259765625, 1053.8291015625, 19.7421875, 180},
{-819.958984375, 1503.498046875, 19.811328887939, 90},
{-366.322265625, 1193.810546875, 19.651054382324, 180},
{-861.3232421875, 1536.87109375, 22.587043762207, 0},
{-793.5322265625, 1630.705078125, 27.1171875, 90},
{-746.4091796875, 1589.55078125, 26.966306686401, -45},
{-795.884765625, 1556.37109375, 27.124444961548, -90},
{-1211.166015625, 1831.8779296875, 41.9296875, 180},
{-1519.1435546875, 2519.5244140625, 55.911293029785, 0},
{-1483.076171875, 2644.9326171875, 55.8359375, 0},
{-1389.3046875, 2636.51171875, 55.984375, 90},
{-1272.6494140625, 2713.076171875, 50.26628112793, 180},
{-779.587890625, 2743.91796875, 45.684356689453, -90},
{-237.095703125, 2656.3017578125, 62.649311065674, 180},
{-245.1171875, 2710.5224609375, 62.6875, 180},
{-154.4287109375, 2757.7451171875, 62.622268676758, 30},
{-252.1875, 2598.6767578125, 62.858154296875, -90},
}

function sprON()
	if naMapie < maxMapa then
		setTimer(generujNaMapie, 250, 1)
	end
end
setTimer(sprON, 360000, 0) -- co 6 min


function onMap(pedID)
    peds=getElementsByType('ped')
    for i,v in pairs(peds) do
        local ped = getElementData(v,"zb2:numer") or 0
		if ped > 0 and ped == pedID then
		    return true
		end
    end	
end

function delObszar(obID)
    shape=getElementsByType('colshape')
    for i,v in pairs(shape) do
        local shape = getElementData(v,"zb2:numer") or 0
		local shape2 = getElementData(v,"zb2:numer") or 0
		if shape > 0 and shape == obID or shape2 > 0 and shape2 == obID then
		    destroyElement(v)
		end
    end	
end

function delPed(pedID)
    peds=getElementsByType('ped')
    for i,v in pairs(peds) do
        local peds = getElementData(v,"zb2:numer") or 0
		if peds > 0 and peds == pedID then
		    destroyElement(v)
		end
    end	
end

function sprMno(pedID) -- spr monoznik
    peds=getElementsByType('ped')
    for i,v in pairs(peds) do
        ped = getElementData(v,"zb2:numer") or 0
		if ped > 0 and ped == pedID then
			ped_mnz = getElementData(v,"zb2:mnoznik") or 1
			return ped_mnz
		end
    end	
end

function generujNaMapie()
	local rng = math.random(1,#lista)
	for i,v in ipairs(lista) do
		if i == rng then
			if not onMap(i) then
				-- losowanie skina lub nadanie specjalnego
				if v[6] then 
					skin = v[6]
				else
					losujskin = math.random(1,5)
					if losujskin == 1 then skin=230 end
					if losujskin == 2 then skin=135 end
					if losujskin == 3 then skin=137 end
					if losujskin == 4 then skin=79 end
					if losujskin == 5 then skin=78 end
				end
				
				-- tworzenie zebraka
			
				local zebrak = createPed(skin, v[1], v[2], v[3], v[4])
				local zebrakcol2 = createColSphere(v[1], v[2], v[3]-1, 2)  
				if v[7] then mnoznik = v[7] else mnoznik = 1 end
				setElementFrozen(zebrak, true)
				setElementHealth(zebrak, 1)
				setElementData(zebrak,"zb2",true)
				setElementData(zebrak,"zb2:numer",i)
				setElementData(zebrak,"zb2:mnoznik",mnoznik)
				setElementData(zebrakcol2,"zb2",true)
				setElementData(zebrakcol2,"zb2:numer",i)
				
				if v[5] ~= 0 then
					setElementData(zebrak,"ped:name",v[5])
				else
					setElementData(zebrak,"ped:name","Żebrak")
				end
				
				setTimer(function()
					losowanie = math.random(1,4)
					if losowanie == 1 then setPedAnimation(zebrak, "CRACK", "crckidle2", -1, true, false) end
					if losowanie == 2 then setPedAnimation(zebrak, "CRACK", "crckidle4", -1, true, false) end
					if losowanie == 3 then setPedAnimation(zebrak, "BEACH", "ParkSit_W_loop", -1, true, false) end
					if losowanie == 4 then setPedAnimation(zebrak, "BEACH", "ParkSit_M_loop", -1, true, false) end
				end, 250, 1)
				
				naMapie=naMapie+1;
				outputDebugString("Zrespiono ID: "..i.." jest to ("..naMapie.." z "..maxMapa.." MAX)")
				if naMapie < maxMapa then
					setTimer(generujNaMapie, 250, 1)
				end
			else
				setTimer(generujNaMapie, 250, 1)
			end
		end
	end
end

generujNaMapie()

-- administracyjna 

addCommandHandler("tpped", function(plr,cmd,value)
if getElementData(plr,"admin:poziom") >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not tonumber(value) then
			outputChatBox("* Użycie: /tpped <pedID>",plr)
			return 
		end
		for i,v in ipairs(lista) do
		    if i == tonumber(value) then
			    setElementPosition(plr, v[2], v[3], v[4]+1)
			end
		end
	end
	end
end)


-- funkcje wykonawcze GRACZ

function bliskoMenela(plr,md)
	if not md then return end
	local sprzeb = getElementData(source,"zb2") or false
	local sprzeb_id = getElementData(source,"zb2:numer") or false
	if sprzeb ~= false then
	    local plr_id = getElementData(plr,"player:dbid") or 0;
		if plr_id > 0 then
    		outputChatBox("#EBB85DŻebrak mówi#e7d9b0: dej no ... kurna ino centa, królu złoty ..", plr, 255, 255, 255, true)
			outputChatBox(" ", plr)
			outputChatBox("#e7d9b0* Aby poratować żebraka kliknij #EBB85DPPM#e7d9b0 natomiast aby przepędzić #EBB85DLPM#e7d9b0.", plr, 255, 255, 255, true)
			setElementData(plr,"player:wokolicyzebraka",true)
			setElementData(plr,"player:wokolicyzebrakaid",sprzeb_id)
			
			bindKey(plr, "mouse1", "down", wokolicyzebraka, plr)
			bindKey(plr, "mouse2", "down", wokolicyzebraka_dwa, plr)
		end
	end
end
addEventHandler("onColShapeHit", resourceRoot, bliskoMenela) 


function bliskoMenelaWyjdz(plr,md)
    local sprzeb = getElementData(source,"zb2") or false
	if sprzeb ~= false then
		if getElementType(plr) == "vehicle" then
			local kierowca = getVehicleOccupant(plr) or false;
			if kierowca ~= false then 
			plr = kierowca 
			end
		else
			plr = plr
		end
	end
	removeElementData(plr,"player:wokolicyzebraka")
	removeElementData(plr,"player:wokolicyzebrakaid")
	
	unbindKey(plr, "mouse1", "down", wokolicyzebraka)
	unbindKey(plr, "mouse2", "down", wokolicyzebraka_dwa)
end
addEventHandler("onColShapeLeave", resourceRoot, bliskoMenelaWyjdz) 


-- funkcje
function wokolicyzebraka(plr)
	if getPedOccupiedVehicle(plr) then return end
	local sx,sy,sz = getElementVelocity(plr)
	local speed = (sx^2 + sy^2 + sz^2)^(0.5);
	local kmh = speed*180;
    local sprobszar = getElementData(plr,"player:wokolicyzebraka") or false;
    if not sprobszar then
	    -- zakoncz tutaj
	    return
	end	
	if kmh > 5 then 
		outputChatBox("#FF0000Nie tak szybko!", plr, 255, 255, 255, true)
		return 
	end
	local id_obszar = getElementData(plr,"player:wokolicyzebrakaid") or 0;
	local money = math.random(12,230);
	if tonumber(money) < 1 then
	    outputChatBox(" ", plr)
		outputChatBox("#EBB85DŻebrak mówi#e7d9b0:  wystarczy cent...", plr, 255, 255, 255, true)
	    return
	end
	local plrMoney = getPlayerMoney(plr)
	if plrMoney < money then
	    return
	end
	if onMap(id_obszar) then
	takePlayerMoney(plr, money)
	delObszar(id_obszar)
	delPed(id_obszar)
	
	local kwotamnz = sprMno(id_obszar) or 1;
	if kwotamnz > 1 then
		losowanie2 = math.random(1,100)
	    if tonumber(losowanie2) > 0 and tonumber(losowanie2) < 21 then
			value = 1 * sprMno(id_obszar);
			outputChatBox(" ", plr)
			outputChatBox("#EBB85DŻebrak mówi#e7d9b0: dziękuję dobry człowieku... trzymaj, to Twój dobry dzień!", plr, 255, 255, 255, true)
	    else
			value = 1;
			outputChatBox(" ", plr)
			outputChatBox("#EBB85DŻebrak mówi#e7d9b0: dziękuję dobry człowieku!", plr, 255, 255, 255, true)
		end
	else
		value = 1;
		outputChatBox(" ", plr)
		outputChatBox("#EBB85DŻebrak mówi#e7d9b0: dziękuję dobry człowieku!", plr, 255, 255, 255, true)
	end
	
	
	
	local variant = "plus"
	local kaplicacode = "zebrak-id-"..id_obszar
	local plr_rep = getElementData(plr,"player:reputacja") or 0;
	triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,plr,variant)
	
	local plr_id = getElementData(plr,"player:dbid") or 0;
	local nev_repo = plr_rep + value;
	setElementData(plr,"player:reputacja",nev_repo)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja+'"..value.."' WHERE user_id='"..plr_id.."'");
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..plr_id.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
	
	end
	removeElementData(plr,"player:wokolicyzebraka")
	removeElementData(plr,"player:wokolicyzebrakaid")
end


function wokolicyzebraka_dwa(plr)
	if getPedOccupiedVehicle(plr) then return end
	local sx,sy,sz = getElementVelocity(plr)
	local speed = (sx^2 + sy^2 + sz^2)^(0.5);
	local kmh = speed*180;
    local sprobszar = getElementData(plr,"player:wokolicyzebraka") or false;
    if not sprobszar then
	    -- zakoncz tutaj
	    return
	end	
	if kmh > 5 then 
		outputChatBox("#FF0000Nie tak szybko!", plr, 255, 255, 255, true)
		return 
	end
	local id_obszar = getElementData(plr,"player:wokolicyzebrakaid") or 0;
	if onMap(id_obszar) then
	-- usuwamy
	delObszar(id_obszar)
	delPed(id_obszar)
	-- zmieniamy dane
	
	local kwotamnz = sprMno(id_obszar) or 1;
	if kwotamnz > 1 then
		losowanie2 = math.random(1,100)
	    if tonumber(losowanie2) > 0 and tonumber(losowanie2) < 21 then
			value = 1 * sprMno(id_obszar);
	    else
			value = 1;
		end
	else
		value = 1;
	end
	
	local variant = "minus"
	local kaplicacode = "zebrak-id-"..id_obszar
	local plr_rep = getElementData(plr,"player:reputacja") or 0;
	triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,plr,variant)
	
	local plr_id = getElementData(plr,"player:dbid") or 0;
	local nev_repo = plr_rep - value;
	setElementData(plr,"player:reputacja",nev_repo)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja-'"..value.."' WHERE user_id='"..plr_id.."'");
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..plr_id.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
	
	end
	removeElementData(plr,"player:wokolicyzebraka")
	removeElementData(plr,"player:wokolicyzebrakaid")
end
addCommandHandler("przepedzzebraka",wokolicyzebraka_dwa)



addEventHandler("onPedWasted", root, function(amm,killer)
    zebrakspr = getElementData(source,"zb2") or false
	if zebrakspr then
		if getElementType(killer) == "vehicle" then
			local kierowca = getVehicleOccupant(killer) or false;
			if kierowca ~= false then 
			plr = kierowca 
			end
		else
			plr = killer
		end
		zebrakspr_id = getElementData(source,"zb2:numer") or 0
		destoryEl(source)
		delObszar(zebrakspr_id)
		-- zmieniamy dane
		if sprMno(zebrakspr_id) > 1 then
			 losowanie = math.random(1,100)
			 if tonumber(losowanie) > 0 and tonumber(losowanie) < 21 then
			      value = 1 * sprMno(zebrakspr_id);
			 else
			      value = 1;
			 end
		else
		     value = 1;
		end
    	
		local variant = "minus"
		local kaplicacode = "zebrak-id-"..zebrakspr_id
		local plr_rep = getElementData(plr,"player:reputacja") or 0;
		triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,plr,variant)
	
		local plr_id = getElementData(plr,"player:dbid") or 0;
		local nev_repo = plr_rep - value;
		setElementData(plr,"player:reputacja",nev_repo)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja-'"..value.."' WHERE user_id='"..plr_id.."'");
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..plr_id.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
		
		local sprtylko = getElementData(plr,"player:wokolicyzebraka") or false
		if zebrakspr == true then
		removeElementData(plr,"player:wokolicyzebraka")
	    removeElementData(plr,"player:wokolicyzebrakaid")
		end
	end
end)

function destoryEl(elm)
	setTimer(function()
        destroyElement(elm)
	end, 5000, 1)
end