local markerg = createMarker(1737.044921875, 1852.404296875, 11.4, "arrow", 1.2, 255,255,0,50)
local markerg_interio = createMarker(-2029.689453125, -119.62109375, 1035.7, "arrow", 1.2, 255,255,255,50)
    setElementInterior(markerg_interio, 3)
	setElementDimension(markerg_interio, 200)
	
	
--local blipulvkaplica = createBlip(2487.16796875, 918.796875, 11.0234375, 60,2,0,0,0,0,0,500) 

-- // wejscie urzad lv
addEventHandler("onClientMarkerHit", markerg, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	if not md then return end
    triggerServerEvent("onGraczWejdzieGielda", el)
end)
-- // wyjscie urzad lv
addEventHandler("onClientMarkerHit", markerg_interio, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	if not md then return end
    triggerServerEvent("onGraczWyjdzieGielda", el)
end)



---------------- handel start ------------- ------------- -------------
-- timer.cancel()

addEvent("uruchomOdliczanieStart", true)
addEventHandler("uruchomOdliczanieStart", root, function(plr)
if localPlayer == plr then
    zakuppojazdu=setTimer(function()
	    triggerServerEvent("removeZakuPojCzasEnd",localPlayer,localPlayer)
	end, 30000, 1) --- 30000
end
end)

addEvent("zakonczOdliczanieEnd", true)
addEventHandler("zakonczOdliczanieEnd", root, function(plr)
if localPlayer == plr then
    killTimer(zakuppojazdu)
end
end)

------------- ------------- ------------- v -------------
local markerg_handelint_1 = createMarker(-2033.4296875, -117.5068359375, 1033.85, "cylinder", 1, 255,255,255,50)
    setElementInterior(markerg_handelint_1, 3)
	setElementDimension(markerg_handelint_1, 200)
	
local markerg_handelint_2 = createMarker(-2033.4296875, -117.5068359375, 1032.171875, "cylinder", 3.3, 255,0,0,55)
    setElementInterior(markerg_handelint_2, 3)
	setElementDimension(markerg_handelint_2, 200)
	
        local okno={}
        okno.gielda = guiCreateWindow(0.25, 0.24, 0.50, 0.52, "Sprzedaż pojazdów.", true)
        guiWindowSetSizable(okno.gielda, false)

        okno.gielda_grindlist_cars = guiCreateGridList(0.03, 0.09, 0.45, 0.71, true, okno.gielda)
        guiGridListAddColumn(okno.gielda_grindlist_cars, "ID", 0.3)
        guiGridListAddColumn(okno.gielda_grindlist_cars, "Nazwa", 0.3)
        guiGridListAddColumn(okno.gielda_grindlist_cars, "Przebieg", 0.3)
        okno.gielda_grindlist_players = guiCreateGridList(0.52, 0.09, 0.45, 0.71, true, okno.gielda)
        guiGridListAddColumn(okno.gielda_grindlist_players, "ID", 0.4)
        guiGridListAddColumn(okno.gielda_grindlist_players, "Nazwa gracza", 0.5)
        okno.gielda_input_cost = guiCreateEdit(0.03, 0.86, 0.45, 0.09, "0", true, okno.gielda)
        okno.gielda_submitbutton = guiCreateButton(0.52, 0.86, 0.28, 0.09, "Wyślij ofertę", true, okno.gielda)
        okno.gielda_desc = guiCreateLabel(0.04, 0.81, 0.30, 0.04, "Cena pojazdu: + (250$)", true, okno.gielda)
        --okno.gielda_exitbutton = guiCreateButton(775, 486, 150, 49, "Zamknij", false, okno.gielda)
		okno.gielda_exitbutton = guiCreateButton(0.81, 0.86, 0.16, 0.09, "Zamknij", true, okno.gielda)  
        guiSetVisible(okno.gielda,false)
		guiSetProperty(okno.gielda_input_cost, "ValidationString", "^[0-9]*$") 
		
	
addEventHandler("onClientMarkerHit", markerg_handelint_1, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	if not md then return end
    -- triggerServerEvent("onGraczWejdzieGielda", el)
    guiSetVisible(okno.gielda,true)
	showCursor(true)
	triggerServerEvent("onGoscWejdzie", root, el);	
end)

addEventHandler("onClientGUIClick", root, function(btn,state)

	if source == okno.gielda_exitbutton then
    guiSetVisible(okno.gielda,false)
	--destroyElement(okno.gielda)
	showCursor(false)
	end
	
	if source == okno.gielda_submitbutton then
		local selectedCar = guiGridListGetSelectedItem(okno.gielda_grindlist_cars);
		local selectedPlayer = guiGridListGetSelectedItem(okno.gielda_grindlist_players);
		local selectedPrince = guiGetText(okno.gielda_input_cost) or 0;
		
		local idCar = tostring(guiGridListGetItemText(okno.gielda_grindlist_cars, selectedCar, 1));
		local idPlayer = tostring(guiGridListGetItemText(okno.gielda_grindlist_players, selectedPlayer, 1));
		local namePlayer = tostring(guiGridListGetItemText(okno.gielda_grindlist_players, selectedPlayer, 2));
		
		--selectedPrince = string.gsub(selectedPrince, "%W", "")
		--selectedPrince = string.match(selectedPrince, "%d+")
		selectedPrince = string.match(selectedPrince,"%d+")
		--selectedPrince = string.match(selectedPrince, '[0-9]')
		--selectedPrince = selectedPrince:gsub(w,"")
		--selectedPrince = tonumber(selectedPrince) ~= nil
		
		if tonumber(selectedPrince) <= 0 then return end
		if selectedCar < 0 then return end
		if selectedPlayer < 0 then return end
		
		value = (selectedPrince*100);
		get_kwote = math.floor(value);
		
		if tonumber(get_kwote) <= 0 then
			outputChatBox("#841515✖#e7d9b0 Cena pojazdu powinna być większa niż #388E000$#e7d9b0!", 255,255,255,true)
		return false end
		
		--value = (selectedPrince*100);
		
		if tonumber(value) > 99999999 then
			outputChatBox("#841515✖#e7d9b0 Cena pojazdu powinna być mniejsza niż #388E00999,999.99$#e7d9b0!", 255,255,255,true)
		return false end
		if namePlayer == getPlayerName(localPlayer) then
			outputChatBox("#841515✖#e7d9b0 Mhm... "..namePlayer..", samemu sobie??", 255,255,255,true)
		return false end
        
		triggerServerEvent("cz2SellAuta", root, idCar, idPlayer, selectedPrince)
    guiSetVisible(okno.gielda,false)
	--destroyElement(okno.gielda)
	showCursor(false)
		
	end

end)



addEvent("onClientOdsiwezy", true)
addEventHandler("onClientOdsiwezy", root, function(result)
	guiGridListClear(okno.gielda_grindlist_cars)
	for i,veh in pairs(result) do
		local row=guiGridListAddRow(okno.gielda_grindlist_cars);
		guiGridListSetItemText(okno.gielda_grindlist_cars, row, 1, veh.veh_id, false, false);
		guiGridListSetItemText(okno.gielda_grindlist_cars, row, 2, getVehicleNameFromModel(veh.veh_modelid), false, false);
		guiGridListSetItemText(okno.gielda_grindlist_cars, row, 3, veh.veh_przebieg, false, false);
	end
end)


addEventHandler("onClientMarkerLeave", markerg_handelint_2, function(el,md)
    sprdat = getElementData(el,"intrangiel") or false;
	if sprdat == true then
    setElementData(el,"intrangiel",false)
	end
end)


function mkkr_hits(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	if not md then return end
	setElementData(el,"intrangiel",true)
	
	guiGridListClear(okno.gielda_grindlist_players)
	for i, plr in ipairs(getElementsByType("player")) do
	if getElementData(plr,"intrangiel") == true then
	local row=guiGridListAddRow(okno.gielda_grindlist_players);
        guiGridListSetItemText(okno.gielda_grindlist_players, row, 1, getElementData(plr,"id"), false, false)
		guiGridListSetItemText(okno.gielda_grindlist_players, row, 2, getPlayerName(plr), false, false)
	end
	end
end

addEventHandler("onClientMarkerHit", markerg_handelint_2, mkkr_hits)



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




