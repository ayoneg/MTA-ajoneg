--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Prolog.
]]--


local marker = createMarker(2544.013671875, 2320.8388671875, 10.813302993774-2, "cylinder", 2, 78, 188, 0, 22) -- tylko visu
local sphe = createColSphere(2544.013671875, 2320.8388671875, 10.813302993774, 1)
	setElementData(sphe,"misja",true)
	t = createElement("text")
	setElementData(t,"name","Misja - Prolog #1")
	setElementData(t,"scale",1)
	setElementData(t,"distance",10)
	setElementPosition(t,2544.013671875, 2320.8388671875, 10.813302993774+1)	

addEventHandler("onColShapeHit", sphe, function(plr,md)
	if not md then return end
    if getElementType(plr) ~= "player" then return end
	local misja = getElementData(source,"misja") or false;
	if misja then
		local veh = isPedInVehicle(plr) or false;
		if veh then return end
		local uid = getElementData(plr,"player:dbid") or 0;
		if uid > 0 then
			local code = "prolog";
			local wybprem = exports["aj-dbcon"]:wyb("SELECT * FROM server_jobslog WHERE joblog_code=? AND joblog_userid=?",code,uid);
			if #wybprem <= 0 then
				triggerClientEvent("misje:start",plr,plr)
			else
				outputChatBox("#841515✖#e7d9b0 Wykonano już ten etap fabularny!", plr,231, 217, 176,true) 
			end
		end
	end
end)


addEvent("misje:nagrody", true)
addEventHandler("misje:nagrody", root, function(kto,code)
	if isElement(kto) then
		local uid = getElementData(kto,"player:dbid") or 0;
		if uid > 0 then
			if code == "prolog" then
				-- nadaj nagrody za prolog
				local calycost = 15000 -- 150$
				local ilosc = 100 -- 100PG
				local slot = 2 -- 2 losty poj
				
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code=?, joblog_data=NOW(), joblog_value=1, joblog_userid=?, joblog_type=?",code,uid,1);
				local mycash = getPlayerMoney(kto)
				local fullcost = mycash + (calycost)
				if fullcost > 99999999 then
					outputChatBox("", kto,231, 217, 176,true)
					outputChatBox("#841515✖#e7d9b0 Błąd, gracz osiągną limit gotówki przy sobie!", kto,231, 217, 176,true) 
					return 
				end
				
				givePlayerMoney(kto,calycost)
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+'"..calycost.."'  WHERE user_id = '"..uid.."'");
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..calycost.." WHERE user_id = '22'");
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '22', lbank_touserid = '"..uid.."', lbank_kwota='"..calycost.."', lbank_data=NOW(), lbank_desc='Misje: prolog.', lbank_type='1'");
				
				local tresc = "Misja: Prolog za nami!";
				triggerClientEvent("onPlayerGetPG", kto, tresc, ilosc)
				-- nadajemy do bazy 
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_pghistory SET pgh_admin=?, pgh_ilosc=?, pgh_data=NOW(), pgh_desc=?, pgh_foruser=?, pgh_job=1",22,ilosc,tresc,uid)
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_pg=user_pg+'"..ilosc.."' WHERE user_id='"..uid.."'")	
				local PGgraczaTeraaz = getElementData(kto,"player:PG");
				local nowePG = PGgraczaTeraaz + ilosc;
				setElementData(kto,"player:PG",nowePG)		
				
				local slotownow = getElementData(kto,"player:carSlot") or 0;
				setElementData(kto,"player:carSlot",slotownow+slot)
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_carslot=user_carslot+'"..slot.."' WHERE user_id='"..uid.."'");
				desc_sl = " + #EBB85D"..slot.." slotów na poajzd#e7d9b0";
			end
		end
	end
end)
