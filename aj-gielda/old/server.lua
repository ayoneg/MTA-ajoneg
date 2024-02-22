
--// urzad lv wejscie
addEvent("onGraczWejdzieGielda", true)
addEventHandler("onGraczWejdzieGielda", root, function()
    setElementInterior(source, 3, -2029.7607421875, -117.705078125, 1035.171875)
	setElementDimension(source, 200)
    local rotX, rotY, rotZ = getElementRotation(source) -- get the local players's rotation
	setElementRotation(source,0,0,rotZ-90,"default",true)
     	--fadeCamera ( source, true, 1.0, 255, 0, 0 )
		setCameraTarget(source, source)
end)

--// urzad lv wyjscie
addEvent("onGraczWyjdzieGielda", true)
addEventHandler("onGraczWyjdzieGielda", root, function()
    setElementInterior(source, 0, 1737.1171875, 1857.9501953125, 10.8203125)
	setElementDimension(source, 0)
    local rotX, rotY, rotZ = getElementRotation(source) -- get the local players's rotation
	setElementRotation(source,0,0,rotZ+180,"default",true)
     	--fadeCamera ( source, true, 1.0, 255, 0, 0 )
		setCameraTarget(source, source)
end)

local name = createBlip(1737.1181640625, 1890.7734375, 11.1328125, 55, 2, 0, 0, 0, 255, -1, 600)


function sprauta(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
    local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner = '"..uid.."'");
	triggerClientEvent(client, "onClientOdsiwezy", root, result)
end


function sellAutaStart(idCar,idPlayer,selectedPrince,target,sid,client_new)
    --outputChatBox("* test  "..idCar)

	
    local cars = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..idCar.."'");
	veh_id = cars[1].veh_id;
	veh_przebieg = cars[1].veh_przebieg;
	veh_modelid = cars[1].veh_modelid;
	
	veh_mk1 = cars[1].veh_mk1;
	if veh_mk1 > 0 then veh_mk1_ = "MK1" else veh_mk1_ = "" end
	veh_mk2 = cars[1].veh_mk2;
	if veh_mk2 > 0 then veh_mk2_ = ", MK2" else veh_mk2_ = "" end
	veh_mk3 = cars[1].veh_mk3;
	if veh_mk3 > 0 then veh_mk3_ = ", MK3" else veh_mk3_ = "" end
	veh_SU1 = cars[1].veh_SU1;
	if veh_SU1 > 0 then veh_SU1_ = ", SU1" else veh_SU1_ = "" end
	
	value = (selectedPrince*100);
	local money = string.format("%.2f", value/100)
	--local money2 = value/100;
	multicost = selectedPrince + 250;
	local multicost22 = string.format("%.2f", multicost)

	
	local sprkppojazd = getElementData(target,"kuppojazd") or 0;
	if sprkppojazd > 0 then
		-- nic
		outputChatBox("#841515✖#e7d9b0 Błąd, podany gracz aktualnie handluje.", client_new, 255,255,255,true)
	else
		outputChatBox(" ", target,255,255,255,true)
		outputChatBox("#e7d9b0 * Otrzymałeś/aś ofertę kupna pojazdu #B8B0E7"..getVehicleNameFromModel(veh_modelid).."#e7d9b0 za cenę #388E00"..multicost22.."$#e7d9b0.", target,255,255,255,true)
		outputChatBox("#e7d9b0 * Zamontowane układy: #B8B0E7"..veh_mk1_..veh_mk2_..veh_mk3_..veh_SU1_.."#e7d9b0.", target,255,255,255,true)
		outputChatBox("#e7d9b0 * O pojeździe:  ID #B8B0E7"..veh_id.."#e7d9b0, przebieg silnika #B8B0E7"..veh_przebieg.."#e7d9b0 km", target,255,255,255,true);
		outputChatBox("#e7d9b0 * Aby potwierdzić zakup wpisz #E7B0B0/kuppojazd "..sid.." "..multicost.."#e7d9b0, masz 30 sekund.", target,255,255,255,true)
		outputChatBox(" ", target,255,255,255,true)
	
		setElementData(target,"kuppojazd",multicost)
		setElementData(target,"kuppojazd:owner_id",sid)
		setElementData(target,"kuppojazd:car_id",veh_id)
		triggerClientEvent("uruchomOdliczanieStart",root,target)
	end
	
end

addEvent("removeZakuPojCzasEnd", true)
addEventHandler("removeZakuPojCzasEnd", root, function(plr)

    outputChatBox("#EBB85DGiełda#e7d9b0: czas na zakup pojazdu minął.", plr, 255, 255, 255, true)  
	removeElementData(plr,"kuppojazd")
	removeElementData(plr,"kuppojazd:car_id")
	removeElementData(plr,"kuppojazd:owner_id")
	
end)


function akceptujTransakcje(plr,cmd,cel,kwota)
	if not getElementData(plr,"kuppojazd") then return end
--	killTimer(timer)
	local carowner = getElementData(plr,"kuppojazd:owner_id") or 0;
	if carowner ~= tonumber(cel) then return end
--	local carid = getElementData(plr,"kuppojazd:owner_id") or 0;
--	if carid ~= tonumber(cel) then return end
	local dbid = getElementData(plr,"player:dbid") or 0;
	if dbid > 0 then
	local cost = getElementData(plr,"kuppojazd") or 0;
	if tonumber(kwota) == cost then
	
	   local plr_m = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..dbid.."'");
	   if #plr_m < 0 then return end
	   local plr_cars = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner = '"..dbid.."'");
	   
	   plr_money = plr_m[1].user_money
	   plr_slots = plr_m[1].user_carslot
	   if plr_money < getElementData(plr,"kuppojazd") then
	       outputChatBox("#841515✖#e7d9b0 Błąd, nie masz przy sobie tyle gotówki!", plr, 255,255,255,true)
		   --outputChatBox("* Błąd, "..getPlayerName(plr).." nie masz przy sobie tyle gotówki!", target)
	       return
	   end
	   if #plr_cars >= tonumber(plr_slots) then
	       outputChatBox("#841515✖#e7d9b0 Błąd, nie masz miejsca na kolejny pojazd!", plr, 255,255,255,true)
	       return 
	   end
	local target=findPlayer(client,cel)
	if not target then
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local targ_id = getElementData(target,"id") or 0;
	
	local onwer_id = getElementData(plr,"kuppojazd:owner_id") or 0;
	local carow_id = getElementData(plr,"kuppojazd:car_id") or 0;
	
	
	if onwer_id == targ_id then
--	cost = getElementData(plr,"kuppojazd");
    cost = cost*100;
	cost2 = cost - 25000;
	
	local getplrmoney = getPlayerMoney(target) + cost2;
	if getplrmoney > 99999999 then
		outputChatBox("#841515✖#e7d9b0 Błąd, "..getPlayerName(target).." nie posiada miejsca na gotowkę.", plr, 255,255,255,true)
		outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz miejsca na gotowkę.", target, 255,255,255,true)
		return 
	end
	
	takePlayerMoney(plr, cost)
    givePlayerMoney(target, cost2)
	
	uid = getElementData(plr,"player:dbid") or 0;
	uid2 = getElementData(target,"player:dbid") or 0;
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cost.." WHERE user_id = '"..uid.."'");
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..cost.." WHERE user_id = '"..uid2.."'");
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_owner='"..uid.."' WHERE veh_id = '"..carow_id.."'");
	
	--// TYPE = 1 - wpłata // 2 - wypłata
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..uid.."', lbank_touserid = '"..uid2.."', lbank_kwota='"..cost.."', lbank_data=NOW(), lbank_desc='Zakup/Sprzedaż pojazdu ID "..carow_id..".', lbank_type='1'");
	
    local money = string.format("%.2f", cost2/100)
	
    local transfer_text=('[HANDEL:AUT] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"player:dbid")..' ['..money..' $]')	
	outputServerLog(transfer_text)
	
	local desc22 = 'HANDEL/AUT: '..getPlayerName(plr)..'/'..getElementData(plr,"id")..' kupił od '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..' suma: '..money..' $'
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	
	outputChatBox("#388E00✔#e7d9b0 Gratulacje, pomyślnie zakupiono pojazd!", plr, 255,255,255,true)
	outputChatBox("#388E00✔#e7d9b0 Gratulacje, pomyślnie sprzedano pojazd!", target, 255,255,255,true)
	
	else
--	outputChatBox("#841515✖#e7d9b0 Błąd, !", plr, 255,255,255,true)
	end
	
	removeElementData(plr,"kuppojazd")
	removeElementData(plr,"kuppojazd:car_id")
	removeElementData(plr,"kuppojazd:owner_id")
	
	triggerClientEvent("killTimerClientSideC",root,plr)
	
	end
	end

end
addCommandHandler("kuppojazd", akceptujTransakcje)


addEvent("cz2SellAuta", true)
addEventHandler("cz2SellAuta", root, function(idCar, idPlayer, selectedPrince)

	local uid = getElementData(client,"player:dbid");
	local sid = getElementData(client,"id");
	if not uid then return end

	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner = '"..uid.."' AND veh_id = '"..idCar.."'");
	if #result < 0 then return end
	local target=findPlayer(client,idPlayer)
	if not target then
		outputChatBox("* Nie znaleziono podanego gracza.", client, 255, 0, 0)
		return
	end
	if getElementData(target, "intrangiel") == false then 
		outputChatBox("* Podany gracz, nie jest w odpowiednim miejscu.", client, 255, 0, 0)
		return
	end
--	local sprus = dbPoll(dbQuery(db, "SELECT * FROM server_users WHERE user_id='"..idPlayer.."'"),-1);
--	if sprus[1].user_money < selectedPrince then
--	    outputChatBox("* Podany gracz, nie jest w odpowiednim miejscu.", plr, 255, 0, 0)
--	    return 
--	end
	local plr_mo = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
	if #plr_mo < 0 then return end
	local plr_money = plr_mo[1].user_money;
	
	value = (selectedPrince*100);
	
	local new_money = plr_money+value;
	local new_money = tonumber(new_money);
	if 99999999 < new_money then 
		outputChatBox("#841515✖#e7d9b0 Błąd, osiągnięto limit gotówki przy sobie!", client,231, 217, 176,true) 
		return 
	end
	   

	--outputChatBox("* test git", client);
	--value = true;
	--outputChatBox("* Wysłano ofertę do gracza!", client)
	outputChatBox("#388E00✔#e7d9b0 Wysłano ofertę do gracza!", client, 255,255,255,true)
	sellAutaStart(idCar,idPlayer,selectedPrince,target,sid,client)
end)

addEvent("onGoscWejdzie", true)
addEventHandler("onGoscWejdzie", root, sprauta)

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 0, true) then
				if (target) then
					outputChatBox("* Znaleziono więcej niż jednego gracza o pasującym nicku, podaj więcej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	if target and getElementData(target,"p:inv") then return nil end
	return target
end

