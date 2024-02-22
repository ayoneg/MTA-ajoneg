setOcclusionsEnabled( false )

-----------------------------------------------------------------------------------------
function Pay(plr, cmd, target, value)
    if not target or not tonumber(value) then
        outputChatBox('* Użyj: /zaplac <nick/ID> <kwota>', plr)
        return
    end
    --value=string.match(value, "%d*")
	value = tonumber(value)
	value = (value*100);
    local target=findPlayer(plr,target)
    if not target then
		outputChatBox("#841515✖#e7d9b0 Nie znaleziono podanego gracza.", plr,231, 217, 176,true)
        return
    end
	local dbid_spr = getElementData(target, "player:dbid") or 0;
	if dbid_spr < 0 then
	   outputChatBox('#841515✖#e7d9b0 Gracz nie jest zalogowany!.', plr,231, 217, 176,true)
	return end
    if getPlayerMoney(plr) < value then
		outputChatBox("#841515✖#e7d9b0 Nie masz wystarczajacych środków.", plr,231, 217, 176,true)
        return
    end
    if value == 0 or value < 1 then
		outputChatBox("#841515✖#e7d9b0 Podałeś/aś nie prawidłową wartość.", plr,231, 217, 176,true)
        return
    end
    if target == plr then
		outputChatBox("#841515✖#e7d9b0 Żegnam. xD", plr,231, 217, 176,true)
        return
    end
	
	
	local new_money = getPlayerMoney(target)+value;
	local new_money = tonumber(new_money);
	if 99999999 < new_money then 
		outputChatBox("#841515✖#e7d9b0 Błąd, gracz osiągną limit gotówki przy sobie!", plr,231, 217, 176,true) 
		return 
	end
	
    takePlayerMoney(plr, value)
    givePlayerMoney(target ,value)
	
	uid = getElementData(plr,"player:dbid") or 0;
	uid2 = getElementData(target,"player:dbid") or 0;

	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..value.." WHERE user_id = '"..uid.."'");
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..value.." WHERE user_id = '"..uid2.."'");
	--// TYPE = 1 - wpłata // 2 - wypłata
	local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid = '"..uid.."', lbank_touserid = '"..uid2.."', lbank_kwota='"..value.."', lbank_data=NOW(), lbank_desc='Przelew na konto "..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..".', lbank_type='1'");
	
    local money = string.format("%.2f", value/100)
    outputChatBox("#388E00✔#e7d9b0 Przekazujesz #388E00"..money.."$#e7d9b0 graczowi "..getPlayerName(target):gsub("#%x%x%x%x%x%x","").."/"..getElementData(target,"id").."#e7d9b0.", plr,231, 217, 176,true)
    outputChatBox("#388E00✔#e7d9b0 Gracz "..getPlayerName(plr):gsub("#%x%x%x%x%x%x","").."/"..getElementData(plr,"id").." przekazuje Ci #388E00"..money.."$#e7d9b0.", target,231, 217, 176,true)

    --local transfer_text=('[PRZELEWY] (%d)%s(sid:%d) >> (%d)%s(sid:%d): %s'):format(getElementData(plr,"id"), getPlayerName(plr):gsub("#%x%x%x%x%x%x",""), getElementData(plr,"player:dbid"), getElementData(target,"id"), getPlayerName(target):gsub("#%x%x%x%x%x%x",""), getElementData(target,"player:dbid"), value)
	--triggerClientEvent("onDebugMessage", resourceRoot, transfer_text,4, "PRZELEWY")
	--triggerEvent("admin:addText", resourceRoot, transfer_text:gsub("#%x%x%x%x%x%x",""))
	--triggerEvent("admin:logs", root, transfer_text)
	--outputServerLog(transfer_text)
	
    local transfer_text=('[PRZELEWY] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"player:dbid")..' ['..money..' $]')	
	outputServerLog(transfer_text)
	
	local desc22 = 'PRZELEW: '..getPlayerName(plr)..'/'..getElementData(plr,"id")..' >> '..getPlayerName(target):gsub("#%x%x%x%x%x%x","")..'/'..getElementData(target,"id")..' suma: '..money..' $'
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
end
addCommandHandler('dajkase', Pay)
addCommandHandler('zaplac', Pay)
addCommandHandler('pay', Pay)
addCommandHandler('givemoney', Pay)
-----------------------------------------------------------------------------------------


addEvent("wplacGotowke", true)
addEventHandler("wplacGotowke", root, function(get_kwote)
	local uid = getElementData(client,"player:dbid");
	if not uid then return end

	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
	if #result < 0 then return end
	--local get_kwote = (get_kwote*100)
	if result[1].user_money < get_kwote then 
	outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz takiej kwoty!", client,231, 217, 176,true) return end
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-'"..get_kwote.."'  WHERE user_id = '"..uid.."'");
	if query then
		takePlayerMoney(client, get_kwote)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..get_kwote.." WHERE user_id = '"..uid.."'");
		--outputChatBox("* Pomyślnie wypłacono gotówkę!", client);
		
		local money = string.format("%.2f", get_kwote/100)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie wpłacono #388E00"..money.."$#e7d9b0 na konto bankowe.", client,231, 217, 176,true)
		wyjdzbank(client);
	end
end)


function odswiezbank(client)
	local uid = getElementData(client,"player:dbid")
	if not uid then return end
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
	triggerClientEvent(client, "onClientReturnBankomat", root, result)
end

function wyjdzbank(client)
	triggerClientEvent(client, "onClientCloseBankomat", root, result)
end


addEvent("wyplacGotowke", true)
addEventHandler("wyplacGotowke", root, function(get_kwote)

	local uid = getElementData(client,"player:dbid");
	if not uid then return end

	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
	if #result < 0 then return end
	--local get_kwote = (get_kwote*100)
	if result[1].user_bankmoney < get_kwote then 
	
	outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz takiej kwoty w banku!", client,231, 217, 176,true) return end
	
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney-'"..get_kwote.."' WHERE user_id = '"..uid.."'");
	if query then
		givePlayerMoney(client, get_kwote)
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money+"..get_kwote.." WHERE user_id = '"..uid.."'");
		--outputChatBox("* Pomyślnie wypłacono gotówkę!", client);
		
		local money = string.format("%.2f", get_kwote/100)
		outputChatBox("#388E00✔#e7d9b0 Pomyślnie wypłacono #388E00"..money.."$#e7d9b0 z konta bankowego.", client,231, 217, 176,true)
		wyjdzbank(client);
	end
end)

addEvent("sprBankoKase", true)
addEventHandler("sprBankoKase", root, odswiezbank)

-----------------------------------------------------------------
-----------------------------------------------------------------
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




