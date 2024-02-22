------------------------------------------------------------------
------------------------------------------------------------------
-----------------------------ZEBRACY MAP--------------------------
------------------------------------------------------------------

addCommandHandler("showhud2", function(plr,cmd)
   local uid = getElementData(plr,"player:dbid") or 0;
   if uid > 0 then
       local getjudcfg = getElementData(plr,"player:hud2") or false;
	   if getjudcfg == false then
           setElementData(plr,"player:hud2",true)
	   else
	   	   setElementData(plr,"player:hud2",false)
	   end
   end
end)



------------------------------------------------------------------
                      -- USZKODZENIA AUT --
------------------------------------------------------------------
addCommandHandler("usz", function(plr,cmd)
if getElementData(plr,"admin:poziom") >= 5 and getElementData(plr,"admin:zalogowano") == "true" then
		local veh=getPedOccupiedVehicle(plr)
		if not veh then
			outputChatBox("* Nie znajdujesz się w pojeździe", plr)
			return
		end
		outputChatBox("* uszk: "..getElementHealth(veh),plr,0,255,0)
end
end)
------------------------------------------------------------------

------------------------------------------------------------------
                  -- LICZENIE ONLINE GRACZA --
------------------------------------------------------------------
setTimer(function()
	local players=getElementsByType('player')
	for _, p in pairs(players) do
	dbid = getElementData(p,"player:dbid") or 0;
	if dbid > 0 then
		if getElementData(p, "player:minuty") and tonumber(getElementData(p, "player:minuty")) >= 1 then
			local min1_a = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..dbid.."'");
			minuty_gracza = min1_a[1].user_minuty + getElementData(p,"player:minuty");
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_minuty='"..minuty_gracza.."', user_lastlogindata=NOW() WHERE user_id='"..dbid.."'");
			
			-- zerowansko minut
			setElementData(p,"player:minuty",0)
		end
	end
 	end
end, 660000, 0) -- co 11 min

addEventHandler("onPlayerQuit", root,function()
	dbid = getElementData(source,"player:dbid") or 0;
	if dbid > 0 then
		minuty_gracza = getElementData(source,"player:minuty") or 0;
		if tonumber(minuty_gracza) > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_minuty=user_minuty+'"..minuty_gracza.."', user_lastlogindata=NOW() WHERE user_id='"..dbid.."'");
		end
	end
end)
------------------------------------------------------------------

------------------------------------------------------------------
                     -- LICZENIE PREMKI --
------------------------------------------------------------------
setTimer(function()
	local players=getElementsByType('player')
	for _, p in pairs(players) do
			if getElementData(p, "player:online") and tonumber(getElementData(p, "player:online")) == 60 then
				setElementData(p, "player:online", 0)
				if getElementData(p, "player:premium") == 1 then
					local czas = tostring((os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S")))
					local pczas = getElementData(p,"player:premium_time") or false;
					if pczas >= czas then 
						uid = getElementData(p,"player:dbid") or 0;
						ile = 15000
						money_gracza = getPlayerMoney(p) + ile;
						
						if money_gracza > 99999999 then return end
						
						givePlayerMoney(p, ile)
						local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..ile.." WHERE user_id='"..uid.."'");
						local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '0', lbank_touserid = '"..uid.."', lbank_kwota='"..ile.."', lbank_data=NOW(), lbank_desc='Premia 150$ z konta premium.', lbank_type='1'");
						
						outputChatBox("#EFD00C* Premium: Otrzymujesz #388E00150$#EFD00C za przegranie 1h na serwerze.", p,255,255,255,true)
					else
						outputChatBox("#EFD00C* Premium: Twoje konto właśnie wygasło.", p,255,255,255,true)
						removeElementData(p,"player:premium")
						removeElementData(p,"player:premium_time")
					end
				end
			end
 	end
end, 60000, 0)
------------------------------------------------------------------
------------------------------------------------------------------
-----------------------------IDLERS AFK---------------------------
------------------------------------------------------------------
setTimer(
    function()
        for _, player in ipairs(getElementsByType("player")) do
		adm_poziom = getElementData(player,"admin:poziom") or 0;
		player_dbid = getElementData(player,"player:dbid") or 0;
		
		if player_dbid > 0 and adm_poziom < 7 then -- and adm_poziom < 7
            if (getPlayerIdleTime(player) > 300000) then -- co 5 min sprawdza // 3*5 = 15 min afk [dla moda, supa, gracza]
			
			    sprafk_up = getElementData(player,"player:afk") or 0;
	
			if sprafk_up == 0 then
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 1/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				setElementData(player,"player:afk",1)
			end
				
            if (getPlayerIdleTime(player) > 600000) then
				 
			if sprafk_up == 1 then
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 2/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				setElementData(player,"player:afk",2)
			end
				
			if (getPlayerIdleTime(player) > 900000) then
					  
			if sprafk_up == 2 then	  
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 3/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				
--				kickPlayer(player, "AFK na serwerze.")
				
			end
			
			end
			
			if (getPlayerIdleTime(player) > 910000) then  
				if sprafk_up == 2 then	  
					kickPlayer(player, "AFK na serwerze.")
				end
			end
			
            end
			end
		end -- warunek z dbid
		
		if player_dbid > 0 and adm_poziom == 7 then 
            if (getPlayerIdleTime(player) > 1200000) then -- co 20 min sprawdza // 3*20 = 60 min afk [adm]
			
			    sprafk_up = getElementData(player,"player:afk") or 0;
	
			if sprafk_up == 0 then
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 1/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				setElementData(player,"player:afk",1)
			end
				
            if (getPlayerIdleTime(player) > 2400000) then
				 
			if sprafk_up == 1 then
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 2/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				setElementData(player,"player:afk",2)
			end
				
			if (getPlayerIdleTime(player) > 3600000) then
					  
			if sprafk_up == 2 then	  
				outputChatBox(" ", player,255,0,0,true)
				outputChatBox("Otrzymałeś ostrzeżenie za AFK, rusz się albo zostaniesz wykopany z serwera! 3/3", player,255,0,0,true)
				outputChatBox(" ", player,255,0,0,true)
				
--				kickPlayer(player, "AFK na serwerze.")
				
			end
			
			end
			
			if (getPlayerIdleTime(player) > 3610000) then  
				if sprafk_up == 2 then	  
					kickPlayer(player, "AFK na serwerze.")
				end
			end
			
            end
			end
		end -- warunek z dbid
		
		
		
        end -- for end
    end, -- function end
30000, 0) -- Timer to execute every 30 seconds, checking for idlers
------------------------------------------------------------------
-----------------------------TIME TEST----------------------------
------------------------------------------------------------------
setMinuteDuration(15000)
--[[
function syncTime()
    local realTime = getRealTime()
    local hour = realTime.hour
    local minute = realTime.minute
    setMinuteDuration ( 60000 )
    setTime( hour , minute )
end
setTimer ( syncTime, 500, 1 ) 
setTimer ( syncTime, 3000000, 0 ) 
function SyncTime2()
	setTimer ( syncTime, 4000, 1 )
end
addEventHandler ( "onResourceStart", getRootElement(), SyncTime2 )
]]--
--------------------------------------------------------------------------------
-- hardkorowy anty spam

local tickets = {}
local czas_od_ostatniej_komendy = 500 -- czas w ms

addEventHandler('onPlayerCommand',root,function()
	if not tickets[source] then
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy
		return
	end
	if tickets[source]>getTickCount() then
		--outputChatBox("Zwolnij!", source,255,0,0,true)
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy -- // Jeśli chcemy żeby znów musiał poczekać
		cancelEvent()
	else
		tickets[source] = getTickCount() + czas_od_ostatniej_komendy
	end
end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-----------                SPRAWDZANIE ODZNACZENIA AUT
--------------------------------------------------------------------------------

function sprPojazdy()
	local vehicless = getElementsByType('vehicle')
	for _, veh in pairs(vehicless) do
	local salon = getElementData(veh,"vehicle:salon") or false;
	if salon==false then
    local kierowca = getVehicleOccupant(veh) 
    if kierowca == false then 
	
	local veh_id = getElementData(veh,"vehicle:id") or 0;
	local veh_odznaczone = getElementData(veh,"vehicle:odznaczone") or false;
	local veh_przebieg = getElementData(veh,"vehicle:przebieg") or 0;
	local veh_paliwo = getElementData(veh,"vehicle:paliwo") or 0;
	local veh_owner = getElementData(veh,"vehicle:owner") or "Serwer";
    
--	if veh_owner == "Serwer" then -- jesli vehicle to serwerowa furra respiona przez adm
--	
--	destroyElement(veh);
--	else
	local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicle_driver WHERE driver_carid='"..veh_id.."' AND timediff(NOW(),driver_czas)<'00:15:00' ORDER BY driver_id DESC LIMIT 1"); 
	if #result2 == 0 then
	
	setElementData(veh,"vehicle:odznaczoneSUSZ",true) -- odznaca dla suszarki adm
	
	end
	
	if veh_odznaczone == true then -- jesli jest odznaczony, sprawdzamy ile juz to trwa
    
	--[[ // WYTEP ODNZACZONE POJ (off)
	local result28h = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicle_driver WHERE driver_carid='"..veh_id.."' AND timediff(NOW(),driver_czas)<'00:15:00' ORDER BY driver_id DESC LIMIT 1"); -- 10min
	if #result28h == 0 then -- jesli odznaczony i ostatni kiero jest 15 min temu, dajemy auto z bomby do dp // jesli nie spełni się, to nic się nie wykona
	
	x,y,z = getElementPosition(veh)
	x = math.ceil(x)
	y = math.ceil(y)
	z = math.ceil(z)
    local transfer_text=('[AUTODP:VEH] Server przenosi pojazd ID: '..veh_id..', z pozycji: '..x..', '..y..', '..z..'.')	
	outputServerLog(transfer_text)
	
	exports["aj-vehs"]:zapiszPojazd(veh)
	
	end -- zapytanie wewnwtrz pentli o wytepanie [end]
	]]--

	else  -- jesli nie jest odznaczony sprawdz czy mozna odznaczyc
	
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicle_driver WHERE driver_carid='"..veh_id.."' AND timediff(NOW(),driver_czas)<'72:00:00' ORDER BY driver_id DESC LIMIT 1"); -- 72 // 72h
	if #result == 0 then 
	-- odznaczamy pojazd
	setElementData(veh,"vehicle:odznaczone",true);
	
	x,y,z = getElementPosition(veh)
	x = math.ceil(x)
	y = math.ceil(y)
	z = math.ceil(z)
    local transfer_text=('[AUTO:ODZNACZ] Server odznacza pojazd ID: '..veh_id..', z pozycji: '..x..', '..y..', '..z..'.')	
	outputServerLog(transfer_text)
	end
	
	end
	 
	end
	end
	end
end

setTimer(sprPojazdy,600000, 0) -- raz na 10 min (600000 ms)

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

function sprPojazdyPubliczne()
	local vehicless = getElementsByType('vehicle')
	for _, veh in pairs(vehicless) do
	local salon = getElementData(veh,"vehicle:salon") or false;
	if salon==false then
    local kierowca = getVehicleOccupant(veh) 
    if kierowca == false then 
	
	local veh_id = getElementData(veh,"vehicle:id") or 0;
	local veh_odznaczone = getElementData(veh,"vehicle:odznaczone") or false;
	local veh_przebieg = getElementData(veh,"vehicle:przebieg") or 0;
	local veh_paliwo = getElementData(veh,"vehicle:paliwo") or 0;
	local veh_owner = getElementData(veh,"vehicle:owner") or "Serwer";
    
	if veh_owner == "Serwer" then -- jesli vehicle to serwerowa furra respiona przez adm
	
	destroyElement(veh);
	
	end

	end
	end
	end
end

setTimer(sprPojazdyPubliczne, 30000, 0) -- raz na 30 sek (30000 ms)


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------









