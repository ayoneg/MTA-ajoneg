
local stopChat = false
addCommandHandler("root.say", function(plr,cmd)
	local perm = tonumber(getElementData(plr,"admin:poziom")) or 0;
	if perm >= 10 and getElementData(plr,"admin:zalogowano") == "true" then
		if stopChat then
			stopChat = false
			outputChatBox('* ROOT: Włączyłeś/aś czat /say.', plr)
		else
			stopChat = true
			outputChatBox('* ROOT: Wyłączyłeś/aś czat /say.', plr)
		end
	end
end)


-- czat premium
addCommandHandler("v", function(plr, cmd, ...)
	if getElementData(plr, "player:premium") == 0 and getElementData(plr, "admin:zalogowano") == "false" then 
	outputChatBox("* Musisz posiadać status premium by pisać na czacie globalnym!",plr,78,255,0) 
	return end
	if not ... then
	local x = getElementData(plr,"player:pchatoff")
	if x == false then
	outputChatBox("* Wyłączyłeś/aś chat premium.",plr)
	setElementData(plr,"player:pchatoff",true)
	end
	if x == true then
	outputChatBox("* Włączyłeś/aś chat premium.",plr)
	setElementData(plr,"player:pchatoff",false)
	end
	return end
	if (getElementData(plr,"zakazy:mute")) then
	    outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
	return end
	if stopChat then
	cancelEvent()
	outputChatBox('* Chat premium jest aktualnie wyłączony.', plr, 255, 0, 0, true)
	return end
	if getElementData(plr,"player:pchatoff") then
		cancelEvent()
		outputChatBox('* Posiadasz wyłączony chat premium.', plr, 255, 0, 0, true)
		return 
	end
	if ... then
		local message = table.concat({ ... }," ")
		local name = getPlayerName(plr):gsub("#%x%x%x%x%x%x","")
		for _,p in pairs(getElementsByType("player")) do
			if ( getElementData(p, "admin:zalogowano") == "true" or getElementData(p,"player:premium") ) and not getElementData(p,"player:pchatoff") then
			playSoundFrontEnd(p,38) -- 6 // 14 // 33 // 37 // 38
			outputChatBox("#fbf5d0"..getElementData(plr,"id").."#EFD00C> "..name.."#ffffff: "..message:gsub("#%x%x%x%x%x%x","").."", p, 255, 255, 255, true)
			end
		end
		local desc = "[PREMIUM] "..getElementData(plr,"id").."> "..name..": "..message:gsub("#%x%x%x%x%x%x","")..""
		outputServerLog(desc)
	end
end)

-- /r GLOBAL CHAT
function globalChat(plr,cmd, ...)
local admperm = getElementData(plr,"admin:poziom") or 0;
if admperm >= 5 then
    if getElementData(plr,"admin:zalogowano") == "true" then
    local tresc = table.concat(arg," ")
	local moj_admin_poziom = getElementData(plr, "admin:poziom") or 0;
	local moj_admin_duty = getElementData(plr, "admin:zalogowano") or "false";
    if moj_admin_poziom < 5 then return end
	if moj_admin_poziom >= 5 and moj_admin_duty == "false" then
	    outputChatBox('* Zaloguj się na rangę, aby korzystać z tego czatu.', plr, 255, 0, 0, true)
		return 
	end
	if moj_admin_poziom == 5 then admincolor = "#1f6e04"; end --// supp #3095bd
	if moj_admin_poziom == 6 then admincolor = "#1f6e04"; end --// moderator 
	if moj_admin_poziom == 7 then admincolor = "#4ad1d3"; end --// administrator  00f0ff [#4ad1d3] #FF4500 // #007fff
	if moj_admin_poziom == 10 then admincolor = "#cf0000"; end --// root 
	
    local transfer_text=('[GLOBALCHAT:R] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> r ('..tresc..')')	
	outputServerLog(transfer_text)
	-- gloal root
	outputChatBox(admincolor..">> "..tresc, root, _, _, _, true)
	
end
	end
end
addCommandHandler("r", globalChat, false, false)
addCommandHandler("global", globalChat, false, false)

-- local chat (/me /do)

addEventHandler('onPlayerChat', root, function(msg, type)
	cancelEvent()
	if stopChat then
		cancelEvent()
		outputChatBox('* Chat jest aktualnie wyłączony.', source, 255, 0, 0, true)
		return 
	end
	if not getElementData(source,"player:dbid") then
		outputChatBox("* Musisz być zalogowany/a!", source)
		return 
	end
	if (getElementData(source,"zakazy:mute")) then
	    outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",source, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(source, "zakazy:mute"),source, 255,0,0)
		return 
	end
	local tick=getTickCount()
	if type==0 then
		cancelEvent()
		if not isElement(source) then return end

		local x,y,z=getElementPosition(source)
		local sphere=createColSphere(x,y,z, 42) --//rendering
		local players=getElementsWithinColShape(sphere, 'player')
		
		for i,v in pairs(players) do
			local id = getElementData(source,"id")
			local admin_poziom = getElementData(source, "admin:poziom") or 0;
			local admin_duty = getElementData(source, "admin:zalogowano") or "false";
			
			wyb_premka = getElementData(source,"player:premium") or 0;
			jobCOLOR = getElementData(source,"player:jobCOLORfr") or false;
			if wyb_premka == 1 then nickcolor = "#EFD00C"; else nickcolor = "#808080"; end
			if jobCOLOR then nickJOB = jobCOLOR; else nickJOB="#ffffff"; end
			
			outputChatBox(""..nickcolor..""..getElementData(source,"id").." "..nickJOB..""..getPlayerName(source):gsub("#%x%x%x%x%x%x","")..":#e6e6e6 "..msg:gsub("#%x%x%x%x%x%x",""), v, _, _, _, true)
		end
		destroyElement(sphere)
		
        local transfer_text=('[SAY:LOCAL] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' '..msg:gsub("#%x%x%x%x%x%x","")..'')	
	    outputServerLog(transfer_text)
		
	    local desc22 = "LOCAL "..getPlayerName(source).."/"..getElementData(source,"id")..": "..msg:gsub("#%x%x%x%x%x%x","")..""
	    triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	elseif type==1 then
		cancelEvent()
		local x,y,z=getElementPosition(source)
		local sphere=createColSphere(x,y,z, 42)
		local players=getElementsWithinColShape(sphere, 'player')
		destroyElement(sphere)
		for i,v in pairs(players) do
			outputChatBox("* "..getPlayerName(source):gsub("#%x%x%x%x%x%x","").." "..msg:gsub("#%x%x%x%x%x%x","").."", v, 25, 91, 255)
		end

        local transfer_text=('[SAY:ME] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' '..msg:gsub("#%x%x%x%x%x%x","")..'')	
	    outputServerLog(transfer_text)
		
	    local desc22 = "LOCAL/ME "..getPlayerName(source).."/"..getElementData(source,"id")..": "..msg:gsub("#%x%x%x%x%x%x","")..""
	    triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	end
end)

function doChat(plr,cmd, ...)
local msg = table.concat(arg," ")
	if stopChat then
		cancelEvent()
		outputChatBox('* Chat jest aktualnie wyłączony.', plr, 255, 0, 0, true)
	return end
	if not getElementData(plr,"player:dbid") then
	outputChatBox("* Musisz być zalogowany/a!", plr)
	return end
	if (getElementData(plr,"zakazy:mute")) then
	    outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
	return end
		local x,y,z=getElementPosition(plr)
		local sphere=createColSphere(x,y,z, 42)
		local players=getElementsWithinColShape(sphere, 'player')
		destroyElement(sphere)
		for i,v in pairs(players) do
			outputChatBox("* "..msg:gsub("#%x%x%x%x%x%x","").." ("..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..")", v)
		end

        local transfer_text=('[SAY:DO] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..msg:gsub("#%x%x%x%x%x%x","")..'')	
	    outputServerLog(transfer_text)
		
	    local desc22 = "LOCAL/DO "..getPlayerName(plr).."/"..getElementData(plr,"id")..": "..msg:gsub("#%x%x%x%x%x%x","")..""
	    triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
end
addCommandHandler("do", doChat, false, false)

-- mod chat
function modChat(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local moj_admin_poziom = getElementData(plr, "admin:poziom") or 0;
	local moj_admin_duty = getElementData(plr, "admin:zalogowano") or "false";
    if moj_admin_poziom < 5 then return end
	if moj_admin_poziom >= 5 and moj_admin_duty == "false" then
	    outputChatBox('* Zaloguj się na rangę, aby korzystać z tego czatu.', plr, 255, 0, 0, true)
	return end
    local transfer_text=('[CHAT:M] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..tresc)	
	outputServerLog(transfer_text)
	for i2, v2 in ipairs(getElementsByType("player")) do
		local id = getElementData(v2,"id")
		local admin_poziom = getElementData(v2, "admin:poziom") or 0;
		local admin_duty = getElementData(v2, "admin:zalogowano") or "false";
		
	    if admin_poziom >= 5 and admin_duty=="true" then

		outputChatBox("#1f6e04M> " .. getPlayerName(plr) .. "(" .. getElementData(plr,"id") .. "): #ffffff" .. tresc, v2, _, _, _, true)
		playSoundFrontEnd(v2,33)
		end
	end
end
addCommandHandler("m", modChat, false, false)

-- admin chat
function adminChat(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local moj_admin_poziom = getElementData(plr, "admin:poziom") or 0;
	local moj_admin_duty = getElementData(plr, "admin:zalogowano") or "false";
    if moj_admin_poziom < 7 then return end
	if moj_admin_poziom >= 7 and moj_admin_duty == "false" then
	    outputChatBox('* Zaloguj się na rangę, aby korzystać z tego czatu.', plr, 255, 0, 0, true)
	return end
	
    local transfer_text=('[CHAT:A] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..tresc)	
	outputServerLog(transfer_text)
	for i2, v2 in ipairs(getElementsByType("player")) do
		local id = getElementData(v2,"id")
		local admin_poziom = getElementData(v2, "admin:poziom") or 0;
		local admin_duty = getElementData(v2, "admin:zalogowano") or "false";
		
	    if admin_poziom >= 7 and admin_duty=="true" then

		outputChatBox("#cf0000A> " .. getPlayerName(plr) .. "(" .. getElementData(plr,"id") .. "): #ffffff" .. tresc, v2, _, _, _, true)
		playSoundFrontEnd(v2,33)
		end
	end
end
addCommandHandler("a", adminChat, false, false)

--root chat
function adminChatroot(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local moj_admin_poziom = getElementData(plr, "admin:poziom") or 0;
	local moj_admin_duty = getElementData(plr, "admin:zalogowano") or "false";
    if moj_admin_poziom < 10 then return end
	if moj_admin_poziom >= 10 and moj_admin_duty == "false" then
	    outputChatBox('* Zaloguj się na rangę, aby korzystać z tego czatu.', plr, 255, 0, 0, true)
	return end
	for i2, v2 in ipairs(getElementsByType("player")) do
		local id = getElementData(v2,"id")
		local admin_poziom = getElementData(v2, "admin:poziom") or 0;
		local admin_duty = getElementData(v2, "admin:zalogowano") or "false";
		
	    if admin_poziom >= 10 and admin_duty=="true" then

		outputChatBox("#330000R> " .. getPlayerName(plr) .. "(" .. getElementData(plr,"id") .. "): #ffffff" .. tresc, v2, _, _, _, true)
		playSoundFrontEnd(v2,33)
		end
	end
end
addCommandHandler("aa", adminChatroot, false, false)