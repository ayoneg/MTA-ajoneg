-- test
----- ----- ----- ----- ----- ----- -----

function osiagniecia()
    players = getElementsByType('player')
    for i,plr in pairs(players) do
	    local plr_id = getElementData(plr,"player:dbid") or 0;
		if tonumber(plr_id) > 0 then
			local plr_godziny = getElementData(plr,"player:onlineHours") or 0;
			
			-- osiągniecia BETA TESTER
			if tonumber(plr_godziny) >= 0 then -- start #0 (tester-gry)
				-- sprawdzamy w bazie, czy juz nie ma osiągnięcia za to@!
				local ments_nameID = "tester-gry";
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_achievements WHERE ments_userID='"..tonumber(plr_id).."' AND ments_nameID='"..tostring(ments_nameID).."' LIMIT 1")
				if #result == 0 then
					-- nie ma osiągnięcia, nadajemy :)
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_achievements SET ments_userID='"..tonumber(plr_id).."', ments_nameID='"..tostring(ments_nameID).."', ments_data=NOW()")
					
					-- co ma nadać ?
					local ilosc_PG = 100;
					local tresc_OS = "Błąd tam, błąd tu — Halo AjoN, kiedy to naprawisz???? A dodasz coś takiego (...) #BETATESTER";
					triggerClientEvent("onPlayerGetPG", plr, tresc_OS, ilosc_PG)
					nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nada nam reszte
				end
			end -- end #0 (tester-gry)
			
			-- osiągniecia za godzine gry
			if tonumber(plr_godziny) == 1 then -- start #1 (godzina-gry)
				-- sprawdzamy w bazie, czy juz nie ma osiągnięcia za to@!
				local ments_nameID = "godzina-gry";
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_achievements WHERE ments_userID='"..tonumber(plr_id).."' AND ments_nameID='"..tostring(ments_nameID).."' LIMIT 1")
				if #result == 0 then
					-- nie ma osiągnięcia, nadajemy :)
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_achievements SET ments_userID='"..tonumber(plr_id).."', ments_nameID='"..tostring(ments_nameID).."', ments_data=NOW()")
					
					-- co ma nadać ?
					local ilosc_PG = 25;
					local tresc_OS = "Wspaniale, pierwsza godzina gry za Tobą, mamy nadzieje, że świetnie się bawisz! :-)";
					triggerClientEvent("onPlayerGetPG", plr, tresc_OS, ilosc_PG)
					nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nada nam reszte
				end
			end -- end #1 (godzina-gry)
			
			
			-- osiągniecia za dwie godziny gry
			if tonumber(plr_godziny) == 2 then -- start #2 (drugagodzina-gry)
				-- sprawdzamy w bazie, czy juz nie ma osiągnięcia za to@!
				local ments_nameID = "drugagodzina-gry";
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_achievements WHERE ments_userID='"..tonumber(plr_id).."' AND ments_nameID='"..tostring(ments_nameID).."' LIMIT 1")
				if #result == 0 then
					-- nie ma osiągnięcia, nadajemy :)
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_achievements SET ments_userID='"..tonumber(plr_id).."', ments_nameID='"..tostring(ments_nameID).."', ments_data=NOW()")
					
					-- co ma nadać ?
					local ilosc_PG = 50;
					local tresc_OS = "Czas zrobić sobie przerwę na smaczną kawusię, grasz już dwie godziny!";
					triggerClientEvent("onPlayerGetPG", plr, tresc_OS, ilosc_PG)
					nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nada nam reszte
				end
			end -- end #2 (drugagodzina-gry)
			
			
			-- osiągniecia za szóstą godzine gry
			if tonumber(plr_godziny) == 6 then -- start #3 (szostagodzina-gry)
				-- sprawdzamy w bazie, czy juz nie ma osiągnięcia za to@!
				local ments_nameID = "szostagodzina-gry";
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_achievements WHERE ments_userID='"..tonumber(plr_id).."' AND ments_nameID='"..tostring(ments_nameID).."' LIMIT 1")
				if #result == 0 then
					-- nie ma osiągnięcia, nadajemy :)
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_achievements SET ments_userID='"..tonumber(plr_id).."', ments_nameID='"..tostring(ments_nameID).."', ments_data=NOW()")
					
					-- co ma nadać ?
					local ilosc_PG = 150;
					local tresc_OS = "Niesamowite, to już szósta godzina gry za Tobą w jednej sesji — czas na chwilową przerwę!";
					triggerClientEvent("onPlayerGetPG", plr, tresc_OS, ilosc_PG)
					nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nada nam reszte
				end
			end -- end #3 (szostagodzina-gry)
			
			
			-- osiągniecia za dwunastą godzine gry
			if tonumber(plr_godziny) == 12 then -- start #4 (dwunastagodzina-gry)
				-- sprawdzamy w bazie, czy juz nie ma osiągnięcia za to@!
				local ments_nameID = "dwunastagodzina-gry";
				local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_achievements WHERE ments_userID='"..tonumber(plr_id).."' AND ments_nameID='"..tostring(ments_nameID).."' LIMIT 1")
				if #result == 0 then
					-- nie ma osiągnięcia, nadajemy :)
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_achievements SET ments_userID='"..tonumber(plr_id).."', ments_nameID='"..tostring(ments_nameID).."', ments_data=NOW()")
					
					-- co ma nadać ?
					local ilosc_PG = 250;
					local tresc_OS = "To już czas zrobić dłuższą przerwę, dwanaście godzin gry w sesji za Tobą, szalejesz!";
					triggerClientEvent("onPlayerGetPG", plr, tresc_OS, ilosc_PG)
					nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nada nam reszte
				end
			end -- end #4 (dwunastagodzina-gry)
			
		end
	end
end
setTimer(osiagniecia, 900000, 0) -- co 15 min petla sprawdza graczy

function nadajTakieTam(ilosc_PG,tresc_OS,plr_id,plr) -- funkcja nadaje nagrody
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_pghistory SET pgh_admin='22', pgh_ilosc='"..ilosc_PG.."', pgh_data=NOW(), pgh_desc='"..tresc_OS.."', pgh_foruser='"..plr_id.."'")
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_pg=user_pg+'"..ilosc_PG.."' WHERE user_id='"..plr_id.."'")
	-- i do logów serwera
    local transfer_text=('[OSIAGNIECIE] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' ('..tresc_OS..') ilosc PG: ('..ilosc_PG..')')	
	outputServerLog(transfer_text)
	
	-- uszko added :)
	desc22 = 'OSIĄGNIĘCIE: '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..': '..tresc_OS..' ilość PG: '..ilosc_PG..'';
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	local PGgraczaTeraaz = getElementData(plr,"player:PG");
	local nowePG = PGgraczaTeraaz + ilosc_PG;
	setElementData(plr,"player:PG",nowePG)
end

----- ----- ----- ----- ----- ----- -----

addCommandHandler("nowynick", function(plr,cmd,value)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
		if not value then
			outputChatBox("* Użycie: /nowynick <nowynick>",plr)
			return
		end
		if string.len(value) < 3 or string.len(value) > 22 then
			outputChatBox("#841515✖#e7d9b0 Nick powinien zawierać od 3 do 22 znaków.",plr,231, 217, 176,true)
			return
		end
		if tostring(getPlayerName(plr)) == tostring(value) then
			outputChatBox("#841515✖#e7d9b0 Nick powinien być inny niż aktualny.",plr,231, 217, 176,true)
			return
		end
		local nickname = tostring(value)
		
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_nickname=? LIMIT 1",nickname)
		if #result > 0 then
			outputChatBox("#841515✖#e7d9b0 Podany nick jest już zajęty przez innego gracza.",plr,231, 217, 176,true)
			return
		end
		local result24h = exports["aj-dbcon"]:wyb("SELECT IFNULL(COUNT(oldnick_id),0) zmiananicku FROM server_users_oldnicknames WHERE oldnick_userid=? AND timediff(NOW(),oldnick_data)<'24:00:00';",plr_id)
		if result24h and result24h[1].zmiananicku > 0 then
			outputChatBox("#841515✖#e7d9b0 Błąd, w przeciągu ostatnich #EBB85D24 godzin#e7d9b0, dokonano już zmiany nicku.",plr,231, 217, 176,true)
			return
		end
		
		-- print info
		outputChatBox(" ",plr,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Zmieniając nick #841515ZMIENIASZ LOGIN#e7d9b0 do konta.",plr,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Zmiany nie da się cofnąć, a stary nick może zostać zajęty przez innego gracza!",plr,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Kolejna zmiana dostępna będzie po upływie #EBB85D24 godzin#e7d9b0.",plr,231, 217, 176,true)
		outputChatBox(" ",plr,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Wpisz #EBB85D/potwierdzam#e7d9b0 aby zaakceptować zmianę nicku na #EBB85D"..tostring(nickname).."#e7d9b0.",plr,231, 217, 176,true)
		setElementData(plr,"player:zmiananickuCHECK",true)
		setElementData(plr,"player:zmiananickuNOWYNICK",tostring(nickname))
	end
end)

addCommandHandler("potwierdzam", function(plr,cmd)
	local plr_id = getElementData(plr,"player:dbid") or 0;
	if plr_id > 0 then
		local CHECK = getElementData(plr,"player:zmiananickuCHECK") or false;
		if CHECK then
			local NOWYNICK = getElementData(plr,"player:zmiananickuNOWYNICK") or false;
			if NOWYNICK ~= false then
				--- zmieniamy nick
				local playerNAME = getPlayerName(plr);
				
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_nickname=? WHERE user_id=?",NOWYNICK,plr_id)
				setPlayerName(plr, tostring(NOWYNICK))
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_users_oldnicknames SET oldnick_name=?, oldnick_userid=?, oldnick_data=NOW()",playerNAME,plr_id)
				
				removeElementData(plr,"player:zmiananickuCHECK")
				removeElementData(plr,"player:zmiananickuNOWYNICK")
				
				
				outputChatBox("#388E00✔#e7d9b0 Pomyślnie dokonano zmiany nicku!",plr,231, 217, 176,true)
			end
		end
	end
end)















