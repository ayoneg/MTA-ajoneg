
function odswieztest22(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
--    local result = dbPoll(dbQuery(db, "SELECT * FROM server_logibankowe WHERE lbank_touserid='"..uid.."' OR lbank_userid='"..uid.."' ORDER BY lbank_id DESC  LIMIT 75"),-1);
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_logibankowe WHERE lbank_touserid='"..uid.."' OR lbank_userid='"..uid.."' ORDER BY lbank_id DESC  LIMIT 75");
	triggerClientEvent(client, "onClientReturn2", root, result)
end

addEvent("onClientReturnEnd2", true)
addEventHandler("onClientReturnEnd2", root, odswieztest22)



--[[
function odswieztest33(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
    local result = dbPoll(dbQuery(db, "SELECT SUM(lbank_kwota) FROM server_logibankowe WHERE lbank_touserid='"..uid.."' ORDER BY lbank_id DESC"),-1);
	triggerClientEvent(client, "onClientReturn3", root, result["SUM(lbank_kwota)"])
end

addEvent("onClientReturnEnd3", true)
addEventHandler("onClientReturnEnd3", root, odswieztest33)
]]--

addEvent("wyslijPrzelew", true)
addEventHandler("wyslijPrzelew", root, function(get_kwote, get_nrkonta)
	local uid = getElementData(client,"player:dbid");
	if not uid then return end
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
	if #result < 0 then return end
	local result_acc = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..get_nrkonta.."'");
	if #result_acc < 0 then return end
	--local get_kwote = (get_kwote*100)
	if result[1].user_bankmoney < get_kwote then 
	outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz takiej kwoty w banku!", client,231, 217, 176,true) return end
	
--	triggerClientEvent(client,"potwierdzeniaPlatnosci",root)
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney-'"..get_kwote.."'  WHERE user_id = '"..uid.."'");
	if query then
	--liczpro = get_kwote/100;
	liczpro = get_kwote*0.95;
	liczpro = math.floor(liczpro);
	liczpro_bot = get_kwote*0.05;
	liczpro_bot = math.floor(liczpro_bot);
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..liczpro.." WHERE user_id = '"..get_nrkonta.."'");
		-- tutaj bot serwerowy dostaje podatek ;)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..liczpro_bot.." WHERE user_id = '22'");
		
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..uid.."', lbank_touserid = '"..get_nrkonta.."', lbank_kwota='"..liczpro.."', lbank_data=NOW(), lbank_desc='Przelew na konto bankowe "..result_acc[1].user_nickname..".', lbank_type='1'");
		
		local transfer_text=('[PRZELEWY:BANK] '..uid..' >> '..get_nrkonta..' ['..liczpro..' $]')	
	    outputServerLog(transfer_text)
		
		local money = string.format("%.2f", liczpro/100)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie przelano #388E00"..money.."$#e7d9b0 na numer ("..result_acc[1].user_nickname.."/"..get_nrkonta..") konta bankowego.", client,231, 217, 176,true)
		triggerClientEvent(client,"zamknijOkna",root)
		--wyjdzbank(client);
	end
end)










