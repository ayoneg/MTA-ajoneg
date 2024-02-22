--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Prolog.
]]--
local skin = getElementModel(localPlayer)
local show = false
local text = "test";

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end


local screenW, screenH = guiGetScreenSize()
addEventHandler("onClientRender", root,function()
	if show then
--		dxDrawText(text, (screenW - 796) / 2 + 1, (screenH - 72) / 2 + 1, ((screenW - 796) / 2) + 796 + 1, (screenH - 72) / 2) + 72 + 1, tocolor(0, 0, 0, 255), 1.30, "default", "center", "center", false, false, false, false, false)
		dxDrawText(text, ((screenW - 796) / 2)+1, ((screenH - 72) / 2)+1, (((screenW - 796) / 2) + 796)+1, (( (screenH - 72) / 2) + 72)+1, tocolor(0, 0, 0, 255), 1.30, "default", "center", "center", false, false, false, false, false)
		dxDrawText(text, (screenW - 796) / 2, (screenH - 72) / 2, ((screenW - 796) / 2) + 796, ( (screenH - 72) / 2) + 72, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
	end
end)

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


local pedynamapie={
	{"", 168, 2537.5048828125, 2291.1435546875, 10.8203125, 90, 0, 0, "GANGS", "prtial_gngtlkH"},
	{"Urmliusz", 72, 2538.7451171875, 2283.86328125, 10.8203125, -90, 0, 0, "GANGS", "smkcig_prtl"},
	{"", 55, 2540.0322265625, 2284.474609375, 10.8203125, 100, 0, 0, "GANGS", "prtial_gngtlkG"},
	{"Kodżo", 98, 2536.3125, 2320.982421875, 10.8203125, -110, 0, 0, "GANGS", "prtial_gngtlkH"},
	{"", skin, 2537.7138671875, 2320.501953125, 10.813302993774, 70, 0, 0, "GANGS", "prtial_gngtlkG"},	
	{"Urmliusz", 72, 2492.2041015625, 2300.109375, 10.8203125, -140, 0, 0, "GANGS", "smkcig_prtl", "blad"},
	{"Urmliusz", 72, 2536.9619140625, 2288.4716796875, 10.8203125, 90, 0, 0, "brak", "brak", "blad"},
}

function resppedy(gracz)
	if gracz==localPlayer then
		for i,v in ipairs(pedynamapie) do
			if i < 6 then
				local ped = createPed(v[2], v[3], v[4], v[5], v[6])
				setElementData(ped,"ped:name",v[1])
				setElementData(ped,"pedm:id",gracz)
				if tostring(v[9]) ~= "brak" then
					setElementData(ped,"pedm:ANI",true)
					setElementData(ped,"pedm:ANIun",v[9])
					setElementData(ped,"pedm:ANIuntu",v[10])
				end
				setElementInterior(ped, v[7])
				setElementDimension(ped, v[8])
				setElementFrozen(ped, true)
				if tostring(v[9]) ~= "brak" then
					setTimer(function()
						setPedAnimation(ped, v[9], v[10], -1, true, false)
					end, 150, 1)
				end
			end
		end
	end
end

function resppeda(gracz,tp)
	if gracz==localPlayer then
		for i,v in ipairs(pedynamapie) do
			if tonumber(tp)==i then
				ped = createPed(v[2], v[3], v[4], v[5], v[6])
				setElementData(ped,"ped:name",v[1])
				setElementData(ped,"pedm:id",gracz)
				setElementData(ped,"pedm:ids",i)
				if tostring(v[9]) ~= "brak" then
					setElementData(ped,"pedm:ANI",true)
					setElementData(ped,"pedm:ANIun",v[9])
					setElementData(ped,"pedm:ANIuntu",v[10])
				end
				setElementInterior(ped, v[7])
				setElementDimension(ped, v[8])
				setElementFrozen(ped, true)
				if tostring(v[9]) ~= "brak" then
					setTimer(function()
						setPedAnimation(ped, v[9], v[10], -1, true, false)
					end, 150, 1)
				end
				
				givePedWeapon(ped,8,9,true)
			end
		end
		setElementFrozen(gracz,false)
	end
end


function findPed(ped)
	for i,v in ipairs(getElementsByType('ped')) do
		local sprawdz = getElementData(v,"pedm:ids") or false;
		if sprawdz==ped then
			return v
		end
	end
	return false
end

function setAnim(ped,zmi1,zmi2)
	local ped = findPed(ped)
	if ped then
		setPedWeaponSlot(ped,0)
		setPedAnimation(ped, zmi1, zmi2, -1, false, false)
	end
end

function say(gracz,kto,wiadomosc)
	if gracz==localPlayer then
		outputChatBox(" ")
		outputChatBox("#EBB85D"..kto.."#ffffff: #e6e6e6"..wiadomosc,231, 217, 176,true)
	end
end

--setCameraTarget(localPlayer)
--setElementFrozen(localPlayer,false)

function off(gracz)
	if gracz==localPlayer then
		setCameraTarget(gracz)
		removeCamHandler()
--		setElementData(gracz,"player:hud2",true)
--		setPlayerHudComponentVisible("radar",true)
	end	
end


function cam(gracz,czas,gdzie1)
	if gracz==localPlayer then
		smoothMoveCamera(gdzie1[1], gdzie1[2], gdzie1[3], gdzie1[4], gdzie1[5], gdzie1[6], gdzie1[7], gdzie1[8], gdzie1[9], gdzie1[10], gdzie1[11], gdzie1[12], czas)
--		setTimer(off, czas+1500, 1, gracz)
		setElementData(gracz,"player:hud2",false)
		setPlayerHudComponentVisible("all",false)
	end
end

function setPos(gracz,x,y,z,rootZ)
	if isElement(gracz) then
		remPed(gracz)
		setElementPosition(gracz,x,y,z)
--		setCameraTarget(gracz)
		setElementRotation(gracz,0,0,rootZ)
		setElementFrozen(gracz,false)
	end
end

function remPed(gracz)
	for i,v in ipairs(getElementsByType('ped')) do
		local sprawdz = getElementData(v,"pedm:id") or false;
		if sprawdz==gracz then
			destroyElement(v)
		end
	end
end

function fade(gracz,type)
	if isElement(gracz) then
		if type then
			fadeCamera(false, 1.5)
		else
			fadeCamera(true)
		end
	end
end

function pokaukryjexe(gracz,var)
	setPlayerHudComponentVisible("area_name",false)
	setPlayerHudComponentVisible("radio",false) 
	setPlayerHudComponentVisible("money", false)
	setElementData(gracz,"player:hud2",var)
	setPlayerHudComponentVisible("radar",var)
end

function offShow(gracz)
	if isElement(gracz) then
		show = false
--		setPlayerHudComponentVisible("chatbox",true)
	end
end

function showText(gracz,tex,czas)
	if isElement(gracz) then
		show = true
		text = tex
		timer=setTimer(offShow, (czas*1000), 1, gracz)
--		setPlayerHudComponentVisible("chatbox",false)
	end
end

function rozpocznij(gracz)
	if isElement(gracz) then
		setElementFrozen(gracz, true)
		setElementPosition(gracz, 2544.013671875, 2320.8388671875, 10.813302993774-35)
	end
end

-------
local czystart = false
local show2
local scenka2
local tekstbt2 = "Zzatakuj go (widzisz że ma nóż)";
local czygotowy
local dokonane
local dialog = false

addEventHandler("onClientRender", root,function()
	if show2 then
        dxDrawImage((screenW - 366) / 2, (screenH - 403) / 2, 366, 403, ":aj-log2/back10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(797, 577, 324, 55, tocolor(24, 29, 43, 255), false)
        dxDrawRectangle(797, 655, 324, 55, tocolor(24, 29, 43, 255), false)
        dxDrawText("Urmliusz stoi przygotowany na odparcie ataku, jest uzbrojony. Widzisz, że trzyma nóż w ręce. \nBez broni palnej, nic tutaj nie zrobisz...\n\nSłyszałeś, że podobno w okolicach parku LS można zakupić broń. Warto sprawdzić wiarygodność tych informacji...", 797, 362, 1121, 522, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, true, false, false, false)
        dxDrawText(tekstbt2, 797 + 1, 583 + 1, 1121 + 1, 627 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText(tekstbt2, 797, 583, 1121, 627, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Wycofujesz się", 797 + 1, 661 + 1, 1121 + 1, 704 + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Wycofujesz się", 797, 661, 1121, 704, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
	end
	if dialog then
        dxDrawText(dialog:gsub("#%x%x%x%x%x%x",""), 603 + 1, 863 + 1, 1318 + 1, 947 + 1, tocolor(0, 0, 0, 255), 1.50, "default", "center", "center", true, false, false, false, false)
        dxDrawText(dialog, 603, 863, 1318, 947, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", true, false, false, true, false)
	end
end)

local sphe2 = createColSphere(2492.2041015625, 2300.109375, 10.8203125, 7)
	setElementData(sphe2,"misja:1",true)

addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function(prevSlot, curSlot)
	local uid = getElementData(localPlayer,"player:dbid") or 0;
	if uid > 0 then
		if czystart then
			if getPedWeapon(localPlayer, curSlot)==24 then
				gotowyaa(true,"Zzatakuj go")
			else
				gotowyaa(false,"Zzatakuj go (widzisz że ma nóż)")
			end
		end
	end
end)

function showDialog(gracz,tekstdialog)
	if isElement(gracz) and localPlayer==gracz then
		if tekstdialog then
			dialog = tekstdialog
		else
			dialog = false
		end
	end
end


function ukryjall(gracz,var)
	if not var then
		setPlayerHudComponentVisible("all",false)
	else
		setPlayerHudComponentVisible("all",true)
	end
	showChat(var);	
	setElementData(gracz,"player:hud2",var)
	setPlayerHudComponentVisible("area_name",false)
	setPlayerHudComponentVisible("radio",false) 
	setPlayerHudComponentVisible("money", false)
end

function gotowyaa(var,tekst)
	czygotowy = var
	tekstbt2 = tekst
end

local etap = 0
local plrms

function nowyetap(kto)
	if isElement(kto) then
		etap = etap + 1
		prolog_st(kto)	
	end
end

	
function playmusic()
	if misc then
		stopSound(misc);
	else
		misc=playSound(":aj-prolog/grand_theft_auto_4_theme_song.mp3",true);
		setSoundVolume(misc, 0.5);
	end
end
	
	
addEventHandler("onClientClick", root, function(btn,state)
	if show2 then
		if btn=="left" and state=="down" then
			--exit
			if isMouseInPosition(797, 655, 324, 55) then
				show2 = false
				scenka = true
				showCursor(false)
				setElementFrozen(localPlayer, false)
				ukryjall(localPlayer, true)
				toggleControl("next_weapon", false)
				toggleControl("previous_weapon", false)
			end
			
			if isMouseInPosition(797, 577, 324, 55) and czygotowy then
				show2 = false
				dokonane = true
				scenka = true
				showCursor(false)
				pokaukryjexe(localPlayer, false)
				setPedAnimation(localPlayer, "SWORD", "sword_IDLE", -1, true, false)
				setAnim(6, "ped", "handsup")
				-- satrt up
				etap = 17
				prolog_st(localPlayer)
			end
		end
	end
end)
	
addEventHandler("onClientColShapeHit", root, function(plr,md)
	if not md then return end
    if getElementType(plr) ~= "player" then return end
	if plr~=localPlayer then return end
	local jubiler2 = getElementData(source,"misja:1") or false;
	if jubiler2 then
		local veh = isPedInVehicle(plr) or false;
		if veh then return end
		if czystart then
			local uid = getElementData(plr,"player:dbid") or 0;
			if uid > 0 then
				if not dokonane then
					if not scenka then
						etap = 15
						prolog_st(plr)
					else
						etap = 16
						prolog_st(plr)
					end
				end
			end
		end
	end
end)

addEvent("misje:start", true)
addEventHandler("misje:start", root, function(kto)
	if isElement(kto) then
		if localPlayer==kto then
			if not czystart then
				czystart = true
				prolog_st(kto)
				fade(kto, false)
				setElementData(kto,"player:robimisje",true)
			end
		end
	end
end)

function prolog_st(kto)
	if isElement(kto) then
		if etap==0 then
--			fade(kto, true)
			setTimer(nowyetap, 1000, 1, kto)
		elseif etap==1 then
			resppedy(kto)
			ukryjall(kto, false)
--			local ktop = "Kodżo"
--			local wiadomosc = "Widzisz tego pajaca?"
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Kodżo: Widzisz tego pajaca?")
			setTimer(nowyetap, 100, 1, kto)
		elseif etap==2 then
			local gdzie1 = {2530.8688964844, 2319.3325195312, 12.071399688721, 2531.849609375, 2319.3911132812, 11.885372161865, 2531.8381347656, 2289.4377441406, 12.068799972534, 2532.6052246094, 2288.8422851562, 11.830140113831}
			cam(kto, 10000, gdzie1)
			rozpocznij(kto)
			setTimer(nowyetap, 8000, 1, kto)
		elseif etap==3 then
--			local ktop = "Kodżo"
--			local wiadomosc = "To on odbił mi dziewczyne... sukin kot..."
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Kodżo: To on odbił mi dziewczyne... sukin kot...")
			setTimer(nowyetap, 2650, 1, kto)
		elseif etap==4 then
			local gdzie1 = {2530.6279296875, 2310.3010253906, 16.683200836182, 2530.2202148438, 2310.87890625, 17.390308380127, 2541.2800292969, 2311.5236816406, 11.810000419617, 2540.7766113281, 2312.37109375, 11.641283035278}
			cam(kto, 10000, gdzie1)
			setTimer(nowyetap, 8000, 1, kto)
		elseif etap==5 then
--			local ktop = "Ty"
--			local wiadomosc = "Dokopie mu stary."
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Ty: Dokopie mu stary.")
			setTimer(nowyetap, 3000, 1, kto)
		elseif etap==6 then
--			local ktop = "Kodżo"
--			local wiadomosc = "Ty serio, chcesz mi pomóc?"
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Kodżo: Ty serio, chcesz mi pomóc?")
			setTimer(nowyetap, 3200, 1, kto)
		elseif etap==7 then
--			local ktop = "Kodżo"
--			local wiadomosc = "Jesteś niesamowity "..getPlayerName(kto).."!"
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Kodżo: Jesteś niesamowity "..getPlayerName(kto).."!")
			setTimer(nowyetap, 3650, 1, kto)
		elseif etap==8 then
--			fade(kto, true)
			showDialog(kto,false)
			setTimer(nowyetap, 1500, 1, kto)
		elseif etap==9 then
			setTimer(nowyetap, 350, 1, kto)
			local gdzie1 = {2537.7270507812, 2315.7119140625, 11.868300437927, 2536.943359375, 2315.1042480469, 11.740299224854, 2536.0656738281, 2296.9287109375, 11.823699951172, 2535.1638183594, 2296.5158691406, 11.695698738098}
			cam(kto, 5050, gdzie1)
		elseif etap==10 then
--			setCameraTarget(kto)
--			local ktop = "Kodżo"
--			local wiadomosc = "O kurwa, zuważył nas... Spierdala!"
--			say(kto, ktop, wiadomosc)
			resppeda(kto, 7)
			local ped = findPed(7)
			setPedAnimation(ped)
			setElementFrozen(ped,false)
			setPedControlState(ped, "forwards", true)
			setPedControlState(ped, "sprint", true)
--			ukryjall(kto, false)
--			showText(kto,"Kodżo: O kurwa, zuważył nas... Spierdala!",4)
			showDialog(kto,"Kodżo: O kurwa, zuważył nas... Ucieka!")
			setTimer(nowyetap, 4000, 1, kto)
		elseif etap==11 then
			fade(kto, true)
			showDialog(kto,"Ty: Dorwe go!")
--			ukryjall(kto, false)
			setTimer(nowyetap, 2000, 1, kto)
		elseif etap==12 then
--			setPos(kto, 2537.7138671875, 2320.501953125, 10.813302993774,70)
--			setElementFrozen(kto, true)
			showDialog(kto,false)
			off(kto)
			setPos(kto, 2537.7138671875, 2320.501953125, 10.813302993774,70)
			setElementFrozen(kto, true)
			setCameraTarget(kto)
--			showText(kto,"Biegnij za nim i rozlicz się z nim!",4)
			resppeda(kto, 6)
			setTimer(nowyetap, 4050, 1, kto)
		elseif etap==13 then
			setCameraTarget(kto)
			ukryjall(kto, true)
			fade(kto, false)
			setTimer(nowyetap, 1000, 1, kto)
			setElementFrozen(kto, false)
		elseif etap==14 then
--			setCameraTarget(kto)
--			setTimer(resppeda, 30000, 1, plr, 6)
			setElementData(kto,"player:robimisje",false)
		elseif etap==15 then
			setElementData(kto,"player:robimisje",true)
			toggleControl("next_weapon", false)
			toggleControl("previous_weapon", false)
			local gdzie1 = {2495.4267578125, 2288.1586914062, 11.880200386047, 2495.1291503906, 2289.0766601562, 11.617836952209,2498.2578125, 2307.8068847656, 15.007699966431, 2497.6879882812, 2307.1791992188, 14.477111816406}
			cam(kto, 7000, gdzie1)
			setElementFrozen(kto, true)
			setTimer(nowyetap, 7000, 1, kto)
		elseif etap==16 then
			setCameraTarget(kto)
			setElementFrozen(kto, true)
			off(kto)
			show2 = true
			showCursor(true)
		elseif etap==17 then
--			local ktop = "Urmliusz"
--			local wiadomosc = "Staty, nie rób tego ja nie chce... #767676((upuszcza nóż))"
--			say(kto, ktop, wiadomosc)
			ukryjall(kto, false)
			showDialog(kto,"Urmliusz: Stary, nie rób tego ja nie chce... #767676((upuszcza nóż))")
			setTimer(nowyetap, 5000, 1, kto)
		elseif etap==18 then
--			local ktop = "Urmliusz"
--			local wiadomosc = "Wyjade z SA, nigdy mnie nie zobaczycie, przysięgam... #767676((widać, że się boi))"
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Urmliusz: Wyjade z SA, nigdy mnie nie zobaczycie, przysięgam... #767676((widać, że się boi))")
			setTimer(nowyetap, 6000, 1, kto)
		elseif etap==19 then
--			local ktop = "Ty"
--			local wiadomosc = "Ta? Mhm żebym Cię tutaj więcej nie widział leszczu, bo Cię dojedziemy!"
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Ty: Ta? Mhm żebym Cię tutaj więcej nie widział leszczu, bo Cię dojedziemy!")
			setTimer(nowyetap, 5000, 1, kto)
		elseif etap==20 then
--			local ktop = "Urmliusz"
--			local wiadomosc = "Ttt Ta TTakk ... Obiecuje, nigdy..."
--			say(kto, ktop, wiadomosc)
			showDialog(kto,"Urmliusz: Ttt Ta TTakk ... Obiecuje, nigdy...")
			setTimer(nowyetap, 4000, 1, kto)
		elseif etap==21 then
			showDialog(kto,false)
			local ped = findPed(6)
			setPedAnimation(ped)
			setElementFrozen(ped,false)
			setElementRotation(ped, -90, 0, 0)
			setPedControlState(ped, "forwards", true)
			setPedControlState(ped, "sprint", true)
			fade(kto, true)
			setTimer(nowyetap, 2000, 1, kto)
		elseif etap==22 then
			rozpocznij(kto)
			ukryjall(kto, false)
			showText(kto,"Urmliusz uciekł z miasta tego samego dnia, a Kodżo odzyskał kobiete...",4)
			setTimer(nowyetap, 2000, 1, kto)
		elseif etap==23 then
			playmusic()
			setTimer(nowyetap, 2020, 1, kto)
		elseif etap==24 then
			showText(kto,"AJONEG PRZEDSTAWIA:",4)
			setTimer(nowyetap, 4000, 1, kto)
		elseif etap==25 then
			fade(kto, false)
			local gdzie1 = {2130.3920898438, 2448.8005371094, 44.268398284912, 2131.2277832031, 2449.1481933594, 43.843330383301, 1996.4510498047, 2587.0754394531, 53.284099578857, 1996.5040283203, 2588.0290527344, 52.987873077393}
			cam(kto, 20000, gdzie1)
			setTimer(nowyetap, 6000, 1, kto)
		elseif etap==26 then
			showText(kto,"OFICJALNY SERWER NA PLATFORMIE MTA",5)
			setTimer(nowyetap, 8500, 1, kto)
		elseif etap==27 then
			showText(kto,"Witamy w rodzinie!",4)
			setTimer(nowyetap, 5000, 1, kto)
		elseif etap==28 then
			fade(kto, true)
			setTimer(nowyetap, 2500, 1, kto)
		elseif etap==29 then
			setPos(kto, 2537.7138671875, 2320.501953125, 10.813302993774, 70)
			setCameraTarget(kto)
			setTimer(nowyetap, 1500, 1, kto)
		elseif etap==30 then
			toggleControl("next_weapon", true)
			toggleControl("previous_weapon", true)
			fade(kto, false)
			ukryjall(kto, true)
			playmusic()
			setCameraTarget(kto)
			setElementData(kto,"player:robimisje",false)
			
			triggerServerEvent("misje:nagrody",kto,kto,"prolog")
		end
		
	end
end




-- "Urmliusz zauważył was i zaczął uciekać do uliczki naprzeciwko..."
--- start





