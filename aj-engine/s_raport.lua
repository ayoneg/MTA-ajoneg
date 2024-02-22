
--- adms

addCommandHandler("ucho", function(plr,cmd)
    local uid = getElementData(plr,"player:dbid") or 0;
    if uid > 0 then
        local getjudcfgucho = getElementData(plr,"player:ucho") or false;
        if getjudcfgucho == false then
            setElementData(plr,"player:ucho",true)
        else
            setElementData(plr,"player:ucho",false)
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
		
	local target = exports["aj-engine"]:findPlayer(plr,id)
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

	
--- komenty karne


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
			
			local transfer_text=('[KARY:KICK] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> kick  '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..(getElementData(target,"player:dbid") or 0)..' ('..reason..')')	
			outputServerLog(transfer_text)
	
			kickPlayer(target, plr, reason)
		end
	end
end)

-- ban
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
				end
		
				if mutetype=="h" and tonumber(x) < 25 then
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
				end
		                                -- 999 MAX BAN --
				if mutetype=="d" and tonumber(x) < 1000 then
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 5, getElementData(plr,"player:dbid"));
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
	if #wynikglowny_blokady > 0 then	
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
	    local query = exports["aj-dbcon"]:upd("UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
		
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
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
        local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 4, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a cofnięcie licencji lotniczej od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a cofnięcie licencji lotniczej od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		
        local wynikglowny_adm = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='4' ORDER BY zakaz_id DESC");
		
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
	
    local wynikglowny_blokady = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_czas>NOW() AND zakaz_type='2' AND zakaz_value='0' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' ORDER BY zakaz_id DESC");
	if #wynikglowny_blokady > 0 then	
        data_teraz = (os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S"));
        local query = exports["aj-dbcon"]:upd("UPDATE server_zakazy SET zakaz_note='"..reason.."', zakaz_czas='"..data_teraz.."', zakaz_value='1' WHERE zakaz_userserial='"..getPlayerSerial(target).."' AND zakaz_type='2' AND zakaz_fromadmin='"..getElementData(plr,"player:dbid").."' AND zakaz_value='0'");
		
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
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz,getPlayerSerial(target),reason, x, 2, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a zakaz prowadzenia pojazdów (A,B,C) od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." otrzymał/a zakaz prowadzenia pojazdów (A,B,C) od "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", powód: "..reason.." ("..x.." "..mutetype..")")
		
		
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
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? minute,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="h" and tonumber(x) < 25 then
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? hour,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end
		
		if mutetype=="d" and tonumber(x) < 15 then
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_zakazy (zakaz_dodany,zakaz_userserial,zakaz_desc,zakaz_czas,zakaz_type,zakaz_fromadmin) VALUES (?,?,?,NOW() + INTERVAL ? day,?,?)", data_teraz, getPlayerSerial(target),reason, x, 1, getElementData(plr,"player:dbid"));
		end	
		
		
		if (mutetype=="d" and tonumber(x) < 15) or (mutetype=="h" and tonumber(x) < 25) or (mutetype=="m" and tonumber(x) < 361) then
		triggerClientEvent(root, "admin:rendering", root, getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wyciszony/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", na "..x..""..mutetype.." - powód: "..reason.."")
		outputConsole(getPlayerName(target):gsub("#%x%x%x%x%x%x","").." został/a wyciszony/a przez "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","")..", na "..x..""..mutetype.." - powód: "..reason.."")
		
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

	
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"admin:zalogowano") == "true" then
			for iv=#reportView, 2, -1 do
			spr22 = reportView[iv] or nil;
			if spr22 ~= nil then
				if reportView[iv][2] == getElementData(target,"id") then
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