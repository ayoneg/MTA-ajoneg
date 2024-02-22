--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt frakcji SAPD beta.
]]--

addEventHandler("onResourceStart", root, function() 
local players=getElementsByType('player')
    for _, p in pairs(players) do
		bindKey(p, "y", "down", "chatbox", "frakcja")
		bindKey(p, "u", "down", "chatbox", "służby")
    end
end)

addEventHandler("onPlayerSpawn", getRootElement(),function (_)
	bindKey(source, "y", "down", "chatbox", "frakcja")
	bindKey(source, "u", "down", "chatbox", "służby")
end)

--======================
-- TUTAJ KWESTIA INTERIORU
local SAPD = createMarker(2287.0732421875, 2432.3671875, 10.8203125+0.65, "arrow", 1.3, 255,255,255,50)
local SAPD_int = createMarker(2279.4931640625, 2433.013671875, 51.528125762939+0.65, "arrow", 1.3, 255,255,255,50)
    setElementInterior(SAPD_int, 6)
	setElementDimension(SAPD_int, 5000)
local BLIP = createBlipAttachedTo(SAPD, 30, 2, 255, 0, 0, 255, 0, 300)


addEventHandler("onMarkerHit",SAPD, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 6, 2279.51171875, 2429.5859375, 51.528125762939)
	setElementDimension(el, 5000)
	setElementRotation(el,0,0,180,"default",true)
	setCameraTarget(el, el)
end)

addEventHandler("onMarkerHit", SAPD_int, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 0, 2287.0712890625, 2427.9248046875, 10.8203125)
	setElementDimension(el, 0)
	setElementRotation(el,0,0,180,"default",true)
	setCameraTarget(el, el)
end)
--======================
-- mandaty wynagrodzenie
local mandatywy = {
	SAPD_LV={
    	mpos={2288.0048828125, 2415.330078125, 51.528125762939},
		dimint={5000, 6},
		desc = "Pomiar prędkości",
	},
	USM_LV={ -- usm lv
    	mpos={2551.5874023438, 2165.4731445312, 0.75354409217834},
		dimint={0, 0},
		desc = "Pomiar prędkości",
	},
}

for i,v in pairs(mandatywy) do
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1.2, 75, 0, 155, 22)
	setElementData(marker,"mandatywy",true)
	setElementDimension(marker, v.dimint[1])
	setElementInterior(marker, v.dimint[2])	
	t = createElement("text")
	setElementData(t,"name",v.desc)
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementDimension(t, v.dimint[1])
	setElementInterior(t, v.dimint[2])
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3]+1)
end
addEvent("wyliczWynagrodzenieMandaty",true)
addEventHandler("wyliczWynagrodzenieMandaty", root,function(plr)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local resultsp = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_userid=? LIMIT 1;",uid)
		if #resultsp > 0 then
			local us_code = resultsp[1].fra_frakcjaid
		else
			local us_code = "none"
		end
		local code = "USM";
		local caount = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_userid=? AND joblog_code=? AND joblog_cfg=1;",uid,code)
		if caount and #caount > 0 then
			local result = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(joblog_value),0) lp FROM server_jobslog WHERE joblog_userid=? AND joblog_code=? AND joblog_cfg=1;",uid,code)
			if tostring(us_code) == "SAPD" then
				wynagrodzenie = result[1].lp * 0.22 -- 22% def
			else
				wynagrodzenie = result[1].lp * 0.12 -- 12% def
			end
			local money = string.format("%.2f", wynagrodzenie/100)
			
			--tab logic
			if (#caount)==1 then 
				text = "pomiar";
			elseif (#caount)>=2 and (#caount)<5 then
				text = "pomiary";
			else
				text = "pomiarów";
			end
			
			outputChatBox(" ", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Wynagrodzenie za pomiar prędkości #388E00"..money.."$#e7d9b0 (za #EBB85D"..(#caount).." "..text.."#e7d9b0).", plr,231, 217, 176,true)
			
			-- wyczysc logi
			local query = exports["aj-dbcon"]:upd("UPDATE server_jobslog SET joblog_cfg=0 WHERE joblog_userid=? AND joblog_cfg=1 AND joblog_code=?;",uid,code);
			
			-- nadaj kase
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+? WHERE user_id=?;",wynagrodzenie,uid)
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='22', lbank_touserid=?, lbank_kwota=?, lbank_data=NOW(), lbank_desc='Wynagrodzenie: Pomiar prędkości.', lbank_type='1'",uid,wynagrodzenie);
		end
	end
end)


--======================
-- mandaty oplacanie
local mandaty = {
	SAPD_LV={
    	mpos={2286.8486328125, 2422.0419921875, 51.528125762939},
		dimint={5000, 6},
		desc = "Mandaty",
	},
}

for i,v in pairs(mandaty) do
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1.2, 78, 188, 0, 22)
	setElementData(marker,"mandaty",true)
	setElementDimension(marker, v.dimint[1])
	setElementInterior(marker, v.dimint[2])	
	t = createElement("text")
	setElementData(t,"name",v.desc)
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementDimension(t, v.dimint[1])
	setElementInterior(t, v.dimint[2])
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3]+1.5)
end

local czas = {}

addEvent("zliczMandatyKarne",true)
addEventHandler("zliczMandatyKarne", root,function(plr)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		if czas[plr] and getTickCount() < czas[plr] then 
			return 
		end
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id=? LIMIT 1;",uid)
		if result and #result > 0 then
			setElementData(plr,"player:poliMandaty",result[1].user_polimoney)
			triggerClientEvent(plr,"odswiezMandatyKarne",plr,plr)
			czas[source] = getTickCount()+15000; -- 15 sek zabezpieczenia
		end
	end
end)


addEvent("zaplacZaMandatyPoli",true)
addEventHandler("zaplacZaMandatyPoli", root,function(plr)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id=? AND user_polimoney>0 LIMIT 1;",uid)
		if result and #result > 0 then
			removeElementData(plr,"player:poliMandaty",0)
			triggerClientEvent(plr,"odswiezMandatyKarne",plr,plr)
			money = result[1].user_polimoney
			takePlayerMoney(plr,money)
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_polimoney=0, user_money=user_money-? WHERE user_id=?;",money,uid)
			outputChatBox(" ", plr,231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Pomyślnie opłacono mandaty karne.", plr,231, 217, 176,true)
			setPlayerWantedLevel(plr, 0)
			-- do bota
			bot_id = 22;
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+? WHERE user_id=?;",money,bot_id)
			
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='"..uid.."', lbank_touserid='22', lbank_kwota='"..money.."', lbank_data=NOW(), lbank_desc='Opłata z mandaty karne.', lbank_type='1'");
		end
	end
end)




--======================
-- DUTY
local duty = {
-- USM
	USM_LV={
    	mpos={2547.2231445312, 2166.5561523438, 0.75354409217834},
		dimint={0, 0},
    	code="USM",
		desc="Urzędowa Straż Miejska",
		desc2="Komenda Główna USM",
		desc3="Praca w USM LV.";
	},
	-- tine
	--
	--frakcje powazne
	SAPD_LV={
    	mpos={2286.8203125, 2412.6875, 51.528125762939},
		dimint={5000, 6},
    	code="SAPD",
		desc="Praca w Policji",
		desc2="Komenda Główna Policji w SA",
		desc3="Lider: ---\n\nZastępca: ---\n\nTest: ---";
	},
}

for i,v in pairs(duty) do
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1.2, 78, 188, 0, 22)
	setElementData(marker,"frakcja",true)
	setElementData(marker,"frakcja:code",v.code)
	setElementData(marker,"frakcja:desc2",v.desc2)
	setElementData(marker,"frakcja:desc3",v.desc3)
	setElementDimension(marker, v.dimint[1])
	setElementInterior(marker, v.dimint[2])	
	t = createElement("text")
	setElementData(t,"name",v.desc)
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementDimension(t, v.dimint[1])
	setElementInterior(t, v.dimint[2])
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3]+1)
end

addEvent("sprFrakcjeGracza",true)
addEventHandler("sprFrakcjeGracza", root,function(code_in,plr)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local duty = getElementData(plr,"player:frakcja") or false;
		if duty then
			local code = getElementData(plr,"player:frakcjaCODE") or "";
			if tostring(code_in)==code then
				local ranklvl = getElementData(plr,"player:frakcjaRANK") or 15;
				local colorfr = getElementData(plr,"player:jobCOLORfr")
				removeElementData(plr,"player:frakcja")
--			removeElementData(plr,"player:frakcjaCODE")
				destroyBlipsAttachedTo(plr)
				local rgb = getElementData(plr,"player:colorRGB")
				createBlipAttachedTo(plr,0,2,rgb[1],rgb[2],rgb[3])
				removeElementData(plr,"player:jobCOLOR")
				removeElementData(plr,"player:jobCOLORfr")
				removeElementData(plr,"player:duty")
				removeElementData(plr,"player:frakcjaRANK")
				local minuty = getElementData(plr,"player:frakcjaTIME") or 0;
				if minuty > 0 then
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='"..minuty.."', joblog_type='"..ranklvl.."', joblog_userid='"..uid.."'");
					removeElementData(plr,"player:frakcjaTIME")
				end
				outputChatBox("#7AB4EAⒾ#e7d9b0 Zakończono służbę "..colorfr..""..code.."#e7d9b0.", plr,231, 217, 176,true)
				triggerClientEvent(plr,"ukryjPanelFrakcji",plr,plr)
				setElementModel(plr, getElementData(plr,"player:skinid") or 0)
			
				--zabieram suszara
				takeWeapon(plr, 22)
			else
				outputChatBox("* Nie jesteś zatrudniony/a w tej frakcji.", plr,255,0,0)
				triggerClientEvent(plr,"ukryjPanelFrakcji",plr,plr)
			end
		else
			local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_frakcjaid=? AND fra_userid=? LIMIT 1;",code_in,uid)
			if result and #result > 0 then
				setElementData(plr,"player:frakcja",true)
--				setElementData(plr,"player:frakcjaCODE",code)
				destroyBlipsAttachedTo(plr)
				
				--tablica RGB frakcji i USM
				if tostring(code_in)=="SAPD" then
					colorRGB = {7,49,187}
					colorHEX = "#0731bb"
					
					giveWeapon (plr, 22, 9999999, true); -- suszara
					
				elseif tostring(code_in)=="USM" then
					colorRGB = {153, 0, 153}
					colorHEX = "#990099"
					
					giveWeapon (plr, 22, 9999999, true); -- suszara
					
					local userplec = getElementData(plr,"player:plec") or 0;
					if userplec == 0 then
						setElementModel(plr, 71)
					else
						setElementModel(plr, 69)
					end					
				end
				
				createBlipAttachedTo(plr,0,2,unpack(colorRGB))
				setElementData(plr,"player:jobCOLOR",colorRGB);
				setElementData(plr,"player:jobCOLORfr",colorHEX);
				setElementData(plr,"player:duty",code_in)
				setElementData(plr,"player:frakcjaCODE",code_in)
				setElementData(plr,"player:frakcjaRANK",result[1].fra_poziom)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Rozpoczynasz służbę "..colorHEX..""..code_in.."#e7d9b0.", plr,231, 217, 176,true)
				triggerClientEvent(plr,"ukryjPanelFrakcji",plr,plr)
			else
				outputChatBox("* Nie jesteś zatrudniony/a w tej frakcji.", plr,255,0,0)
				triggerClientEvent(plr,"ukryjPanelFrakcji",plr,plr)
			end
		end
	end
end)

--======================

function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	end
	return target
end


--local tomek = createPed (244, 2079.71875, -1213.7294921875, 23.965990066528)
--[[
addEventHandler("onPlayerDamage",root,function(attacker,weapon,bodypart)
	if weapon == 3 then
		outputChatBox("#7AB4EAⒾ#e7d9b0 test.", root,231, 217, 176,true)
--		setPedAnimation(source, "SWORD", "Sword_Hit_3", 1, true)
--		animSet(source,"SWORD","Sword_Hit_3")
		setTimer(animSet, 1, 1, source, "sword", "Sword_Hit_3")
		setTimer(animSet, 1000, 1, source, "ped", "FLOOR_hit")
		setTimer(offAnim, 5000, 1, source)
	end
end)

function offAnim(gracz)
	setPedAnimation(gracz, false)
end

function animSet(kto,var1,var2)
	setPedAnimation(kto, var1, var2, -1, false, false)
end
]]--
-- obrazenia, ded: sword Sword_Hit_3
-- zakuj: anim: BD_FIRE  wash_up



-- test duty
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

-- jak dednie
addEventHandler("onPlayerWasted",root,function(totalAmmo,killer,killerWeapon,bodypart,stealth)
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
		local duty = getElementData(source,"player:frakcja") or false;
		if duty then
			local code = getElementData(source,"player:frakcjaCODE") or false;
			local colorfr = getElementData(source,"player:jobCOLORfr")
			local ranklvl = getElementData(source,"player:frakcjaRANK") or 15;
			removeElementData(source,"player:frakcja")
--			removeElementData(source,"player:frakcjaCODE")
			destroyBlipsAttachedTo(source)
			local rgb = getElementData(source,"player:colorRGB")
			createBlipAttachedTo(source,0,2,rgb[1],rgb[2],rgb[3])
			removeElementData(source,"player:jobCOLOR")
			removeElementData(source,"player:jobCOLORfr")
			removeElementData(source,"player:frakcjaRANK")
			local minuty = getElementData(source,"player:frakcjaTIME") or 0;
			if minuty > 0 then
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='"..minuty.."', joblog_type='"..ranklvl.."', joblog_userid='"..uid.."'");
				removeElementData(source,"player:frakcjaTIME")
			end
			outputChatBox("#7AB4EAⒾ#e7d9b0 Zakończono służbę "..colorfr..""..code.."#e7d9b0.", source,231, 217, 176,true)
		end
	end
end)

function quitPlayer() -- jak wyjdzie / connection lost ?
    local uid = getElementData(source,"player:dbid") or 0;
	if uid > 0 then
		local duty = getElementData(source,"player:frakcja") or false;
		if duty then
			local code = getElementData(source,"player:frakcjaCODE") or false;
			local ranklvl = getElementData(source,"player:frakcjaRANK") or 15;
			local minuty = getElementData(source,"player:frakcjaTIME") or 0;
			if minuty > 0 then
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='"..minuty.."', joblog_type='"..ranklvl.."', joblog_userid='"..uid.."'");
				removeElementData(source,"player:frakcjaTIME")
			end
		end
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)

--- test chat
function frakcjaChat(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local mojafrakcja = getElementData(plr, "player:frakcja") or false;
	if not mojafrakcja then
	    outputChatBox('* Z czatu frakcyjnego, mogą korzystać tylko osoby na służbie.', plr)
	return end
	if getElementData(plr,"zakazy:mute") then
		outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
		return 
	end
	local frakcjaname = getElementData(plr, "player:frakcjaCODE");
	local colorfr = getElementData(plr,"player:jobCOLORfr")
	local players=getElementsByType('player')
	for i, v in pairs(players) do
		local id = getElementData(v,"id")
		local plr_fra = getElementData(v,"player:frakcjaCODE") or false;
		local dutyy = getElementData(v,"player:frakcja") or false;
	    if tostring(plr_fra) == tostring(frakcjaname) and dutyy then
			outputChatBox(""..colorfr..""..frakcjaname..">#ffffff " .. getPlayerName(plr) .. ": #e6e6e6" .. tresc, v, _, _, _, true) -- (" .. getElementData(plr,"id") .. ")
			playSoundFrontEnd(v,33)
		end
	end
	
    local transfer_text=('[CHAT:FRAKCJA] '..frakcjaname..'> '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..tresc)	
	outputServerLog(transfer_text)
	
	local desc22 = ""..frakcjaname.." "..getPlayerName(plr).."/"..getElementData(plr,"id")..": "..tresc:gsub("#%x%x%x%x%x%x","")..""
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))

end
addCommandHandler("frakcja", frakcjaChat)

--- test chat sluzby
function sluzbyChat(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local mojafrakcja = getElementData(plr, "player:frakcja") or false;
	local frakcjaCODE = getElementData(plr, "player:frakcjaCODE") or false;
	if not mojafrakcja or frakcjaCODE=="USM" then
	    outputChatBox('* Z czatu służb, mogą korzystać tylko służby.', plr)
	return end
	if getElementData(plr,"zakazy:mute") then
		outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
		return 
	end
	local frakcjacol = getElementData(plr, "player:jobCOLORfr");
	local frakcjaname = "Służby";
	local org_color = "#696969";
	local players=getElementsByType('player')
	for i, v in pairs(players) do
		local id = getElementData(v,"id")
		local plr_fradu = getElementData(v,"player:frakcja") or false;
	    if plr_fradu then
			outputChatBox(""..org_color..""..frakcjaname.."> "..frakcjacol..""..getPlayerName(plr).."#ffffff: #e6e6e6" .. tresc, v, _, _, _, true) -- (" .. getElementData(plr,"id") .. ")
			playSoundFrontEnd(v,33)
		end
	end
	
    local transfer_text=('[CHAT:SŁUŻBY] '..frakcjaname..'> '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..tresc)	
	outputServerLog(transfer_text)
	
	local desc22 = "SŁUŻBY "..getPlayerName(plr).."/"..getElementData(plr,"id")..": "..tresc:gsub("#%x%x%x%x%x%x","")..""
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))

end
addCommandHandler("służby", sluzbyChat)


-- kajdanki :) // rozjebane sa
--[[
function contr(cel,var)
	toggleControl(cel,"sprint",var)
	toggleControl(cel,"jump",var)
	toggleControl(cel,"crouch",var)
	toggleControl(cel,"enter_exit",var)
	toggleControl(cel,"enter_passenger", var)
	toggleControl(cel,"next_weapon",var) 
	toggleControl(cel,"previous_weapon",var)
end

addCommandHandler("zlap", function(plr,cmd,cel)
	local duty = getElementData(plr,"player:frakcja") or false;
	if duty then
	if not cel then 
		outputChatBox("#7AB4EAⒾ#e7d9b0 Użycie: /zlap <id>.", plr,231, 217, 176,true)
		return
	end
	local target = findPlayer(plr,cel)
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
	if dist <= 5 then
		-- jesli dystans nie jest większy niż 5
		-- sprawdzamy czy nie jest juz zakuty
		local zakuty = getElementData(target,"player:kajdanki") or false;
		local zakuty2 = getElementData(plr,"player:kajdanki") or false;
		local used = getElementData(plr,"player:kajdankiUSED") or false;
		local used2 = getElementData(target,"player:kajdankiUSED") or false;
		if zakuty2 or used2 then return end
		if zakuty and used then
			-- jesli jest no to go odkuwamy
--			outputChatBox("#7AB4EAⒾ#e7d9b0 Odkuwasz z kajdanek gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			removeElementData(target,"player:kajdanki")
			removeElementData(target,"player:kajdankiCAR")
			removeElementData(target,"player:kajdankiPLR")
			removeElementData(plr,"player:kajdankiUSED")
			removeElementData(plr,"player:kajdankiUSEDPLR")
			contr(target,true)
			setPedWalkingStyle(plr, 0)
			setPedAnimation(target, false)
			setElementCollisionsEnabled(target, true)
			detachElements(target,plr)
		elseif not zakuty and not used then
			-- jesli nie jest to zakuwamy
--			outputChatBox("#7AB4EAⒾ#e7d9b0 Zakuwasz kajdankami gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			setElementData(target,"player:kajdanki",true)
			setElementData(target,"player:kajdankiPLR",plr)
			setElementData(plr,"player:kajdankiUSEDPLR",target)
			setElementData(plr,"player:kajdankiUSED",true)
			contr(target,false)
			local vehicle = getPedOccupiedVehicle(target) or false
			if vehicle then
				removePedFromVehicle(target)
			end
			attachElements(target, plr, 0, 0.7, 0) 
			setPedWalkingStyle(plr, 68)
--			setPedAnimation(target, "GRAVEYARD", "mrnM_loop", -1, false, true)
			setPedAnimation ( target, "fat", "IDLE_tired", -1, true, false )
			setElementCollisionsEnabled(target, false)
		elseif zakuty and not used then
			outputChatBox("#7AB4EAⒾ#e7d9b0 Zakuwasz kajdankami gracza #EBB85D"..getPlayerName(target).."#e7d9b0.", plr,231, 217, 176,true)
			setElementData(target,"player:kajdanki",true)
			setElementData(target,"player:kajdankiPLR",plr)
			setElementData(plr,"player:kajdankiUSEDPLR",target)
			setElementData(plr,"player:kajdankiUSED",true)
			contr(target,false)
			local vehicle = getPedOccupiedVehicle(target) or false
			if vehicle then
				removePedFromVehicle(target)
			end
			attachElements(target, plr, 0, 0.7, 0) 
			setPedWalkingStyle(plr, 68)
			setPedAnimation ( target, "fat", "IDLE_tired", -1, true, false )
			setElementCollisionsEnabled(target, false)
		end
	else
		outputChatBox("#7AB4EAⒾ#e7d9b0 Jesteś za daleko od gracza.", plr,231, 217, 176,true)
	end
	end
end)


function findEmptyCarSeat(veh)
    local max = getVehicleMaxPassengers(veh)
    local pas = getVehicleOccupants(veh)
    for i=1, max do
        if not pas[i] and i~= 1 then
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

addEventHandler("onVehicleStartEnter", getRootElement(), function(player, seat, jacked, door)
	if source then
		local kajdanki = getElementData(player,"player:kajdankiUSED") or false;
		if ( seat==0 and kajdanki ) or ( seat==1 and kajdanki ) then
			cancelEvent()
		end
		if seat >= 1 then
		local kajdanki = getElementData(player,"player:kajdankiUSED") or false;
		if kajdanki then
			local zakuty = getElementData(player,"player:kajdankiUSEDPLR") or false;
			if zakuty then
				local miejsce = findEmptyCarSeat(source)
--				local testmm = sprawdzMiejsce(source,seat)
				if miejsce then
					detachElements(zakuty, player)
					setElementCollisionsEnabled(zakuty, true)
					warpPedIntoVehicle(zakuty,source,miejsce)
					removeElementData(zakuty,"player:kajdankiPLR")
					removeElementData(zakuty,"player:kajdanki")
					removeElementData(player,"player:kajdankiUSED")
					removeElementData(player,"player:kajdankiUSEDPLR")
					setPedWalkingStyle(player, 0)
					setTimer(testmont, 50, 1, player)
					setElementData(zakuty,"player:kajdankiCAR",true)
--					outputChatBox(""..seat,root)
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










