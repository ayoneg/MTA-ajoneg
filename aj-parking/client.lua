--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt przechowywalni pojazdów + KAT. (v2.0)
]]--

local screenW, screenH = guiGetScreenSize()

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

------ dp info ------------ dp info ------------ dp info ------
addEvent("showInfoOnDP", true)
addEventHandler("showInfoOnDP", root, function(value)
     function dxDrawTextFunk()
          dxDrawText("#7AB4EAⒾ #ffffffAby przenieść pojazd na parking, wyjdź z niego na tym terenie.", screenW * 0.3182, screenH * 0.7685, screenW * 0.6818, screenH * 0.7880, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, true, false)
     end
     addEventHandler("onClientRender", root, dxDrawTextFunk)
end)
addEvent("removeInfoOnDP", true)
addEventHandler("removeInfoOnDP", root, function(value)
    if isEventHandlerAdded("onClientRender", root, dxDrawTextFunk) then
        removeEventHandler("onClientRender", root, dxDrawTextFunk) 
    end
end)
------ dp info ------------ dp info ------------ dp info ------

local o={}

o.okno = guiCreateWindow(0.28, 0.32, 0.44, 0.37, "Odbieranie pojazdów", true)
guiWindowSetSizable(o.okno, false)
guiWindowSetMovable(o.okno, false)

o.genrr = guiCreateGridList(0.02, 0.09, 0.65, 0.86, true, o.okno)
guiGridListAddColumn(o.genrr, "ID", 0.2)
guiGridListAddColumn(o.genrr, "Nazwa", 0.2)
guiGridListAddColumn(o.genrr, "Przebieg", 0.2)
guiGridListAddColumn(o.genrr, "Tablica", 0.2)
o.wybpojclass = guiCreateComboBox(0.68, 0.09, 0.30, 0.49, "-- Wybierz z listy", true, o.okno)



o.submit = guiCreateButton(0.68, 0.63, 0.30, 0.15, "Wyjmij pojazd", true, o.okno)
o.close = guiCreateButton(0.68, 0.80, 0.30, 0.15, "Zamknij panel", true, o.okno)  	
guiGridListSetSortingEnabled(o.genrr, false)
	
guiSetVisible(o.okno, false)
	
addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == o.wybpojclass then
        local selected = guiComboBoxGetSelected(o.wybpojclass)
        if not selected then return end
		if selected == 0 then
			triggerServerEvent("GetRec", localPlayer,0)
		end
		if selected == 1 then
			triggerServerEvent("GetRec", localPlayer,1)
		end
		if selected == 2 then
			triggerServerEvent("GetRec", localPlayer,2)
		end
	end
	if source == o.close then
		if guiGetVisible(o.okno) == true then
			showCursor(false)
			guiSetVisible(o.okno,false)
		end
	end
	if source == o.submit then
		local selectedRow=guiGridListGetSelectedItem(o.genrr) or -1
		if selectedRow < 0 then return end	
		local id=guiGridListGetItemText(o.genrr, selectedRow, 1)
		local modelID=guiGridListGetItemData(o.genrr, selectedRow, 2)
		guiGridListRemoveRow(o.genrr, selectedRow)
		triggerServerEvent("VehicleSpawnPrzechoV2", localPlayer, tonumber(id),tonumber(modelID), localPlayer)
		guiSetVisible(o.okno,false)
		showCursor(false)
	end
end)
	
addEvent("GetVehicles", true)
addEventHandler("GetVehicles", root, function(result)
	guiGridListClear(o.genrr)
	if not result then return end
	for i,veh in pairs(result) do
		local row=guiGridListAddRow(o.genrr)
		guiGridListSetItemText(o.genrr, row, 1, veh["veh_id"], false, false)
		guiGridListSetItemText(o.genrr, row, 2, getVehicleNameFromModel(veh["veh_modelid"]), false, false)
		guiGridListSetItemData(o.genrr, row, 2, veh["veh_modelid"]) -- data modelid
		guiGridListSetItemText(o.genrr, row, 3, veh["veh_przebieg"].."km", false, false)
		guiGridListSetItemText(o.genrr, row, 4, veh["veh_tablica"], false, false)
	end
end)


addEventHandler("onClientColShapeHit", root, function(el,md)
	if not md or el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	if guiGetVisible(o.okno) == false then
		local sprawdz = getElementData(source,"przecho:wyjmij") or false;
		if sprawdz then
			local przechocode = getElementData(source,"przecho:code") or false;
			setElementData(localPlayer,"player:przechoCODE",przechocode)
			
			guiComboBoxClear(o.wybpojclass)
			guiComboBoxAddItem(o.wybpojclass, "Prywatne")
			guiComboBoxAddItem(o.wybpojclass, "Organizacja")
			
			local sluzba = getElementData(el,"player:frakcja") or false;
			if sluzba then guiComboBoxAddItem(o.wybpojclass, "Frakcja") end
			
			showCursor(true)
			guiSetVisible(o.okno,true)
        	local selected = guiComboBoxGetSelected(o.wybpojclass)
        	if not selected then return end
			if selected == 0 then
				triggerServerEvent("GetRec", localPlayer,0)
			end
			if selected == 1 then
				triggerServerEvent("GetRec", localPlayer,1)
			end
			if selected == 2 and sluzba then
				triggerServerEvent("GetRec", localPlayer,2)
			elseif selected == 2 and not sluzba then
				triggerServerEvent("GetRec", localPlayer,0)
			end
		end
	end
end)


addEventHandler("onClientColShapeLeave", root, function(el,md)
	if not md or el~=localPlayer then return end
	local sprawdz = getElementData(source,"przecho:wyjmij") or false;
	if sprawdz then
		setElementData(localPlayer,"player:przechoCODE",false)
	end
end)

------ ------ ------- ------ ------ ------- ------ ------ -------

addEvent("testtrigger22", true)
addEventHandler("testtrigger22", root, function(result_test)
if odpalone == 1 then
    guiSetVisible(panelauta,false);	
	showCursor(false);
	odpalone = 0;
end
end)


addEvent("testtrigger", true)
addEventHandler("testtrigger", root, function(result_test)
    setRadioChannel(0)
end)
