
	function destroyBlipsAttachedTo(player)
    	local attached = getAttachedElements ( player )
    	if ( attached ) then
        	for k,element in ipairs(attached) do
            	if getElementType ( element ) == "blip" then
                	destroyElement ( element )
            	end
        	end
    	end
	end
	
	--// JAK GRACZ WYJDZIE
	addEventHandler("onPlayerJoin",root,function()
		destroyBlipsAttachedTo(source)
		setElementAlpha(source,0)
	end)
	
addEvent("jakGraczWchodziStart",true)
addEventHandler("jakGraczWchodziStart",root,function()
--    local result = dbPoll(dbQuery(db, "SELECT * FROM server_users WHERE user_serial = '"..getPlayerSerial(client).."'"),-1);
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_serial = '"..getPlayerSerial(client).."'");
	if(#result == 0) then 
		user_name_from_db=getPlayerName(client); 
	else 
		user_name_from_db=result[1].user_nickname; 
	end
	triggerClientEvent(client,"jakGraczWchodziOpen",client,user_name_from_db);
end)

addEvent("jakLoginHasloGitWyslij",true)
addEventHandler("jakLoginHasloGitWyslij",root,function(user_pass,user_nickname)
    local user_pass = md5("Aj0N3G_fG"..user_pass)
--		local result = dbPoll(dbQuery(db, "SELECT * FROM server_users WHERE user_nickname = '"..user_nickname.."' AND user_pass = '"..user_pass.."'"),-1);
		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_nickname=? AND user_pass=?",user_nickname,user_pass);
		if(#result >= 1) then
		--outputChatBox("Zalogowano!",client);
		
		
--    local wynik=dbQuery(db, "SELECT * FROM server_users WHERE user_nickname=?",user_nickname)
--    local wynikglowny=dbPoll(wynik,-1)
	
	local wynikglowny = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_nickname=?",user_nickname);
	user_id = wynikglowny[1].user_id;
	setElementData(source,"player:dbid", user_id)
	log_nic = wynikglowny[1].user_nickname;
	--local wynik_adm = dbPoll(dbQuery(db, "SELECT * FROM server_admins WHERE admin_serial='"..getPlayerSerial(client).."'"),-1);
	
--    local wynik_adm=dbQuery(db, "SELECT * FROM server_admins WHERE admin_serial='"..getPlayerSerial(client).."'")
--    local wynikglowny_adm=dbPoll(wynik_adm,-1)
	local serial_ADM = wynikglowny[1].user_serial;
	
	local wynikglowny_adm = exports["aj-dbcon"]:wyb("SELECT * FROM server_admins WHERE admin_serial='"..serial_ADM.."'");
	if #wynikglowny_adm > 0 and serial_ADM ~= getPlayerSerial(client) then
		-- proba wlamania na konto adm ?
		local desc22 = '### '..getPlayerName(client)..'/'..getElementData(source,"id")..' nieudana próba logowania na ADM!!!'
		triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
		
		local transfer_text=('[UWAGA!!!] '..getPlayerName(client)..'/'..getElementData(source,"player:dbid")..' nieudane logowanie do konta ADM '..serial_ADM..' (from '..getPlayerSerial(client)..')')	
		outputServerLog(transfer_text)
		
		-- tutaj potem mozna nadac auto ban ale to potem
	end
	if #wynikglowny_adm > 0 and serial_ADM == getPlayerSerial(client) then
	-- SPRAWDZAMY CZY MA SUPA / MODA / ADMINA / ROOT
	admin_poziom = wynikglowny_adm[1].admin_poziom;
	setElementData(source,"admin:poziom", admin_poziom)
	
	if admin_poziom >= 6 then -- JEŚLI ROOT,Admin,Mod ZALOGUJ
    setElementData(source,"admin:zalogowano", "true")
    setElementData(source,"player:ucho",true)
	-- logi
	
	local desc22 = '### '..log_nic..'/'..getElementData(source,"id")..' zalogował się na DUTY.'
	triggerClientEvent("admin:addText", resourceRoot, desc22:gsub("#%x%x%x%x%x%x",""))
	
	else -- JEŚLI NIE JEST adm,root TO NIE ZALOGUJ
	setElementData(source,"admin:zalogowano", "false")
	end
	else -- nie ma admina
	setElementData(source,"admin:poziom", 0)
	setElementData(source,"admin:zalogowano", "false")
	end
	
	errorText = "Witamy na serwerze "..user_nickname.."!";
	outputChatBox(errorText,client)
	--createBlipAttachedTo ( source, 0, 2, 100, 100, 100 )--robimy blipa
	setElementAlpha(source,255)
	
    setPlayerMoney(source,wynikglowny[1].user_money)
--	setPlayerSkin(source,wynikglowny[1].user_skin)
	setElementModel(source,wynikglowny[1].user_skin)
	playerSkin = wynikglowny[1].user_skin;
	setPlayerName(source,wynikglowny[1].user_nickname)
	
	--user_id = wynikglowny[1].user_id;
	user_katA = wynikglowny[1].user_katA;
	user_katB = wynikglowny[1].user_katB;
	user_katC = wynikglowny[1].user_katC;
	
	user_katL = wynikglowny[1].user_katL;
	user_katH = wynikglowny[1].user_katH;
	
	user_carslot = wynikglowny[1].user_carslot;
	
	user_PG = wynikglowny[1].user_pg;
	user_reputacja = wynikglowny[1].user_reputacja;
	user_plec = wynikglowny[1].user_plec;
	--spawnPlayer(source,1886.39709, 2339.41235, 11, -90, playerSkin)
	--setCameraTarget(source)
	
	toggleControl (source, "fire", false) 
	toggleControl (source, "action", false)
	toggleControl (source, "aim_weapon", false)
	toggleControl (source, "vehicle_fire", false)
	toggleControl (source, "vehicle_secondary_fire", false)

	--// ZAKAZ TYPE ==> [1] ==> MUTE
	local wynikglowny_blokadymute = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(client).."' AND zakaz_czas>NOW() AND zakaz_type='1'");
	if #wynikglowny_blokadymute > 0 then
	if wynikglowny_blokadymute[1].zakaz_value == 0 then 
	setElementData(source,"zakazy:mute", wynikglowny_blokadymute[1].zakaz_czas)
	else end
	end
	
	--// ZAKAZ TYPE ==> [2] ==> Poj. ABC
	local wynikglowny_blokadyprawko = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(client).."' AND zakaz_czas>NOW() AND zakaz_type='2'");
	if #wynikglowny_blokadyprawko > 0 then
	if wynikglowny_blokadyprawko[1].zakaz_value == 0 then 
	setElementData(source,"zakazy:prawko", wynikglowny_blokadyprawko[1].zakaz_czas)
	else end
	end
	
	--// ZAKAZ TYPE ==> [4] ==> LATANIElicka L,H
	local wynikglowny_blokadylatanie = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(client).."' AND zakaz_czas>NOW() AND zakaz_type='4'");
	if #wynikglowny_blokadylatanie > 0 then
	if wynikglowny_blokadylatanie[1].zakaz_value == 0 then 
	setElementData(source,"zakazy:latanie", wynikglowny_blokadylatanie[1].zakaz_czas)
	else end
	end
	
	
	--// WYBIERANIE I NADAWANIE ORG
	local wynikorg = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje_czlonkowie WHERE orguser_userid='"..user_id.."'");
	if #wynikorg > 0 then
		local plr_orgRANK = wynikorg[1].orguser_rank;
		local plr_orgID = wynikorg[1].orguser_orgid;
		local wynikorgother = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..plr_orgID.."'");
		if #wynikorgother > 0 then
			local org_name = wynikorgother[1].org_name;
			local org_shortname = wynikorgother[1].org_shortname;
			setElementData(source,"player:orgID",plr_orgID)
			setElementData(source,"player:orgNAME",org_name)
			setElementData(source,"player:orgShortNAME",org_shortname)
			setElementData(source,"player:orgRank",plr_orgRANK)
		end
	end
	
	--// NADANIE KAT A B C
	setElementData(source,"player:katA", user_katA)
	setElementData(source,"player:katB", user_katB)
	setElementData(source,"player:katC", user_katC)
	
	setElementData(source,"player:katL", user_katL)
	setElementData(source,"player:katH", user_katH)
	
	--setElementData(source,"player:dbid", user_id)
	setElementData(source,"player:skinid", playerSkin)
	setElementData(source,"player:PG", user_PG)
	setElementData(source,"player:reputacja", user_reputacja)
	setElementData(source,"player:plec", user_plec)
	setElementData(source,"player:minuty",0)
	setElementData(source,"player:carSlot",user_carslot)
	
	setElementData(source,"player:hud2",true)
	setElementData(source,"admin:noticeKILL",true)
	
	local vehondp = exports["aj-dbcon"]:wyb("SELECT IFNULL(SUM(veh_parking),0) veh_suma FROM server_vehicles WHERE veh_owner='"..user_id.."'");
	if #vehondp > 0 then
	setElementData(source,"player:vehondp",vehondp[1].veh_suma)
	end
	setElementFrozen(source, false)
	
	--// PREMIUM ACCOUNT (TYPE 1)
	local wyb_prem_s = exports["aj-dbcon"]:wyb("SELECT * FROM server_premium WHERE p_userid='"..user_id.."' AND p_type='1' AND p_days>NOW()");
	if #wyb_prem_s > 0 then
		setElementData(source,"player:premium", 1)
		setElementData(source,"player:premium_time", wyb_prem_s[1].p_days)
		outputChatBox(" ",client) 
		outputChatBox("Posiadasz aktywny pakiet premium!",client) 
		outputChatBox("Wygasa: "..wyb_prem_s[1].p_days,client) 
		outputChatBox(" ",client) 
	end
	
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_userid=? LIMIT 1;",user_id)
	if result and #result > 0 then
		local code = tostring(result[1].fra_frakcjaid);
		if code=="SAPD" or code=="USM" then
			setElementData(source,"player:frakcjaCODE",code)
		end
	end
	
	odswiezMeneliXD()
		
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_lastlogindata=NOW() WHERE user_id='"..user_id.."'"); -- athh
		
		value = true;
		triggerClientEvent(client,"jakGraczSieZaloguje",client,value);
		
	else
		local query = exports["aj-dbcon"]:upd("INSERT INTO server_nieudanelog SET nlog_nickname=?, nlog_serial=?, nlog_data=NOW()",user_nickname,getPlayerSerial(client));
		return triggerClientEvent("pokaz_blad",source,"Błąd, podany login i/lub hasło są niepoprawne!")
	end

end)

function odswiezMeneliXD() -- odsiweza animacje pedow na mapie
	for i,v in ipairs(getElementsByType('ped')) do
		local sprawdz = getElementData(v,"zb2") or false;
		if sprawdz then
    		setTimer(function()
			losowanie = math.random(1,4)
    		if losowanie == 1 then setPedAnimation(v, "CRACK", "crckidle2", -1, true, false) end
			if losowanie == 2 then setPedAnimation(v, "CRACK", "crckidle4", -1, true, false) end
			if losowanie == 3 then setPedAnimation(v, "BEACH", "ParkSit_W_loop", -1, true, false) end
			if losowanie == 4 then setPedAnimation(v, "BEACH", "ParkSit_M_loop", -1, true, false) end
    		end, 250, 1)
		end
		local sprawdz2 = getElementData(v,"ped:ANI") or false;
		if sprawdz2 then
			local ani1 = getElementData(v,"ped:ANIun")
			local ani2 = getElementData(v,"ped:ANIuntu")
			setPedAnimation(v, tostring(ani1), tostring(ani2), -1, true, false)
		end
	end
end

addEvent("jakRegLoginHasloGitWyslij",true)
addEventHandler("jakRegLoginHasloGitWyslij",root,function(user_nickname,user_pass,plec)
	local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_nickname=?",user_nickname);
    if(#result == 0) then
	    
	    --WSZYSTKO GIT DODAJE
	    user_pass = md5("Aj0N3G_fG"..user_pass);
		-- LIMIT KONT NA SERIAL : 2
		user_serial=getPlayerSerial(client);
		user_limitaccount = 2;
		
			local result2 = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_serial=?",user_serial);
			if(#result >= 2) then
				return triggerClientEvent("pokaz_blad",source,"Błąd, przekroczono limit kont na serial!")
			else
				if plec == 1 then skin=12; else skin=0; end
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_users SET user_nickname=?, user_pass=?, user_serial=?,  user_regdata=NOW(), user_plec=?, user_skin=?, user_carslot='3'",user_nickname,user_pass,user_serial,plec,skin);
				
				triggerClientEvent("uktyjPanelReg",source,"false")
				
			    return triggerClientEvent("pokaz_blad",source,"Pomyślnie założono konto! - teraz możesz się zalogować.")
			end
		
		
	else
	    return triggerClientEvent("pokaz_blad",source,"Błąd, podany nick jest już zajęty!")
	end
end)



addEvent("sprawdzbany",true)
addEventHandler("sprawdzbany",root,function(test)
	--// ZAKAZ TYPE ==> [5] ==> BANY
	--// ZAKAZ TYPE ==> [5] ==> BANY
	player_dbid = getElementData(source,"player:dbid") or 0;
	if player_dbid > 0 then
	local wynikglowny_blokady = exports["aj-dbcon"]:wyb("SELECT * FROM server_zakazy WHERE zakaz_userserial='"..getPlayerSerial(client).."' AND zakaz_czas>NOW() AND zakaz_type='5'");
	if #wynikglowny_blokady > 0 then
	if wynikglowny_blokady[1].zakaz_value == 0 then 
	local wyn10 = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..wynikglowny_blokady[1].zakaz_fromadmin.."'");
	local plr = source
    
	outputConsole(" ",plr)
	outputConsole(" ",plr)
	outputConsole(" ",plr)
	outputConsole(" ",plr)
	outputConsole("---------------------------- [ZBANOWANY] ----------------------------",plr) 
	outputConsole("Przez: "..wyn10[1].user_nickname,plr) 
	outputConsole("Twój serial: "..wynikglowny_blokady[1].zakaz_userserial,plr) 
	outputConsole("Ban aktywny do: "..wynikglowny_blokady[1].zakaz_czas,plr)
	outputConsole("Powód zbanowania: "..wynikglowny_blokady[1].zakaz_desc,plr)
	outputConsole("------------------------------------------------------------------------------",plr)
	outputConsole("Jeżeli uważasz, że ban jest niesłuszny, bądź chciałbyś",plr)
	outputConsole("wnioskować o wcześniejsze zwolnienie z kary, napisz apelację.",plr)
	outputConsole("------------------------------------------------------------------------------",plr)
	kickPlayer(source, "Więcej: ~ lub F8")
	end
    end
	end
end)


addEvent("robimyBlipaGracza",true)
addEventHandler("robimyBlipaGracza",root,function(player)
    removeElementData(player,"player:showpanelwyboru")
    removeElementData(player,"player:vehondp")
	-- suto blip gett
	local premium = getElementData(player,"player:premium") or 0;
	if premium > 0 then
		-- jesli premium
		r = 239
		g = 208
		b = 12
	else
	    -- jesli nie premium
		local RNG = math.random(0,2)
		if RNG==0 then
			r = 100
			g = 100
			b = 100
		end
		if RNG==1 then
			r = 167
			g = 167
			b = 167
		end
		if RNG==2 then
			r = 255
			g = 255
			b = 255
		end
	end
	setElementData(player,"player:colorRGB",{r,g,b})
	createBlipAttachedTo(player,0,2,r,g,b)
	
	triggerEvent("policja:refreshwantedlvl",player,player)
end)

addCommandHandler("testrgb", function(plr,cmd)
	local rgb = getElementData(plr,"player:colorRGB")
	outputChatBox("R: "..rgb[1].." G: "..rgb[2].." B: "..rgb[3],plr)
end)

