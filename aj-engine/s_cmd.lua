

addCommandHandler("nicki", function(plr,cmd,cel)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
		if not cel then
			outputChatBox("* Użycie: /nicki <ID/Nick>",plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local target_id = getElementData(target,"player:dbid") or 0;
		local szukamgracza = exports["aj-dbcon"]:wyb("SELECT * FROM server_users_oldnicknames WHERE oldnick_userid='"..target_id.."' ORDER BY oldnick_id DESC LIMIT 5")
		if #szukamgracza == 0 then
			outputChatBox("#841515✖#e7d9b0 Błąd, podany gracz nigdy nie zmienił nicku.",plr,231, 217, 176,true)
			return
		end
		-- poka info raz 2 3
		local graczanicki = {}
		for i,gracz in ipairs(szukamgracza) do
			zmienna = ""..(gracz.oldnick_name):gsub("#%x%x%x%x%x%x","").."";
			table.insert(graczanicki, zmienna)
		end
		outputChatBox("#e7d9b0Ostatnie 5 nicków gracza #EBB85D"..getPlayerName(target).."#e7d9b0 to:", plr,231, 217, 176,true)
		outputChatBox(table.concat(graczanicki,", "),plr)
	end
end)

addCommandHandler("gp2", function(plr,cmd)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
	local veh = getPedOccupiedVehicle(plr)
	if veh then
		--gp poj
		local x,y,z = getElementPosition(veh)
		outputChatBox("{"..x..", "..y..", "..z.."},", plr, 0, 255, 0);
	else
		 -- gp gracz
		local x,y,z = getElementPosition(plr)
		outputChatBox("{"..x..", "..y..", "..z.."},", plr, 0, 255, 0);
	end
	end
end)


-- obracanie pojazdu
function sprPojBlisko(gracz)
	x,y,z = getElementPosition(gracz)
	for k, v in ipairs(getElementsByType("vehicle",root)) do
		fX,fY,fZ = getElementPosition(v)
		dist = getDistanceBetweenPoints3D(x,y,z,fX,fY,fZ)
		if tonumber(dist) < 3 then
			return v
		end
	end
	return false
end

function sprGraczBlisko(gracz)
	x,y,z = getElementPosition(gracz)
	for k, v in ipairs(getElementsByType("player",root)) do
		fX,fY,fZ = getElementPosition(v)
		dist = getDistanceBetweenPoints3D(x,y,z,fX,fY,fZ)
		if tonumber(dist) < 5 and v ~= gracz then
			return v
		end
	end
	return false
end

addCommandHandler("obrocpojazd", function(plr,cmd)
    local uid = getElementData(plr,"player:dbid") or 0;
    if uid > 0 then
		pojazd = sprPojBlisko(plr);
		if pojazd then
			xr, yr, zr = getElementRotation(pojazd)
			if xr >= 170 and xr <= 210 then
				gracz = sprGraczBlisko(plr);
				if gracz then
					salon = getElementData(pojazd,"vehicle:salon") or false;
					if not salon then
						triggerEvent("localInfoChat",root,plr,"obraca pojazd na koła.",45)
						setElementRotation(pojazd, 0, 0, zr)
					end
				else
					outputChatBox("#7AB4EAⒾ#e7d9b0 Aby obrócić pojazd, potrzebujesz pomocnika w pobliżu!", plr,231, 217, 176,true)
				end
			end
		else
			outputChatBox("#7AB4EAⒾ#e7d9b0 Aby obrócić pojazd, musisz znajdować się obok niego!", plr,231, 217, 176,true)
		end
    end
end)


---------------------------------------------------------------------------
-- sellanie pojazdu v2
-- sellanie pojazdu v2

function sprPojBliskoDWA(poj,gracz)
	x,y,z = getElementPosition(gracz)
--	x2,y2,z2 = getElementPosition(gracz)
	for k, v in ipairs(getElementsByType("vehicle",root)) do
		fX,fY,fZ = getElementPosition(v)
		dist = getDistanceBetweenPoints3D(x,y,z,fX,fY,fZ)
		pojid = getElementData(v,"vehicle:id") or 0;
		if tonumber(dist) < 7 and pojid==tonumber(poj) and pojid > 0 then
			return v
		end
	end
	return false
end

function sprGraczBliskoDWA(plr,gracz)
	x,y,z = getElementPosition(plr)
	x2,y2,z2 = getElementPosition(gracz)
	dist = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if tonumber(dist) < 7 and plr ~= gracz then
		return true
	end
	return false
end

addCommandHandler("sprzedajpojazd", function(plr,cmd,plrid,carid,carcena)
    if not plrid or not tonumber(carid) or not tonumber(carcena) then
		outputChatBox("* Użycie: /sprzedajpojazd <nick/ID> <ID poj> <cena>",plr)
		return 
	end
	if tonumber(carcena) > 999999 then 
		outputChatBox("* Maksymalna kwota sprzedaży pojazdu wynosi 999,999$!",plr)
		return 
	end
	if tonumber(carcena) <= 0 then return end
    local uid = getElementData(plr,"player:dbid") or 0;
    if uid > 0 then
		pojazd = sprPojBliskoDWA(carid,plr);
		if pojazd then
			pojowner = getElementData(pojazd,"vehicle:owner") or 0;
			if pojowner==uid and pojowner > 0 then
				local target = exports["aj-engine"]:findPlayer(plr,plrid)
				if not target or target==plr then
					outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
					return
				end
				gracz = sprGraczBliskoDWA(plr,target);
				if gracz then
					-- tutaj dokonczyc
					sellAutaStart(carid,carcena,target,uid,plr)
					outputChatBox("#388E00✔#e7d9b0 Wysłano ofertę do gracza!", plr, 255,255,255,true)
				else
					outputChatBox("#7AB4EAⒾ#e7d9b0 Aby sprzedać pojazd, kupiec musi być w pobliżu!", plr,231, 217, 176,true)
				end
			end
		else
			outputChatBox("#7AB4EAⒾ#e7d9b0 Aby sprzedać pojazd, musisz znajdować się obok niego!", plr,231, 217, 176,true)
		end
    end
end)

function sellAutaStart(idCar,selectedPrince,target,ownerID,plr)
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
	multicost = selectedPrince + 250; -- podatek
	local multicost22 = string.format("%.2f", multicost)

	local sid = getElementData(plr,"id")
	
	local sprkppojazd = getElementData(target,"kuppojazd") or 0;
	if sprkppojazd > 0 then
		-- nic
		outputChatBox("#841515✖#e7d9b0 Błąd, podany gracz aktualnie handluje.", plr, 255,255,255,true)
	else
		outputChatBox(" ", target,255,255,255,true)
		outputChatBox("#e7d9b0 * Otrzymałeś/aś ofertę kupna pojazdu #B8B0E7"..getVehicleNameFromModel(veh_modelid).."#e7d9b0 za kwotę #388E00"..multicost22.."$#e7d9b0.", target,255,255,255,true)
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

function znajdzPoj(pojID)
	for k, v in ipairs(getElementsByType("vehicle",root)) do
		local crID = getElementData(v,"vehicle:id") or 0;
		if tonumber(pojID) == crID then
			return v
		end
	end
	return false	
end

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
	local target = exports["aj-engine"]:findPlayer(plr,cel)
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
	
	if cost > getPlayerMoney(plr) then
		outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz tyle gotówki.", plr, 255,255,255,true)
		return 
	end
	
	takePlayerMoney(plr, cost)
    givePlayerMoney(target, cost2)
	
	uid = getElementData(plr,"player:dbid") or 0;
	uid2 = getElementData(target,"player:dbid") or 0;
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cost.." WHERE user_id = '"..uid.."'");
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..cost.." WHERE user_id = '"..uid2.."'");
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_owner='"..uid.."', veh_ownergroup='0' WHERE veh_id = '"..carow_id.."'");
	
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
	
	veh = znajdzPoj(carow_id)
	if veh then
		exports["aj-vehs"]:przeladujPoj(veh)
	end
	removeElementData(plr,"kuppojazd")
	removeElementData(plr,"kuppojazd:car_id")
	removeElementData(plr,"kuppojazd:owner_id")
	
	triggerClientEvent("zakonczOdliczanieEnd",root,plr)
	
	end
	end

end
addCommandHandler("kuppojazd", akceptujTransakcje)

addEvent("removeZakuPojCzasEnd", true)
addEventHandler("removeZakuPojCzasEnd", root, function(plr)

    outputChatBox("#EBB85DGiełda#e7d9b0: czas na zakup pojazdu minął.", plr, 255, 255, 255, true)  
	removeElementData(plr,"kuppojazd")
	removeElementData(plr,"kuppojazd:car_id")
	removeElementData(plr,"kuppojazd:owner_id")
	
end)

---------------------------------------------------------------------------


function cmd_admins(plr)
  local supporci={}
  local moderatorzy={}
  local admini={}
  local root={}
  for i,v in ipairs(getElementsByType("player")) do
  	if (getElementData(v,"admin:poziom") == 5) then
	  local t
	  local login = getElementData(v,"admin:zalogowano")
	  if login == "true" then
		t="#3095bd"..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."("..getElementData(v,"id")..")"
		table.insert(supporci,t)
	  end
	end
  	if (getElementData(v,"admin:poziom") == 6) then
	  local t
	  local login = getElementData(v,"admin:zalogowano")
	  if login == "true" then
		t="#1f6e04"..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."("..getElementData(v,"id")..")"
		table.insert(supporci,t)
	  end
	end
  	if (getElementData(v,"admin:poziom") == 7) then
	  local t
	  local login = getElementData(v,"admin:zalogowano")
	  if login == "true" then
		t=""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."("..getElementData(v,"id")..")"
		table.insert(admini,t)
	  end
	end
  	if (getElementData(v,"admin:poziom") == 10) then
	  local t
	  local login = getElementData(v,"admin:zalogowano")
	  if login == "true" then
		t=""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."("..getElementData(v,"id")..")"
		table.insert(root,t)
	  end
	end
end

  if (#root>0) then
  outputChatBox("Administratorzy RCON:", plr, 100, 0, 0)
    outputChatBox(" " .. table.concat(root,", "), plr)
  end
 
  if (#admini>0) then 
  outputChatBox("Administratorzy:", plr, 255, 0, 0)
    outputChatBox(" " .. table.concat(admini,", "), plr)
  end
  
  outputChatBox("Moderatorzy:", plr, 134, 170, 193)
  if (#supporci>0) then
    outputChatBox(" #e7d9b0" .. table.concat(supporci,"#e7d9b0, "), plr, 255, 255, 255, true)
  else
	outputChatBox("* Brak.", plr)
  end
end
addCommandHandler("admins", cmd_admins, false, false)
addCommandHandler("ekipa", cmd_admins, false, false)
addCommandHandler("admini", cmd_admins, false, false)
