addEvent("nadajCzasJednej4doDB", true)
addEventHandler("nadajCzasJednej4doDB",root,function(newtime_outh,plr_uid,veh_name,plr)
    if tonumber(newtime_outh) > 0 then
	    if tonumber(plr_uid) > 0 then 
			local query = exports["aj-dbcon"]:upd("INSERT INTO server_jedna4mili SET mil_uid='"..plr_uid.."', mil_time='"..newtime_outh.."', mil_vehname='"..veh_name.."', mil_data=NOW()");
			-- uszko added :)
			newtime = string.format("%.3f", newtime_outh/1000)
			desc22 = 'W 1/4 MILI: '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' ('..veh_name..') czas: '..newtime..'';
			triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
			odswiezamListe14Mili()
		end
	end
end)

local staszek = createPed(60, 897.8623046875, 2040.548828125, 7.8203125, -90)
--setElementData(staszek, "ped:name", "Staszek")
setElementFrozen(staszek, true)
setElementHealth(staszek, 100000)
setElementData(staszek,"ped:listajedna4","Brak wyników...")

function odswiezamListe14Mili()
	setElementData(staszek,"ped:listajedna4","")
	
	setElementData(staszek, "ped:listajedna4", "Najlepsze 5 przejazdów (ostatnie 7 dni):\n\n")
	
	local wybieram = exports["aj-dbcon"]:wyb("SELECT * FROM server_jedna4mili WHERE timediff(NOW(),mil_data)<'168:00:00' ORDER BY mil_time LIMIT 5");
	for i,id in ipairs(wybieram) do
	    local nick = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..id.mil_uid.."'");
		local newtime = string.format("%.3f", id.mil_time/1000)
		setElementData(staszek, "ped:listajedna4", getElementData(staszek,"ped:listajedna4")..""..i..". "..id.mil_vehname.." ("..nick[1].user_nickname..") "..newtime.."\n")
	end
	
	setElementData(staszek, "ped:listajedna4", getElementData(staszek,"ped:listajedna4").."\nOstatnie 7 przejazdów na 1/4 mili:\n\n")
	
	local wybieram2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_jedna4mili ORDER BY mil_id DESC LIMIT 7");
	for i,id in ipairs(wybieram2) do
	    local nick = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..id.mil_uid.."'");
		local newtime = string.format("%.3f", id.mil_time/1000)
		setElementData(staszek, "ped:listajedna4", getElementData(staszek,"ped:listajedna4")..""..i..". "..id.mil_vehname.." ("..nick[1].user_nickname..") "..newtime.."\n")
	end
end