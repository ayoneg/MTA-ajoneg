-- core admins
-- type(clothingSlot) ~= "number" -- oho



addCommandHandler("root.cj", function(plr,cmd,clothingSlot,clothingID)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	if not isElement(plr) or type(tonumber(clothingSlot)) ~= "number" then
		error("Invalid arguments to setPedClothes()!", 2)
	end
	
	if not clothingID then
		return removePedClothes(plr, clothingSlot)
	end
	
	local hasClothes = getPedClothes(plr, clothingSlot) 
	if hasClothes then
		removePedClothes(plr, clothingSlot)
	end
	
	local texture, model = getClothesByTypeIndex(clothingSlot, clothingID)
	return addPedClothes(plr, texture, model, clothingSlot)
    end
end
end)

addCommandHandler("root.tune", function(plr,cmd,value)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 10 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	local veh=getPedOccupiedVehicle(plr)
		if not veh or not tonumber(value) then
			outputChatBox("* Użycie: /tune <id>", plr)
			return
		end
		if tonumber(value) == 1086 then return end
		local veh=getPedOccupiedVehicle(plr)
		addVehicleUpgrade(veh,value)
		outputChatBox("* Do twojego pojazdu dodano tuning, o id: "..value.."", plr)
	end
	end

end)

addCommandHandler("root.zerowanie", function(plr,cmd)
if getElementData(plr,"admin:poziom") >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe", plr)
			return
		end
		setElementData(veh, "vehicle:przebieg", 0)
		outputChatBox("* Auto zostało wyzerowane!",plr,0,255,0)
end
end)

addCommandHandler("root.nadajslot", function(plr,cmd,cel,value)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 10 then
    if getElementData(plr,"admin:zalogowano") == "true" then
    if not cel or not value then
        outputChatBox("* Użyj: /root.nadajslot <id/nick>", plr)
        return
    end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local plr_carSlot = getElementData(target,"player:carSlot") or 0;
	local plr_id = getElementData(target,"player:dbid") or 0;
	setElementData(target,"player:carSlot",plr_carSlot+value)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_carslot=user_carslot+'"..value.."' WHERE user_id='"..plr_id.."'");
end
end
end)

addCommandHandler("root.lampy", function(plr,cmd,lampR,lampG,lampB)
if getElementData(plr,"admin:poziom") >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe", plr)
			return
		end
		if not tonumber(lampR) or not tonumber(lampG) or not tonumber(lampB) then
		    outputChatBox("* Użycie: /root.lampy <r> <g> <b>", plr)
		    return
		end
		setVehicleHeadLightColor(veh, lampR, lampG, lampB)	
		outputChatBox("* Pomyślnie zmieniono kolor lamp pojazdu.",plr,0,255,0)
end
end)

addCommandHandler("root.tablicapoj", function(plr,cmd, ...)
if getElementData(plr,"admin:poziom") >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe", plr)
			return
		end
		if not ... then
		    outputChatBox("* Użycie: /root.tablicapoj <treść>", plr)
		    return
		end
		local veh_id=getElementData(veh,"vehicle:id") or 0;
		local plate = table.concat({...}, " ")
		setVehiclePlateText(veh,plate.." "..veh_id.."")
		outputChatBox("* Pomyślnie zmieniono tablicę pojazdu.",plr,0,255,0)
end
end)

addCommandHandler("root.przepiszpoj", function(plr,cmd,carid,target)
if getElementData(plr,"admin:poziom") >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
    if not carid or not target then
	   outputChatBox("* Użycie: /root.przepiszpoj <carID> <userUID>",plr)
	   return
	end
	local spruser = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..target.."' LIMIT 1");
	if #spruser > 0 then
--        outputChatBox("* Auto zostało wyzerowane!",plr,0,255,0)
		local sprcar = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..carid.."' LIMIT 1");
		if #sprcar > 0 then
		    local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_owner = '"..target.."' WHERE veh_id = '"..carid.."'");
	        local vehicless = getElementsByType('vehicle')
		    for _, veh in pairs(vehicless) do
			    local veh_ids = getElementData(veh,"vehicle:id") or 0;
				if veh_ids == tonumber(carid) then
				    exports["aj-vehs"]:zapiszPoj(veh)
					exports["aj-vehs"]:przeladujPoj(veh)
				end
			end
			outputChatBox("* Pojazd "..getVehicleNameFromModel(sprcar[1].veh_modelid).."/"..sprcar[1].veh_id.." został przepisany na konto "..spruser[1].user_nickname.."/"..spruser[1].user_id.."",plr,0,255,0)
		end
	end
end
end)

addCommandHandler("root.vehsdp", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 10 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	    local vehicless = getElementsByType('vehicle')
		for _, veh in pairs(vehicless) do
    	    local v_id = getElementData(veh,"vehicle:id") or 0;
			if tonumber(v_id) > 0 and tonumber(v_id) < 999999 then
		    	local vehs_spr = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..v_id.."'");
				if vehs_spr[1].veh_parking == 0 then
				    outputChatBox("* Daje na parking ID: "..vehs_spr[1].veh_id, plr);
					exports["aj-vehs"]:zapiszPojazd(veh)
				end
			else
			    destroyElement(veh)
			end
		end
		outputChatBox("* Zakończono synchronizacje pojazdów...", root);
	end
end
end)

--[[
function setMyVehiclesVariant(theUser, command, var1, var2)
local perm = tonumber(getElementData(theUser,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(theUser,"admin:zalogowano") == "true" then
    local var1, var2 = tonumber(var1), tonumber(var2) -- If anything was passed make sure its number or nil
    local myVeh = getPedOccupiedVehicle(theUser) -- Get the vehicle that they're in
    if (myVeh and getVehicleController(myVeh) == theUser) then -- Make sure they're in control
        local wasSet = setVehicleVariant(myVeh, var1, var2) -- Set what they wanted
        if (wasSet) then
            outputChatBox("Vehicle variant successfully set!", theUser, 0, 255, 0)
        else
            outputChatBox("Vehicle variant unsuccessfully set.", theUser, 255, 255, 0)
        end
    end
	end
end
end
addCommandHandler("setvehvar", setMyVehiclesVariant) -- Add the command

function getMyVehiclesVariant(theUser, command)
if getElementData(theUser,"admin:poziom") >= 7 then
    if getElementData(theUser,"admin:zalogowano") == "true" then
    local myVeh = getPedOccupiedVehicle(theUser) -- Get the vehicle that they're in
    if (myVeh) then
        local var1, var2 = getVehicleVariant(myVeh) -- Get the info
        outputChatBox("This vehicles variants: "..tostring(var1).." "..tostring(var2)) -- Output the info
    end
end
end
end
addCommandHandler("getvehvar", getMyVehiclesVariant)
]]--


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

addCommandHandler("gasnica", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
	if perm >= 6 and getElementData(plr,"admin:zalogowano") == "true" then
		if giveWeapon(plr,42,99999,true) then
			outputChatBox("#7AB4EAⒾ#e7d9b0 Otrzymałeś/aś gaśnicę.", plr,231, 217, 176,true)
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


addCommandHandler("ucho", function(plr,cmd)
    local uid = getElementData(plr,"player:dbid") or 0;
	local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
    if uid > 0 and perm >= 5 then
        local getjudcfgucho = getElementData(plr,"player:ucho") or false;
        if getjudcfgucho == false then
            setElementData(plr,"player:ucho",true)
        else
            setElementData(plr,"player:ucho",false)
        end
    end
end)

addCommandHandler("przeladujpoj", function(plr,cmd,carid)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
	if perm >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
    if not carid then
	   outputChatBox("* Użycie: /przeladujpoj <carID>",plr)
	   return
	end
	local sprcar = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..carid.."' LIMIT 1");
	if #sprcar > 0 then
	    local vehicless = getElementsByType('vehicle')
		for _, veh in pairs(vehicless) do
			local veh_ids = getElementData(veh,"vehicle:id") or 0;
			if veh_ids == tonumber(carid) then
				exports["aj-vehs"]:zapiszPoj(veh)
				exports["aj-vehs"]:przeladujPoj(veh)
				exports["aj-vehsconfig"]:nadajHandingPoj(veh,plr)
			end
		end
		outputChatBox("* Pojazd "..getVehicleNameFromModel(sprcar[1].veh_modelid).."/"..sprcar[1].veh_id.." został przeładowany.",plr,0,255,0)
	end
end
end)

addCommandHandler("pogoda", function(plr,cmd,pogodaID)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
	if perm >= 6 and getElementData(plr,"admin:zalogowano") == "true" then
    if not pogodaID then
	   outputChatBox("* Użycie: /pogoda <ID>",plr)
	   return
	end
	if tonumber(pogodaID) < 0 or tonumber(pogodaID) > 43 then
	   return
	end
	setWeather(pogodaID)
end
end)


addCommandHandler("tpgp", function(plr,cmd,value1,value2,value3)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not tonumber(value1) or not tonumber(value2) or not tonumber(value3) then
			outputChatBox("* Użycie: /tpgp <x> <y> <z>",plr)
			return 
		end
		setElementPosition(plr, value1, value2, value3+1)
		
        local transfer_text=('[TP:GP] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> x: '..value1..' y: '..value2..' z: '..value3..'')	
	    outputServerLog(transfer_text)
	end
	end
end)

addCommandHandler("tpto", function(plr,cmd,plr1,plr2)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not plr1 or not plr2 then
			outputChatBox("* Użycie: /tpto <ID/nick> <ID/nick>",plr)
			return 
		end
		local target1 = findPlayer(plr,plr1)
		if not target1 then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local target2 = findPlayer(plr,plr2)
		if not target2 then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		-- all ok, tepam
		if target2 == target1 or plr == target1 or plr == target2 then return end
		-- all ok, tepam
		x,y,z = getElementPosition(target1)
		dimplr1 = getElementDimension(target1)
		intplr1 = getElementInterior(target1)
		
		setElementPosition(target2, x,y,z+1)
		setElementDimension(target2, dimplr1)
		setElementInterior(target2, intplr1)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Pomyślnie przeniesiono gracza #EBB85D"..getPlayerName(target2).."#e7d9b0 do gracza #EBB85D"..getPlayerName(target1).."#e7d9b0.", plr,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Zostałeś/aś przeniesiony/a do gracza #EBB85D"..getPlayerName(target1).."#e7d9b0 przez #EBB85D"..getPlayerName(plr).."#e7d9b0.", target2,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Przeniesiono do Ciebię gracza #EBB85D"..getPlayerName(target2).."#e7d9b0, przez #EBB85D"..getPlayerName(plr).."#e7d9b0.", target1,231, 217, 176,true)
		
        local transfer_text=('[TP:TO] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> przenosi '..getPlayerName(target2)..'/'..getElementData(target2,"player:dbid")..' do '..getPlayerName(target1)..'/'..getElementData(target1,"player:dbid")..'')	
	    outputServerLog(transfer_text)
	end
	end
end)

odliczanie_swiat = false

addCommandHandler("odlicz", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	if odliczanie_swiat == false then
		x,y,z = getElementPosition(plr)
		triggerClientEvent("oczliczStart", resourceRoot, x,y,z)
		odliczanie_swiat = true
		setTimer(function()
		odliczanie_swiat = false
		end, 6000, 1)
	else
	    outputChatBox("* Aktualnie na świecie istnieje już odliczanie!", plr, 255, 0, 0)
	end
    end
end
end)

addCommandHandler("pojazdygracza", function(plr,cmd,cel)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
    if not cel then
        outputChatBox("* Użyj: /pojazdygracza <id/nick>", plr)
        return
    end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
	local result = exports['aj-dbcon']:wyb("SELECT * FROM server_vehicles WHERE veh_owner = '"..getElementData(target,"player:dbid").."'")
	if not result or #result < 1 then
	outputChatBox("* Podany gracz nie posiada żadnych pojazdów.", plr)
	return end
	outputChatBox("#e7d9b0Pojazdy gracza #EBB85D"..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."#e7d9b0:", plr, 255, 255, 255, true)
	outputChatBox(" ",plr)
	for i,res in pairs(result) do
	if res.veh_parking == 1 then notice = ", #999999(PARKING)"; else notice = ""; end
    outputChatBox("#EBB85D"..res.veh_id.."#e7d9b0 "..getVehicleNameFromModel(res.veh_modelid)..", #EBB85D"..res.veh_przebieg.." km#e7d9b0 przebiegu"..notice.."", plr, 255, 255, 255, true)
	end
	outputChatBox(" ",plr)
end
end
end)

scianarapsow = createObject ( 16637,-1931.6,883.27,35.41 )
setObjectScale(scianarapsow,3)
setElementDimension(scianarapsow,9999)
reportView = {{" ",0}}
setElementData(scianarapsow,"sciana:raportow",reportView)

addEvent("admin:addReport", true)
addEventHandler("admin:addReport", root, function(text,id)
	table.insert(reportView, {text,id})
	if #reportView > 17 then
		table.remove(reportView, 2)
	end
	setElementData(scianarapsow,"sciana:raportow",reportView)
end)

addEvent("admin:removeReport", true)
addEventHandler("admin:removeReport", root, function(id)
	for i=#reportView, 2, -1 do
		if reportView[i][2] == id then
			table.remove(reportView,i)
		end
	end
	setElementData(scianarapsow,"sciana:raportow",reportView)
end)

addEvent("admin:addNotice", true)
addEventHandler("admin:addNotice", root, function(reason,plr,id)
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") == "true" then
		
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then return end
	
            outputChatBox(""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." usunął/ęła raport na "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."/"..id..": "..reason, v, 255, 0, 0)
        end
	end
end)


scianatext = createObject ( 981,0,0,0 )
textView = {{" ",0}}
setElementDimension(scianatext,9999)
setElementData(scianatext,"sciana:text",textView)


addCommandHandler("cl", function(plr,cmd,id,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	local reason=table.concat({...}, " ")
	local target = exports["aj-engine"]:findPlayer(plr,id)
	if target then
		id=getElementData(target,"id")
		if target ~= plr then
		end
	end
	--if not target then id = id; end
	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") == "true" then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == id then
				triggerEvent("admin:removeReport", root, id)
				--outputChatBox(""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." usunął/ęła raport na "..opis:gsub("#%x%x%x%x%x%x","").."/"..id..": "..reason, v, 255, 0, 0)
				triggerEvent("admin:addNotice", root, reason,plr,id)
			    end
		    end
			end -- ff
		end
	end
	
	end
	end
end)

addEventHandler("onPlayerQuit", root, function()
    local id = getElementData(source,"id")
    triggerEvent("admin:removeReport", resourceRoot, id)  
end)




function reporty_adm(plr,cmd,cel,...)
	if not cel then
	if cmd == "zglos" then outputChatBox("* Użyj: /zglos <nick/ID> <powód>", plr) end
	if cmd == "raport" then outputChatBox("* Użyj: /raport <nick/ID> <powód>", plr) end
    if cmd == "report" then outputChatBox("* Użyj: /report <nick/ID> <powód>", plr) end	
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then
		outputChatBox("#841515✖#e7d9b0  Nie znaleziono podanego gracza.", plr, 255, 0, 0,true)
		return
	end
	local text=table.concat({...}, " ")
	desc=""..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."/"..getElementData(target,"id").." - "..text:gsub("#%x%x%x%x%x%x","").." - "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."/"..getElementData(plr,"id")..""
	triggerEvent("admin:addReport", resourceRoot, desc, getElementData(target,"id"))
	outputChatBox("#388E00✔#e7d9b0 Pomyślnie wysłano zgłoszenie.", plr,255,255,255,true)
end

addCommandHandler("report", reporty_adm, false, false)
addCommandHandler("raport", reporty_adm, false, false)
addCommandHandler("zglos", reporty_adm, false, false)

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

	
addCommandHandler("flip", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe!", plr)
			return
		end
		local salon = getElementData(veh,"vehicle:salon") or false;
		if salon==false then
		local x,y,z = getElementRotation(veh)
		outputChatBox("* Obróciłeś/aś pojazd.",plr)
		setElementRotation(veh, 0, 0, z)
		end
	end
    end
end)

addCommandHandler("dim", function(plr, cmd, value)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 10 then
    if getElementData(plr,"admin:zalogowano") == "true" then
        if (not value) then
            outputChatBox("* Użyj: /dim <ilość>", plr)
            return
        end
        setElementDimension(plr, value)
    end
	end
end)

--[[
addCommandHandler("eventowa", function(plr, cmd, value)
if getElementData(plr,"admin:poziom") >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if veh then
			outputChatBox("* Wyjdz z pojazdu!", plr)
			return
		end
        setElementDimension(plr, 10)
    end
	end
end)
]]--
addCommandHandler("up", function(plr, cmd, value)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
        if (tonumber(value)==nil) then
            outputChatBox("Użyj: /up <ile>", plr)
            return
        end
        local e = plr
        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(plr)
			local salon = getElementData(e,"vehicle:salon") or false;
			if salon==true then return end
        end
        local x,y,z = getElementPosition(e)
        setElementPosition(e, x, y, z+tonumber(value))
    end
	end
end)

addCommandHandler("thru", function(plr, cmd, value)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
        if (tonumber(value)==nil) then
            outputChatBox("Użyj: /thru <ile>", plr)
            return
        end
        local e = plr
        if getCameraTarget(plr) ~= plr then
            e = getCameraTarget(plr)
        end
        if (isPedInVehicle(plr)) then
            e = getPedOccupiedVehicle(e)
			local salon = getElementData(e,"vehicle:salon") or false;
			if salon==true then return end
        end
        local x,y,z = getElementPosition(e)
        local _,_,rz = getElementRotation(e)
        local rrz = math.rad(rz)
        local x = x + (value * math.sin(-rrz))
        local y = y + (value * math.cos(-rrz))
        setElementPosition(e, x, y, z)
    end
	end
end)

addCommandHandler("pj",function(plr,cmd,pj)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	if not pj or not tonumber(pj) then outputChatBox("* Wpisz /pj <0-3> !",plr) return end
	local pj = tonumber(pj)
	if pj < 0 or pj > 3 then outputChatBox("* Wpisz /pj <0-3> !",plr) return end
	local veh = getPedOccupiedVehicle(plr)
	if not veh then outputChatBox("* Najpierw wsiądź do pojazdu !", plr) return end
	setVehiclePaintjob(veh,pj)
	end
	end
end)

addCommandHandler("dajbron", function(plr,cmd,cel,bron,amunicja)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 10 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not cel or not bron then
			outputChatBox("* Użycie: /daj.bron <nick/ID> <bron> <amunicja>", plr)
			return
		end
		if not tonumber(bron) then
		outputChatBox("* Użycie: /daj.bron <nick/ID> <bron> <amunicja>", plr)
			return
		end
		if not amunicja then local amunicja = 10 end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if giveWeapon(target,bron,amunicja,true) then
			outputChatBox("* Nadałeś(aś) broń ("..getWeaponNameFromID(bron)..") dla "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
			outputChatBox("* Otrzymałeś(aś) broń ("..getWeaponNameFromID(bron)..") od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x",""),target)
			
			desc22 = ">>> "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." nadaje ("..getWeaponNameFromID(bron)..") dla "..getPlayerName(target):gsub("#%x%x%x%x%x%x","");
			triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
		else
			outputChatBox("* Wpisałeś(aś) złe id broni!",plr)
		end
	end
	end
end)

-- klatka by ajoneg (c) 2021 <ajonoficjalny@gmail>
local klatki = {}

function removeKratka(target,plr,value)
	for i,v in ipairs(getElementsByType("object")) do
		if getElementData(v,"owner") == getPlayerName(target) then
			destroyElement(v)
		end
	end
end

function createKratka(target,plr) -- crekrat
		local x,y,z=getElementPosition(target)
		local dim=getElementDimension(target)
		local int=getElementInterior(target)
		local object=createObject(971, x,y,z-0.9, 270, 0, 180)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		local object=createObject(971, x,y,z+6, 270, 0, 180)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		local object=createObject(971, x,y+3.5,z+2.5, 0, 0, 0)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		local object=createObject(971, x-4.5,y,z+2.5, 0, 0, 270)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		local object=createObject(971, x,y-3.5,z+2.5, 0, 0, 180)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		local object=createObject(971, x+4,y,z+2.5, 0, 0, 270)
		setElementData(object,"owner",getPlayerName(target))
		setElementData(object,"owner2",getPlayerName(plr))
		setElementDimension(object,dim)
		setElementInterior(object,int)
		-- dodajemy logi z klatek
    	local transfer_text=('[SET:KLATKA] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >>  '..x..', '..y..', '..z..'')	
		outputServerLog(transfer_text)
end

addCommandHandler("klatka", function(plr,cmd,cel)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			cel = getElementData(plr,"id") -- nie ma celu, celem jest gracz ktowy wpisze komende
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if not klatki[target] then
			klatki[target] = true;
			value = "niepokaz";
			removeKratka(target,plr,value)
			createKratka(target,plr)
		else
			value = "niepokaz";
			removeKratka(target,plr,value)
			createKratka(target,plr)
			klatki[target] = false;
		end
	end
end
end)

addCommandHandler("unklatka", function(plr,cmd,cel)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			cel = getElementData(plr,"id") -- nie ma celu, celem jest gracz ktowy wpisze komende
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		-- del
		value = "pokaz";
		removeKratka(target,plr,value)
		klatki[target] = false;
	end
end
end)

-- do poprawy
local blokadaduty = {}
local blokaROOT = false

addCommandHandler("root.blokadaduty", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
	if perm >= 10 then
		if not blokaROOT then
			blokaROOT = true
			outputChatBox("* Uruchomiono blokadę ROOT duty.", plr)	
		else
			blokaROOT = false
			outputChatBox("* Wyłączono blokadę ROOT duty.", plr)	
		end
	end
end)

--// SPRAWDZAMY PERMISJE ADMINA
addCommandHandler("duty", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	    setElementData(plr,"admin:zalogowano","false");	 
	    outputChatBox("* Wylogowano się z duty.", plr)	
--	    toggleControl (plr, "fire", false) 
--	    toggleControl (plr, "action", false)
--	    toggleControl (plr, "aim_weapon", false)
--	    toggleControl (plr, "vehicle_fire", false)
--	    toggleControl (plr, "vehicle_secondary_fire", false)
	    -- def
	    if getElementAlpha(plr) == 0 then 
			setElementAlpha(plr,255); 
			local rgb = getElementData(plr,"player:colorRGB")
			createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
		end
		
        local transfer_text=('[DUTY:LOGOUT] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> wylogowano sie z duty.')	
	    outputServerLog(transfer_text)
	
	    desc22 = "### "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."/"..getElementData(plr,"id").." wylogował się z DUTY.";
	    triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	
	else
	
	if blokaROOT then -- root.block
		outputChatBox("* Blokada logowania się na duty.", plr)	
		return 
	end
	
	if getElementData(plr,"admin:poziom") >= 7 then--------
	
		setElementData(plr,"admin:zalogowano","true");
		outputChatBox("* Zalogowano na duty.", plr)
		
    	local transfer_text=('[DUTY:LOG] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> zalogowano sie z duty.')	
		outputServerLog(transfer_text)
	
		desc22 = "### "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."/"..getElementData(plr,"id").." zalogował się na DUTY.";
		triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	else------------------------------------------------
	
	if blokadaduty[plr] and getTickCount() < blokadaduty[plr] then return end
    setTimer(delayedChat, 17000, 1, plr)
	outputChatBox("* Zostaniesz zalogowany za 17 sekund.", plr)
	blokadaduty[plr] = getTickCount()+17000;
	
	end------------------------------------------------
	
	
	end
end
end)

function delayedChat(plr)
	if isElement(plr) then
	if getElementData(plr,"admin:zalogowano") == "true" then return end
	setElementData(plr,"admin:zalogowano","true");
	outputChatBox("* Zalogowano na duty.", plr)
	
    local transfer_text=('[DUTY:LOG] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> zalogowano sie z duty.')	
	outputServerLog(transfer_text)
	
	desc22 = "### "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."/"..getElementData(plr,"id").." zalogował się na DUTY.";
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	end
end

-- cfng WALIZEK 
walizka_na_mapie = false -- domyslnie false, nie ma na mapie (nie tykac)
xType = 1 --domyslny mnoznik dla walizki (nie tykac)
-- WALIZKI START
addCommandHandler("walizka", function(plr,cmd,...)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
if walizka_na_mapie == false then
    if not ... then
	    outputChatBox("* Użycie: /walizka <podpowiedź>", plr)
        return
    end	
    local reason = table.concat({...}, " ")
		outputChatBox(""..getPlayerName(plr).." zgubił/a walizkę, podpowiedź: "..reason, root, 255,0,0)
	local x,y,z = getElementPosition(plr)
	local dim = getElementDimension(plr)
	local int = getElementInterior(plr)
	
	local pickups = createPickup(x, y, z, 3, 1210, 150);
	setElementDimension(pickups, dim)     
	setElementInterior(pickups, int)
    setElementData(plr,"player:walizka",true)
	setElementData(pickups,"walizka",true)
	
    local transfer_text=('[WALIZKA] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> dodano walizke na mape. (xyz: '..x..', '..y..', '..z..') text: '..reason)	
	outputServerLog(transfer_text)
	
	walizka_na_mapie = true
	setTimer (function() -- 5s blokady dla stawiajacego
		setElementData(plr,"player:walizka",false);
	end, 5000, 1)
else
	outputChatBox("* Maksymalnie jedna walizka na mape.", plr)
end
end
end)

addCommandHandler("root.walizka", function(plr,cmd,value, ...)
if getElementData(plr,"admin:poziom") >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
if walizka_na_mapie == false then
    if not value or not ... then
	    outputChatBox("* Użycie: /root.walizka <xType> <podpowiedź>", plr)
        return
    end	
	if tonumber(value) > 10 or tonumber(value) < 1 then
	    outputChatBox("* xType od 1 do 10.", plr)
        return
    end	
    local reason = table.concat({...}, " ")
		outputChatBox(""..getPlayerName(plr).." zgubił/a walizkę, podpowiedź: "..reason, root, 255,0,0)
	local x,y,z = getElementPosition(plr)
	local dim = getElementDimension(plr)
	local int = getElementInterior(plr)
	
	local pickups = createPickup(x, y, z, 3, 1210, 150);
	setElementDimension(pickups, dim)     
	setElementInterior(pickups, int)
    setElementData(plr,"player:walizka",true)
	setElementData(pickups,"walizka",true)
    xType = value
	
    local transfer_text=('[WALIZKA:ROOT] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> dodano walizke na mape. (xyz: '..x..', '..y..', '..z..') text: '..reason)	
	outputServerLog(transfer_text)
	
	walizka_na_mapie = true
	setTimer (function() -- 5s blokady dla stawiajacego
		setElementData(plr,"player:walizka",false);
	end, 5000, 1)
else
	outputChatBox("* Maksymalnie jedna walizka na mape.", plr)
end
end
end)

addEventHandler("onPickupHit", getRootElement(),function(gracz)
    if ( getElementType( gracz ) == "player" ) then
		if getElementData(gracz,"player:walizka") ~= true and getElementData(source,"walizka") == true then
			destroyElement(source)
			local vod = 25 -- minimalna ilość w walizce
			local vdo = 169 -- maksymalna ilość w walizce
			-- nie uwzględnia mnoznika xType
			local kasa = math.random(vod,vdo);
			kasa = kasa * xType;
			outputChatBox("Gracz "..getPlayerName(gracz).." odnalazł walizkę, a w niej "..kasa.."$!", root,255,0,0)
		    setElementData(gracz,"player:walizka",false);
			
			uid = getElementData(gracz,"player:dbid") or 0;
			kasa = kasa*100;
			if uid > 0 then
			givePlayerMoney(gracz, kasa);
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..kasa.." WHERE user_id = '"..uid.."'")

			kasa = kasa/100;
    		local transfer_text=('[WALIZKA:ZEBRANA] '..getPlayerName(gracz)..'/'..getElementData(gracz,"player:dbid")..' >> zebrano walizke ['..kasa..' $].')	
			outputServerLog(transfer_text)
	
			walizka_na_mapie = false
			xType = 1

		    end
		end
    end
end)
-- WALIZKI |END|

-- suszarka
addCommandHandler("suszarka", function(player,cmd)
if getElementData(player,"admin:poziom") >= 5 and getElementData(player,"admin:zalogowano") == "true" then
	giveWeapon (player, 22, 999999, true);
end
end)

-- bronie i cfg :)
addEventHandler('onPlayerWeaponSwitch', getRootElement(),function(previousWeaponID,currentWeaponID)
local admlvl = getElementData(source,"admin:poziom") or 0;
local dmstrefa = getElementData(source,"player:dmSTREFA") or false;
if not dmstrefa then -- kiedy nie ma dm
	if currentWeaponID==22 then
		setWeaponProperty(22, "pro", "weapon_range", 220);
		setWeaponProperty(22, "pro", "flags", 0x001000);
		setWeaponProperty(22, "pro", "damage", 0);
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', false)
		toggleControl(source, "action", false)
	elseif currentWeaponID==41 then --spray
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', true)
		setWeaponProperty(41, "pro", "damage", 0);
	elseif currentWeaponID==42 and ( admlvl >= 6 ) then --gasnica
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', true)
		setWeaponProperty(42, "pro", "damage", 0);
	elseif currentWeaponID==43 then --spray
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', false)
		setWeaponProperty(43, "pro", "damage", 0);
	else
		toggleControl(source, 'fire', false)
		toggleControl(source, "aim_weapon", false)
		toggleControl(source, "action", false)
	end
else
	if currentWeaponID==22 then
		setWeaponProperty(22, "pro", "weapon_range", 220);
		setWeaponProperty(22, "pro", "flags", 0x001000);
		setWeaponProperty(22, "pro", "damage", 0);
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', false)
		toggleControl(source, "action", false)
	else
		toggleControl(source, "aim_weapon", true)
		toggleControl(source, 'fire', true)
		toggleControl(source, "action", true)
	end
end
end)


--test
addCommandHandler("jp", function(plr,cmd)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	if getElementData(plr,"admin:specon") == 1 then
	outputChatBox ("* Wyjdź ze speca, aby włączyć JetPack'a.",plr)
	return end
		if isPedInVehicle(plr) then
			removePedFromVehicle(plr)
		end
		if doesPedHaveJetPack(plr) then
			removePedJetPack(plr)
		else
			givePedJetPack(plr)
		end
	end
	end
end)

--test wyswietl ost kiero
addCommandHandler("ok", function(plr,cmd,cel)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("Użycie: /ok <ID pojazdu>", plr)
			return
		end
--    local sp1_s=dbQuery(db, "SELECT * FROM server_vehicle_driver WHERE driver_carid='"..cel.."' ORDER BY driver_id DESC")
--    local sp1=dbPoll(sp1_s,-1)
    -- wyb = wybierz // upd = update, wstaw -- warunki
	local sp1 = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicle_driver WHERE driver_carid='"..cel.."' ORDER BY driver_id DESC");

	if #sp1 > 5 then outputChatBox("["..sp1[6].driver_czas.."] - "..sp1[6].driver_nickname.."", plr) end
	if #sp1 > 4 then outputChatBox("["..sp1[5].driver_czas.."] - "..sp1[5].driver_nickname.."", plr) end
	if #sp1 > 3 then outputChatBox("["..sp1[4].driver_czas.."] - "..sp1[4].driver_nickname.."", plr) end
	if #sp1 > 2 then outputChatBox("["..sp1[3].driver_czas.."] - "..sp1[3].driver_nickname.."", plr) end
	if #sp1 > 1 then outputChatBox("["..sp1[2].driver_czas.."] - "..sp1[2].driver_nickname.."", plr) end
	if #sp1 > 0 then outputChatBox("["..sp1[1].driver_czas.."] - "..sp1[1].driver_nickname.."", plr) end
	
	end
	end
end)

--//kolorowanie auta
addCommandHandler("kolor", function(plr,cmd,value,value2,value3,svalue,svalue2,svalue3)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
if getElementData(plr,"admin:zalogowano") == "true" then
		if not tonumber(value) or not tonumber(value2) or not tonumber(value3) then
			outputChatBox("* Użycie: /kolor <r g b>", plr)
			return
		end
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znaleziono pojazdu.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(plr)
		if not tonumber(svalue) then svalue = 255; end
		if not tonumber(svalue2) then svalue2 = 255; end
		if not tonumber(svalue3) then svalue3 = 255; end
		setVehicleColor(veh,value,value2,value3,svalue,svalue2,svalue3)
		outputChatBox("* Twojemu pojazdowi zmieniono kolor.", plr)
		
		local id_veh = getElementData(veh,"vehicle:id");
		local ovner_veh = getElementData(veh,"vehicle:owner");
--		if id_veh < 1000000 then
    local transfer_text=('[ADM:MALOWANIE] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> malowanie auta (ID: '..id_veh..'): Owner: '..ovner_veh..'.')	
	outputServerLog(transfer_text)
	
	local desc22 = 'MALOWANIE '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> malowanie auta (ID: '..id_veh..'): Owner: '..ovner_veh..'.'
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	
--	    end
	end
	end

end)

--kick
addCommandHandler("k", function(plr,cmd,cel,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("* Użycie: /k <nick/ID> <powód>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wykopany/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.."")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wykopany/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.."")
		
		
    local transfer_text=('[KARY:KICK] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> kick  '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"player:dbid")..' ('..reason..')')	
	outputServerLog(transfer_text)
	
	--desc22 = 'KICK: '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' wykopał  '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"player:dbid")..' powód: '..reason..'';
	--triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	kickPlayer(target, plr, reason)
	
	end
	end
end)


--test ban
addCommandHandler("b", function(plr,cmd,cel,x,mutetype,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 7 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(x) or not mutetype or not reason then
			outputChatBox("Użycie: /b <nick/ID> <ilość> <m/h/d> <powód>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
		x = math.floor(x);
		if tonumber(x) > 0 then
		if mutetype=="m" or mutetype=="h" or mutetype=="d" then
		if mutetype=="m" and tonumber(x) < 361 then
        -- wyb = wybierz // upd = update, wstaw -- warunki
	    local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
	    local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
		end
		                                -- 999 MAX BAN --
 		if mutetype=="d" and tonumber(x) < 1000 then
	    local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 1000) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a zbanowany/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." zostal/a zbanowany/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powod: "..reason.." ("..x.." "..mutetype..")")
		kickPlayer(target, plr, "Połącz się ponownie.")
			

		end
		end
		
		
		end
	end
	end
end)

--test odwieś zakazlatania licka
addCommandHandler("odwieslatanie", function(plr,cmd,cel,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("Użycie: /odwieslatanie <nick/ID> <powód odwieszenia>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
    -- wyb = wybierz // upd = update, wstaw -- warunki
	local wynikglowny_blokady = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='4' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC");
--    local wynik_blokady=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='4' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC")
--   local wynikglowny_blokady=dbPoll(wynik_blokady,-1)
	if #wynikglowny_blokady > 0 then	
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
	    local query = exports["aj-dbcon"]:upd("UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
--		dbExec(db, "UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
		
		outputChatBox("* Pomyślnie usunięto zakaz latania, graczowi "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
		removeElementData(target,"zakazy:latanie")
	else
	    outputChatBox("* Podany gracz nie ma aktywnej kary lub jest nadana przez innego administratora.", plr,255,0,0)
	end
	end
	end
end)

--test zakazlatania
addCommandHandler("zakazlatania", function(plr,cmd,cel,x,mutetype,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(x) or not mutetype or not reason then
			outputChatBox("Użycie: /zakazlatania <nick/ID> <ilość> <m/h/d> <powód>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
		x = math.floor(x);
		if tonumber(x) > 0 then
		if mutetype=="m" or mutetype=="h" or mutetype=="d" then
		if mutetype=="m" and tonumber(x) < 361 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a cofnięcie licencji lotniczej od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a cofnięcie licencji lotniczej od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		
        local wynikglowny_adm = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' ORDER BY zakaz_id DESC");
		
--        local wynik_adm=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' ORDER BY zakaz_id DESC")
--        local wynikglowny_adm=dbPoll(wynik_adm,-1)
		setElementData(target,"zakazy:latanie", wynikglowny_adm[1].zakaz_czas)
		
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Otrzymałeś/aś zakaz latania przez: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Powód: "..reason:gsub("#%x%x%x%x%x%x","")..", na: "..x.." "..mutetype.."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Jeżeli uważasz, że kara jest niesłuszna, napisz apelacje.", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		
        -- LISTA AUT NA KAT L+H
		KatLH = { [592]=true,[577]=true,[511]=true,[512]=true,[593]=true,[520]=true,[553]=true,[476]=true,[519]=true,[460]=true,[513]=true,[548]=true,[425]=true,[417]=true,[487]=true,[488]=true,[497]=true,[563]=true,[447]=true,[447]=true,[469]=true,}

		local veh=getPedOccupiedVehicle(target)
		local miejsce=getPedOccupiedVehicleSeat(target)
		
		if veh and miejsce==0 then
		if KatLH[getElementModel(veh)] == true then
			removePedFromVehicle(target)
			return
		end
		return end
		
		end
		end
		
		
		end
	end
	end
end)

--test odwieś zakazpjb
addCommandHandler("odwiespjb", function(plr,cmd,cel,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("Użycie: /odwiespjb <nick/ID> <powód odwieszenia>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
--    local wynik_blokady=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='2' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC")
--    local wynikglowny_blokady=dbPoll(wynik_blokady,-1)
	
    local wynikglowny_blokady = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='2' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC");
	if #wynikglowny_blokady > 0 then	
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
        local query = exports["aj-dbcon"]:upd("UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='2' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
--		dbExec(db, "UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='2' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
		
		outputChatBox("* Pomyślnie usunięto blokadę prawa jazdy (A,B,C), graczowi "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
		removeElementData(target,"zakazy:prawko")
	else
	    outputChatBox("* Podany gracz nie ma aktywnej kary lub jest nadana przez innego administratora.", plr,255,0,0)
	end
	end
	end
end)

--test zakazpjb
addCommandHandler("zakazpjb", function(plr,cmd,cel,x,mutetype,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(x) or not mutetype or not reason then
			outputChatBox("Użycie: /zakazpjb <nick/ID> <ilość> <m/h/d> <powód>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
		x = math.floor(x);
		if tonumber(x) > 0 then
		if mutetype=="m" or mutetype=="h" or mutetype=="d" then
		if mutetype=="m" and tonumber(x) < 361 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a zakaz prowadzenia pojazdów (A,B,C) od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a zakaz prowadzenia pojazdów (A,B,C) od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		
		
 --       local wynik_adm=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='2' ORDER BY zakaz_id DESC")
 --       local wynikglowny_adm=dbPoll(wynik_adm,-1)
		local wynikglowny_adm = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='2' ORDER BY zakaz_id DESC");
		
		setElementData(target,"zakazy:prawko", wynikglowny_adm[1].zakaz_czas)
		
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Otrzymałeś/aś zakaz prowadzenia na kat.: A,B,C przez: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Powód: "..reason:gsub("#%x%x%x%x%x%x","")..", na: "..x.." "..mutetype.."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Jeżeli uważasz, że kara jest niesłuszna, napisz apelacje.", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		
-- LISTA AUT NA KAT A+B+C
KatABC = { [602]=true,[496]=true,[401]=true,[518]=true,[527]=true,[589]=true,[419]=true,[587]=true,[533]=true,[526]=true,[474]=true,[545]=true,[517]=true,[410]=true,[600]=true,[436]=true,[439]=true,[549]=true,[491]=true,[445]=true,[604]=true,[507]=true,[585]=true,[466]=true,[492]=true,[546]=true,[551]=true,[516]=true,[467]=true,[426]=true,[547]=true,[405]=true,[580]=true,[409]=true,[550]=true,[566]=true,[540]=true,[421]=true,[529]=true,[416]=true,[490]=true,[470]=true,[596]=true,[598]=true,[599]=true,[597]=true,[531]=true,[459]=true,[422]=true,[482]=true,[605]=true,[572]=true,[530]=true,[418]=true,[482]=true,[413]=true,[440]=true,[543]=true,[583]=true,[478]=true,[554]=true,[579]=true,[400]=true,[404]=true,[489]=true,[505]=true,[479]=true,[442]=true,[458]=true,[536]=true,[575]=true,[534]=true,[567]=true,[535]=true,[576]=true,[412]=true,[402]=true,[542]=true,[603]=true,[475]=true,[429]=true,[541]=true,[415]=true,[480]=true,[562]=true,[565]=true,[434]=true,[494]=true,[502]=true,[503]=true,[411]=true,[559]=true,[561]=true,[560]=true,[506]=true,[451]=true,[558]=true,[555]=true,[477]=true,[568]=true,[424]=true,[504]=true,[457]=true,[483]=true,[508]=true,[571]=true,[500]=true,[444]=true,[556]=true,[557]=true,[471]=true,[495]=true,[539]=true,[485]=true,[438]=true,[420]=true,[525]=true,[552]=true,[574]=true,[581]=true,[462]=true,[521]=true,[463]=true,[463]=true,[522]=true,[461]=true,[448]=true,[468]=true,[586]=true,[523]=true,[433]=true,[427]=true,[428]=true,[407]=true,[544]=true,[601]=true,[428]=true,[499]=true,[609]=true,[498]=true,[524]=true,[578]=true,[486]=true,[573]=true,[455]=true,[588]=true,[403]=true,[423]=true,[414]=true,[443]=true,[515]=true,[514]=true,[456]=true,[431]=true,[437]=true,[408]=true,[432]=true,[532]=true,[406]=true,}

		local veh=getPedOccupiedVehicle(target)
		local miejsce=getPedOccupiedVehicleSeat(target)
		
		if veh and miejsce==0 then
		if KatABC[getElementModel(veh)] == true then
			removePedFromVehicle(target)
			return
		end
		return end
		
		end
		end
		
		
		end
	end
	end
end)


--test odwieś mute /ocisz
addCommandHandler("odcisz", function(plr,cmd,cel,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 6 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not reason then
			outputChatBox("Użycie: /odcisz <nick/ID> <powód odwieszenia>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
--    local wynik_blokady=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='1' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC")
--    local wynikglowny_blokady=dbPoll(wynik_blokady,-1)
    local wynikglowny_blokady = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='1' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC");
	
	if #wynikglowny_blokady > 0 then	
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
		local query = exports["aj-dbcon"]:upd("UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='1' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
		
		outputChatBox("* Pomyślnie usunięto karę wyciszenia, graczowi "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
		removeElementData(target,"zakazy:mute")
	else
	    outputChatBox("* Podany gracz nie ma aktywnej kary lub jest nadana przez innego administratora.", plr,255,0,0)
	end
	end
	end
end)

--test mute
addCommandHandler("wycisz", function(plr,cmd,cel,x,mutetype,...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 6 then
if getElementData(plr,"admin:zalogowano") == "true" then
		local reason=table.concat({...}, " ")
		if not cel or not tonumber(x) or not mutetype or not reason then
			outputChatBox("Użycie: /wycisz <nick/ID> <ilość> <m/h/d> <powód>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 255, 255)
			return
		end
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
		x = math.floor(x);
		if tonumber(x) > 0 then
		if mutetype=="m" or mutetype=="h" or mutetype=="d" then
		if mutetype=="m" and tonumber(x) < 361 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
--		dbExec(db, "INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wyciszony/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", na "..x..""..mutetype.." - powód: "..reason.."")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wyciszony/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", na "..x..""..mutetype.." - powód: "..reason.."")
		
--        local wynik_adm=dbQuery(db, "SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='1' ORDER BY zakaz_id DESC")
--        local wynikglowny_adm=dbPoll(wynik_adm,-1)
		local wynikglowny_adm = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='1' ORDER BY zakaz_id DESC");
		setElementData(target,"zakazy:mute", wynikglowny_adm[1].zakaz_czas)
		
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Zostałeś/aś wyciszony/a przez: "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Powód: "..reason:gsub("#%x%x%x%x%x%x","")..", na: "..x.." "..mutetype.."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Jeżeli uważasz, że kara jest niesłuszna, napisz apelacje.", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		
		end
		
		end
		end
	end
	end
end)

--// warny
addCommandHandler("warn", function(plr,cmd,cel, ...)
local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
if perm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
        if not cel then return end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
        if (not target) then
            outputChatBox("* Nie znaleziono podanego gracza.", plr)
            return
        end
        local tresc = table.concat(arg, " ")
        if (string.len(tresc)<=1) then
            outputChatBox("* Wpisz treść ostrzeżenia!", plr)
            return
        end
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Otrzymałeś/aś ostrzeżenie od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Powód: "..tresc:gsub("#%x%x%x%x%x%x","").."", target, 255, 255, 255)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox("Nie stosowanie się do ostrzeżeń, może skutkować wyrzuceniem z serwera lub banem!", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
		outputChatBox(" ", target, 255, 0, 0)
        triggerClientEvent("onPlayerWarningReceived", target, tresc)
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a ostrzeżenie od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..tresc.."")
		
    local transfer_text=('[KARY:WARN] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> warn >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"player:dbid")..' ('..tresc..')')	
	outputServerLog(transfer_text)
		
	outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a ostrzeżenie od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..tresc.."")
	--[[	
	for i,v in ipairs(getElementsByType("player")) do
	if getElementData(v,"admin:zalogowano") == "true" then
		outputChatBox(""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." usunął/ęła raport na: "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."/"..getElementData(target,"id")..": warn", v, 255, 0, 0)
		triggerEvent("admin:removeReport", resourceRoot, getElementData(target,"id"))
	end
	end
	]]--
	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") == "true" then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == getElementData(target,"id") then
				--outputChatBox(""..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." usunął/ęła raport na "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."/"..getElementData(target,"id")..": warn", v, 255, 0, 0)
				triggerEvent("admin:removeReport", resourceRoot, getElementData(target,"id"))
				triggerEvent("admin:addNotice", root, "warn",plr,getElementData(target,"id"))
			    end
		    end
			end
		end
	end
	
		
    end
	end
end)

-- DM OFF / ON
--[[ // juz nie jest potrzebny
addCommandHandler("dmon", function(plr,cmd)
if getElementData(plr,"admin:poziom") >= 7 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	
	if getElementData(plr,"admin:dm") == "true" then
	    setElementData(plr,"admin:dm","false");	 
	    outputChatBox("* Wyłączono tryb DM!", plr)	
	toggleControl (plr, "fire", false) 
	toggleControl (plr, "action", false)
	toggleControl (plr, "aim_weapon", false)
--	toggleControl (plr, "vehicle_fire", false)
--	toggleControl (plr, "vehicle_secondary_fire", false)
	
    local transfer_text=('[ADM:DMON] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> Tryb DM wylaczony')	
	outputServerLog(transfer_text)
	
	else
	    setElementData(plr,"admin:dm","true");	 
	    outputChatBox("* Odpalono tryb DM!", plr)		
	toggleControl (plr, "fire", true) 
	toggleControl (plr, "action", true)
	toggleControl (plr, "aim_weapon", true)
--	toggleControl (plr, "vehicle_fire", true)
--	toggleControl (plr, "vehicle_secondary_fire", true)
	
    local transfer_text=('[ADM:DMON] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> Tryb DM odpalony')	
	outputServerLog(transfer_text)
	
	end
	
	end
end
end)
]]


addCommandHandler("inv", function(plr)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		local miejsce=getPedOccupiedVehicleSeat(plr)
		if veh and miejsce==0 then
			setElementAlpha(plr,255)
			outputChatBox("* Nie możesz prowadzić pojazdu na INV!",plr,255,0,0)
		return end
		if getElementData(plr,"admin:specon") == 1 then
		outputChatBox ("* Wyjdź ze speca, aby wyłączyć INV'a!",plr)
		return end

		if getElementAlpha(plr) > 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo(plr)
			
    local transfer_text=('[ADM:INV] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> Tryb INV wlaczony.')	
	outputServerLog(transfer_text)

		else
			setElementAlpha(plr,255)
			local rgb = getElementData(plr,"player:colorRGB")
			createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
				
    local transfer_text=('[ADM:INV] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> Tryb INV wylaczony.')	
	outputServerLog(transfer_text)
	
		end
		
    end
end)


addCommandHandler("paliwo", function(plr,cmd)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe", plr)
			return
		end
		setElementData(veh, "vehicle:paliwo", 5)
		outputChatBox("* Stacje są już dostępne!",plr)
end
end)

--// KOMENDY RESPI AUTO Z BAZY (nasze)
addCommandHandler("vehdp", function(plr,cmd,carid)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
    if not carid then
	    outputChatBox("* Użycie: /vehdp <ID pojazdu>", plr)
	    return
	end
	local vehicles = getElementsByType('vehicle')
	for _, veh in pairs(vehicles) do
    local kierowca = getVehicleOccupant(veh) 
    if kierowca == false then 
	    local veh_id = getElementData(veh,"vehicle:id") or 0;
		if tonumber(veh_id) > 0 then
			if tonumber(veh_id) == tonumber(carid) then
			    outputChatBox("* Pomyślnie przeniesiono pojazd na parking.", plr)
				exports["aj-vehs"]:zapiszPojazd(veh)
				return
			end
		end
	else
	    local veh_id = getElementData(veh,"vehicle:id") or 0;
		if tonumber(veh_id) > 0 then
			if tonumber(veh_id) == tonumber(carid) then
			    outputChatBox("* Podany pojazd jest używany!", plr)
				return
			end
		end
	end
	end
end
end)

addCommandHandler("vopis", function(plr,cmd, ...)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
    local veh=getPedOccupiedVehicle(plr) or false
	if not veh then
		outputChatBox("* Nie znajdujesz się w pojeździe", plr)
		return
	end
	local vopisveh = getElementData(veh,"vehicle:vopis") or false
	if vopisveh then removeElementData(veh,"vehicle:vopis") return end
    local vopis=table.concat({...}, " ")
    if (string.len(vopis)<=1) then
        outputChatBox("* Wpisz conajmniej 2 znaki!", plr)
        return
    end
    setElementData(veh,"vehicle:vopis",vopis)
end
end)

addCommandHandler("wyjmij", function(plr,cmd,carid)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
    if tonumber(carid) then
--			outputChatBox("* Pomyślnie przeniesiono pojazd na parking.", plr)
            local value = "admwyjmij"
			local carid = tonumber(carid)
	        exports["aj-vehs"]:respPojazd(plr,carid,value)
	else outputChatBox("* Podaj ID Twojego pojazdu!",plr) end
end
end)

addCommandHandler("pinfo", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Użycie: /pinfo <nick/ID>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local result = exports['aj-dbcon']:wyb("SELECT * FROM server_users WHERE user_id = '"..getElementData(target,"player:dbid").."'")
outputChatBox("------------------------------[INFO]------------------------------", plr, 255, 0, 0)
     outputChatBox("ID konta: #939393"..getElementData(target,"player:dbid"), plr, 255, 255, 255, true)
	 outputChatBox("Nick: #939393"..getPlayerName(target):gsub("#%x%x%x%x%x%x",""), plr, 255, 255, 255, true)
     outputChatBox("Skin ID: #939393"..getPlayerSkin(target), plr, 255, 255, 255, true)
	 
	 local mins = getElementData(target,"player:online") or 0
	 local hours = getElementData(target,"player:onlineHours") or 0
	 outputChatBox("W sesji: #939393"..hours.." h "..mins.." m", plr, 255, 255, 255, true)
	 
	 local godziny = string.format("%.2f", result[1].user_minuty/60)
	 local godziny = math.floor(godziny)
	 outputChatBox("W grze: #939393"..godziny.." godzin ("..result[1].user_minuty.." m)", plr, 255, 255, 255, true)
	 
	 local sluzba = getElementData(target,"player:frakcja") or false;
	 if sluzba then
	 local minuty = getElementData(target,"player:frakcjaTIME") or 0;
	 local code = getElementData(target,"player:frakcjaCODE") or "blad";
	 local frakcjacol = getElementData(target, "player:jobCOLORfr") or "";
	 outputChatBox("Służba: #939393"..minuty.." min. ("..frakcjacol..""..code.."#939393).", plr, 255, 255, 255, true)
	 end
	 
	 if result[1].user_katA == 1 then descA="A, "; else descA=""; end
	 if result[1].user_katB == 1 then descB="B, "; else descB=""; end
	 if result[1].user_katC == 1 then descC="C, "; else descC=""; end
	 if result[1].user_katL == 1 then descL="L, "; else descL=""; end
	 if result[1].user_katH == 1 then descH="H"; else descH=""; end
	 
	 outputChatBox("Licencje: #939393"..descA..descB..descC..descL..descH, plr, 255, 255, 255, true)
	 if getElementData(plr,"admin:poziom") >= 7 then
	 local summaj = result[1].user_money + result[1].user_bankmoney;
	 local summaj = string.format("%.2f", summaj/100)
	 outputChatBox("Majątek: #939393"..summaj.."$", plr, 255, 255, 255, true)
	 end
     local sprlog = getElementData(target,"admin:zalogowano") or "false";
	 if sprlog == "true" then dutyreturn = "Zalogowany/a"; else dutyreturn = "Wylogowany/a"; end
	 poziomrangi = getElementData(target,"admin:poziom") or 0;
	 if poziomrangi == 10 then ranganame = "#330000RCON"; end
	 if poziomrangi == 7 then ranganame = "#cf0000Administrator"; end
	 if poziomrangi == 6 then ranganame = "#1f6e04Moderator"; end
	 if poziomrangi == 5 then ranganame = "#3095bdSupport"; end
	 if poziomrangi == 0 then ranganame = "#ffffffGracz"; end	 
	 outputChatBox("Ranga: "..ranganame.." #939393("..dutyreturn..")", plr, 255,255,255, true)
	 outputChatBox("Serial: #939393"..getPlayerSerial(target), plr, 255, 255, 255, true)
	 outputChatBox("Zarejestrowano: #939393"..result[1].user_regdata, plr, 255, 255, 255, true)
outputChatBox("--------------------------------------------------------------------", plr, 255, 0, 0) 
end
end)

addCommandHandler("wyloguj", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Użycie: /wyloguj <nick/ID>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if getElementData(target,"admin:poziom") >= getElementData(plr,"admin:poziom") then
            outputChatBox("* Nie możesz wylogować z duty podanego gracza.", plr, 255, 0, 0)
			return 
		end
		duty_sprlogged = getElementData(target,"admin:zalogowano") or "false";
		if duty_sprlogged == "true" then
		outputChatBox("* Wylogowano gracza o nicku "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".", plr)
		outputChatBox("* Zostałeś wylogowany z duty przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..".", target)
        setElementData(target,"admin:zalogowano","false");
		setElementData(target,"admin:dm","false");	
		toggleControl (target, "fire", false) 
		toggleControl (target, "action", false)
		toggleControl (target, "aim_weapon", false)
		toggleControl (target, "vehicle_fire", false)
		toggleControl (target, "vehicle_secondary_fire", false)
		
		if getElementAlpha(target) ~= 255 then
        	setElementAlpha(target,255); 
			local rgb = getElementData(target,"player:colorRGB")
			createBlipAttachedTo ( target, 0, 2, rgb[1], rgb[2], rgb[3] ); 
		end
		
    local transfer_text=('[ADM:WYLOGUJ] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> Wylogowal >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	
	desc22 = 'WYLOGUJ: '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' wylogował '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.';
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
		
		else
		outputChatBox("* Nie udało się wylogować, ponieważ "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." nie jest na duty.", plr)
		end
end
end)

addCommandHandler("th", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Użycie: /th <nick/ID>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if isPedInVehicle(target) then
			removePedFromVehicle(target)
		end
		local x,y,z=getElementPosition(plr)
		setElementInterior(target,getElementInterior(plr))
		setElementDimension(target,getElementDimension(plr))
		setElementPosition(target,x,y,z+1)
	
    local transfer_text=('[ADM:TH] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /th >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	
end
end)

addCommandHandler("tt", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Użycie: /tt <nick/ID>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if target == plr then return end
		if isPedInVehicle(plr) then
			removePedFromVehicle(plr)
		end
		local veh=getPedOccupiedVehicle(target);
	
	if veh then
	maxpass = getVehicleMaxPassengers(veh);
	nowpass = getVehicleOccupants(veh);
	
	if maxpass == 0 then 
		    local x,y,z=getElementPosition(target)
		    setElementInterior(plr,getElementInterior(target))
		    setElementDimension(plr,getElementDimension(target))
		    setElementPosition(plr,x+math.random(1,1),y+math.random(1,1),z+2)
			if getElementAlpha(plr) ~= 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo ( plr )
			end
	
    local transfer_text=('[ADM:TT] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /tt >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == getElementData(target,"id") then
				triggerEvent("admin:removeReport", resourceRoot, getElementData(target,"id"))
				triggerEvent("admin:addNotice", root, "tt",plr,getElementData(target,"id"))
			    end
		    end
			end
		end
	end
	
	return end

		local counter = 0
		for seat, target in pairs(getVehicleOccupants(veh)) do
    		counter = counter + 1
			if seat == counter then
		        local x,y,z=getElementPosition(target)
		        setElementInterior(plr,getElementInterior(target))
		        setElementDimension(plr,getElementDimension(target))
		        setElementPosition(plr,x+math.random(1,1),y+math.random(1,1),z+2)
			if getElementAlpha(plr) ~= 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo ( plr )
			end
			
			end
			
		end
		
		function findEmptyCarSeat(veh)
    		local max = getVehicleMaxPassengers(veh)
    		local pas = getVehicleOccupants(veh)
    		for i=1, max do
        		if not pas[i] then
            		return i
       		 end
    		end
    		return false
		end
		
		local seat = findEmptyCarSeat(veh)
		if seat then
			setElementInterior(plr,getElementInterior(target))
			setElementDimension(plr,getElementDimension(target))
    		warpPedIntoVehicle(plr,veh,seat)
			if getElementAlpha(plr) ~= 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo ( plr )
			end
			
		end

	else
		local x,y,z=getElementPosition(target)
		setElementInterior(plr,getElementInterior(target))
		setElementDimension(plr,getElementDimension(target))
		setElementPosition(plr,x+math.random(1,1),y+math.random(1,1),z)
			if getElementAlpha(plr) ~= 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo ( plr )
			end
			
	end

    local transfer_text=('[ADM:TT] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /tt >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == getElementData(target,"id") then
				triggerEvent("admin:removeReport", resourceRoot, getElementData(target,"id"))
				triggerEvent("admin:addNotice", root, "tt",plr,getElementData(target,"id"))
			    end
		    end
			end
		end
	end
	
end
end)

addCommandHandler("thv", function(plr,cmd,vid)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not vid or not tonumber(vid) then return end
		vid=tonumber(vid)
		for i,v in ipairs(getElementsByType("vehicle")) do
			local dbid=getElementData(v,"vehicle:id")
			if dbid and tonumber(dbid) == vid then
			local salon = getElementData(v,"vehicle:salon") or false;
			if salon==false then
	    		local x,y,z=getElementPosition(plr)
			    local rx,ry,rz = getElementRotation(plr)
				
				if getElementAlpha(plr) ~= 255 then
					setElementAlpha(plr,255)
					local rgb = getElementData(plr,"player:colorRGB")
					createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
				end
				
	    		setElementPosition(v,x,y,z+0.1)
				setElementRotation(v,rx,ry,rz)
	    		setElementInterior(v, getElementInterior(plr))
	    		setElementDimension(v, getElementDimension(plr))
				if isElementFrozen(v) == true then
				    setElementFrozen(v, false)
				end
				warpPedIntoVehicle(plr,v)
				
				local occp = getVehicleOccupants(v) or false;
				if occp then
					for i, player in pairs(getVehicleOccupants(v)) do
	    			setElementInterior(player, getElementInterior(plr))
	    			setElementDimension(player, getElementDimension(plr))
					end
				end
				

                local transfer_text=('[ADM:THV] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /thv >> car id: '..dbid..'.')	
	            outputServerLog(transfer_text)
			end
		end
	end
end
end)


addCommandHandler("ttv", function(plr,cmd,vid)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not vid or not tonumber(vid) then return end
		vid=tonumber(vid)
		for i,v in ipairs(getElementsByType("vehicle")) do
			local dbid=getElementData(v,"vehicle:id")
			if dbid and tonumber(dbid) == vid then
	    		local x,y,z=getElementPosition(v)
	    		setElementPosition(plr,x,y,z+2)
	    		setElementInterior(plr, getElementInterior(v))
	    		setElementDimension(plr, getElementDimension(v))
				--warpPedIntoVehicle(plr,v)
				-- wsadz do auta gosci, // 
				
				if getElementAlpha(plr) ~= 255 then
					setElementAlpha(plr,255)
					local rgb = getElementData(plr,"player:colorRGB")
					createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
				end
				
    local transfer_text=('[ADM:TTV] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /ttv >> car id: '..dbid..'.')	
	outputServerLog(transfer_text)
	    	end
		end
-- potem dodac info ze nie ma na mapie lub jest w dp :-)

end
end)

addCommandHandler("heal", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Zostałeś/aś uleczony/a.", plr)
			setElementHealth(plr, 100)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if target == plr then return end
		setElementHealth(target, 100)
		outputChatBox("* Uleczyłeś/aś gracza " ..getPlayerName(target):gsub("#%x%x%x%x%x%x",""), plr)
end
end)

addCommandHandler("spec", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("Uzyj: /spec <id/nick>", plr,255,255,255,true)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("Nie znaleziono podanego gracza.", plr, 255, 0, 0,true)
			return
		end
		if target == plr then return end
		if doesPedHaveJetPack(plr) then
			removePedJetPack(plr)
		end
		local x,y,z=getElementPosition(plr)
		removePedFromVehicle(plr)
		setElementFrozen(plr,true)
		setCameraTarget(plr, target)
		
		local x2,y2,z2 = getElementPosition(target)
		
		if getElementAlpha(plr) > 0 then
			setElementAlpha(plr,0)
			destroyBlipsAttachedTo(plr)
		end
		
		local spec = getElementData(plr,"spec:pos")
		if not spec then
		setElementData(plr,"spec:pos",{x,y,z})
		setElementData(plr,"spec:dim", getElementDimension(plr))
		setElementData(plr,"spec:int", getElementInterior(plr))
		end
		
		setElementInterior(plr, getElementInterior(target))
		setElementDimension(plr, getElementDimension(target))
		
		attachElements (plr, target, 0,0,z2+5)
		setElementPosition(plr,x,y,z-10)
		toggleControl(plr, "next_weapon", false)
		toggleControl(plr, "previous_weapon", false)

	
    local transfer_text=('[ADM:SPEC] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /spec >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	setElementData(plr,"admin:specon",1)
	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == getElementData(target,"id") then
				triggerEvent("admin:removeReport", resourceRoot, getElementData(target,"id"))
				triggerEvent("admin:addNotice", root, "spec",plr,getElementData(target,"id"))
			    end
		    end
			end
		end
	end
	
end
end)


addCommandHandler("specoff", function(plr,cmd)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		local spec = getElementData(plr,"spec:pos")
		if not spec then return end
		local spec_dim = getElementData(plr,"spec:dim") or 0
		local spec_int = getElementData(plr,"spec:int") or 0
		
		if getElementAlpha(plr) ~= 255 then
			setElementAlpha(plr,255)
			local rgb = getElementData(plr,"player:colorRGB")
			createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
		end
		
        detachElements(plr, source)
		setElementPosition(plr, spec[1], spec[2], spec[3])
		setCameraTarget(plr, plr)
		setElementFrozen(plr, false)
		setElementInterior(plr, spec_int)
		setElementDimension(plr, spec_dim)
		removeElementData(plr,"spec:pos")
		removeElementData(plr,"spec:dim")
		removeElementData(plr,"spec:int")
        removeElementData(plr,"admin:specon")
		toggleControl(plr, "next_weapon", true)
		toggleControl(plr, "previous_weapon", true)
    local transfer_text=('[ADM:SPECOFF] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /specoff .')	
	outputServerLog(transfer_text)
end
end)

addCommandHandler("skin", function(plr,cmd,cel,id)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
		local id = tonumber(id)
		if not cel or not id then
			outputChatBox("* Użycie: /skin <nick/ID> <id skinu> ", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		if id < 0 or id > 311 then outputChatBox("* Użycie: /skin <nick/ID> <id skinu>", plr) return end
		if ( id == 10 or id == 16 ) and getElementData(plr,"admin:poziom") == 7 then outputChatBox("* Skin został zablokowany z powodu buga!",plr) return end
		setElementModel(target,id)
		--local query = exports['pystories-db']:dbSet("UPDATE pystories_users SET skin=? WHERE id=?",id,getElementData(target,"player:sid"))
		player_dbid = getElementData(target,"player:dbid");
		setElementData(plr,"player:skinid", id)
--		dbExec(db, "UPDATE server_users SET user_skin='"..id.."' WHERE user_id='"..player_dbid.."'");
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_skin='"..id.."' WHERE user_id='"..player_dbid.."'");
		
		outputChatBox("* Zmieniono skin graczu "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").." na id "..id,plr)
	
    local transfer_text=('[ADM:SKINCHANGE] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /skin >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..'.')	
	outputServerLog(transfer_text)
	
end
end)

--[[
addCommandHandler("fix", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 6 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe!", plr)
			return
		end
		outputChatBox("* Naprawiłeś/aś pojazd!",plr)
		setElementHealth(veh, 1000)
		fixVehicle(veh)
		
		setVehicleDoorOpenRatio(veh, 0, 0, 100)
		setVehicleDoorOpenRatio(veh, 1, 0, 100)
		setVehicleDoorOpenRatio(veh, 2, 0, 100)
		setVehicleDoorOpenRatio(veh, 3, 0, 100)
		setVehicleDoorOpenRatio(veh, 4, 0, 100)
		setVehicleDoorOpenRatio(veh, 5, 0, 100)
		
	dbid = getElementData(veh,"vehicle:id") or 0;
    local transfer_text=('[ADM:FIX] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /fix >> car id: '..dbid..'.')	
	outputServerLog(transfer_text)
end
end)
]]--

addCommandHandler("pfix", function(plr,cmd,cel)
if getElementData(plr,"admin:poziom") >= 6 and getElementData(plr,"admin:zalogowano") == "true" then
		if not cel then
			outputChatBox("* Użycie: /pfix <nick/ID>", plr)
			return
		end
		local target = exports["aj-engine"]:findPlayer(plr,cel)
		if not target then
			outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
			return
		end
		local veh=getPedOccupiedVehicle(target)
		if not veh then
			outputChatBox("* "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..", nie znajduje się w pojeździe !", plr)
			return
		end
		outputChatBox("* Naprawiłeś/aś pojazd "..getPlayerName(target):gsub("#%x%x%x%x%x%x",""),plr)
		setElementHealth(veh, 1000)
		fixVehicle(veh)
		
	dbid = getElementData(veh,"vehicle:id") or 0;
    local transfer_text=('[ADM:PFIX] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /pfix >> car id: '..dbid..' ('..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..')/'..getElementData(target,"player:dbid")..'.')	
	outputServerLog(transfer_text)		
end
end)

--[[
addCommandHandler("cfix", function(plr, cmd, range)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
        if (not range) then
            outputChatBox("Użyj: /cfix <zasieg>", plr)
        return end
		if not tonumber(range) then
		outputChatBox("* /cfix <zasieg>", plr)
		return end
		range = tonumber(range)
		if range <= 0 then
		outputChatBox("* Za mala odleglosc", plr)
		return end
		if range > 100 then
		outputChatBox("* Za duza odleglosc", plr)
		return end
		local x,y,z = getElementPosition(plr)
		local cub = createColSphere(x,y,z,range)
		local pojazdy = getElementsWithinColShape( cub, "vehicle")
		if #pojazdy == 0 then
		outputChatBox("* Brak pojazdow w poblizu", plr)
		return end
		for i,pojazd in ipairs(pojazdy) do
			fixVehicle(pojazd)
		end
		setTimer(destroyElement,5000,1,cub)
		
    local transfer_text=('[ADM:CFIX] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /cfix >> na odleglosc: '..range..'.')	
	outputServerLog(transfer_text)	
end
end)
]]--
addCommandHandler("fix", function(plr, cmd, range)
if getElementData(plr,"admin:poziom") >= 6 and getElementData(plr,"admin:zalogowano") == "true" then
        if (not range) or not tonumber(range) then
			local veh=getPedOccupiedVehicle(plr)
			if not veh then
				outputChatBox("* Nie znajdujesz się w pojeździe!", plr)
				return
			end
		      outputChatBox("* Naprawiłeś/aś pojazd!",plr)
		      setElementHealth(veh, 1000)
		      fixVehicle(veh)
		
		      setVehicleDoorOpenRatio(veh, 0, 0, 100)
		      setVehicleDoorOpenRatio(veh, 1, 0, 100)
		      setVehicleDoorOpenRatio(veh, 2, 0, 100)
		      setVehicleDoorOpenRatio(veh, 3, 0, 100)
		      setVehicleDoorOpenRatio(veh, 4, 0, 100)
		      setVehicleDoorOpenRatio(veh, 5, 0, 100)
		
	          dbid = getElementData(veh,"vehicle:id") or 0;
              local transfer_text=('[ADM:FIX] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /fix >> car id: '..dbid..'.')	
	          outputServerLog(transfer_text)
			return
        end
		range = tonumber(range)
		if range <= 0 then
		outputChatBox("* Za mala odleglosc", plr)
		return end
		if range > 100 then
		outputChatBox("* Za duza odleglosc", plr)
		return end
		local x,y,z = getElementPosition(plr)
		local cub = createColSphere(x,y,z,range)
		local pojazdy = getElementsWithinColShape( cub, "vehicle")
		if #pojazdy == 0 then
		outputChatBox("* Brak pojazdow w poblizu", plr)
		return end
		for i,pojazd in ipairs(pojazdy) do
			fixVehicle(pojazd)
		end
		outputChatBox("* Naprawiono pojazdy w okolicy: "..range.."", plr)
		setTimer(destroyElement,5000,1,cub)
		
    	local transfer_text=('[ADM:FIX '..range..'] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /cfix >> na odleglosc: '..range..'.')	
		outputServerLog(transfer_text)	
end
end)

addCommandHandler("resp", function(plr,cmd,name)
if getElementData(plr,"admin:poziom") >= 7 and getElementData(plr,"admin:zalogowano") == "true" then
			if not name then return end
			local veh=getPedOccupiedVehicle(plr)
			if veh then 
                outputChatBox("* Wyjdz z auta przed wpisaniem tej komendy.", plr)
			return end
			if tonumber(name) == nil then -- Nil.
				outputChatBox("* Musisz wpisać model (ID), nie nazwę.", plr)
				return
			end

			if tonumber(name) >= 400 and tonumber(name) <= 611 then
			--// SPRAWDZAMY CZY MODEL JEST POPRAWNY, MOZNA DODAC WYJATKI --//
			if tonumber(name) == 450 or tonumber(name) == 606 or tonumber(name) == 607 or tonumber(name) == 610 or tonumber(name) == 584 or tonumber(name) == 611 or tonumber(name) == 608 or tonumber(name) == 591 then --  or tonumber(name) == 435
			    outputChatBox("* Ten model jest na liście zablokowanych.", plr)
			return end
			
			if getElementAlpha(plr) ~= 255 then
				setElementAlpha(plr,255)
				local rgb = getElementData(plr,"player:colorRGB")
				createBlipAttachedTo ( plr, 0, 2, rgb[1], rgb[2], rgb[3] ); 
			end
			
			local x,y,z = getElementPosition(plr)
			local rx,ry,rz = getElementRotation(plr)
			local veh = createVehicle(name, x, y, z, rx, ry, rz);
			if veh == "blad" then return end
			local model = getVehicleNameFromModel(name)

			setElementInterior(veh,getElementInterior(plr))
			setElementDimension(veh,getElementDimension(plr))
			--setElementData(veh, "vehicle:fuel", 100)
			warpPedIntoVehicle(plr,veh)
			
            setElementData(veh,"vehicle:id", ""..math.random(1000000,9999999).."")
		    setElementData(veh,"vehicle:owner", "Serwer")
			setElementData(veh,"vehicle:paliwo", 100)
			setElementData(veh,"vehicle:przebieg", 0)
			setElementData(veh,"vehicle:odznaczone",true)
			setVehiclePlateText(veh,getElementData(veh,"vehicle:id").."")
			exports["aj-vehsSirens"]:vehSirens(veh)
			
			outputChatBox("* Zrespiłeś/aś pojazd: "..model, plr)

    local transfer_text=('[ADM:RESP] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> /resp >> '..model..' (ID: '..getElementData(veh,"vehicle:id")..')')	
	outputServerLog(transfer_text)	
	
            end
end
end)


addCommandHandler("dv", function(plr,cmd)

			local veh=getPedOccupiedVehicle(plr)
			if not veh then
				outputChatBox("* Musisz siedzieć w pojeździe.", plr)
				return
			end
			if getElementData(veh,"vehicle:id") then
				outputChatBox("* Nie możesz usunąć tego pojazdu.", plr)
				return
			end
			destroyElement(veh)
			outputChatBox("* Usunąłeś(aś) pojazd", plr)
end)


local zapisane_pozycje = {}
addCommandHandler("sp", function(plr,cmd)

    local pos={}
    pos[1],pos[2],pos[3]=getElementPosition(plr)
    pos[4]=getElementInterior(plr)
    pos[5]=getElementDimension(plr)
	local uid = getElementData(plr,"player:dbid")
    zapisane_pozycje[uid] = pos
    outputChatBox("* Pozycja została zapisana.", plr)

end)

addCommandHandler("lp", function(plr,cmd)

	local uid = getElementData(plr,"player:dbid")
    local pos=zapisane_pozycje[uid]
    if (not pos) then
    outputChatBox("* Nie masz żadnej zapisanej pozycji.", plr)
    return
    end
	local veh = getPedOccupiedVehicle(plr)
	if veh then
		outputChatBox("* Najpierw wyjdź z pojazdu.", plr)
		return
	end	
    setElementPosition(plr,pos[1],pos[2],pos[3])
    setElementInterior(plr,pos[4])
    setElementDimension(plr,pos[5])
    outputChatBox("* Wczytano pozycję.", plr)

end)


function destroyBlipsAttachedTo(player)
    local attached = getAttachedElements ( player )
    if ( attached ) then
        for k,element in ipairs(attached) do
            if getElementType ( element ) == "blip" then
                destroyElement ( element )
            end
        end
    end
end

--// JAK GRACZ WYJDZIE
addEventHandler("onPlayerQuit",root,function()

    destroyBlipsAttachedTo(source)
	-- klatka jesli jest
	if klatki[source] then
	for i,v in ipairs(getElementsByType("object")) do
		if getElementData(v,"owner") == getPlayerName(source) then
			destroyElement(v)
		end
		if getElementData(v,"owner2") == getPlayerName(source) then
			destroyElement(v)
		end
		klatki[source] = false;
	end
	end
	
	local sprduty = getElementData(source,"admin:zalogowano") or false;
	if sprduty == "true" then
    local transfer_text=('[DUTY:LOGOUT] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' >> wylogowano sie z duty.')	
	outputServerLog(transfer_text)
	
	desc22 = "### "..getPlayerName(source):gsub("#%x%x%x%x%x%x","").."/"..getElementData(source,"id").." wylogował się z DUTY.";
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	end


end)

