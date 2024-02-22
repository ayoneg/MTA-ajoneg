--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt frakcji SAPD beta.
]]--
local screenW, screenH = guiGetScreenSize()

local frakcje = {}
frakcje.okno = guiCreateWindow(0.61, 0.42, 0.16, 0.23, "Ładowanie ---", true)
guiWindowSetMovable(frakcje.okno, false)
guiWindowSetSizable(frakcje.okno, false)
frakcje.okno_desc = guiCreateLabel(0.04, 0.14, 0.91, 0.36, "---", true, frakcje.okno)  
frakcje.button_start = guiCreateButton(0.04, 0.54, 0.91, 0.42, "---", true, frakcje.okno)
guiSetVisible(frakcje.okno, false)


local poli = {}
poli.mandat_gui = guiCreateWindow((screenW - 331) / 2, (screenH - 395) / 2, 331, 395, "Mandaty", false)
guiWindowSetSizable(poli.mandat_gui, false)

poli.mandat_pay = guiCreateButton(20, 77, 293, 62, "Zapłać ---$", false, poli.mandat_gui)
poli.mandat_pris = guiCreateButton(20, 149, 293, 62, "Odsiedź w więzieniu", false, poli.mandat_gui)
poli.mandat_exit = guiCreateButton(20, 297, 293, 62, "Nic nie rób", false, poli.mandat_gui)
poli.mandat_cena = guiCreateLabel(20, 31, 293, 36, "Kwota: ---$", false, poli.mandat_gui)
guiSetFont(poli.mandat_cena, "default-bold-small")
guiLabelSetColor(poli.mandat_cena, 207, 0, 0)
guiLabelSetHorizontalAlign(poli.mandat_cena, "center", false)
guiLabelSetVerticalAlign(poli.mandat_cena, "center")    
guiSetVisible(poli.mandat_gui, false)



addEventHandler("onClientMarkerLeave", root, function(el,md)
	local getjob = getElementData(source,"frakcja") or false
    if getjob then
		if el==localPlayer then
    		showCursor(false)
    		guiSetVisible(frakcje.okno, false)
		end
	end
	local getpoli = getElementData(source,"mandaty") or false
    if getpoli then
		if el==localPlayer then
    		showCursor(false)
    		guiSetVisible(poli.mandat_gui, false)
		end
	end
end)

-- jak gracz wejdzie
addEventHandler("onClientMarkerHit", root, function(el,md)
	local getjob = getElementData(source,"frakcja") or false
    if getjob then
	local _,_,z = getElementPosition(source)
	local _,_,z2 = getElementPosition(el)
	if (z+3) > z2 and (z-3) < z2 then
		if getElementType(el)~="player" then return end
		if isPedInVehicle(el) then return end
		if el==localPlayer then
		local getCODE = getElementData(source,"frakcja:code") or false
		if not getCODE then return end
		local duty = getElementData(el,"player:frakcja") or false;
		if getElementData(el,"player:frakcjaCODE") == getCODE and duty then
		    opis_button = "Zakończ pracę";
		else
		    opis_button = "Rozpocznij pracę";
		end
		local get_desc2 = getElementData(source,"frakcja:desc2") or "";
		local get_desc3 = getElementData(source,"frakcja:desc3") or "";
		
		guiSetText(frakcje.button_start,tostring(opis_button))
		guiSetText(frakcje.okno,tostring(get_desc2))
		guiSetText(frakcje.okno_desc,tostring(get_desc3))
		
		setElementData(el,"player:dutycode",getCODE)
		
    	if guiGetVisible(frakcje.okno) == false then
    		showCursor(true)
    		guiSetVisible(frakcje.okno, true)
		end
		end
	end
	end
	--next
	local getpoli = getElementData(source,"mandaty") or false
    if getpoli then
	local _,_,z = getElementPosition(source)
	local _,_,z2 = getElementPosition(el)
	if (z+3) > z2 and (z-3) < z2 then
		if getElementType(el)~="player" then return end
		if isPedInVehicle(el) then return end
		if el==localPlayer then
			
			--sprawdza mandaty
			triggerServerEvent("zliczMandatyKarne",localPlayer,localPlayer)
			
			local mandaty = getElementData(localPlayer,"player:poliMandaty") or 0;
			if mandaty <= 0 then
				guiSetText(poli.mandat_pay, "Zapłać 0.00$")
				guiSetText(poli.mandat_cena, "Kwota: 0.00$")
			else
				local mandaty = string.format("%.2f", mandaty/100)
				guiSetText(poli.mandat_pay, "Zapłać "..mandaty.."$")
				guiSetText(poli.mandat_cena, "Kwota: "..mandaty.."$")
			end
			if guiGetVisible(poli.mandat_gui) == false then
				showCursor(true)
				guiSetVisible(poli.mandat_gui, true)
			end
		end
	end
	end
	-- wynagrodzenie
	local getpoli = getElementData(source,"mandatywy") or false
    if getpoli then
	local _,_,z = getElementPosition(source)
	local _,_,z2 = getElementPosition(el)
	if (z+3) > z2 and (z-3) < z2 then
		if getElementType(el)~="player" then return end
		if isPedInVehicle(el) then return end
		if el==localPlayer then
			--sprawdza mandaty
			triggerServerEvent("wyliczWynagrodzenieMandaty",localPlayer,localPlayer)
		end
	end
	end
end)

addEvent("odswiezMandatyKarne", true)
addEventHandler("odswiezMandatyKarne", root,function(gracz)
    if guiGetVisible(poli.mandat_gui) == true then
		if localPlayer == gracz then
			local mandaty = getElementData(localPlayer,"player:poliMandaty") or 0;
			local mandaty = string.format("%.2f", mandaty/100)
			guiSetText(poli.mandat_pay, "Zapłać "..mandaty.."$")
			guiSetText(poli.mandat_cena, "Kwota: "..mandaty.."$")
		end
    end	
end)

addEventHandler("onClientGUIClick", root, function()
    if source == frakcje.button_start then
	    local sprr10 = getElementData(localPlayer,"player:duty") or false;
		if sprr10 then
			local getdutycode = getElementData(localPlayer,"player:dutycode") or false
			triggerServerEvent("sprFrakcjeGracza",localPlayer,getdutycode,localPlayer)
		else
			local getdutycode = getElementData(localPlayer,"player:dutycode") or false;
			if getdutycode then
				triggerServerEvent("sprFrakcjeGracza",localPlayer,getdutycode,localPlayer)
			end
		end
	end
	
	if source == poli.mandat_pay then
		local money = getPlayerMoney()
		local mandaty = getElementData(localPlayer,"player:poliMandaty") or 0;
		if mandaty > 0 and mandaty <= money then
			triggerServerEvent("zaplacZaMandatyPoli",localPlayer,localPlayer)
		else
			outputChatBox(" ",231, 217, 176,true)
			outputChatBox("#7AB4EAⒾ#e7d9b0 Nie posiadasz mandatów lub nie masz wystarczającej ilość gotówki.",231, 217, 176,true)
		end
	end
	
	if source == poli.mandat_exit then
		showCursor(false)
        guiSetVisible(poli.mandat_gui, false)
	end
end)

addEvent("ukryjPanelFrakcji", true)
addEventHandler("ukryjPanelFrakcji", root,function(gracz)
    if guiGetVisible(frakcje.okno) == true then
		if localPlayer == gracz then
        	showCursor(false)
        	guiSetVisible(frakcje.okno, false)
		end
    end	
end)

--===================================
--[[
addEventHandler("onClientRender", root,function()
	local kajdanki = getElementData(localPlayer,"player:kajdanki") or false;
	if kajdanki then
		local police = getElementData(localPlayer,"player:kajdankiPLR") or false;
		if police then
			local x,y,z = getElementRotation(police)
			local pdim = getElementDimension(police)
			local dim = getElementDimension(localPlayer)
			local pint = getElementInterior(police)
			local int = getElementInterior(localPlayer)
			if pdim~=dim or pint~=int then
				triggerServerEvent("kajdanki:dimint",root,police,localPlayer)
			end
			setElementRotation(localPlayer,x,y,z)
		end
	end
end)


local enabled = false
 
addCommandHandler("ccam", function()
    enabled = not enabled
    if enabled then
        start = getTickCount()
        dx, dy, dz, lx, ly, lz = getCameraMatrix()
        addEventHandler("onClientPreRender", root, interpolateCam)
    else
        start = nil
        setCameraTarget(localPlayer)
        removeEventHandler("onClientPreRender", root, interpolateCam)
    end
end)
 
function interpolateCam()
    local now = getTickCount()
    local endTime = start + 2000
    local elapsedTime = now - start
    local duration = endTime - start
    local progress = elapsedTime / duration
    local px, py, pz = getElementPosition(localPlayer)
    local x, y, z = interpolateBetween ( dx, dy, dz, dx+4, dy+4, dz, progress, "OutQuad")
    setCameraMatrix(x, y, z, px, py, pz+0.6, 0, 0)
end
]]--
--===================================
-- liczenie sluzby test
setTimer(function()
	local players=getElementsByType('player')
	for _, p in pairs(players) do
		local sluzba = getElementData(p,"player:frakcja") or false;
		if sluzba and getElementAlpha(p) == 255 and localPlayer==p then
			local sluzba_time = getElementData(p,"player:frakcjaTIME") or 0;
			local sluzba_time = sluzba_time + 1;
			setElementData(p,"player:frakcjaTIME",sluzba_time)
		end
	end
end, 60000, 0)
