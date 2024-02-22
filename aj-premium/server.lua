--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt sklepu premium.
]]--

-- tablica ofert
local cenaoff = {750, 1050, 1400, 200}
local dnioff = {30, 45, 60, 0}
local slotoff = {0, 2, 4, 5}

addEvent("premium:zakup",true)
addEventHandler("premium:zakup",root,function(plr,oferta)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		cena = tonumber(cenaoff[oferta])
		dni = tonumber(dnioff[oferta])
		slot = tonumber(slotoff[oferta])
		if cena > 0 then
			local player_pp = getElementData(plr,"player:premiumPoints") or 0;
			if cena > player_pp then
				outputChatBox("#841515✖#e7d9b0 Nie posiadasz tyle #EBB85DPunktów Premium#e7d9b0!", plr,231, 217, 176,true)	
				return
			end
			-- zmienne
			local desc_pr = ""
			local desc_sl = ""
					
			--nadajemy premke
			if dni > 0 then
				local premium = getElementData(plr,"player:premium") or false;
				if premium then
					local query = exports["aj-dbcon"]:upd("UPDATE server_premium SET p_days=DATE_ADD(p_days, INTERVAL "..dni.." DAY) WHERE p_userid='"..uid.."'");
					local premka = exports["aj-dbcon"]:wyb("SELECT * FROM server_premium WHERE p_userid='"..uid.."' AND p_type='1' AND p_days>NOW()");
					setElementData(plr,"player:premium_time", premka[1].p_days)
				else
					local premka = exports["aj-dbcon"]:wyb("SELECT * FROM server_premium WHERE p_userid='"..uid.."'");
					if #premka > 0 then
						-- jesli kiedys juz bylo ale wygaslo
						local query = exports["aj-dbcon"]:upd("UPDATE server_premium SET p_addtime=NOW(), p_days=DATE_ADD(NOW(), INTERVAL "..dni.." DAY) WHERE p_userid='"..uid.."'");
						setElementData(plr,"player:premium", 1)
						local wybprem = exports["aj-dbcon"]:wyb("SELECT * FROM server_premium WHERE p_userid='"..uid.."' AND p_type='1' AND p_days>NOW()");
						setElementData(plr,"player:premium_time", wybprem[1].p_days)
					else
						-- jesli nie bylo nigdy
						local query = exports["aj-dbcon"]:upd("INSERT INTO server_premium SET p_userid='"..uid.."', p_addtime=NOW(), p_days=DATE_ADD(NOW(), INTERVAL "..dni.." DAY), p_type='1'");
						setElementData(plr,"player:premium", 1)
						local wybprem = exports["aj-dbcon"]:wyb("SELECT * FROM server_premium WHERE p_userid='"..uid.."' AND p_type='1' AND p_days>NOW()");
						setElementData(plr,"player:premium_time", wybprem[1].p_days)
					end
				end
				desc_pr = " #EBB85DPremium "..dni.." dni#e7d9b0";
			end
			
			-- nadajemy sloty
			if slot > 0 then
				local slotownow = getElementData(plr,"player:carSlot") or 0;
				setElementData(plr,"player:carSlot",slotownow+slot)
				local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_carslot=user_carslot+'"..slot.."' WHERE user_id='"..uid.."'");
				desc_sl = " + #EBB85D"..slot.." slotów na poajzd#e7d9b0";
			end
			
			
			local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_ppoints=user_ppoints-'"..cena.."' WHERE user_id = '"..uid.."'");
			outputChatBox("#388E00✔#e7d9b0 Kupiłeś/aś pakiet"..desc_pr..""..desc_sl..".", plr,231, 217, 176,true)
			refreshPoints(plr)
		end
	end
end)


addEvent("premium:refreshpoins",true)
addEventHandler("premium:refreshpoins",root,function(plr)
	refreshPoints(plr)
end)

function refreshPoints(user)
	local uid = getElementData(user,"player:dbid") or 0;
	if uid > 0 then
		local query = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id = '"..uid.."'");
		if #query > 0 then
			setElementData(user,"player:premiumPoints",query[1].user_ppoints)
		end
	end
end