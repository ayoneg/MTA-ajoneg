--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt logowania na konto.
]]--
triggerServerEvent("jakGraczWchodziStart",localPlayer);
local screenW, screenH = guiGetScreenSize()
errorText=false

local sm = {}
sm.moov = 0

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local start
local animTime
local tempPos = {{},{}}
local tempPos2 = {{},{}}

local function camRender()
	local now = getTickCount()
	if (sm.moov == 1) then
		local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start)/animTime, "InOutQuad")
		local x2,y2,z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start)/animTime, "InOutQuad")
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientRender",root,camRender)
--		fadeCamera(true)
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1) then
		killTimer(timer1)
--		killTimer(timer2)
		removeEventHandler("onClientRender",root,camRender)
--		fadeCamera(true)
	end
--	fadeCamera(true)
	sm.moov = 1
	timer1 = setTimer(removeCamHandler,time,1)
--	timer2 = setTimer(fadeCamera, time-1000, 1, false) -- 
	start = getTickCount()
	animTime = time
	tempPos[1] = {x1,y1,z1}
	tempPos[2] = {x1t,y1t,z1t}
	tempPos2[1] = {x2,y2,z2}
	tempPos2[2] = {x2t,y2t,z2t}
	addEventHandler("onClientRender",root,camRender)
	return true
end

local posid = 0
local possum = 6

function newpos(type)
	if type then
		fadeCamera(false, 1.5)
	else
	posid = posid + 1
	fadeCamera(true)
	if posid==1 then
		czas = 15000
		smoothMoveCamera(2638.7573242188, 983.54602050781, 43.330001831055, 2637.9301757812, 984.03161621094, 43.047290802002, 2424.6647949219, 892.83380126953, 43.680698394775, 2425.0217285156, 893.70831298828, 43.352165222168, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid==2 then
		czas = 25000
		smoothMoveCamera(2050.4985351562, 820.57507324219, 74.420303344727, 2051.3029785156, 821.09338378906, 74.130149841309, 2061.93359375, 1698.0169677734, 48.490798950195, 2062.6860351562, 1698.5909423828, 48.167881011963, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid==3 then
		czas = 15000
		smoothMoveCamera(2030.9560546875, 1706.9432373047, 27.792200088501, 2030.2646484375, 1706.2526855469, 27.57984161377, 1649.2143554688, 1947.5595703125, 59.345798492432, 1649.8148193359, 1946.8764648438, 58.930194854736, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid==4 then
		czas = 19000
		smoothMoveCamera(1003.4501953125, 1828.0118408203, 44.180500030518, 1004.106262207, 1828.6553955078, 43.786296844482, 583.69348144531, 1828.1949462891, 32.655700683594, 584.31774902344, 1828.9515380859, 32.461082458496, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid==5 then
		czas = 19000
		smoothMoveCamera(2630.8134765625, 922.26599121094, 43.768901824951, 2631.4741210938, 921.54852294922, 43.548305511475, 2771.2426757812, 1066.8686523438, 41.997501373291, 2771.7543945312, 1066.0096435547, 42.008750915527, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid==6 then
		czas = 19000
		smoothMoveCamera(127.44460296631, 1222.2078857422, 52.737201690674, 126.82987213135, 1221.5074462891, 52.374546051025, -330.08599853516, 1169.6586914062, 51.625400543213, -329.46487426758, 1170.4117431641, 51.408252716064, czas)
		poss = setTimer(newpos, czas+50, 1, false)
		poss2 = setTimer(newpos, czas-1500, 1, true)
	end
	if posid > possum then 
		posid=0; 
		newpos(); 
	end
	end
end


addEvent("jakGraczWchodziOpen",true)
addEventHandler("jakGraczWchodziOpen",root,function(user_name_from_db)
    showCursor(true);
	showChat(false);
    setPlayerHudComponentVisible("all",false) 
    setElementFrozen(localPlayer, true)
	setElementPosition(localPlayer, 0, 0, -23)
	
--	setCameraMatrix(2494.646484375, 836.599609375, 35.268157958984, -2469.8785400391, 1319.25317382813, 10)
--	smoothMoveCamera(2004.9749755859, 2512.0270996094, 67.498397827148, 2004.7724609375, 2512.9636230469, 67.21248626709, 2066.1511230469, 729.04089355469, 68.730400085449, 2066.1960449219, 730.00219726562, 68.458595275879, 100000)
--	fadeCamera(false, 1.5)
	newpos()
	--[[
	    SOUND INFO
			Song: Syn Cole - Gizmo [NCS Release]
			Music provided by NoCopyrightSounds
			Free Download/Stream: http://ncs.io/Gizmo
			Watch: http://youtu.be/pZzSq8WfsKo
			-- Syn_Cole-Gizmo_[NCS_Release].mp3
	]]
	if math.random(1,2)==1 then
		misc=playSound(":aj-log2/Syn_Cole-Gizmo_[NCS_Release].mp3",true);
	else
		misc=playSound(":aj-log2/Relax_Junona_Boys.mp3",true);
	end
	setSoundVolume(misc, 0.5);
	

        global_box = guiCreateStaticImage(0.00, 0.00, 0.32, 1.00, ":aj-log2/back10.png", true)

        panel_logo = guiCreateStaticImage(0.25, 0.07, 0.46, 0.25, ":aj-log2/ajoneg.png", true, global_box)
        panel_name_input = guiCreateEdit(0.07, 0.42, 0.85, 0.06, user_name_from_db, true, global_box)
        panel_haslo_input = guiCreateEdit(0.07, 0.53, 0.85, 0.06, "", true, global_box)
        guiEditSetMasked(panel_haslo_input, true)
        panel_login_info = guiCreateLabel(0.07, 0.39, 0.44, 0.02, "Podaj login:", true, global_box)
        panel_haslo_info = guiCreateLabel(0.07, 0.51, 0.44, 0.02, "Podaj hasło:", true, global_box)
        panel_button_zaloguj = guiCreateButton(0.07, 0.63, 0.85, 0.09, "Zaloguj", true, global_box)
        panel_button_nowekonto = guiCreateButton(0.62, 0.73, 0.30, 0.04, "Nowe konto -->", true, global_box)
		
        function pokazblod ()
        if errorText then
        pzzr = pokazanoblod or 0;
        if pzzr == 0 then
        panel_error_desc = guiCreateLabel(0.06, 0.80, 0.86, 0.05, errorText, true, global_box)
        guiSetFont(panel_error_desc, "italic")
        guiLabelSetColor(panel_error_desc, 169, 0, 0)
        guiLabelSetHorizontalAlign(panel_error_desc, "center", true)
        guiLabelSetVerticalAlign(panel_error_desc, "center")  
        pokazanoblod = 1;
        else
        destroyElement(panel_error_desc)
        panel_error_desc = guiCreateLabel(0.06, 0.80, 0.86, 0.05, errorText, true, global_box)
        guiSetFont(panel_error_desc, "italic")
        guiLabelSetColor(panel_error_desc, 169, 0, 0)
        guiLabelSetHorizontalAlign(panel_error_desc, "center", true)
        guiLabelSetVerticalAlign(panel_error_desc, "center")  
        pokazanoblod = 1;
        end
        end  
        end -- fnck ernd
	
		
        panel_reg = guiCreateWindow(0.33, 0.22, 0.50, 0.50, "Nowe konto", true)
        guiWindowSetSizable(panel_reg, false)

        panel_reg_input_nick = guiCreateEdit(0.05, 0.13, 0.37, 0.10, "", true, panel_reg)
        panel_reg_input_haslo = guiCreateEdit(0.05, 0.29, 0.37, 0.10, "", true, panel_reg)
        panel_reg_input_ponownie_haslo = guiCreateEdit(0.05, 0.46, 0.37, 0.10, "", true, panel_reg)
        panel_reg_buttonstart = guiCreateButton(0.05, 0.78, 0.37, 0.17, "Stwórz nowe konto", true, panel_reg)
        panel_reg_nick = guiCreateLabel(0.05, 0.10, 0.20, 0.05, "Podaj nick (login):", true, panel_reg)
        panel_reg_haslo = guiCreateLabel(0.05, 0.26, 0.20, 0.05, "Podaj hasło:", true, panel_reg)
        panel_reg_ponownie_haslo = guiCreateLabel(0.05, 0.43, 0.20, 0.05, "Ponownie podaj hasło:", true, panel_reg)
        panel_regulamin_desc = guiCreateMemo(0.47, 0.13, 0.48, 0.69, ":-)\n:-D\nble ble", true, panel_reg)
        panel_regulamin = guiCreateLabel(0.47, 0.10, 0.20, 0.05, "Regulamin serwera:", true, panel_reg)
        reg_regulamin_zgoda = guiCreateCheckBox(0.58, 0.86, 0.37, 0.08, "Przeczytałem/am oraz zgadzam się z regulaminem serwera.", false, true, panel_reg)
        reg_kobieta = guiCreateRadioButton(0.05, 0.67, 0.17, 0.05, "Kobieta", true, panel_reg)
        reg_mezczyzna = guiCreateRadioButton(0.25, 0.67, 0.17, 0.05, "Mężczyzna", true, panel_reg)
        guiRadioButtonSetSelected(reg_mezczyzna, true)
        panel_reg_postac_w_grze = guiCreateLabel(0.05, 0.63, 0.20, 0.05, "Postać w grze:", true, panel_reg)    
        guiEditSetMasked(panel_reg_input_haslo, true)
        guiEditSetMasked(panel_reg_input_ponownie_haslo, true)		
        guiSetVisible(panel_reg,false)
	
    local blokada = {}
	addEventHandler("onClientGUIClick",panel_button_zaloguj,function()
	if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then return end
	
	    local pass = guiGetText(panel_haslo_input);
		local nickname = guiGetText(panel_name_input);
		
		if string.len(nickname) < 2 then
			errorText = "Błąd, login powinien zawierać min. 3 znaki!";
			pokazblod()
        return end
		if string.len(pass) < 2 then
			errorText = "Błąd, podaj pełne hasło!";
			pokazblod()
        return end
		triggerServerEvent("jakLoginHasloGitWyslij",localPlayer,pass,nickname);
		
		blokada[localPlayer] = getTickCount()+2000; -- 2 sek zabezpieczenia
	end,false)
	
	addEventHandler("onClientGUIClick",panel_button_nowekonto,function()
		if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then return end
	
		guiSetVisible(panel_reg,true)
		
		blokada[localPlayer] = getTickCount()+2000; -- 2 sek zabezpieczenia
	end,false)
	
	addEventHandler("onClientGUIClick",panel_reg_buttonstart,function()
		if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then return end
	
	local user_nickname = guiGetText(panel_reg_input_nick);
	local user_pass = guiGetText(panel_reg_input_haslo);
	local user_pass2 = guiGetText(panel_reg_input_ponownie_haslo);
		local zgodaregulamin = guiCheckBoxGetSelected(reg_regulamin_zgoda)
		if zgodaregulamin == false then
			errorText = "Aby stworzyć konto, musisz zgodzić się z regulaminem serwera.";
			pokazblod()
			return
		end
		if string.len(user_nickname) < 2 or string.len(user_nickname) > 25 then
			errorText = "Błąd, login powinien zawierać od 3 do 25 znaków!";
			pokazblod()
        return end
		if string.len(user_pass) < 7 or string.len(user_pass) > 25 then
			errorText = "Błąd, hasło powino zawierać od 8 do 25 znaków!";
			pokazblod()
        return end
		if string.len(user_pass2) < 7 or string.len(user_pass2) > 25 then
			errorText = "Błąd, hasło powino zawierać od 8 do 25 znaków!";
			pokazblod()
        return end
		if user_pass2 ~= user_pass then
			errorText = "Błąd, podane hasła nie są takie same!";
			pokazblod()
        return end		
		
		if guiRadioButtonGetSelected(reg_kobieta) then plec=1; end
		if guiRadioButtonGetSelected(reg_mezczyzna) then plec=0; end
	triggerServerEvent("jakRegLoginHasloGitWyslij",localPlayer,user_nickname,user_pass,plec);
		blokada[localPlayer] = getTickCount()+2000; -- 2 sek zabezpieczenia
	end,false)
	
end)

addEvent("uktyjPanelReg",true)
addEventHandler("uktyjPanelReg",root,function()
guiSetVisible(panel_reg,false)
end)

addEvent("jakGraczSieZaloguje",true)
addEventHandler("jakGraczSieZaloguje",root,function(value)
    guiSetVisible(global_box,false)
	if ( guiGetVisible ( panel_reg ) == true ) then
	guiSetVisible(panel_reg,false)
	end
	value="true";
    triggerServerEvent("sprawdzbany",localPlayer,value);
	triggerEvent("onClientLoggingShowSpawns",root)
end)


addEvent("onClientLoggingShowSpawns",true)
addEventHandler("onClientLoggingShowSpawns",root,function()

addEventHandler("onClientRender", root, pokazPanelWyboru)
			
end)

local screenW, screenH = guiGetScreenSize()
function isMouseIn(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*screenW,cy*screenH
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function pokazPanelWyboru()
        vehondp = getElementData(localPlayer,"player:vehondp") or 0;
        dxDrawRectangle(screenW * 0.0026, screenH * 0.0509, screenW * 0.2589, screenH * 0.0361, tocolor(12, 12, 12, 211), false)
        dxDrawText("#ffffffPrzechowywalnia pojazdów - #ff0000"..vehondp.."", screenW * 0.0042, screenH * 0.0509, screenW * 0.2583, screenH * 0.0870, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, true, false)
        dxDrawRectangle(screenW * 0.0026, screenH * 0.0963, screenW * 0.2589, screenH * 0.0361, tocolor(12, 12, 12, 211), false)
        dxDrawText("Urząd miasta LV", screenW * 0.0042, screenH * 0.0963, screenW * 0.2583, screenH * 0.1324, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
		-- 472p w dol -- i tylko dxDrawRectangle jako obszar nie tekst!!!!@!@
        dxDrawRectangle(screenW * 0.0026, screenH * 0.1435, screenW * 0.2589, screenH * 0.0361, tocolor(12, 12, 12, 211), false)
		dxDrawText("Fort Carson", screenW * 0.0042, screenH * 0.1472, screenW * 0.2583, screenH * 0.1759, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
		
		local wdol = 0.1435
		local wdol2 = 0.1759
		for i,home in ipairs(getElementsByType("pickup")) do
			local getOwner = getElementData(home,"dom:owner") or 0;
			local uid = getElementData(localPlayer,"player:dbid") or 0;
			local getOwnerGroup = getElementData(home,"dom:ownergroup") or 0;
			local orgID = getElementData(localPlayer,"player:orgID") or 0;
			if ( tonumber(uid) > 0 and tonumber(uid) == tonumber(getOwner) ) or ( tonumber(getOwnerGroup) == tonumber(orgID) and tonumber(orgID) > 0 ) then
				wdol = wdol + 0.0472;
				wdol2 = wdol2 + 0.0472;
				local domname = getElementData(home,"dom:name") or "";
				dxDrawRectangle(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361, tocolor(12, 12, 12, 211), false)
				dxDrawText(domname, screenW * 0.0042, screenH * wdol, screenW * 0.2583, screenH * wdol2, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
				local homeID = getElementData(home,"dom:id") or 0;
				if isMouseIn(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361) then slspw = "domek-"..homeID; pokazOpisWybranegoSpawn(slspw); end
			end
		end
		
		local frakcja = getElementData(localPlayer,"player:frakcjaCODE") or "";
		if tostring(frakcja)=="SAPD" then
			wdol = wdol + 0.0472;
			wdol2 = wdol2 + 0.0472;
			dxDrawRectangle(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361, tocolor(12, 12, 12, 211), false)
			dxDrawText("Policja", screenW * 0.0042, screenH * wdol, screenW * 0.2583, screenH * wdol2, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
			if isMouseIn(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361) then slspw = "SAPD"; pokazOpisWybranegoSpawn(slspw); end
		end
		
		if isMouseIn(screenW * 0.0026, screenH * 0.0509, screenW * 0.2589, screenH * 0.0361) then 
			slspw = "spawnlv"; 
			pokazOpisWybranegoSpawn(slspw);	
		end
		if isMouseIn(screenW * 0.0026, screenH * 0.0963, screenW * 0.2589, screenH * 0.0361) then 
			slspw = "umlv"; 
			pokazOpisWybranegoSpawn(slspw); 
		end
		if isMouseIn(screenW * 0.0026, screenH * 0.1435, screenW * 0.2589, screenH * 0.0361) then
			slspw = "fcsa"; 
			pokazOpisWybranegoSpawn(slspw); 
		end
		
		setElementData(localPlayer,"player:showpanelwyboru",true)
end

function pokazOpisWybranegoSpawn(slspw)
        if slspw == "spawnlv" then 
		slteXt = "Przechowywalnia pojazdów\nBank of San Andreas\nGiełda pojazdów\nTunning pojazdów\nMechanik pojazdów"; 
		end
        if slspw == "umlv" then 
		slteXt = "Urząd miasta SA\nNiewielka kaplica\nPark wypoczynkowy"; 
		end
        if slspw == "fcsa" then 
		slteXt = "Szkoła jazdy kat. B\nHandlarz pojazdów (Cygan)"; 
		end
		-- FRAKCJE
        if slspw == "SAPD" then
		slteXt = "Komenda Główna Policji"; 
		end
		
		for i,home in ipairs(getElementsByType("pickup")) do
			local getOwner = getElementData(home,"dom:owner") or 0;
			local uid = getElementData(localPlayer,"player:dbid") or 0;
			local getOwnerGroup = getElementData(home,"dom:ownergroup") or 0;
			local orgID = getElementData(localPlayer,"player:orgID") or 0;
			local homeID = getElementData(home,"dom:id") or 0;
			if ( tonumber(uid) > 0 and tonumber(uid) == tonumber(getOwner) ) or ( tonumber(getOwnerGroup) == tonumber(orgID) and tonumber(orgID) > 0 ) then
				local zmienna = "domek-"..homeID;
				local domname = getElementData(home,"dom:name") or "";
				local x,y,z = getElementPosition(home)
				local ulica = getZoneName(x,y,z, false)
				local ulica2 = getZoneName(x,y,z, true)
				if ulica2~=ulica then ulica = ""..ulica.."\n"..ulica2 else ulica = ""..ulica end
				if slspw == zmienna then slteXt = domname.."\nNumer nieruchomości "..homeID.."\n\n"..ulica; end
			end
		end
		
		-- odbieramy dane i wyswietlamy graczowi :-)
        dxDrawText(slteXt, (screenW * 0.2880) + 1, (screenH * 0.0546) + 1, (screenW * 0.4510) + 1, (screenH * 0.3824) + 1, tocolor(0, 0, 0, 255), 1., "default", "left", "top", false, false, false, false, false)
        dxDrawText(slteXt, screenW * 0.2880, screenH * 0.0546, screenW * 0.4510, screenH * 0.3824, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, false, false, false)
end


addEventHandler("onClientClick", root, function(btn,state)
getcnfg = getElementData(localPlayer,"player:showpanelwyboru") or false;
if getcnfg == true then
    if btn=="left" and state=="down" then
        if isMouseIn(screenW * 0.0026, screenH * 0.0509, screenW * 0.2589, screenH * 0.0361) then -- przecho lv
        setElementData(localPlayer,"player:spawn",{1947.0380859375, 2445.0791015625, 11.178249359131, -180})
        closeEtc()
		closeot()
        end
		
        if isMouseIn(screenW * 0.0026, screenH * 0.0963, screenW * 0.2589, screenH * 0.0361) then -- umlv
        setElementData(localPlayer,"player:spawn",{2464.5732421875, 1020.98828125, 10.820312, -180})
        closeEtc()
		closeot()
        end
		
        if isMouseIn(screenW * 0.0026, screenH * 0.1435, screenW * 0.2589, screenH * 0.0361) then -- umlv
        setElementData(localPlayer,"player:spawn",{-19.783203125, 1185.150390625, 19.358837127686, 0})
        closeEtc()
		closeot()
        end
		
		local wdol = 0.1435
		for i,home in ipairs(getElementsByType("pickup")) do
			local getOwner = getElementData(home,"dom:owner") or 0;
			local uid = getElementData(localPlayer,"player:dbid") or 0;
			local getOwnerGroup = getElementData(home,"dom:ownergroup") or 0;
			local orgID = getElementData(localPlayer,"player:orgID") or 0;
			if ( tonumber(uid) > 0 and tonumber(uid) == tonumber(getOwner) ) or ( tonumber(getOwnerGroup) == tonumber(orgID) and tonumber(orgID) > 0 ) then
				wdol = wdol + 0.0472;
				local homeID = getElementData(home,"dom:id") or 0;
				if isMouseIn(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361) then 
					local p = getElementData(home,"dom:wyjscie") or {0, 0, -20}
					local rootZ = getElementData(home,"dom:root") or 0;
					setElementData(localPlayer,"player:spawn",{p[1], p[2], p[3], rootZ})
					closeEtc()
					closeot()
				end
			end
		end
		local frakcja = getElementData(localPlayer,"player:frakcjaCODE") or "";
		if tostring(frakcja)=="SAPD" then
			wdol = wdol + 0.0472;
			if isMouseIn(screenW * 0.0026, screenH * wdol, screenW * 0.2589, screenH * 0.0361) then 
				setElementData(localPlayer,"player:spawn",{2287.0712890625, 2427.9248046875, 10.8203125, 180})
				closeEtc()
				closeot()
			end
		end
		
    end
end
end)

function closeot()
	if isTimer(poss) then killTimer(poss) end
	if isTimer(poss2) then killTimer(poss2); fadeCamera(true) end
end

function closeEtc()
setTimer(function()
    setElementAlpha(localPlayer,255)
	setCameraTarget(localPlayer)
	removeCamHandler()
	
	stopSound(misc);
	
	showChat(true);	
--	showPlayerHudComponent("all",true);
	setPlayerHudComponentVisible("all",true)
	setPlayerHudComponentVisible("area_name",false)
	setPlayerHudComponentVisible("radio",false) 
--	showPlayerHudComponent("area_name", false)
--	showPlayerHudComponent("radio", false)
	setPlayerHudComponentVisible("money", false)
	setElementData(localPlayer,"player:pokazKase",true)
	-- voicee
	setPedVoice(localPlayer, "PED_TYPE_DISABLED", nil)
	
end, 2000, 1)

	removeEventHandler("onClientRender", root, pokazPanelWyboru)
	showCursor(false);
 
	setElementFrozen(localPlayer, true)
	triggerServerEvent("robimyBlipaGracza",localPlayer,localPlayer);
	triggerServerEvent("core:spawnPlayer",localPlayer)

end

addEvent("pokaz_blad",true)
addEventHandler("pokaz_blad",root,function(txt)
    if source==localPlayer then
	    errorText=txt
		pokazblod()
	end
end)

local gameView={"Logi serwerowe:"}

addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text)
dbid = getElementData(localPlayer,"player:dbid") or 0;
if dbid > 0 then
	table.insert(gameView, text)	
	if #gameView > 14 then
		table.remove(gameView, 2)
	end
end
end)
