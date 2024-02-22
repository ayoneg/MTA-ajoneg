--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt organizacji.
]]--

addEventHandler("onResourceStart", root, function() 
local players=getElementsByType('player')
    for _, p in pairs(players) do
        bindKey(p, "o", "down", "chatbox", "organizacja")
    end
end)

addEventHandler("onPlayerSpawn", getRootElement(),function (_)
	bindKey(source, "o", "down", "chatbox", "organizacja")
end)
-----  -----  -----  -----  -----  -----  -----  -----

addEvent("pokazLogiBankORG", true)
addEventHandler("pokazLogiBankORG", root, function(client)
    local plr_orgID = getElementData(client,"player:orgID") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_logibankomat WHERE orgbank_orgid='"..plr_orgID.."' ORDER BY orgbank_id DESC LIMIT 100")
	if result and #result > 0 then
	local orgcash = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..plr_orgID.."' LIMIT 1")	
	local cashe = orgcash[1].org_bankocash;
		triggerClientEvent(client, "pokazLogiBankORGnow", root, result,cashe)
	end
end)


addEvent("wybUseraDaneBankoORG", true)
addEventHandler("wybUseraDaneBankoORG", root, function(uid,row)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..uid.."' LIMIT 1")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazUserNameBankORG", root, result[1].user_nickname,row)
	end
end)

addEvent("wplacKwoteBankoORG", true)
addEventHandler("wplacKwoteBankoORG", root, function(plr_id,plr_orgID,org_cash,org_desc,plr)
	if plr_orgID > 0 then
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-'"..org_cash.."' WHERE user_id='"..plr_id.."'")
		takePlayerMoney(plr, org_cash)
		local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_bankocash=org_bankocash+'"..org_cash.."' WHERE org_id='"..plr_orgID.."'") 
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_logibankomat SET orgbank_desc='"..org_desc.."', orgbank_userid='"..plr_id.."', orgbank_orgid='"..plr_orgID.."', orgbank_data=NOW(), orgbank_cash='"..org_cash.."', orgbank_value='0'"); -- 0 wplata na konto
		local money = string.format("%.2f", org_cash/100)
		outputChatBox("#388E00✔#e7d9b0 Przekazano #388E00"..money.."$#e7d9b0 na konto organizacji.", plr,231, 217, 176,true)
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..plr_id.."', lbank_touserid = '22', lbank_kwota='"..org_cash.."', lbank_data=NOW(), lbank_desc='Przelew na konto organizacji "..getElementData(plr,"player:orgNAME")..".', lbank_type='1'");
	end
end)

addEvent("wyplacKwoteBankoORG", true)
addEventHandler("wyplacKwoteBankoORG", root, function(plr_id,plr_orgID,org_cash,org_desc,plr)
	if plr_orgID > 0 then
	local plr_orgRANK = getElementData(plr,"player:orgRank") or 0;
	if plr_orgRANK == 1 then
		local org = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..plr_orgID.."'");
		local org_cashDB = org[1].org_bankocash;
		if org_cashDB < tonumber(org_cash) then
			outputChatBox("#841515✖#e7d9b0 Błąd, bankomat organizacji nie posiada takiej kwoty.",plr,231, 217, 176,true)
			return
		end
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+'"..org_cash.."' WHERE user_id='"..plr_id.."'")
		givePlayerMoney(plr, org_cash)
		local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_bankocash=org_bankocash-'"..org_cash.."' WHERE org_id='"..plr_orgID.."'") 
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_logibankomat SET orgbank_desc='"..org_desc.."', orgbank_userid='"..plr_id.."', orgbank_orgid='"..plr_orgID.."', orgbank_data=NOW(), orgbank_cash='"..org_cash.."', orgbank_value='1'"); -- 0 wplata na konto
		local money = string.format("%.2f", org_cash/100)
		outputChatBox("#388E00✔#e7d9b0 Wypłacono #388E00"..money.."$#e7d9b0 z konta organizacji.", plr,231, 217, 176,true)
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..plr_id.."', lbank_kwota='"..org_cash.."', lbank_data=NOW(), lbank_desc='Przelew z konta organizacji "..getElementData(plr,"player:orgNAME")..".', lbank_type='1'");
	end
	end
end)

-----  -----  -----  -----  -----  -----  -----  -----

function orgChat(plr,cmd, ...)
    local tresc = table.concat(arg," ")
	local moja_org = getElementData(plr, "player:orgID") or 0;
	if moja_org == 0 then
	    outputChatBox('* Aby napisać coś na czacie organizacji, najpierw musisz do niej należeć.', plr)
	return end
	if getElementData(plr,"zakazy:mute") then
		outputChatBox("Posiadasz nałożoną blokadę wyciszenia.",plr, 255,0,0)
		outputChatBox("Blokada wygasa: ".. getElementData(plr, "zakazy:mute"),plr, 255,0,0)
		return 
	end
	local moja_org_name = getElementData(plr, "player:orgShortNAME");
	local colorg = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..moja_org.."'");
	local org_color = colorg[1].org_colorHEX;
	local org_color = "#"..org_color;
	local players=getElementsByType('player')
	for i, v in pairs(players) do
		local id = getElementData(v,"id")
		local plr_org = getElementData(v,"player:orgID") or 0;
	    if tonumber(plr_org) == tonumber(moja_org) then
			outputChatBox(""..org_color..""..moja_org_name..">#ffffff " .. getPlayerName(plr) .. "(" .. getElementData(plr,"id") .. "): #e6e6e6" .. tresc, v, _, _, _, true)
			playSoundFrontEnd(v,33)
		end
	end
	
    local transfer_text=('[CHAT:ORG] '..moja_org_name..'> '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' '..tresc)	
	outputServerLog(transfer_text)
	
	local desc22 = "ORG "..moja_org_name.." "..getPlayerName(plr).."/"..getElementData(plr,"id")..": "..tresc:gsub("#%x%x%x%x%x%x","")..""
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))

end
addCommandHandler("organizacja", orgChat)

-----  -----  -----  -----  -----  -----  -----  -----

function pokalisteczlonkoworgbyku(client)
    local plr_orgID = getElementData(client,"player:orgID") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_czlonkowie WHERE orguser_orgid='"..plr_orgID.."'")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazListeCzlonkowOrgNOW", root, result)
	end
end
addEvent("pokazListeCzlonkowOrg", true)
addEventHandler("pokazListeCzlonkowOrg", root, pokalisteczlonkoworgbyku)


function wybUsera(uid,row)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..uid.."' LIMIT 1")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazUserName", root, result[1].user_nickname,row,result[1].user_lastlogindata)
	end
end
addEvent("wybUseraDane", true)
addEventHandler("wybUseraDane", root, wybUsera)

function wybUsera2(uid,row)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..uid.."' LIMIT 1")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazUserNameData", root, result[1].user_lastlogindata,row)
	end
end
addEvent("wybUseraDaneData", true)
addEventHandler("wybUseraDaneData", root, wybUsera2)

function wybUseraORG(rid,row,plr)
    local plr_orgID = getElementData(plr,"player:orgID") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_rangi WHERE orgrank_orgid='"..plr_orgID.."' AND orgrank_value='"..rid.."' LIMIT 1")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazUserORGName", root, result[1].orgrank_name,row)
	end
end
addEvent("wybOrgUserDane", true)
addEventHandler("wybOrgUserDane", root, wybUseraORG)

-----  -----  -----  -----  -----  -----  -----  -----

function pokalisterang(plr)
    local plr_orgID = getElementData(plr,"player:orgID") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_rangi WHERE orgrank_orgid='"..plr_orgID.."'")
	if result and #result > 0 then
		triggerClientEvent(plr, "pokaListeRangNOW", root, result)
	end
end
addEvent("pokazListeRangORG", true)
addEventHandler("pokazListeRangORG", root, pokalisterang)


function zmianaRangiUseraORG(plr,userUID,rankID)
    local plr_orgID = getElementData(plr,"player:orgID") or 0;
	if tonumber(plr_orgID) > 0 then
	local plr_orgRANK = getElementData(plr,"player:orgRank") or 0;
	if plr_orgRANK == 1 or plr_orgRANK == 2 then
	
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_czlonkowie WHERE orguser_orgid='"..plr_orgID.."' AND orguser_userid='"..userUID.."' LIMIT 1");
	local wyb_plrRank = result[1].orguser_rank;
	if result and wyb_plrRank == 1 then
		outputChatBox("* Nie można edytować rangi lidera organizacji.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if result and wyb_plrRank == 2 and plr_orgRANK ~= 1 then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if result and wyb_plrRank == 2 and rankID < 2 then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if result and wyb_plrRank ~= 2 and rankID == 2 and plr_orgRANK ~= 1 then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	--[[
	if tonumber(rankID) == result[1].orguser_rank then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if 1 <= rankID then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if tonumber(plr_orgRANK) > result[1].orguser_rank then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	]]
	if tonumber(rankID) == 1 then return end
--	outputChatBox("moje perm: ("..plr_orgRANK..") / ("..result[1].orguser_rank..") nadana ranga: "..rankID,root)
	
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje_czlonkowie SET orguser_rank='"..rankID.."' WHERE orguser_userid='"..userUID.."'") 
	
	outputChatBox("* Pomyślnie edytowano członka organizacji.",plr)
	pokalisteczlonkoworgbyku(plr) -- refrsh listy
	
	local user = sprOnline(userUID);
	if user then
		outputChatBox("(( Twoja przynależność w organizacji została zmieniona. ))", user)
		setElementData(user,"player:orgRank",rankID);
	end

	triggerClientEvent(plr, "zamknijPanelZarOrg", root);
	end
	end
end
addEvent("zmianaRangiUseraORG", true)
addEventHandler("zmianaRangiUseraORG", root, zmianaRangiUseraORG)

function wyslijZapkeDoORG(plr, adduser_ID)
if tonumber(adduser_ID) > 0 and plr then
	local user = sprOnlineID(adduser_ID) or false;
	if user then
		local user_id = getElementData(user,"player:dbid") or 0;
		local wymg_godziny = 30; -- 30h
		local result0 = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..user_id.."' LIMIT 1")
		if #result0 == 0 then -- gdyby jednak
			outputDebugString("Błąd, niepoprawne UID GRACZA, nie ma w bazie >> "..getPlayerName(user)) -- test
			return
		end
		local user_godziny = string.format("%.2f", result0[1].user_minuty/60)
		local user_godziny = math.floor(user_godziny)
		if tonumber(user_godziny) < tonumber(wymg_godziny)  then 
			outputChatBox("* Gracz nie posiada wymaganej ilości godzin aby dołączyć.",plr,255,0,0)
			return
		end
		local user_orgID = getElementData(user,"player:orgID") or 0;
		if tonumber(user_orgID) > 0 then 
			outputChatBox("* Gracz znajduje się już w organizacji.",plr,255,0,0)
			return
		end
		local orgID = getElementData(plr,"player:orgID");
		local orgNAME = getElementData(plr,"player:orgNAME");
		outputChatBox("* Wysłano zaproszenie do organizacji do "..getPlayerName(user).."/"..getElementData(user,"id")..".", plr)
		
		outputChatBox("* Otrzymałeś/aś zaproszenie do organizacji "..orgNAME..".", user)
		outputChatBox("* Aby dołączyć wpisz /akceptuj "..orgID.."", user)
		
		setElementData(user,"player:orgJOINid",orgID)
	end
end -- vasr
end
addEvent("wyslijZapkeDoORG", true)
addEventHandler("wyslijZapkeDoORG", root, wyslijZapkeDoORG)

function kickTypazORG(plr, adduser_ID)
	local user = sprOnline(adduser_ID) or false;
	local orgID = getElementData(plr,"player:orgID") or 0;
	if tonumber(orgID) > 0 then
	local mojePERM = getElementData(plr,"player:orgRank") or 0;
	if mojePERM == 1 or mojePERM == 2 then
	
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_czlonkowie WHERE orguser_orgid='"..orgID.."' AND orguser_userid='"..adduser_ID.."' LIMIT 1");
	local wyb_plrRank = result[1].orguser_rank;
	if result and wyb_plrRank == 1 then
		outputChatBox("* Nie można wykopać lidera organizacji.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end
	if result and wyb_plrRank == 2 and mojePERM ~= 1 then
		outputChatBox("* Nie możesz promować członków na tę rengę.",plr, 255,0,0)
		triggerClientEvent(plr, "zamknijPanelZarOrg", root)
		return 
	end	

	if user then
		outputChatBox("(( Twoja przynależność w organizacji została zmieniona. ))", user)
		removeElementData(user,"player:orgID")
		removeElementData(user,"player:orgNAME")
		removeElementData(user,"player:orgShortNAME")
		removeElementData(user,"player:orgRank")
	end
	local query = exports["aj-dbcon"]:upd("DELETE FROM server_organizacje_czlonkowie WHERE orguser_userid='"..adduser_ID.."'") 
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_czlonkowie=org_czlonkowie-1 WHERE org_id='"..orgID.."'") 
	
	outputChatBox("* Pomyślnie usunięto członka organizacji.", plr)
	pokalisteczlonkoworgbyku(plr)
	end
	end
end
addEvent("kickTypazORG", true)
addEventHandler("kickTypazORG", root, kickTypazORG)

function akceptujZape(plr,cmd,orgID)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
		local sprZAPE = getElementData(plr,"player:orgJOINid") or 0;
		if sprZAPE > 0 then
--			local query = exports["aj-dbcon"]:upd("INSER INTO server_organizacje_czlonkowie SET orguser_rank='4', orguser_userid='"..userUID.."', ") 
			if tonumber(sprZAPE) == tonumber(orgID) then
				outputChatBox("(( Twoja przynależność w organizacji została zmieniona. ))", plr)
				
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_rangi WHERE orgrank_orgid='"..orgID.."' ORDER BY orgrank_value DESC")
				local first_rank = result[1].orgrank_value;
				
				local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..orgID.."'")
				local org_name = result2[1].org_name;
				local org_shortname = result2[1].org_shortname;
				
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_czlonkowie SET orguser_rank='"..first_rank.."', orguser_orgid='"..orgID.."', orguser_userid='"..plr_id.."', orguser_joindata=NOW()") 
				
				local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_czlonkowie=org_czlonkowie+1 WHERE org_id='"..orgID.."'") 
				
				setElementData(plr,"player:orgID",orgID)
				setElementData(plr,"player:orgNAME",org_name)
				setElementData(plr,"player:orgShortNAME",org_shortname)
				setElementData(plr,"player:orgRank",first_rank); -- 4 def 
				
				removeElementData(plr,"player:orgJOINid")
			end
		end
	end
end
addCommandHandler("akceptuj", akceptujZape, false, false)

function wyjdzzORG(plr,cmd)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
		local plr_orgID = getElementData(plr,"player:orgID") or 0;
		if plr_orgID > 0 then
			local plr_orgRANK = getElementData(plr,"player:orgRank") or 0;
			if plr_orgRANK > 0 then
				if plr_orgRANK ~= 1 then -- inne niz jeden, poniewaz 1=lider
					outputChatBox("* Opuściłeś organizacje "..getElementData(plr,"player:orgNAME").." ("..getElementData(plr,"player:orgShortNAME")..")", plr)
					
					local query = exports["aj-dbcon"]:upd("DELETE FROM server_organizacje_czlonkowie WHERE orguser_userid='"..plr_id.."'") 
					local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_czlonkowie=org_czlonkowie-1 WHERE org_id='"..plr_orgID.."'") 
					
					removeElementData(plr,"player:orgID")
					removeElementData(plr,"player:orgNAME")
					removeElementData(plr,"player:orgShortNAME")
					removeElementData(plr,"player:orgRank")
				else
					outputChatBox("* Lider nie może opuścić organizacji.", plr, 255,0,0)
				end
			end
		end
	end
end
addCommandHandler("opuscorganizacje", wyjdzzORG, false, false)

function sprOnline(uid)
	for i, us in ipairs(getElementsByType("player")) do
	local plr_uid = getElementData(us,"player:dbid") or 0;
	if plr_uid > 0 then
		if tonumber(plr_uid) == tonumber(uid) then
			return us
		end
	end
	end
end

function sprOnlineID(id)
	for i, us in ipairs(getElementsByType("player")) do
	local plr_id = getElementData(us,"id") or 0;
	if plr_id > 0 then
		if tonumber(plr_id) == tonumber(id) then
			return us
		end
	end
	end
end







