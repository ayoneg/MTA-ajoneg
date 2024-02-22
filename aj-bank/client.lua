local marker = createMarker(2447.6865234375, 2376.216796875, 12.8, "arrow", 1.3, 255,255,255,50)
local marker2 = createMarker(2448.8115234375, 2375.8955078125, 12.9, "arrow", 1.3, 255,255,255,50)
--createBlip(2473.7958984375, 2379.1767578125, 71.049575805664, 56,2,0,0,0,0,0,500)

blipbanklv = createBlip(2473.7958984375, 2379.1767578125, 71.049575805664, 56, 1, 0,255,5,255, -100, 500)
--createBlip(2436.8857421875, 2352.484375, 10.8203125, 52,2,0,0,0,0,0,500)
-- // wejscie /wejscia stacja lv sapd
addEventHandler("onClientMarkerHit", marker, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    setElementPosition (el, 2452.2763671875, 2375.9169921875, 12.25354385376)
end)

addEventHandler("onClientMarkerHit", marker2, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    setElementPosition (el,  2444.2197265625, 2376.2099609375, 12.044117927551)
end)


local panel2={}
addEvent("potwierdzeniaPlatnosci", true)
addEventHandler("potwierdzeniaPlatnosci", root, function(get_kwote,get_nrkonta)

		local get_kwote = string.format("%.2f", get_kwote/100)
		guiSetVisible(panel2.potwierdzeniePlatnosci,true)
        panel2.descOpis = guiCreateLabel(0.04, 0.54, 0.92, 0.34, "Płatność na konto: ____ "..get_nrkonta.."\n\nKwota: _____________ "..get_kwote.."$", true, panel2.potwierdzeniePlatnosci)
        guiLabelSetVerticalAlign(panel2.descOpis, "center")   

end)

        panel2.potwierdzeniePlatnosci = guiCreateWindow(0.37, 0.08, 0.25, 0.21, "Potwierdzenie płatności", true)
        panel2.buttonPotwierdzam = guiCreateButton(0.04, 0.17, 0.56, 0.27, "Potwierdzam", true, panel2.potwierdzeniePlatnosci)
        panel2.buttonAnuluj = guiCreateButton(0.65, 0.17, 0.31, 0.27, "Anuluj", true, panel2.potwierdzeniePlatnosci)
        guiSetVisible(panel2.potwierdzeniePlatnosci,false)
		

local marker_globallogi = createMarker(2465.2924804688, 2389.4482421875, 11.25354385376, "cylinder", 1.2, 255,255,255,50 )
local panel={}
        panel.przelew = guiCreateWindow(0.29, 0.36, 0.42, 0.28, "Przelew na konto bankowe", true)
        guiWindowSetSizable(panel.przelew, false)

        panel.input_nrkonta = guiCreateEdit(0.17, 0.19, 0.26, 0.16, "", true, panel.przelew)
        panel.input_kwota = guiCreateEdit(0.17, 0.38, 0.26, 0.16, "", true, panel.przelew)
        panel.button_wykonaj = guiCreateButton(0.04, 0.62, 0.25, 0.25, "Wykonaj przelew", true, panel.przelew)

        panel.desc1 = guiCreateLabel(0.02, 0.19, 0.14, 0.16, "Nr. Konta:", true, panel.przelew)
        guiLabelSetHorizontalAlign(panel.desc1, "center", false)
        guiLabelSetVerticalAlign(panel.desc1, "center")
        panel.desc2 = guiCreateLabel(0.02, 0.38, 0.14, 0.16, "Kwota:", true, panel.przelew)
        guiLabelSetHorizontalAlign(panel.desc2, "center", false)
        guiLabelSetVerticalAlign(panel.desc2, "center")
        panel.descmemo = guiCreateMemo(0.51, 0.19, 0.45, 0.69, "Zasady korzystania:\n\n1. Kwota minimalna to 5,000.00$.\n2. Kwota maksymalna bez ograniczeń.\n3. Od kwoty pobierane jest 5% podatku.\n4. Po kliknięciu \"Potwierdzam\", nie ma możliwości cofnięcia transakcji.\n\nNr. Konta - UID gracza.", true, panel.przelew)
        guiMemoSetReadOnly( panel.descmemo, true)
        panel.button_zamknij = guiCreateButton(0.30, 0.62, 0.14, 0.25, "Zamknij", true, panel.przelew) 
		guiSetVisible(panel.przelew,false)
		
		guiSetProperty(panel.input_nrkonta, "ValidationString", "^[0-9]*$")
		guiSetProperty(panel.input_kwota, "ValidationString", "^[0-9]*$")

addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == panel.button_wykonaj and guiGetVisible(panel2.potwierdzeniePlatnosci) == false then
		local get_kwote = tonumber(guiGetText(panel.input_kwota)) or 0;
		local get_nrkonta = tonumber(guiGetText(panel.input_nrkonta)) or 0;
		local get_kwote = (get_kwote*100)
		if get_kwote < 499999 then 
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłową kwote!",231, 217, 176,true) return end
		if get_nrkonta == 0 then 
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłowy numer konta!",231, 217, 176,true) return end
		get_kwote = math.floor(get_kwote);
		
		triggerEvent("potwierdzeniaPlatnosci",root,get_kwote,get_nrkonta)
		
		--triggerServerEvent("wyslijPrzelew", root, get_kwote, get_nrkonta)
    end
    if source == panel.button_zamknij then
    	if guiGetVisible(panel.przelew) == true then showCursor(false); guiSetVisible(panel.przelew, false); end
		if guiGetVisible(panel2.potwierdzeniePlatnosci) == true then guiSetVisible(panel2.potwierdzeniePlatnosci, false); destroyElement(panel2.descOpis); end
    end
	if source == panel2.buttonPotwierdzam then 
		local get_kwote = tonumber(guiGetText(panel.input_kwota)) or 0;
		local get_nrkonta = tonumber(guiGetText(panel.input_nrkonta)) or 0;
		local get_kwote = (get_kwote*100)
		if get_kwote < 499999 then 
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłową kwote!",231, 217, 176,true) return end
		if get_nrkonta == 0 then 
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłowy numer konta!",231, 217, 176,true) return end
		get_kwote = math.floor(get_kwote);
		
	    triggerServerEvent("wyslijPrzelew", root, get_kwote, get_nrkonta)
		guiSetVisible(panel2.potwierdzeniePlatnosci, false);
		destroyElement(panel2.descOpis);
	end
    if source == panel2.buttonAnuluj then
    	if guiGetVisible(panel2.potwierdzeniePlatnosci) == true then guiSetVisible(panel2.potwierdzeniePlatnosci, false); destroyElement(panel2.descOpis); end
    end
end)

addEvent("zamknijOkna", true)
addEventHandler("zamknijOkna", root, function()
    if guiGetVisible(panel.przelew) == true then showCursor(false); guiSetVisible(panel.przelew, false); end
	if guiGetVisible(panel2.potwierdzeniePlatnosci) == true then guiSetVisible(panel2.potwierdzeniePlatnosci, false); destroyElement(panel2.descOpis); end
end)

addEventHandler("onClientMarkerHit", marker_globallogi, function(el,md)
    if el ~= localPlayer then return end
    if not guiGetVisible(panel.przelew) then
        showCursor(true);
        guiSetVisible(panel.przelew, true);
        --triggerServerEvent("onClientReturnEnd3", root, el);
    end
end)


local marker_logi1 = createMarker(2465.2973632812, 2399.6552734375, 11.25354385376, "cylinder", 1.2, 255,255,255,50)
local lista={}
--[[
        lista.okonoh = guiCreateWindow(0.28, 0.25, 0.43, 0.51, "Historia konta", true)
        guiWindowSetSizable(lista.okonoh, false)

        lista.gridlist = guiCreateGridList(28, 43, 772, 428, false, lista.okonoh)
        guiGridListAddColumn(lista.gridlist, "Data", 0.2)
        guiGridListAddColumn(lista.gridlist, "Kwota", 0.2)
        guiGridListAddColumn(lista.gridlist, "Odbiorca", 0.2)
		guiGridListAddColumn(lista.gridlist, "Opis", 0.37)
        lista.buttonh = guiCreateButton(28, 481, 225, 55, "Wyjdz", false, lista.okonoh)    
		guiSetVisible(lista.okonoh,false)
        guiGridListSetSortingEnabled (lista.gridlist, false)
		]]--
		
        lista.okonoh = guiCreateWindow(0.27, 0.22, 0.47, 0.55, "Historia konta [Ostatnie 75 transakcji]", true)

        lista.gridlist = guiCreateGridList(0.02, 0.07, 0.96, 0.79, true, lista.okonoh)
        guiGridListAddColumn(lista.gridlist, "Data", 0.2)
        guiGridListAddColumn(lista.gridlist, "Kwota", 0.2)
        guiGridListAddColumn(lista.gridlist, "Odbiorca (UID)", 0.2)
        guiGridListAddColumn(lista.gridlist, "Opis", 0.36)
        lista.buttonh = guiCreateButton(0.02, 0.87, 0.38, 0.09, "Zamknij", true, lista.okonoh)  
		guiSetVisible(lista.okonoh,false)
        guiGridListSetSortingEnabled (lista.gridlist, false)		

addEventHandler("onClientGUIClick", root, function(btn,state)
    if source == lista.buttonh then
    	if guiGetVisible(lista.okonoh) == true then showCursor(false); guiSetVisible(lista.okonoh, false); end
    end
end)


addEvent("onClientReturn2", true)
addEventHandler("onClientReturn2", root, function(result)
	guiGridListClear(lista.gridlist)
	for i,logi in pairs(result) do
		local row=guiGridListAddRow(lista.gridlist);
		local money = string.format("%.2f", logi.lbank_kwota/100)
		guiGridListSetItemText(lista.gridlist, row, 1, logi.lbank_data, false, false);
		guiGridListSetItemText(lista.gridlist, row, 2, money.."$", false, false);
		
		if logi.lbank_userid == getElementData(localPlayer,"player:dbid") then
		guiGridListSetItemColor(lista.gridlist, row, 2, 255, 0, 0 )
		else
		guiGridListSetItemColor(lista.gridlist, row, 2, 56, 142, 0 )
		end
		
		if logi.lbank_userid == getElementData(localPlayer,"player:dbid") then
		guiGridListSetItemText(lista.gridlist, row, 3, "Nr. konta: "..logi.lbank_touserid.."", false, false);
		else
		guiGridListSetItemText(lista.gridlist, row, 3, "Ty, od: ("..logi.lbank_userid..")", false, false);
		end
		
		guiGridListSetItemText(lista.gridlist, row, 4, logi.lbank_desc, false, false);
		
	end
end)

addEventHandler("onClientMarkerHit", marker_logi1, function(el,md)
    if el ~= localPlayer then return end
    if not guiGetVisible(lista.okonoh) then
        showCursor(true);
        guiSetVisible(lista.okonoh, true);
        triggerServerEvent("onClientReturnEnd2", root, el);
    end
end)