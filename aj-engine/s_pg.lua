--// DOBRA, TUTAJ USTAWIMY LIMITY PG
--// TAK, ABY NIE BYŁO NADAWANIA 999 JEDENGO DNIA, ETC
--// MOZEMY TUTAJZ ROBIC COS NA ZASADZIE RANGI,
--// ROOT: 200 / ADMIN: 100 ... ITD

--// SYSTEM DOMYSLNY
local adminPGlimit = 90 -- limit na tydzien
local adminPGdaylimit = 20 -- limit na dzien


--// nadawanie PG
addCommandHandler("nadajpg", function(plr,cmd,cel,ilosc, ...)
if getElementData(plr,"admin:poziom") >= 6 then
    if getElementData(plr,"admin:zalogowano") == "true" then
	    if not cel or not ilosc then
		    outputChatBox("* Użycie: /nadajpg <nick/ID> <ilość> <powód>", plr)
		    return
		end
		local target=findPlayer(plr,cel)
        if (not target) then
            outputChatBox("#841515✖#e7d9b0 Nie znaleziono podanego gracza.", plr, 255, 255, 255, true)
            return
        end
		local ilosc = tonumber(ilosc) or 0; -- czasem wywala blad ze niby zla wartosc, generalnie dzial git
		local ilosc = math.floor(ilosc);
		if ilosc > 20 or ilosc <= 0 then
		    outputChatBox("#841515✖#e7d9b0 Wpisz odpowiednią ilość punktów gry (1-20)!", plr, 255, 255, 255, true)
		    return 
		end
        local tresc = table.concat(arg, " ")
        if (string.len(tresc)<=1) then
            outputChatBox("#841515✖#e7d9b0 Wpisz powód nadania dodatkowych punktów gry!", plr, 255, 255, 255, true)
            return
        end
		-- zaczynamy sprawdzac limity
		-- ogolnie

		local pgh_admin = getElementData(plr,"player:dbid");
	    local pgh_desc = tresc;
	    local pgh_foruser = getElementData(target,"player:dbid");
		
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_pghistory WHERE pgh_foruser=? AND timediff(NOW(),pgh_data)<'00:30:00' AND pgh_job=0 LIMIT 1",pgh_foruser)
		if #result > 0 then
		    outputChatBox("#841515✖#e7d9b0 Ten gracz otrzymał już PG w ciągu ostatnich 30 minut.", plr, 255, 255, 255, true)
		    return
		end
		-- pg z 24h
		local result24h = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(pgh_ilosc),0) pgh_suma FROM server_pghistory WHERE pgh_admin='"..pgh_admin.."' AND timediff(NOW(),pgh_data)<'24:00:00';")
		if result24h and result24h[1].pgh_suma then
			if tonumber(result24h[1].pgh_suma)>=adminPGdaylimit then
				outputChatBox("#841515✖#e7d9b0 Wydałeś/aś już maksymalną ilość punktów PG na dobę.", plr, 255, 255, 255, true)
				return
			elseif tonumber(result24h[1].pgh_suma)+ilosc>adminPGdaylimit then
				outputChatBox("#841515✖#e7d9b0 Nie masz dostępnych aż tylu punktów, obecnie możesz dać maksymalnie "..(adminPGdaylimit-tonumber(result24h[1].pgh_suma)).." PG!", plr, 255, 255, 255, true)
				return
			end
		end
		-- pg z 7 dni
		local result7d = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(pgh_ilosc),0) pgh_suma7d FROM server_pghistory WHERE pgh_admin='"..pgh_admin.."' AND timediff(NOW(),pgh_data)<'168:00:00';")
		if result7d and result7d[1].pgh_suma7d then
			if tonumber(result7d[1].pgh_suma7d)>=adminPGlimit then
				outputChatBox("#841515✖#e7d9b0 Wydałeś/aś już maksymalną ilość punktów PG w przeciągu 7 dni.", plr, 255, 255, 255, true)
				return
			elseif tonumber(result7d[1].pgh_suma7d)+ilosc>adminPGlimit then
				outputChatBox("#841515✖#e7d9b0 Nie masz dostępnych aż tylu punktów, obecnie możesz dać maksymalnie "..(adminPGlimit-tonumber(result7d[1].pgh_suma7d)).." PG!", plr, 255, 255, 255, true)
				return
			end
		end
		-- pg dla samego siebie
		if pgh_admin == pgh_foruser then
		    outputChatBox("#841515✖#e7d9b0 Nie możesz nadać samemu sobie PG!", plr, 255, 255, 255, true)
            return
	    end
		
    triggerClientEvent("onPlayerGetPG", target, tresc, ilosc)
	
	outputChatBox("#388E00✔#e7d9b0 #EBB85DPG#e7d9b0: Pomyślnie nadano punkty graczowi "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..pgh_foruser..", w ilości "..ilosc..".", plr, 255, 255, 255, true)
	outputChatBox("#388E00✔#e7d9b0 #EBB85DPowód#e7d9b0: "..tresc, plr, 255, 255, 255, true)

	-- nadajemy do bazy 
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_pghistory SET pgh_admin=?, pgh_ilosc=?, pgh_data=NOW(), pgh_desc=?, pgh_foruser=?",pgh_admin,ilosc,pgh_desc,pgh_foruser)
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_pg=user_pg+'"..ilosc.."' WHERE user_id='"..pgh_foruser.."'")
	-- i do logów serwera
    local transfer_text=('[NADAJ:PG] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> nadajpg >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..pgh_foruser..' ('..tresc..') ilosc: ('..ilosc..')')	
	outputServerLog(transfer_text)
	
	-- uszko added :)
	desc22 = 'PG: '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' nadał PG '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..' powód: '..tresc..' ilość: '..ilosc..'';
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	local PGgraczaTeraaz = getElementData(target,"player:PG");
	local nowePG = PGgraczaTeraaz + ilosc;
	setElementData(target,"player:PG",nowePG)

		
    end
	end
end)
--[[
addCommandHandler("testpg", function(plr,cmd,cel,ilosc, ...)
	    if not cel or not ilosc then
		    outputChatBox("* Użycie: /nadajpg <nick/ID> <ilość> <powód>", plr)
		    return
		end
		local target=findPlayer(plr,cel)
        if (not target) then
            outputChatBox("#841515✖#e7d9b0 Nie znaleziono podanego gracza.", plr, 255, 255, 255, true)
            return
        end
		local ilosc = tonumber(ilosc) or 0; -- czasem wywala blad ze niby zla wartosc, generalnie dzial git
		local ilosc = math.floor(ilosc);
		if ilosc > 20 or ilosc <= 0 then
		    outputChatBox("#841515✖#e7d9b0 Wpisz odpowiednią ilość punktów gry (1-20)!", plr, 255, 255, 255, true)
		    return 
		end
        local tresc = table.concat(arg, " ")
        if (string.len(tresc)<=1) then
            outputChatBox("#841515✖#e7d9b0 Wpisz powód nadania dodatkowych punktów gry!", plr, 255, 255, 255, true)
            return
        end
	triggerClientEvent("onPlayerGetPG", target, tresc, ilosc)
end)
]]--
--// znajdz goscia
function findPlayer(plr,cel)
	local target=nil
	if (tonumber(cel) ~= nil) then
		target=getElementByID("p"..cel)
	else -- podano fragment nicku
		for _,thePlayer in ipairs(getElementsByType("player")) do
			if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), cel:lower(), 0, true) then
				if (target) then
					outputChatBox("* Znaleziono więcej niż jednego gracza o pasującym nicku, podaj więcej liter.", plr)
					return nil
				end
				target=thePlayer
			end
		end
	end
	if target and getElementData(target,"p:inv") then return nil end
	return target
end