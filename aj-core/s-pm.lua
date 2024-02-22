

function privateMessage(plr,cmd,cel, ...)
	if (getElementData(plr,"zakazy:mute")) then
	    outputChatBox("Posiadasz nałożoną blokadę wycieszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
	    return
	end
	if not cel then
		outputChatBox("Uzyj: /pm <nick/ID> <tresc>", plr)
		return
	end
	local target = exports["aj-engine"]:findPlayer(plr,cel)
	if (not target) then
		outputChatBox("Nie znaleziono gracza o podanym ID/nicku!", plr)
		return
	end
	local pmoff=getElementData(target,"player:pmoff")
	if (pmoff) then
		outputChatBox(getPlayerName(target).." nie akceptuje wiadomości PM.", plr)
		if (type(pmoff)=="string") then
			outputChatBox("Powód: " .. pmoff, plr)
		end
		return
	end
    if getElementData(plr,"player:pmoff") then
      outputChatBox("* Masz aktywne PMoff.", plr)
    end
    local tresc = table.concat(arg," ")
	-- wysyłamy pm (odbiorcy)
	outputChatBox("<< " .. getPlayerName(plr) .. "(" .. getElementData(plr,"id") .. "): " .. tresc, target)
    -- tutaj widzimy ze wyslalismy, (nadawcy)
	outputChatBox(">> " .. getPlayerName(target) .. "(" .. getElementData(target,"id") .. "): " .. tresc, plr)
	playSoundFrontEnd(target,12)
	
    local transfer_text=('[PM] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> '..getPlayerName(target)..'/'..getElementData(target,"player:dbid")..': '..tresc..'')	
	outputServerLog(transfer_text)
	
	local desc22 = 'PM '..getPlayerName(plr)..'('..getElementData(plr,"player:dbid")..') >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'('..getElementData(target,"id")..'): '..tresc..''
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
end

addCommandHandler("pm", privateMessage, false, false)
addCommandHandler("pw", privateMessage, false, false)



addCommandHandler("pmon", function(plr,cmd)
	local pm = getElementData(plr,"player:pmoff") or false;
	if pm then
		removeElementData(plr,"player:pmoff")
		outputChatBox("(( Akceptujesz wszystkie wiadomości PM. ))", plr)
	end
end)

addCommandHandler("pmoff", function(plr,cmd,...)
	local powod = table.concat(arg," ")
	if string.len(powod) < 2 then powod = true; end
	setElementData(plr, "player:pmoff", powod)
	outputChatBox("(( Nie akceptujesz wiadomości PM. ))", plr)
	return
end)
