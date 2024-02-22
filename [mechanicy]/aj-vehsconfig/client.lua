--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt wczytywania handingu pojazdów.
]]--

--==================--  --==================--  --==================--

credit = {}
GUIEditor = {
    scrollbar = {},
    label = {}
}

local screenW, screenH = guiGetScreenSize()
        credit.okno = guiCreateWindow(screenW - 622 - 10, (screenH - 715) / 2, 622, 715, "Panel konfiguracji parametrów pojazdu", false)
        guiWindowSetSizable(credit.okno, false)
        guiSetAlpha(credit.okno, 0.92)
		guiSetVisible(credit.okno, false)

        credit.btn_zapisz = guiCreateButton(16, 651, 424, 49, "Zapisz ustawienia", false, credit.okno)
        credit.btn_zamknij = guiCreateButton(450, 651, 155, 49, "Zamknij", false, credit.okno)
        GUIEditor.scrollbar[1] = guiCreateScrollBar(10, 69, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 100)
        GUIEditor.label[1] = guiCreateLabel(10, 44, 273, 25, "Skrzynia biegów:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.label[2] = guiCreateLabel(419, 69, 193, 27, "5 biegowa", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
        GUIEditor.scrollbar[2] = guiCreateScrollBar(10, 130, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[2], 62)
        GUIEditor.label[3] = guiCreateLabel(10, 105, 273, 25, "Masa pojazdu:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
        GUIEditor.label[4] = guiCreateLabel(419, 130, 193, 27, "100%", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
        GUIEditor.scrollbar[3] = guiCreateScrollBar(10, 192, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[3], 0)
        GUIEditor.label[5] = guiCreateLabel(10, 167, 273, 25, "Sztywność zawieszenia:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        GUIEditor.label[6] = guiCreateLabel(419, 192, 193, 27, "75%", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
        GUIEditor.label[7] = guiCreateLabel(10, 229, 273, 25, "Promień skrętu:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")
        GUIEditor.scrollbar[4] = guiCreateScrollBar(10, 254, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[4], 0)
        GUIEditor.label[8] = guiCreateLabel(419, 254, 193, 27, "75%", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[8], "center")
        GUIEditor.label[9] = guiCreateLabel(10, 19, 273, 25, "Układ MK1", false, credit.okno)
        guiSetFont(GUIEditor.label[9], "default-bold-small")
        guiLabelSetVerticalAlign(GUIEditor.label[9], "center")
        GUIEditor.label[10] = guiCreateLabel(10, 315, 273, 25, "Układ MK2", false, credit.okno)
        guiSetFont(GUIEditor.label[10], "default-bold-small")
        guiLabelSetVerticalAlign(GUIEditor.label[10], "center")
        GUIEditor.scrollbar[5] = guiCreateScrollBar(10, 365, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[5], 0)
        GUIEditor.label[11] = guiCreateLabel(10, 340, 273, 25, "Prędkość maksymalna:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[11], "center")
        GUIEditor.label[12] = guiCreateLabel(419, 365, 193, 27, "75%", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[12], "center")
        GUIEditor.label[13] = guiCreateLabel(10, 402, 273, 25, "Przyśpieszenie:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[13], "center")
        GUIEditor.scrollbar[6] = guiCreateScrollBar(10, 427, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[6], 0)
        GUIEditor.label[14] = guiCreateLabel(419, 427, 193, 27, "75%", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[14], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[14], "center")
        GUIEditor.label[15] = guiCreateLabel(10, 490, 273, 25, "Układ MK3", false, credit.okno)
        guiSetFont(GUIEditor.label[15], "default-bold-small")
        guiLabelSetVerticalAlign(GUIEditor.label[15], "center")
        GUIEditor.label[16] = guiCreateLabel(10, 515, 273, 25, "Napęd:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[16], "center")
        GUIEditor.scrollbar[7] = guiCreateScrollBar(10, 540, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[7], 0)
        GUIEditor.label[17] = guiCreateLabel(419, 540, 193, 27, "RWD", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[17], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[17], "center")
        GUIEditor.label[18] = guiCreateLabel(10, 577, 273, 25, "Turbo sprężarka:", false, credit.okno)
        guiLabelSetVerticalAlign(GUIEditor.label[18], "center")
        GUIEditor.scrollbar[8] = guiCreateScrollBar(10, 602, 398, 27, true, false, credit.okno)
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[8], 0)
        GUIEditor.label[19] = guiCreateLabel(419, 602, 193, 27, "0.8 MPa", false, credit.okno)
        guiLabelSetHorizontalAlign(GUIEditor.label[19], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[19], "center")    

addEventHandler("onClientGUIScroll", root, function() 
	if source == GUIEditor.scrollbar[1] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[1])) or 0;
		if tonumber(position) < 33 then
			guiSetText(GUIEditor.label[2],"3 biegowa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 0)
		elseif tonumber(position) > 33 and tonumber(position) < 66 then
			guiSetText(GUIEditor.label[2],"4 biegowa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 50)
		else
			guiSetText(GUIEditor.label[2],"5 biegowa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 100)
		end
	end
	
	if source == GUIEditor.scrollbar[2] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[2])) or 0;
		position2 = math.floor(position * (position/150))+75;
		guiSetText(GUIEditor.label[4],position2.."%")
	end
	
	if source == GUIEditor.scrollbar[3] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[3])) or 0;
		position2 = math.floor(position * (position/45))+75;
		guiSetText(GUIEditor.label[6],position2.."%")
	end
	
	if source == GUIEditor.scrollbar[4] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[4])) or 0;
		position2 = math.floor(position * (position/45))+75;
		guiSetText(GUIEditor.label[8],position2.."%")
	end
	
	if source == GUIEditor.scrollbar[5] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[5])) or 0;
		position2 = math.floor(position * (position/45))+75;
		guiSetText(GUIEditor.label[12],position2.."%")
	end
	
	if source == GUIEditor.scrollbar[6] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[6])) or 0;
		position2 = math.floor(position * (position/45))+75;
		guiSetText(GUIEditor.label[14],position2.."%")
	end
	
	if source == GUIEditor.scrollbar[7] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[7])) or 0;
		if tonumber(position) < 33 then
			guiSetText(GUIEditor.label[17],"RWD")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[7], 0)
		elseif tonumber(position) > 33 and tonumber(position) < 66 then
			guiSetText(GUIEditor.label[17],"AWD")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[7], 50)
		else
			guiSetText(GUIEditor.label[17],"FWD")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[7], 100)
		end
	end
	
	if source == GUIEditor.scrollbar[8] then
		position = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[8])) or 0;
		if tonumber(position) < 33 then
			guiSetText(GUIEditor.label[19],"0.8 MPa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[8], 0)
		elseif tonumber(position) > 33 and tonumber(position) < 66 then
			guiSetText(GUIEditor.label[19],"1.4 MPa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[8], 50)
		else
			guiSetText(GUIEditor.label[19],"1.8 MPa")
			guiScrollBarSetScrollPosition(GUIEditor.scrollbar[8], 100)
		end
	end
end)


addEventHandler("onClientGUIClick", root, function()
	if source == credit.btn_zapisz then
		local getveh = getElementData(localPlayer,"cnfg:veh") or false;
		
		var0 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[1])) or 0;
		var1 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[2])) or 0;
		var2 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[3])) or 0;
		var3 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[4])) or 0;
		var4 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[5])) or 0;
		var5 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[6])) or 0;
		var6 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[7])) or 0;
		var7 = tonumber(guiScrollBarGetScrollPosition(GUIEditor.scrollbar[8])) or 0;
		
		if getveh then	
			setElementData(getveh,"vehicle:tunecfg",{var0,var1,var2,var3,var4,var5,var6,var7})
		end
		
		if tonumber(var0) < 33 then
			var0 = 3;
		elseif tonumber(var0) > 33 and tonumber(var0) < 66 then
			var0 = 4;
		else
			var0 = 5;
		end

		var1 = math.floor(var1 * (var1/150))+75;	

		var2 = math.floor(var2 * (var2/45))+75;
		
		var3 = math.floor(var3 * (var3/45))+75;
		
		var4 = math.floor(var4 * (var4/45))+75;
		
		var5 = math.floor(var5 * (var5/45))+75;
		
		if tonumber(var6) < 33 then
			var6 = "rwd";
		elseif tonumber(var6) > 33 and tonumber(var6) < 66 then
			var6 = "awd";
		else
			var6 = "fwd";
		end

		if tonumber(var7) < 33 then
			var7 = 80;
		elseif tonumber(var7) > 33 and tonumber(var7) < 66 then
			var7 = 140;
		else
			var7 = 180;
		end
		
		if getveh ~= false then	
			triggerServerEvent("setVehicleNewHanding",root,getveh,var0,var1,var2,var3,var4,var5,var6,var7,localPlayer) -- test
		end
		guiSetVisible(credit.okno, false)
		showCursor(false)
	end
	
	if source == credit.btn_zamknij then
		guiSetVisible(credit.okno, false)
		showCursor(false)
	end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
	if not md or el~=localPlayer then return end
	local sprsource = getElementData(source,"tunercfg") or false;
	if sprsource then
		guiSetVisible(credit.okno, false)
		showCursor(false)
		setElementData(localPlayer,"cnfg:veh",false) -- odpisuje poj
	end
end)


addEventHandler("onClientMarkerHit", root, function(el,md)
    if not md or el~=localPlayer then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
	local sproo = getElementData(source,"tunercfg") or false;
	if sproo then
	
		local fid=getElementData(source, "m:duty")
		local lfid=getElementData(el, "player:duty") or -1;
		if fid~=lfid then return end -- gracz nie jest pracownikiem]]--
	
		local _,_,z = getElementPosition(source)
		local _,_,z2 = getElementPosition(el)
		if (z+3) > z2 and (z-3) < z2 then
		
		local cs = getElementData(source, "cs")
		if not cs then return end
		local pojazdy = getElementsWithinColShape(cs,"vehicle")
		if #pojazdy<1 then
			outputChatBox("Na stanowisku tunera nie ma żadnego pojazdu.")
			return
		end
		if #pojazdy>1 then
			outputChatBox("Na stanowisku tunera jest zbyt dużo pojazdów.")
			return
		end
		local veh = pojazdy[1]
		
		-- wykrywanie aktywnego tune
		local cfg = getElementData(veh,"vehicle:tunecfg") or false;	
		if cfg then
			if cfg[1] and cfg[2] and cfg[3] and cfg[4] and cfg[5] and cfg[6] and cfg[7] and cfg[8] then
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1],cfg[1])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[2],cfg[2])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[3],cfg[3])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[4],cfg[4])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[5],cfg[5])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[6],cfg[6])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[7],cfg[7])
				guiScrollBarSetScrollPosition(GUIEditor.scrollbar[8],cfg[8])
			end
		end
		
		
		guiSetVisible(credit.okno, true)
		showCursor(true)
		
		-- sprawdzam mk poj
		local mk1 = getElementData(veh,"vehicle:mk1") or 0;
		local mk2 = getElementData(veh,"vehicle:mk2") or 0;
		local mk3 = getElementData(veh,"vehicle:mk3") or 0;
--		local su1 = getElementData(veh,"vehicle:mk1") or 0;
		if mk1 ~= 0 then
			guiSetEnabled(GUIEditor.scrollbar[1], true)
			guiSetEnabled(GUIEditor.scrollbar[2], true)
			guiSetEnabled(GUIEditor.scrollbar[3], true)
			guiSetEnabled(GUIEditor.scrollbar[4], true)
		else
			guiSetEnabled(GUIEditor.scrollbar[1], false)
			guiSetEnabled(GUIEditor.scrollbar[2], false)
			guiSetEnabled(GUIEditor.scrollbar[3], false)
			guiSetEnabled(GUIEditor.scrollbar[4], false)
		end
		if mk2 ~= 0 then
			guiSetEnabled(GUIEditor.scrollbar[5], true)
			guiSetEnabled(GUIEditor.scrollbar[6], true)
		else
			guiSetEnabled(GUIEditor.scrollbar[5], false)
			guiSetEnabled(GUIEditor.scrollbar[6], false)
		end
		if mk3 ~= 0 then
			guiSetEnabled(GUIEditor.scrollbar[7], true)
			guiSetEnabled(GUIEditor.scrollbar[8], true)
		else
			guiSetEnabled(GUIEditor.scrollbar[7], false)
			guiSetEnabled(GUIEditor.scrollbar[8], false)
		end
		
		if tonumber(mk3) ~= 0 or tonumber(mk2) ~= 0 or tonumber(mk1) ~= 0 then -- rewstart
			guiSetEnabled(credit.btn_zapisz, true)
		else
			guiSetEnabled(credit.btn_zapisz, false)
		end
		
		setElementData(localPlayer,"cnfg:veh",veh) -- zpisuje poj
		end
	end
end)










