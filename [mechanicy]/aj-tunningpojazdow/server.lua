--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt tunera pojazdów.
]]--

--==================--  --==================--  --==================--

local bramatune = createObject(969, 1994.8956298828, 2123.6000976562, 9.8000001907349, 0, 0, 180)
local test = createColCuboid(1986.3994140625, 2124.103515625, 10.8203125-1, 7, 5, 5)
addEventHandler("onColShapeHit", test, function(el,dim)
	if not dim then return end
	if getElementType ( el ) == "vehicle" then
		moveObject(bramatune, 4000, 2010.8956298828, 2123.6000976562, 9.8000001907349, 0, 0, 0)
	end
end)

addEventHandler("onColShapeLeave", test, function(el,dim)
	if not dim then return end
	if getElementType ( el ) == "vehicle" then
		moveObject(bramatune, 4000, 1994.8956298828, 2123.6000976562, 9.8000001907349, 0, 0, 0)
	end
end)

local strefy={
	tunerLV1={
		cuboid={1973.6064453125, 2143.7255859375, 10.8203125-1, 8, 5, 5},-- cuboid w ktorym musi znalezc sie pojazd
    	mpos={1975.66796875, 2142.4462890625, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    	faction_id="tune-lv", -- nameid frakcji ktora ma do tego dostep
	},
	tunerLV2={
		cuboid={1973.6064453125, 2151.099609375, 10.8203125-1, 8, 5, 5},-- cuboid w ktorym musi znalezc sie pojazd
    	mpos={1975.396484375, 2156.4541015625, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    	faction_id="tune-lv", -- nameid frakcji ktora ma do tego dostep
	},
}

for i,v in pairs(strefy) do
	cs=createColCuboid(unpack(v.cuboid))
	setElementData(cs,"tuner",true)
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1, 0,0,0,100)
	setElementData(marker,"cs",cs)
	setElementData(marker,"tuner",true)
	setElementData(marker,"m:duty",v.faction_id)
	t = createElement("text")
	setElementData(t,"name","Komputer")
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3])
end

addCommandHandler("spr00",function(plr,cmd)
	local veh = getPedOccupiedVehicle(plr)
	if not veh then
		outputChatBox("* Nie znajdujesz się w pojeździe", plr)
		return
	end
	mk1 = getElementData(veh,"vehicle:mk1") or 0;
	mk2 = getElementData(veh,"vehicle:mk2") or 0;
	mk3 = getElementData(veh,"vehicle:mk3") or 0;
	su1 = getElementData(veh,"vehicle:su1") or 0;
	if mk1 ~= 0 then outputChatBox("mk1: ",plr) end
	if mk2 ~= 0 then outputChatBox("mk2: ",plr) end
	if mk3 ~= 0 then outputChatBox("mk3: ",plr) end
	if su1 ~= 0 then outputChatBox("su1: ",plr) end
end)

addEvent("potwierdzenieTune", true)
addEventHandler("potwierdzenieTune", root, function(target,typ,nazwa,koszt,koszt_tuner)
	triggerClientEvent("pokazIntoTunne",root,target,typ,nazwa,koszt,koszt_tuner)
end)

-- tune nadaj raz dwa trzy
addEvent("nadajTune", true)
addEventHandler("nadajTune", root, function(plr,target,pojazd,typ,nazwa,koszt,koszt_tuner,idELEMENTU)
	if tostring(typ) == "demont" then
		local veh_id = getElementData(pojazd,"vehicle:id") or 0; -- id poj
		if tonumber(idELEMENTU) > 10 then
			removeVehicleUpgrade(pojazd,idELEMENTU)
		else
			if tonumber(idELEMENTU)==1 then 
				removeElementData(pojazd,"vehicle:mk1")
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk1='0' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)==2 then 
				removeElementData(pojazd,"vehicle:mk2") 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk2='0' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)==3 then 
				removeElementData(pojazd,"vehicle:mk3") 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk3='0' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)>=4 and tonumber(idELEMENTU)<=9 then 
				removeElementData(pojazd,"vehicle:su1") 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_SU1='0' WHERE veh_id='"..veh_id.."'");
			end -- end
		end

		local spr = tonumber(koszt) - tonumber(koszt_tuner);
		givePlayerMoney(plr, koszt_tuner)
		givePlayerMoney(target, spr)
		
		local plruid = getElementData(target,"player:dbid") or 0;
		local plruid2 = getElementData(plr,"player:dbid") or 0;
		
		if tonumber(plruid) > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..spr.." WHERE user_id='"..plruid.."'");
		end
		if tonumber(plruid2) > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..koszt_tuner.." WHERE user_id='"..plruid2.."'");
		end
		
		triggerEvent("localInfoChat",root,target,"wyraził zgodę na demontaż elementu #EBB85D"..nazwa.."#e7d9b0.",45)
		
		local moneyee = string.format("%.2f", spr/100)
		local moneyee22 = string.format("%.2f", koszt_tuner/100)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie demontowano #EBB85D"..nazwa.."#e7d9b0 za kwotę #388E00"..moneyee.."$#e7d9b0.", target,231, 217, 176,true)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie demontowano #EBB85D"..nazwa.."#e7d9b0 graczowi #EBB85D"..getPlayerName(target).."#e7d9b0 za kwotę #388E00"..moneyee.."$#e7d9b0.", plr,231, 217, 176,true)
		outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..moneyee22.."$#e7d9b0 za demontaż części #EBB85D"..nazwa.."#e7d9b0.", plr,231, 217, 176,true)
		removeData(target)
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..plruid.."', lbank_kwota='"..spr.."', lbank_data=NOW(), lbank_desc='Demont komponentu auta.', lbank_type='1'");
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..plruid2.."', lbank_kwota='"..koszt_tuner.."', lbank_data=NOW(), lbank_desc='Marża za demont elementu.', lbank_type='1'");
		
		local transfer_text=('[TUNE:DEMONT] Pojazd ID:'..veh_id..' cesc '..nazwa..' (przez '..getPlayerName(plr)..'/'..plruid2..' dla '..getPlayerName(target)..'/'..plruid..') za '..moneyee..'$')	
	    outputServerLog(transfer_text)
	end
	if tostring(typ) == "tuning" then
		local targetmoney = getPlayerMoney(target)
		local spr = tonumber(koszt) + tonumber(koszt_tuner);
		if tonumber(spr) > tonumber(targetmoney) then
			outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz tyle gotówki przy sobie!", target,231, 217, 176,true)
			removeData(target)
			return
		end

		givePlayerMoney(plr, koszt_tuner)
		takePlayerMoney(target, spr)
		
--		addVehicleUpgrade(pojazd,idELEMENTU)
		local veh_id = getElementData(pojazd,"vehicle:id") or 0; -- id poj
		if tonumber(idELEMENTU) > 10 then
			addVehicleUpgrade(pojazd,idELEMENTU)
		else
			if tonumber(idELEMENTU)==1 then 
				setElementData(pojazd,"vehicle:mk1",1)
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk1='1' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)==2 then 
				setElementData(pojazd,"vehicle:mk2",1) 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk2='1' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)==3 then 
				setElementData(pojazd,"vehicle:mk3",1) 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_mk3='1' WHERE veh_id='"..veh_id.."'");
			end -- end
			if tonumber(idELEMENTU)>=4 and tonumber(idELEMENTU)<=9 then 
				setElementData(pojazd,"vehicle:su1",idELEMENTU) 
				local res2 = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_SU1='"..idELEMENTU.."' WHERE veh_id='"..veh_id.."'");
			end -- end
		end

		
		local plruid = getElementData(target,"player:dbid") or 0;
		local plruid2 = getElementData(plr,"player:dbid") or 0;
		
		if tonumber(plruid) > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..spr.." WHERE user_id='"..plruid.."'");
		end
		if tonumber(plruid2) > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..koszt_tuner.." WHERE user_id='"..plruid2.."'");
		end
		
		triggerEvent("localInfoChat",root,target,"wyraził zgodę na montaż elementu #EBB85D"..nazwa.."#e7d9b0.",45)
		
		local moneyee = string.format("%.2f", spr/100)
		local moneyee22 = string.format("%.2f", koszt_tuner/100)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie zamontowano #EBB85D"..nazwa.."#e7d9b0 za kwotę #388E00"..moneyee.."$#e7d9b0.", target,231, 217, 176,true)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie zamontowano #EBB85D"..nazwa.."#e7d9b0 graczowi #EBB85D"..getPlayerName(target).."#e7d9b0 za kwotę #388E00"..moneyee.."$#e7d9b0.", plr,231, 217, 176,true)
		outputChatBox("#388E00✔#e7d9b0 Otrzymano #388E00"..moneyee22.."$#e7d9b0 za montaż części #EBB85D"..nazwa.."#e7d9b0.", plr,231, 217, 176,true)
		removeData(target)
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..plruid.."', lbank_touserid = '22', lbank_kwota='"..spr.."', lbank_data=NOW(), lbank_desc='Montaż komponentu auta.', lbank_type='1'");
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..plruid2.."', lbank_kwota='"..koszt_tuner.."', lbank_data=NOW(), lbank_desc='Marża za montaż elementu.', lbank_type='1'");
		
		local transfer_text=('[TUNE:MONTAZ] Pojazd ID:'..veh_id..' cesc '..nazwa..' (przez '..getPlayerName(plr)..'/'..plruid2..' dla '..getPlayerName(target)..'/'..plruid..') za '..moneyee..'$')	
	    outputServerLog(transfer_text)
	end
	
end)


function removeData(target)
	removeElementData(target,"tuneacc:plr")
	removeElementData(target,"tuneacc:target")
	removeElementData(target,"tuneacc:CAR")
	removeElementData(target,"tuneacc:typ")
	removeElementData(target,"tuneacc:nazwa")
	removeElementData(target,"tuneacc:koszt")
	removeElementData(target,"tuneacc:koszt_tuner")
	removeElementData(target,"tuneacc:idELEMENTU")
end










