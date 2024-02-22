--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt STREFY DM BETA.
]]--

local antyspam = {}

local dmss = createColCuboid(2053.462890625, -1398.0859375, 23.804122924805-10, 600, 460, 77)
local strefaDM = createRadarArea(2053.462890625, -1398.085937, 600, 460, 0, 0, 0, 125, root)

function dmconf(var,player)
	toggleControl(player, "fire", var) 
	toggleControl(player, "action", var)
	toggleControl(player, "aim_weapon", var)
end

addEventHandler("onColShapeHit", dmss, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
	outputChatBox("#7AB4EAⒾ#e7d9b0 Wkroczyłeś na strefę bezprawia, wchodzisz na własne ryzyko!", el,231, 217, 176,true)
	setElementData(el,"player:dmSTREFA",true)
	dmconf(true,el)
end)

addEventHandler("onColShapeLeave", dmss, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
	outputChatBox("#7AB4EAⒾ#e7d9b0 Opuszczasz strefę bezprawia.", el,231, 217, 176,true)
	removeElementData(el,"player:dmSTREFA")
	dmconf(false,el)
end)
--[[
addEventHandler("onPlayerWeaponFire", root, function(weapon,_,_,_,el,_,_,_)
    if not source then return end
    if not el then cancelEvent() return end
    if getElementType(el) == "player" then
        local strefadm = getElementData(source,"player:dmSTREFA") or false;
		local strefadm2 = getElementData(el,"player:dmSTREFA") or false;
		if not strefadm2 then
			local tresc = "Bugowanie strefy DM.";
			triggerClientEvent("onPlayerWarningReceived", source, tresc)
--			triggerClientEvent(root, "admin:rendering", root, getPlayerName(source):gsub("#%x%x%x%x%x%x","").." otrzymał/a ostrzeżenie od Konsola-0A, powód: "..tresc.."")
--			outputConsole(getPlayerName(source):gsub("#%x%x%x%x%x%x","").." otrzymał/a ostrzeżenie od Konsola-0A, powód: "..tresc.."")
		end
	end
end)
]]--

addEvent("nadajGraczowiDMShop", true)
addEventHandler("nadajGraczowiDMShop",resourceRoot,function(plr,cena,ID)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local plr_money = getPlayerMoney(plr)
		if tonumber(plr_money) >= tonumber(cena) then
			-- gut, zgadza się
			if tostring(ID) == "HP1" then
				local hp = getElementHealth(plr)
				setElementHealth(plr, hp+66)
			elseif tostring(ID) == "HP2" then
				local hp = getElementHealth(plr)
				setElementHealth(plr, hp+100)
			elseif tostring(ID) == "DEAGLE" then
				if giveWeapon(plr,24,50,true) then
					desc22 = ">>> "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").." kupuje "..getWeaponNameFromID(24).." na strefie DM.";
					triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
				end
			end
			
			takePlayerMoney(plr, cena)
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-'"..cena.."' WHERE user_id=?",uid);
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cena.." WHERE user_id = '22'"); -- zapis
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='"..uid.."', lbank_touserid='22', lbank_kwota='"..cena.."', lbank_data=NOW(), lbank_desc='Zakup w sklepie DM.', lbank_type='1'");
			outputChatBox("#7AB4EAⒾ#e7d9b0 Zakupiono przedmiot!", plr,231, 217, 176,true)
		else
			-- brak siana
			outputChatBox("#7AB4EAⒾ#e7d9b0 Nie posiadasz tyle gotówki!", plr,231, 217, 176,true)
		end
	end
end)

-------------------------------------------------------

function stopTEST(plr)
	setPedAnimation(plr, false)
	setElementFrozen(plr, false)
end

function autoSTOP(plr)
    setElementFrozen(plr, true)
    setPedAnimation ( plr, "CRACK", "crckidle2", -1, true, false )
	setTimer(stopTEST, 7000, 1, plr)
end

local times = 0
local run = false

addCommandHandler("root.zadyma", function(plr,cmd)
    if getElementData(plr,"admin:poziom") >= 10 then
        if getElementData(plr,"admin:zalogowano") == "true" then
			if not run then
				times = math.random(45,75)
				run = true
				explodeTT()
			else
				outputChatBox("#7AB4EAⒾ#e7d9b0 Trzęsienie ziemi, aktualnie trwa.", plr,231, 217, 176,true)
			end
        end
    end
end)

function explodeTT()
	if times > 0 then
		times = times - 1
		for i,v in ipairs(getElementsByType("player")) do
	        local x,y,z = getElementPosition(v)
			triggerClientEvent("createBigExplosion",root,v,x,y,z)
		end
		setTimer(explodeTT, math.random(20,1000), 1)
--		outputChatBox("#7AB4EAⒾ#e7d9b0 Times: "..times, root,231, 217, 176,true)
	else
		run = false
	end
end

------------------

function zgasogien()
    object=getElementsByType('object')
    for i,v in pairs(object) do
		local obj = getElementData(v,"FIRE") or false;
		if obj then
			sphare = getElementData(v,"FIRE")
			destroyElement(sphare)
			destroyElement(v)
		end
    end		
end
--setTimer(zgasogien, 6000, 0) -- co 10 min (600000)

addCommandHandler("fire", function(plr,cmd)
    if getElementData(plr,"admin:poziom") >= 6 then
        if getElementData(plr,"admin:zalogowano") == "true" then
			local x,y,z = getElementPosition(plr)
			for i=0, 8 do
				rand1 = math.random(-5,5)
				rand2 = math.random(-5,5)
				obj=createObject(math.random(1912,1914),x+rand1,y+rand2,z-0.6)
				sphr=createColSphere(x+rand1,y+rand2,z, 1.4)
				setElementCollisionsEnabled(obj, false)
				setElementData(obj,"FIRE",sphr)
				setElementData(sphr,"FIRE",true)
				setElementDimension(sphr, 0)
				setElementInterior(sphr, 0)
			end
			if isTimer(czasfire) then killTimer(czasfire) end
			czas = 60000 * 60 * 1.5; -- 1.5h
			czasfire = setTimer(zgasogien, czas, 1)
        end
    end
end)


function delSphare(ID)
    sphare=getElementsByType('colshape')
    for i,v in pairs(sphare) do
		local obj = getElementData(v,"FIRE") or false;
		if obj and obj == ID then
		    destroyElement(v)
		end
    end	
end

local blokadatest = {}

-- usuwanie
addEvent("removeFireFromWorld", true)
addEventHandler("removeFireFromWorld",resourceRoot,function(element,plr)
	if blokadatest[element] and getTickCount() < blokadatest[element] then return end
	if element then
		blokadatest[element] = getTickCount()+10000;
		local fire = getElementData(element,"FIRE") or false;
		destroyElement(fire)
--		delSphare(fire)
		destroyElement(element)
		
		local uid = getElementData(plr,"player:dbid") or 0;
		if uid > 0 then
			local plr_money = getPlayerMoney(plr)
			cena = 1260 -- 12,60$ za płomyk
			calosc = plr_money + cena;
			if calosc > 99999999 then return end
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+'"..cena.."' WHERE user_id=?",uid);
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cena.." WHERE user_id = '22'"); -- zapis
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='22', lbank_touserid='"..uid.."', lbank_kwota='"..cena.."', lbank_data=NOW(), lbank_desc='Gaszenie płomieni.', lbank_type='1'");
			givePlayerMoney(plr, cena)
		end
		
	end
end)

--[[
addEventHandler("onPlayerWeaponFire", root, function(weapon,endX,endY,endZ,hitElement)
--    if source~=localPlayer then return end
    if weapon ~= 42 then return end
	outputChatBox("gasze ...",root)

    if not hitElement then return end
    if getElementType(hitElement) == "colshape" then
	    local fire = getElementData(hitElement,"FIRE") or false;
		if fire then
			local RNG = math.random(0,1000)
			if RNG >= 0 and RNG < 150 then -- 15%
--				triggerServerEvent("removeFireFromWorld",resourceRoot,el)
				outputChatBox("gasze ...",root)
			end
		end
	end

end)
]]
-- podpalenie
addEventHandler("onColShapeHit", root, function(el,md)
	if not md or not el then return end
    if getElementType(el) ~= "player" then return end
	local fire = getElementData(source,"FIRE") or false;
	if fire then
		setPedOnFire(el, true)
	end
end)


--------------

addCommandHandler("killslog",function(plr,cmd)
	if getElementData(plr,"admin:poziom") >= 5 then
    	if getElementData(plr,"admin:zalogowano") == "true" then
			local configPP = getElementData(plr,"admin:noticeKILL") or false;
			if configPP then
				setElementData(plr,"admin:noticeKILL",false)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Wyłączono powiadomienia zgonów.", plr,231, 217, 176,true)
			else
				setElementData(plr,"admin:noticeKILL",true)
				outputChatBox("#7AB4EAⒾ#e7d9b0 Włączono powiadomienia zgonów.", plr,231, 217, 176,true)
			end
		end
	end
end)

function notiOnChat(plr_k,plr_d,ID)
    for i,v in ipairs(getElementsByType("player")) do
		local uid = getElementData(v,"player:dbid") or 0;
		if uid > 0 then
			local admDUTY = getElementData(v, "admin:zalogowano") or "false";
			if admDUTY == "true" then
				local admLVL = getElementData(v, "admin:poziom") or 0;
				local configPP = getElementData(v, "admin:noticeKILL") or false;
				if admLVL >= 5 and configPP then
					if getWeaponNameFromID(ID) then
						outputChatBox("* "..getPlayerName(plr_k).." zabił/a gracza "..getPlayerName(plr_d)..", przy pomocy "..getWeaponNameFromID(ID)..".", v,255, 0, 0)
					else
						outputChatBox("* "..getPlayerName(plr_k).." zabił/a gracza "..getPlayerName(plr_d)..", przy pomocy ???.", v,255, 0, 0)
					end
				end
			end
		end
    end
end

addEventHandler("onPlayerWasted", root,function(totalAmmo,killer,killerWeapon,bodypart,stealth)
	-- naliczanie punktów killsów
	if killer then
	if getElementType(killer) == "vehicle" then
	    local kierowca = getVehicleOccupant(killer) or false;
		if kierowca then 
			killer = kierowca 
			pojazd = true
		else
			killer = source
			notiOnChat(killer,source,killerWeapon)
			return
		end
	else
	    killer = killer
		pojazd = false
	end
	
	if (getElementType(killer) == "player") and source ~= killer then
        local strefadm = getElementData(source,"player:dmSTREFA") or false;
		local strefadm2 = getElementData(killer,"player:dmSTREFA") or false;
		if not strefadm and strefadm2 then
			local tresc = "Bugowanie strefy DM.";
			triggerClientEvent("onPlayerWarningReceived", killer, tresc)
			local hppl = getElementHealth(source)
			setElementHealth(source,hppl+1)
			dmconf(false,killer)
			
			autoSTOP(killer)
			-- ucho notice
	    	local desc22 = "BUGOWANIE DM "..getPlayerName(killer).."/"..getElementData(killer,"id").." strefa DM Los Santos."
	    	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
			
			if antyspam[killer] and getTickCount() < antyspam[killer] then return end
			
			local text="Bugowanie DM / Strefa DMLS"
			desc=""..getPlayerName(killer):gsub("#%x%x%x%x%x%x","").."/"..getElementData(killer,"id").." - "..text:gsub("#%x%x%x%x%x%x","").." - Auto Report"
			triggerEvent("admin:addReport", resourceRoot, desc, getElementData(killer,"id"))
			
			antyspam[killer] = getTickCount()+10000; -- 10 sek zabezpieczenia
		end
	end
	
	if source ~= killer and not pojazd then
		local uid = getElementData(killer,"player:dbid") or 0;
		if uid > 0 then
			local code = "STREFA-DM";
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code='"..code.."', joblog_data=NOW(), joblog_value='1', joblog_userid='"..uid.."'");
			notiOnChat(killer,source,killerWeapon)
		end
	end
	-- kicak z serwera za kill autem
	if source ~= killer and pojazd then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(killer):gsub("#%x%x%x%x%x%x","").." został/a wykopany/a za zabójstwo pojazdem.")
		outputConsole(getPlayerName(killer):gsub("#%x%x%x%x%x%x","").." został/a wykopany/a za zabójstwo pojazdem.")
    	local transfer_text=('[KARY:KICK] Konsola >> kick  '..getPlayerName(killer):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(killer,"player:dbid")..' (zabójstwo pojazdem)')	
		outputServerLog(transfer_text)
		notiOnChat(killer,source,killerWeapon)
		kickPlayer(killer, "Zabójstwo pojazdem.")
	end
	
	else
		killer = source
		notiOnChat(killer,source,killerWeapon)
	end
end)


addEventHandler("onPlayerDamage", root, function(attacker, weapon, bodypart, loss)
    if not attacker then return end
    if attacker ~= source then
        local strefadm = getElementData(source,"player:dmSTREFA") or false;
		local strefadm2 = getElementData(attacker,"player:dmSTREFA") or false;
		if not strefadm and strefadm2 then
			local tresc = "Bugowanie strefy DM.";
			triggerClientEvent("onPlayerWarningReceived", attacker, tresc)
			local hppl = getElementHealth(source)
			setElementHealth(source,hppl+1)
			dmconf(false,attacker)
			
			autoSTOP(attacker)
			-- ucho notice
	    	local desc22 = "BUGOWANIE DM "..getPlayerName(attacker).."/"..getElementData(attacker,"id").." strefa DM Los Santos."
	    	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
			
			if antyspam[attacker] and getTickCount() < antyspam[attacker] then return end
			
			local text="Bugowanie DM / Strefa DMLS"
			desc=""..getPlayerName(attacker):gsub("#%x%x%x%x%x%x","").."/"..getElementData(attacker,"id").." - "..text:gsub("#%x%x%x%x%x%x","").." - Auto Report"
			triggerEvent("admin:addReport", resourceRoot, desc, getElementData(attacker,"id"))
			
			antyspam[attacker] = getTickCount()+10000; -- 10 sek zabezpieczenia
		end
	end
end)






