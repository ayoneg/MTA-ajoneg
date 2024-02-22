--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--

-----------------------------------------------------------------
-----------------------------------------------------------------
function pokazegzaminyum(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_egzaminyum WHERE egzamin_value=1");
	triggerClientEvent(client, "pokazEgzaminyUM", root, result)
end
addEvent("wyslijZapytanieOEGZAMINY", true)
addEventHandler("wyslijZapytanieOEGZAMINY", root, pokazegzaminyum)


addEvent("udzielonaODPsprSERW", true)
addEventHandler("udzielonaODPsprSERW", root, function(value,plr)
	local uid = getElementData(plr,"player:dbid")
	if not uid then return end
	local id = getElementData(plr,"egzaminUM:postep") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_egzaminyum_lista WHERE el_id=? AND el_trueODP=?",id,value);
	if #result > 0 then
		postep = id + 1
		setElementData(plr,"egzaminUM:postep",postep)
		points = getElementData(plr,"egzaminUM:points")
		points = points + 1
		setElementData(plr,"egzaminUM:points",points)
		wybquestegzmain(plr)
	else
		postep = id + 1
		setElementData(plr,"egzaminUM:postep",postep)
		wybquestegzmain(plr)
	end
end)

function wybquestegzmain(plr)
	if plr then
		local uid = getElementData(plr,"player:dbid") or 0;
		if uid > 0 then
			local id = getElementData(plr,"egzaminUM:postep") or 0;
			local exid = getElementData(plr,"egzaminUM:exmID") or 0;
			local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_egzaminyum_lista WHERE el_id=? AND el_egzaminID=?",id,exid);
			if #result > 0 then
				
				-- tablica pytan
				local tresc = result[1].el_pytanie;
				local odpA = result[1].el_odpA;
				local odpB = result[1].el_odpB;
				local odpC = result[1].el_odpC;
				local odpD = result[1].el_odpD;
				
				triggerClientEvent(plr, "startEgzaminUM", root, plr, tresc, odpA, odpB, odpC, odpD, id, exid)
			else
				local exid = getElementData(plr,"egzaminUM:exmID") or 0;
				local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_egzaminyum WHERE egzamin_id=?",exid);
				postep = result2[1].egzamin_minQue
				
				points = getElementData(plr,"egzaminUM:points") or 0;
				
				if points >= postep then
					local zapytanie = result2[1].egzamin_zapytanie
					local postep = result2[1].egzamin_minQue
					points = points * 10
					outputChatBox(" ",plr)
					outputChatBox("* Egzamin ukończony pomyślnie z wynikiem "..points.."%.",plr)
					if tostring(zapytanie)~="none" then
						local query = exports["aj-dbcon"]:upd("UPDATE server_users SET "..zapytanie.." WHERE user_id=?",uid);
					end
					code = "UM-"..exid;
					local querywy = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code=?, joblog_value=?, joblog_data=NOW(), joblog_userid=?",code,1,uid);
				else
					points = points * 10
					outputChatBox(" ",plr)
					outputChatBox("* Koniec egzaminu, oblałeś z wynikiem "..points.."%.",plr,255,0,0)
				end
				--czyszcze cashe
				removeElementData(plr,"egzaminUM:points")
				removeElementData(plr,"egzaminUM:postep")
				removeElementData(plr,"egzaminUM:exmID")
				triggerClientEvent(plr, "zamknijEgzaminNOW", root, plr)
			end
		end
	end
end

function werfikacjaegzaminowitp(value,cost,plr)
	local uid = getElementData(plr,"player:dbid")
	if not uid then return end
	local money = getPlayerMoney(plr)
	code = "UM-"..value;
	local querywy = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_code=? AND joblog_value=? AND joblog_userid=?",code,1,uid);
	if #querywy > 0 then
		outputChatBox(" ",plr)
		outputChatBox("* Zaliczyłeś już ten egzamin "..(querywy[1].joblog_data)..".",plr)
		return
	end	
	if money >= cost then
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cost.." WHERE user_id = '"..uid.."'");
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..uid.."', lbank_touserid = '22', lbank_kwota='"..cost.."', lbank_data=NOW(), lbank_desc='Opłata za egzamin urzędowy.', lbank_type='1'");
		takePlayerMoney(plr, cost)
			
		startex = 1 + 10*(value -1)
		setElementData(plr,"egzaminUM:postep",startex)
		setElementData(plr,"egzaminUM:points",0)
		setElementData(plr,"egzaminUM:exmID",value)
		
		wybquestegzmain(plr)
	else
		outputChatBox(" ",plr)
		outputChatBox("* Nie posiadasz wymaganej ilości gotówki.",plr,255,0,0)
	end
end
addEvent("sprawdzEgzaminyZacznij", true)
addEventHandler("sprawdzEgzaminyZacznij", root, werfikacjaegzaminowitp)
-----------------------------------------------------------------
-----------------------------------------------------------------

function odswiezaaam_33ddd(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner = '"..uid.."'");
	triggerClientEvent(client, "pokazPojazdyOrg", root, result)
end
addEvent("wyslijZapytanieOPojazdy", true)
addEventHandler("wyslijZapytanieOPojazdy", root, odswiezaaam_33ddd)

function quickRefresh(gtID,orgID)
	for i, v in ipairs(getElementsByType("vehicle")) do
		local veh_id = getElementData(v, "vehicle:id") or 0;
	    if veh_id==gtID then
			setElementData(v,"vehicle:groupowner",orgID)
		end
	end
end

function przepiszPojNaORG(car_id,value,plr)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
	local plr_orgID = getElementData(plr,"player:orgID") or 0;
		if tonumber(car_id) > 0 then
			if tonumber(value) > 0 then -- czyli juz jest na org
				local result = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_groupowner='0' WHERE veh_id='"..car_id.."'")
				outputChatBox("#388E00✔#e7d9b0 Pomyślnie odpisano pojazd z organizacji.", plr,231, 217, 176,true)
				quickRefresh(car_id,plr_orgID)--dodac var z org
			else
				local result = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_groupowner='"..plr_orgID.."' WHERE veh_id='"..car_id.."'")
				outputChatBox("#388E00✔#e7d9b0 Pomyślnie przepisano pojazd na organizacje.", plr,231, 217, 176,true)
				quickRefresh(car_id,plr_orgID)
			end
				odswiezaaam_33ddd(plr) -- odswiez
		end
	end
end

addEvent("przepiszPojNaORG", true)
addEventHandler("przepiszPojNaORG", root, przepiszPojNaORG)

-----------------------------------------------------------------
-----------------------------------------------------------------
-- panel org
local wymg_godziny = 50;


function pokazujeListeeee(client)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje")
	if result and #result > 0 then
		triggerClientEvent(client, "pokazListeOdswiezonaORG", root, result)
	end
end

addEvent("pokazListeOrg", true)
addEventHandler("pokazListeOrg", root, pokazujeListeeee)


function sprOrgV2Edit(plr, org_name, org_shortname, org_pageurl, org_hexcolor, org_lidername, org_vicelidername, org_czlonek, org_rekrut, org_desc, cena_org)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
	local orgID = getElementData(plr,"player:orgID") or 0;
	local result0 = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id=? LIMIT 1",plr_id)
	if #result0 == 0 then -- gdyby jednak
		outputDebugString("Błąd, niepoprawne UID GRACZA, nie ma w bazie >> "..getPlayerName(plr)) -- test
		return
	end
	local plr_godziny = string.format("%.2f", result0[1].user_minuty/60)
	local plr_godziny = math.floor(plr_godziny)
	if tonumber(plr_godziny) < tonumber(wymg_godziny)  then 
		outputChatBox("* Nie posiadasz wymaganej ilości rozegranych godzin.",plr,255,0,0)
		return
	end
	local result1 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_name=? AND org_id<>? LIMIT 1",org_name,orgID)
	if #result1 > 0 then
		outputChatBox("* Nazwa organizacji jest już używana.",plr,255,0,0)
		return
	end
	local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_shortname=? AND org_id<>? LIMIT 1",org_shortname,orgID)
	if #result2 > 0 then
		outputChatBox("* Skrót organizacji jest już używany.",plr,255,0,0)
		return
	end
	local plr_money = getPlayerMoney(plr) or 0;
	if plr_money < cena_org then
		outputChatBox("* Błąd, nie posiadasz wymaganej kwoty.",plr,255,0,0)
		outputDebugString("Błąd, próba umyślnego oszustwa??? >> "..getPlayerName(plr)) -- test
		return
	end
	-- wszystko git to edytujemy
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje SET org_name=?, org_shortname=?, org_webpage=?, org_colorHEX=?, org_desc=? WHERE org_id=?",org_name,org_shortname,org_pageurl,org_hexcolor,org_desc,orgID)
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje_rangi SET orgrank_name=? WHERE orgrank_value='1' AND orgrank_orgid=?",org_lidername,orgID) -- lider
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje_rangi SET orgrank_name=? WHERE orgrank_value='2' AND orgrank_orgid=?",org_vicelidername,orgID) -- vicelider
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje_rangi SET orgrank_name=? WHERE orgrank_value='3' AND orgrank_orgid=?",org_czlonek,orgID) -- członek
	local query = exports["aj-dbcon"]:upd("UPDATE server_organizacje_rangi SET orgrank_name=? WHERE orgrank_value='4' AND orgrank_orgid=?",org_rekrut,orgID) -- rekrut/nowy
	
	outputChatBox("#388E00✔#e7d9b0 Pomyślnie edytowano organizacje "..org_name.." ("..org_shortname..").", plr,255,255,255,true)
	takePlayerMoney(plr, cena_org)
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cena_org.." WHERE user_id = '"..plr_id.."'");
	-- tutaj bot serwerowy dostaje kase ;)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cena_org.." WHERE user_id = '22'");
	
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..plr_id.."', lbank_touserid = '22', lbank_kwota='"..cena_org.."', lbank_data=NOW(), lbank_desc='Edycja organizacji.', lbank_type='1'");
	
	local transfer_text=('[EDYCJA:ORG] user '..plr_id..' >> '..org_name..' ('..org_shortname..').')	
	outputServerLog(transfer_text)
	
	outputDebugString("edited org.: "..org_name.." - ("..org_shortname..")") -- test
	
	setElementData(plr,"player:orgNAME",org_name)
	setElementData(plr,"player:orgShortNAME",org_shortname)
	
	for i, v in ipairs(getElementsByType("player")) do -- lista czlonkow -- nadajemy nowe dane org
		local plr_org = getElementData(v, "player:orgID") or 0;
	    if plr_org==orgID then
			setElementData(v,"player:orgNAME",org_name)
			setElementData(v,"player:orgShortNAME",org_shortname)
		end
	end
	
	triggerClientEvent(plr, "zamknijPanelOrg", root)
	end -- plr db id var
end

addEvent("sprOrgCzNastepnaEdit", true)
addEventHandler("sprOrgCzNastepnaEdit", root, sprOrgV2Edit)

function sprOrgV2(plr, org_name, org_shortname, org_pageurl, org_hexcolor, org_lidername, org_vicelidername, org_czlonek, org_rekrut, org_desc, cena_org)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
	local result0 = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id=? LIMIT 1",plr_id)
	if #result0 == 0 then -- gdyby jednak
		outputDebugString("Błąd, niepoprawne UID GRACZA, nie ma w bazie >> "..getPlayerName(plr)) -- test
		return
	end
	local plr_godziny = string.format("%.2f", result0[1].user_minuty/60)
	local plr_godziny = math.floor(plr_godziny)
	if tonumber(plr_godziny) < tonumber(wymg_godziny)  then 
		outputChatBox("* Nie posiadasz wymaganej ilości rozegranych godzin.",plr,255,0,0)
		return
	end
	local result1 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_name=? LIMIT 1",org_name)
	if #result1 > 0 then
		outputChatBox("* Nazwa organizacji jest już używana.",plr,255,0,0)
		return
	end
	local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_shortname=? LIMIT 1",org_shortname)
	if #result2 > 0 then
		outputChatBox("* Skrót organizacji jest już używany.",plr,255,0,0)
		return
	end
	local plr_money = getPlayerMoney(plr) or 0;
	if plr_money < cena_org  then
		outputChatBox("* Błąd, nie posiadasz wymaganej kwoty.",plr,255,0,0)
		outputDebugString("Błąd, próba umyślnego oszustwa??? >> "..getPlayerName(plr)) -- test
		return
	end
	-- wszystko git to dodajemy
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje SET org_name=?, org_shortname=?, org_webpage=?, org_colorHEX=?, org_createdata=NOW(), org_czlonkowie='1'",org_name,org_shortname,org_pageurl,org_hexcolor)
	
	local wybORG = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_shortname=? ORDER BY org_id DESC",org_shortname) -- wybieramy nasza org
	local org_id = wybORG[1].org_id;
	
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_rangi SET orgrank_orgid=?, orgrank_name=?, orgrank_value='1'",org_id,org_lidername) -- lider
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_rangi SET orgrank_orgid=?, orgrank_name=?, orgrank_value='2'",org_id,org_vicelidername) -- vicelider
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_rangi SET orgrank_orgid=?, orgrank_name=?, orgrank_value='3'",org_id,org_czlonek) -- członek
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_rangi SET orgrank_orgid=?, orgrank_name=?, orgrank_value='4'",org_id,org_rekrut) -- rekrut/nowy
	
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_organizacje_czlonkowie SET orguser_orgid=?, orguser_userid=?, orguser_rank='1', orguser_joindata=NOW()",org_id,plr_id) -- add new czlonek
	
	outputChatBox("#388E00✔#e7d9b0 Pomyślnie utwożono organizacje "..org_name.." ("..org_shortname..").", plr,255,255,255,true)
	takePlayerMoney(plr, cena_org)
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cena_org.." WHERE user_id = '"..plr_id.."'");
	-- tutaj bot serwerowy dostaje kase ;)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cena_org.." WHERE user_id = '22'");
	
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..plr_id.."', lbank_touserid = '22', lbank_kwota='"..cena_org.."', lbank_data=NOW(), lbank_desc='Edycja organizacji.', lbank_type='1'");
	
	local transfer_text=('[EDYCJA:ORG] user '..plr_id..' >> '..org_name..' ('..org_shortname..').')	
	outputServerLog(transfer_text)
	
	outputDebugString("added new org.: "..org_name.." - ("..org_shortname..")") -- test
	
	setElementData(plr,"player:orgID",org_id)
	setElementData(plr,"player:orgNAME",org_name)
	setElementData(plr,"player:orgShortNAME",org_shortname)
	setElementData(plr,"player:orgRank",1)
	
	triggerClientEvent(plr, "zamknijPanelOrg", root)
	end -- plr db id var
end

addEvent("sprOrgCzNastepna", true)
addEventHandler("sprOrgCzNastepna", root, sprOrgV2)

function daneOrgGetNow(plr, orgID)
	local result3 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..orgID.."' LIMIT 1")
	if #result3 > 0 then
		local org_pageurl = result3[1].org_webpage;
		local org_colorHEX = result3[1].org_colorHEX;
		local org_desc = result3[1].org_desc;
		
		local result4 = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_rangi WHERE orgrank_orgid='"..orgID.."' ORDER BY orgrank_value ASC")
		
		local org_lidername = result4[1].orgrank_name;
		local org_vicelidername = result4[2].orgrank_name;
		local org_czlonek = result4[3].orgrank_name;
		local org_rekrut = result4[4].orgrank_name;
		
		triggerClientEvent(plr, "wyslinDaneOrgNow", root, org_pageurl, org_colorHEX, org_desc, org_lidername, org_vicelidername, org_czlonek, org_rekrut)
	end
end
addEvent("daneOrgEdit", true)
addEventHandler("daneOrgEdit", root, daneOrgGetNow)
-----------------------------------------------------------------
-----------------------------------------------------------------
function odswiezaaam(client,code)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_alljobs WHERE job_um=?",code)
	if result and #result > 0 then
		triggerClientEvent(client, "pokazListeOdswiezona", root, result)
	end
end

addEvent("odswiezJobs", true)
addEventHandler("odswiezJobs", root, odswiezaaam)

function sprJos(plr,code)
    local uid = getElementData(plr,"player:dbid") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_userid = '"..uid.."' AND fra_frakcjaid='"..code.."'")
	if result and #result > 0 then
	    nambtn = "Zwolnij się";
	else
		nambtn = "Zatrudnij się";	
	end
	triggerClientEvent(client, "pokazNazweButton", root, nambtn)
end
addEvent("sprTwojaJob", true)
addEventHandler("sprTwojaJob", root, sprJos)



function sprzwolnijzatrudnij(plr,code,job_name)
    local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
	local us = exports["aj-dbcon"]:wyb("SELECT * FROM server_alljobs WHERE job_code='"..code.."'")
	local userPG = getElementData(plr,"player:PG") or 0;
	local userREP = getElementData(plr,"player:reputacja") or 0;
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_userid = '"..uid.."' AND fra_frakcjaid='"..code.."'")
	if result and #result > 0 then
	    -- ZWALNIAMY SIE Z ROBOTY
	    local query = exports["aj-dbcon"]:upd("DELETE FROM server_frakcje WHERE fra_userid = '"..uid.."' AND fra_frakcjaid='"..code.."'")
		local query2 = exports["aj-dbcon"]:upd("UPDATE server_alljobs SET job_activeslot=job_activeslot-'1' WHERE job_code='"..code.."'")
		outputChatBox("#e7d9b0* Zwolniłeś/aś się z #EBB85D"..job_name.."#e7d9b0.",plr,255,255,255,true)
		-- gdyby frakcja
		removeElementData(plr,"player:jobCOLOR")
		removeElementData(plr,"player:jobCOLORfr")
		removeElementData(plr,"player:duty")
		removeElementData(plr,"player:frakcjaRANK")
		removeElementData(plr,"player:frakcjaTIME")
		removeElementData(plr,"player:frakcjaCODE")
		setElementModel(plr, getElementData(plr,"player:skinid") or 0)
		--zabieram suszara
		takeWeapon(plr, 22)
	else
		-- dopiero tutaj sprawdzamy czy mozna zatrudnic, ponieważ nie ma sensu sprawdzac jak sie zwalniamy
		if us[1].job_wymPG > userPG then 
	    	outputChatBox("#e7d9b0* Aby zatrudnić się jako #EBB85D"..job_name.."#e7d9b0, musisz posiadać conajmniej #EBB85D"..us[1].job_wymPG.." PG#e7d9b0.",plr,255,255,255,true)
	    	return 
		end
		-- sprawdzamy czy rep, jest na minus czy +
		if us[1].job_wymREP >= 0 then war="plus"; end
		if us[1].job_wymREP < 0 then war="minus"; end
		if us[1].job_wymREP > userREP and tostring(war)=="plus" then 
	    	outputChatBox("#e7d9b0* Aby zatrudnić się jako #EBB85D"..job_name.."#e7d9b0, musisz posiadać conajmniej #EBB85D"..us[1].job_wymREP.." reputacji#e7d9b0.",plr,255,255,255,true)
	    	return 
		end
		if us[1].job_wymREP < userREP and tostring(war)=="minus" then 
	    	outputChatBox("#e7d9b0* Aby zatrudnić się jako #EBB85D"..job_name.."#e7d9b0, musisz posiadać conajmniej #EBB85D"..us[1].job_wymREP.." reputacji#e7d9b0.",plr,255,255,255,true)
	    	return 
		end
		if us[1].job_activeslot >= us[1].job_maxslot then 
	    	outputChatBox("#e7d9b0* Aktualnie brak wolnych etatów jako #EBB85D"..job_name.."#e7d9b0.",plr,255,255,255,true)
	    	return 
		end
		if us[1].job_wymEXAM~="" then
			local exam = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_code='"..us[1].job_wymEXAM.."' AND joblog_userid='"..uid.."'")
			if #exam == 0 then 
				outputChatBox("#e7d9b0* Nie posiadasz zaliczonego egzaminu/kursu w urzędzie jako #EBB85D"..job_name.."#e7d9b0.",plr,255,255,255,true)
				return 
			end
		end
		-- ZATRUDNIAMY SIĘ ALE SPRAWDZAMY JESZCZE CZY NIE MA PRACY W INNYM WARSZTACIE/PRACY
		local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_userid = '"..uid.."'")
		if result2 and #result2 > 0 then
			-- jesli tak zwalniamy i nadajemy nowa robote
			local code2 = result2[1].fra_frakcjaid or 0;
			local query = exports["aj-dbcon"]:upd("UPDATE server_alljobs SET job_activeslot=job_activeslot-'1' WHERE job_code='"..code2.."'")
			local query2 = exports["aj-dbcon"]:upd("UPDATE server_alljobs SET job_activeslot=job_activeslot+'1' WHERE job_code='"..code.."'")
	    	local query3 = exports["aj-dbcon"]:upd("UPDATE server_frakcje SET fra_frakcjaid='"..code.."', fra_data=NOW() WHERE fra_userid = '"..uid.."'")
			outputChatBox("#e7d9b0* Pomyślnie zatrudniłeś/aś się jako #EBB85D"..job_name.."#e7d9b0, od teraz możesz rozpocząć pracę.",plr,255,255,255,true)
			-- gdyby frakcja
			removeElementData(plr,"player:jobCOLOR")
			removeElementData(plr,"player:jobCOLORfr")
			removeElementData(plr,"player:duty")
			removeElementData(plr,"player:frakcjaRANK")
			removeElementData(plr,"player:frakcjaTIME")
			removeElementData(plr,"player:frakcjaCODE")
			setElementModel(plr, getElementData(plr,"player:skinid") or 0)
			--zabieram suszara
			takeWeapon(plr, 22)
		else
			-- jesli NIE to nadajemy nowa robote
	    	local query = exports["aj-dbcon"]:upd("INSERT INTO server_frakcje SET fra_frakcjaid='"..code.."', fra_userid='"..uid.."', fra_poziom='1', fra_data=NOW()")
			local query2 = exports["aj-dbcon"]:upd("UPDATE server_alljobs SET job_activeslot=job_activeslot+'1' WHERE job_code='"..code.."'")
			outputChatBox("#e7d9b0* Pomyślnie zatrudniłeś/aś się jako #EBB85D"..job_name.."#e7d9b0, od teraz możesz rozpocząć pracę.",plr,255,255,255,true)
			if tostring(code)=="USM" then setElementData(plr,"player:frakcjaCODE","USM") end
		end
	end
	--triggerClientEvent(client, "pokazNazweButton", root, nambtn)
	end
end
addEvent("sprColesThere", true)
addEventHandler("sprColesThere", root, sprzwolnijzatrudnij)
-----------------------------------------------------------------
-----------------------------------------------------------------

function odswieztest(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner=?",uid);
	triggerClientEvent(client, "onClientReturn", root, result)
end

addEvent("onClientRenderNew", true)
addEventHandler("onClientRenderNew", root, function(veh_id,nowa_tablica,cena_zmiany)

	local uid = getElementData(client,"player:dbid");
	if not uid then return end

	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_owner=? AND veh_id=?",uid,veh_id);
	if #result < 0 then return end
	local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles SET veh_tablica=? WHERE veh_id=? AND veh_owner=?",nowa_tablica,veh_id,uid);
	if query then
		takePlayerMoney(client, cena_zmiany)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..cena_zmiany.." WHERE user_id = '"..uid.."'");
		-- tutaj bot dostaje całą kwote ;-)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cena_zmiany.." WHERE user_id = '22'");
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..uid.."', lbank_touserid = '22', lbank_kwota='"..cena_zmiany.."', lbank_data=NOW(), lbank_desc='Zmiana tablicy rejestracyjnej.', lbank_type='1'");
		
		outputChatBox("* Pomyślnie zmieniono tablicę pojazdu!", client);
		odswieztest(client);
	end
end)

addEvent("onClientReturnEnd", true)
addEventHandler("onClientReturnEnd", root, odswieztest)

-----------------------------------------------------------------
-----------------------------------------------------------------