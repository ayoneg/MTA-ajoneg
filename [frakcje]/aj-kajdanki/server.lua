--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt dodatkowy do SAPD - kajdanki.
]]--

function contr(cel,var)
	toggleControl(cel,"sprint",var)
	toggleControl(cel,"jump",var)
	toggleControl(cel,"crouch",var)
	toggleControl(cel,"enter_exit",var)
	toggleControl(cel,"enter_passenger", var)
	toggleControl(cel,"next_weapon",var) 
	toggleControl(cel,"previous_weapon",var)
end

function findEmptyCarSeat(veh,miejsce)
    local max = getVehicleMaxPassengers(veh)
    local pas = getVehicleOccupants(veh)
    for i=2, max do
        if not pas[i] then
        	return i
        end
    end
    return false
end

function sprawdzMiejsce(veh,seat)
    maxs = getVehicleMaxPassengers(veh)
    pas = getVehicleOccupant(veh,seat)
	if pas then
		return false
	end
    return true
end

addEvent("zadjmijControl", true)
addEventHandler("zadjmijControl", resourceRoot, function(komu)
	if komu then
		contr(komu,true)
	end
end)

addEvent("zlap:nadajdimint", true)
addEventHandler("zlap:nadajdimint", resourceRoot, function(komu,dokogo)
	if komu then
		setElementInterior(komu, getElementInterior(dokogo))
		setElementDimension(komu, getElementDimension(dokogo))
	end
end)

addEvent("zlap:wtepajdoauta", true)
addEventHandler("zlap:wtepajdoauta", resourceRoot, function(komu,veh)
	if komu then
		local miejsce = findEmptyCarSeat(veh)
		if miejsce then
			warpPedIntoVehicle(komu, veh, miejsce)
		end
	end
end)

addEvent("zlap:wtepajzauta", true)
addEventHandler("zlap:wtepajzauta", resourceRoot, function(komu)
	if komu then
		removePedFromVehicle(komu)
	end
end)

addEvent("zlap:rotationchek", true)
addEventHandler("zlap:rotationchek", resourceRoot, function(plr,odkogo)
	if plr then
		local xz,yz,zz = getElementRotation(odkogo)
		setElementRotation(plr,xz,yz,zz)
	end
end)


addCommandHandler("zakujwpoj", function(plr,cmd,cel)
	local duty = getElementData(plr,"player:frakcja") or false;
	if duty then
	if not cel then 
		outputChatBox("#7AB4EAⒾ#e7d9b0 Użycie: /zakujwpoj <id/nick>.", plr,231, 217, 176,true)
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then 
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local veh=getPedOccupiedVehicle(plr)
	local vehtarg=getPedOccupiedVehicle(target)
	if not veh or not vehtarg then
--		outputChatBox("* Nie możesz zakuwać, kiedy gracz nie jest w pojeździe.", plr, 255, 0, 0)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Tej komendy możesz użyć tylko w pojeździe.", plr,231, 217, 176,true)
		return
	end
	local x,y,z = getElementPosition(plr)
	local Tx,Ty,Tz = getElementPosition(target)
	local dist = getDistanceBetweenPoints2D(x,y,Tx,Ty)
	if target==plr then return end
	if dist <= 5 then
		local zlapany = getElementData(target,"player:zlap") or false;
		local zlapanyBY = getElementData(target,"player:zlapBY") or false;
		if zlapany and not zlapanyBY then
			removeElementData(target,"player:zlap")
			removeElementData(target,"player:zlapBY")
			triggerClientEvent("zlap:refresh",root,target)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Zdejmujesz kajdanki z gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz zdejmuje Ci kajdanki.", target,231, 217, 176,true)
		elseif zlapany and zlapanyBY then
			setElementData(target,"player:zlap",true)
			removeElementData(target,"player:zlapBY")
			triggerClientEvent("zlap:refresh",root,target)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Przypinasz kajdankami gracza #EBB85D"..getPlayerName(target).."#e7d9b0 w pojeździe.", plr,231, 217, 176,true)
--			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz #EBB85D"..getPlayerName(plr).."#e7d9b0 nakłada Ci kajdanki.", target,231, 217, 176,true)
		elseif not zlapany and not zlapanyBY then
			setElementData(target,"player:zlap",true)
--			triggerClientEvent("zlap:refresh",root,target)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Nakładasz kajdanki na gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz #EBB85D"..getPlayerName(plr).."#e7d9b0 nakłada Ci kajdanki.", target,231, 217, 176,true)
		end
	else
		outputChatBox("#7AB4EAⒾ#e7d9b0 Jesteś za daleko od gracza.", plr,231, 217, 176,true)
	end
	end
end)


addCommandHandler("zakuj", function(plr,cmd,cel)
	local duty = getElementData(plr,"player:frakcja") or false;
	if duty then
	if not cel then 
		outputChatBox("#7AB4EAⒾ#e7d9b0 Użycie: /zakuj <id/nick>.", plr,231, 217, 176,true)
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then 
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local veh=getPedOccupiedVehicle(plr)
	if veh then
		outputChatBox("* Nie możesz zakuwać, kiedy znajdujesz się w pojeździe.", plr, 255, 0, 0)
		return
	end
	local x,y,z = getElementPosition(plr)
	local Tx,Ty,Tz = getElementPosition(target)
	local dist = getDistanceBetweenPoints2D(x,y,Tx,Ty)
	if target==plr then return end
	if dist <= 5 then
		local zlapany = getElementData(target,"player:zlapBY") or false;
		if zlapany then
			removeElementData(target,"player:zlap")
			removeElementData(target,"player:zlapBY")
			triggerClientEvent("zlap:refresh",root,target)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Zdejmujesz kajdanki z gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz zdejmuje Ci kajdanki.", target,231, 217, 176,true)
		else
			setElementData(target,"player:zlap",true)
			setElementData(target,"player:zlapBY",plr)
			triggerClientEvent("zlap:refresh",root,target)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Nakładasz kajdanki na gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz #EBB85D"..getPlayerName(plr).."#e7d9b0 nakłada Ci kajdanki.", target,231, 217, 176,true)
		end
	else
		outputChatBox("#7AB4EAⒾ#e7d9b0 Jesteś za daleko od gracza.", plr,231, 217, 176,true)
	end
	end
end)

addEventHandler("onVehicleStartExit", root, function(plr,seat)
	local kajdanki = getElementData(plr,"player:zlap") or false;
	if kajdanki then
	    outputChatBox("* Masz na sobie kajdanki, nie możesz wysiąść.",plr)
	    cancelEvent() 
	    return 
	end
end)



---------------------------------------------------------------------------------
--[[
addCommandHandler("zakuj", function(plr,cmd,cel)
	local duty = getElementData(plr,"player:frakcja") or false;
	if duty then
	if not cel then 
		outputChatBox("#7AB4EAⒾ#e7d9b0 Użycie: /zakuj <id>.", plr,231, 217, 176,true)
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then 
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local veh=getPedOccupiedVehicle(plr)
	if veh then
		outputChatBox("* Nie możesz zakuwać, kiedy znajdujesz się w pojeździe.", plr, 255, 0, 0)
		return
	end
	local x,y,z = getElementPosition(plr)
	local Tx,Ty,Tz = getElementPosition(target)
	local dist = getDistanceBetweenPoints2D(x,y,Tx,Ty)
	if target==plr then return end
	local use = getElementData(target,"player:zakujUSE") or false;
	if use then return end
	if dist <= 5 then
--		local zakuty = getElementData(target,"player:zakuj") or false;
		local zakutyCAR = getElementData(target,"player:zakujCAR")
		if zakutyCAR then
			removeElementData(target,"player:zakujCAR")
			setPedAnimation(target, false)
			contr(target,false)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Sciągasz kajdanki graczowi #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz zdajmuje Ci kajdanki.", target,231, 217, 176,true)
		else
			local zakuty = getElementData(target,"player:zakuj") or false;
			local zakutyBY = getElementData(target,"player:zakujBY") or false;
			if zakuty and not zakutyBY then
				removeElementData(target,"player:zakuj")
				contr(target,true)
				setPedAnimation(target, false)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Sciągasz kajdanki graczowi #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz zdajmuje Ci kajdanki.", target,231, 217, 176,true)
			elseif not zakuty then
				setElementData(target,"player:zakuj",true)
				if getPedOccupiedVehicle(target) then
					setElementData(target,"player:zakujCAR",true)
				else
					setPedAnimation(target, "GRAVEYARD", "mrnM_loop", -1, false, true)
				end
				contr(target,false)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Nakładasz kajdanki graczowi #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz #EBB85D"..getPlayerName(plr).."#e7d9b0 nakłada Ci kajdanki.", target,231, 217, 176,true)
			elseif zakuty and zakutyBY==plr then
--				removeElementData(target,"player:zakuj")
--				setPedFrozen(target, false)
				removeElementData(target,"player:zakujBY")
				removeElementData(plr,"player:zakujUSE")
				removeElementData(plr,"player:zakujPLR")
				triggerClientEvent("zakuj:refresh",root,target)
				setPedWalkingStyle(plr, 0)
				setPedAnimation(target, "GRAVEYARD", "mrnM_loop", -1, false, true)
				setElementCollisionsEnabled(target, true)
				detachElements(target, plr)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Przestajesz prowadzić gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			else
				outputChatBox("#7AB4EAⒾ#e7d9b0 Nie możesz teraz tego zrobić.", plr,231, 217, 176,true)
			end
			
		end
	else
		outputChatBox("#7AB4EAⒾ#e7d9b0 Jesteś za daleko od gracza.", plr,231, 217, 176,true)
	end
	end
end)


addCommandHandler("zlap", function(plr,cmd,cel)
	local duty = getElementData(plr,"player:frakcja") or false;
	if duty then
	if not cel then 
		outputChatBox("#7AB4EAⒾ#e7d9b0 Użycie: /zlap <id>.", plr,231, 217, 176,true)
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if not target then 
		outputChatBox("* Nie znaleziono podanego gracza.", plr, 255, 0, 0)
		return
	end
	local veh=getPedOccupiedVehicle(plr)
	if veh then
		outputChatBox("* Nie możesz zakuwać, kiedy znajdujesz się w pojeździe.", plr, 255, 0, 0)
		return
	end
	local x,y,z = getElementPosition(plr)
	local Tx,Ty,Tz = getElementPosition(target)
	local dist = getDistanceBetweenPoints2D(x,y,Tx,Ty)
	-- pootem add ze sam siebie nie mozna
	-- here
	if target==plr then return end
	local use = getElementData(target,"player:zakujUSE") or false;
	if use then return end
	if dist <= 5 then
		-- jesli dystans nie jest większy niż 5
		-- sprawdzamy czy nie jest juz zakuty
		local zakuty = getElementData(target,"player:zakuj") or false;
		local zakutyBY = getElementData(target,"player:zakujBY") or false;		
		local zakujUSE = getElementData(plr,"player:zakujUSE") or false;	
		if not zakutyBY and not zakujUSE then
--			setPedFrozen(target, true)
			setElementData(target,"player:zakuj",true)
			setElementData(target,"player:zakujBY",plr)
			setElementData(plr,"player:zakujUSE",true)
			setElementData(plr,"player:zakujPLR",target)
			removeElementData(target,"player:zakujCAR")
			contr(target,false)
			setPedWalkingStyle(plr, 68)
			local vehicle = getPedOccupiedVehicle(target) or false
			if vehicle then
				removePedFromVehicle(target)
			end
			attachElements(target, plr, 0, 0.7, 0)
			setElementAttachedOffsets(target)
--			setPedAnimation(target, "GRAVEYARD", "mrnM_loop", -1, false, true)
			setPedAnimation(target, "fat", "IDLE_tired", -1, true, false)
			setElementCollisionsEnabled(target, false)
			if not zakuty then
				outputChatBox("#7AB4EAⒾ#e7d9b0 Nakładasz kajdanki i prowadzisz gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Funkcjonariusz #EBB85D"..getPlayerName(plr).."#e7d9b0 nakłada Ci kajdanki.", target,231, 217, 176,true)
			end
			triggerClientEvent("zakuj:refresh",root,target)
		end
	else
		outputChatBox("#7AB4EAⒾ#e7d9b0 Jesteś za daleko od gracza.", plr,231, 217, 176,true)
	end
	end
end)





addEventHandler("onVehicleStartEnter", getRootElement(), function(player, seat, jacked, door)
	if source then
		local kajdanki = getElementData(player,"player:zakujUSE") or false;
		if ( seat==0 and kajdanki ) then
			cancelEvent()
		end
		if seat >= 1 then
		local kajdanki = getElementData(player,"player:zakujUSE") or false;
		if kajdanki then
			local zakuty = getElementData(player,"player:zakujPLR") or false;
			if zakuty then
				local miejsce = findEmptyCarSeat(source)
--				if not miejsce and seat==2 then miejsce=3 end
--				if not miejsce and seat==3 then miejsce=4 end
--				local testmm = sprawdzMiejsce(source,seat)
				if miejsce then
					detachElements(zakuty, player)
					setElementCollisionsEnabled(zakuty, true)
					warpPedIntoVehicle(zakuty,source,seat)
					removeElementData(zakuty,"player:zakuj")
					removeElementData(zakuty,"player:zakujBY")
					setElementData(zakuty,"player:zakujCAR",true)
					removeElementData(player,"player:zakujUSE")
					removeElementData(player,"player:zakujPLR")
					setPedWalkingStyle(player, 0)
					setTimer(testmont, 10, 1, player)
					outputChatBox("#7AB4EAⒾ#e7d9b0 Wprowadzasz gracza #EBB85D"..getPlayerName(zakuty).."#e7d9b0 do poajzdu.", player,231, 217, 176,true)
				else
					cancelEvent()
				end
			end
		end
		end
	end
end)

function testmont(player)
	removePedFromVehicle(player)
end
]]--