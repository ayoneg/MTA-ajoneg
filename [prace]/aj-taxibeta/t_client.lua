--test
loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

material = dgsCreate3DInterface(1983, 2488.613, 12,2,2,400,400,tocolor(255,255,255,255),0,-1,0,30,0)
edit = dgsCreateEdit(0,0,200,50,"AJONEG.EU",false,material,tocolor(255,0,0,255),1,1,nil,tocolor(0,0,0,0))
memo = dgsCreateMemo(0,60,200,90,"<<< TO NAJLEPSZY SERWER NA\n ŚWIECIE MTA, ZAGRAJ TERAZ >>>",false,material,tocolor(255,0,0,255),1,1,nil,tocolor(0,0,0,0))

--[[
test = dgsCreateWindow((screenW - 1329) / 2, (screenH - 722) / 2,1329, 722,"test",false,tocolor(255,255,255,188),15,nil,tocolor(44,44,44,255),nil,tocolor(77,77,77,188),15,true)
test2 = dgsCreateProgressBar(958, 48, 340, 65, false, test)
dgsProgressBarSetProgress(test2,77)
lista = dgsCreateGridList(50, 48, 882, 584, false, test)
dgsGridListAddColumn(lista, "Trasa", 0.7)
dgsGridListAddColumn(lista, "Dystans", 0.12)
dgsGridListAddColumn(lista, "Wynagrodzenie", 0.11)
]]--

GUIEditor = {
    progressbar = {},
    label = {},
    button = {},
    window = {},
    gridlist = {},
    memo = {}
}


GUIEditor.window[1] = guiCreateWindow((screenW - 1329) / 2, (screenH - 722) / 2, 1329, 722, "Komputer pokładowy [TAXI]", false)
guiWindowSetMovable(GUIEditor.window[1], false)
guiWindowSetSizable(GUIEditor.window[1], false)

GUIEditor.gridlist[1] = guiCreateGridList(50, 48, 882, 584, false, GUIEditor.window[1])
guiGridListAddColumn(GUIEditor.gridlist[1], "Trasa", 0.7)
--guiGridListAddColumn(GUIEditor.gridlist[1], "Miejsce docoelowe", 0.35)
guiGridListAddColumn(GUIEditor.gridlist[1], "Dystans", 0.12)
guiGridListAddColumn(GUIEditor.gridlist[1], "Wynagrodzenie", 0.11)

guiSetProperty(GUIEditor.gridlist[1], "SortSettingEnabled", "False")
GUIEditor.progressbar[1] = guiCreateProgressBar(958, 48, 340, 65, false, GUIEditor.window[1])
guiProgressBarSetProgress(GUIEditor.progressbar[1], 22)
GUIEditor.label[1] = guiCreateLabel(958, 113, 165, 22, "Stan premii", false, GUIEditor.window[1])
guiSetFont(GUIEditor.label[1], "default-bold-small")
GUIEditor.button[1] = guiCreateButton(958, 642, 340, 53, "Zamknij panel", false, GUIEditor.window[1])
GUIEditor.button[2] = guiCreateButton(958, 503, 340, 119, "Podejmij zlecenie", false, GUIEditor.window[1])
GUIEditor.memo[1] = guiCreateMemo(958, 191, 340, 127, "", false, GUIEditor.window[1])
guiMemoSetReadOnly(GUIEditor.memo[1], true)
GUIEditor.label[2] = guiCreateLabel(958, 318, 165, 22, "Opis pokładowy", false, GUIEditor.window[1])
guiSetFont(GUIEditor.label[2], "default-bold-small")
GUIEditor.button[3] = guiCreateButton(50, 642, 168, 53, "Poziom 1", false, GUIEditor.window[1])
GUIEditor.button[4] = guiCreateButton(764, 642, 168, 53, "Poziom 4", false, GUIEditor.window[1])
GUIEditor.button[5] = guiCreateButton(293, 642, 168, 53, "Poziom 2", false, GUIEditor.window[1])
GUIEditor.button[6] = guiCreateButton(524, 642, 168, 53, "Poziom 3", false, GUIEditor.window[1])
--guiSetProperty(GUIEditor.button[6], "Disabled", "True")    

guiSetVisible(GUIEditor.window[1],false)


-- tat
function findCurs(id)
	local data = getElementData(localPlayer,"TAXI:datalvl")
	for i,v in ipairs(data) do 
		if i == id then
			return v
		end
	end
	return false
end


addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == GUIEditor.button[2] then
		local cheat = getElementData(localPlayer,"player:job") or false
		if cheat then
			triggerServerEvent("TAXI:endJob", localPlayer, localPlayer)
			guiSetVisible(GUIEditor.window[1],false)
			showCursor(false)
			setElementData(localPlayer,"player:GUIblock",false)
			return 
		end
		if not guiGetEnabled(GUIEditor.button[3]) then 
			poziom = 1
		elseif not guiGetEnabled(GUIEditor.button[5]) then 
			poziom = 2
		elseif not guiGetEnabled(GUIEditor.button[6]) then 
			poziom = 3
		elseif not guiGetEnabled(GUIEditor.button[4]) then 
			poziom = 4
		end
        local selectedRow = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
        if not selectedRow or selectedRow < 0 then return end
		--local userUID = guiGridListGetItemData(GUIEditor.gridlist[1], selectedRow, 1)
		local IDkursu = guiGridListGetItemData(GUIEditor.gridlist[1], selectedRow, 1)
		--outputChatBox("ID "..IDkursu..".",231, 217, 176,true)
		triggerServerEvent("TAXI:closethis", localPlayer, localPlayer, IDkursu, poziom)
		
        guiSetVisible(GUIEditor.window[1],false)
		showCursor(false)
		setElementData(localPlayer,"player:GUIblock",false)
	end
	
	if source == GUIEditor.button[3] then
		triggerServerEvent("TAXI:datalvl", localPlayer, localPlayer, 1)
		guiSetProperty(GUIEditor.button[4], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[6], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[3], "Disabled", "True")  
		guiSetProperty(GUIEditor.button[5], "Disabled", "False")
	end
	
	if source == GUIEditor.button[5] then
		triggerServerEvent("TAXI:datalvl", localPlayer, localPlayer, 2)
		guiSetProperty(GUIEditor.button[4], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[6], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[3], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[5], "Disabled", "True")
	end
	
	if source == GUIEditor.button[6] then
		triggerServerEvent("TAXI:datalvl", localPlayer, localPlayer, 3)
		guiSetProperty(GUIEditor.button[4], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[6], "Disabled", "True")  
		guiSetProperty(GUIEditor.button[3], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[5], "Disabled", "False")
	end
	
	if source == GUIEditor.button[4] then
		triggerServerEvent("TAXI:datalvl", localPlayer, localPlayer, 4)
		guiSetProperty(GUIEditor.button[4], "Disabled", "True")  
		guiSetProperty(GUIEditor.button[6], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[3], "Disabled", "False")  
		guiSetProperty(GUIEditor.button[5], "Disabled", "False")  
	end
	
	if source == GUIEditor.gridlist[1] then
		local cheat = getElementData(localPlayer,"player:job") or false
		if cheat then
			return 
		end
        local selectedRow = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
        if not selectedRow or selectedRow < 0 then return end
		local kurs = guiGridListGetItemText(GUIEditor.gridlist[1], selectedRow, 1)
		local cena = guiGridListGetItemText(GUIEditor.gridlist[1], selectedRow, 3)
		local IDkursu = guiGridListGetItemData(GUIEditor.gridlist[1], selectedRow, 1)
		local distmiedzy = guiGridListGetItemData(GUIEditor.gridlist[1], selectedRow, 2)
		local osoby = guiGridListGetItemData(GUIEditor.gridlist[1], selectedRow, 3)
		if osoby <= 1 then text = "osoba"; else text = "osoby"; end
		if not guiGetEnabled(GUIEditor.button[3]) then 
			poziom = 1
		elseif not guiGetEnabled(GUIEditor.button[5]) then 
			poziom = 2
		elseif not guiGetEnabled(GUIEditor.button[6]) then 
			poziom = 3
		elseif not guiGetEnabled(GUIEditor.button[4]) then 
			poziom = 4
		end
		local text_data = "Zlecenie #"..IDkursu.." (Poziom "..poziom..") ["..cena.."]\n\n"..kurs.."\n\nPrzejazd: "..distmiedzy.."km / "..osoby.." "..text;
		guiSetText(GUIEditor.memo[1], text_data)
	end
	
	if source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1],false)
		showCursor(false)
		setElementData(localPlayer,"player:GUIblock",false)
	end
end)


addEvent("TAXI:showGUI", true)
addEventHandler("TAXI:showGUI", root, function(datalvl1)
    if guiGetVisible(GUIEditor.window[1]) then
        guiSetVisible(GUIEditor.window[1],false)
		showCursor(false)
		setElementData(localPlayer,"player:GUIblock",false)
	else
		local vehicle = getPedOccupiedVehicle(localPlayer) or false
		local carhp = getElementHealth(vehicle)
		local carlighthp1 = getVehicleLightState(vehicle, 0)
		local carlighthp2 = getVehicleLightState(vehicle, 1)
		local carmaska = getVehicleDoorState(vehicle, 0)
		local carbagaj = getVehicleDoorState(vehicle, 1)
		local dzwilp = getVehicleDoorState(vehicle, 2)
		local dzwipp = getVehicleDoorState(vehicle, 3)
		local dzwilt = getVehicleDoorState(vehicle, 4)
		local dzwipt = getVehicleDoorState(vehicle, 5)
		local carszyba = getVehiclePanelState(vehicle, 4)
		local carpz = getVehiclePanelState(vehicle, 5)
		local cartz = getVehiclePanelState(vehicle, 6)
		if carhp >= 952 then mnoznik = 1.00; end
		if carhp >= 855 and carhp < 952 then mnoznik = 0.92; end
		if carhp >= 700 and carhp < 855 then mnoznik = 0.84; end
		if carhp >= 575 and carhp < 700 then mnoznik = 0.76; end
		if carhp >= 450 and carhp < 575 then mnoznik = 0.66; end
		if carhp >= 301 and carhp < 450 then mnoznik = 0.40; end
		if carlighthp1 == 1 then mnoznik = mnoznik - 0.10; end
		if carlighthp2 == 1 then mnoznik = mnoznik - 0.10; end
		if carszyba ~= 0 then mnoznik = mnoznik - 0.10; end
		if carpz ~= 0 then mnoznik = mnoznik - 0.04; end
		if cartz ~= 0 then mnoznik = mnoznik - 0.06; end
		
		-- tutaj bonusy
		if carmaska == 0 then mnoznik = mnoznik + 0.08; end
		if carbagaj == 0 then mnoznik = mnoznik + 0.08; end
		if dzwilp == 0 then mnoznik = mnoznik + 0.06; end
		if dzwipp == 0 then mnoznik = mnoznik + 0.06; end
		if dzwilt == 0 then mnoznik = mnoznik + 0.04; end
		if dzwipt == 0 then mnoznik = mnoznik + 0.04; end
		ileprocent = ( 100 * mnoznik );
		guiProgressBarSetProgress(GUIEditor.progressbar[1], ileprocent)
		
		local lvlChl = getElementData(localPlayer,"TAXI:datalvl") or 1
		if lvlChl == 1 then
			guiSetEnabled(GUIEditor.button[3], false)
		elseif lvlChl == 2 then
			guiSetEnabled(GUIEditor.button[5], false)
		elseif lvlChl == 3 then
			guiSetEnabled(GUIEditor.button[6], false)
		elseif lvlChl == 4 then
			guiSetEnabled(GUIEditor.button[4], false)
		end
		
		wstawTAXO(datalvl1)
		--test
		guiSetVisible(GUIEditor.window[1],true)
		showCursor(true)
		setElementData(localPlayer,"player:GUIblock",true)
		
		local cheat = getElementData(localPlayer,"player:job") or false
		if cheat then
			guiSetText(GUIEditor.button[2], "Anuluj zlecenie")
		else
			guiSetText(GUIEditor.button[2], "Podejmij zlecenie")
		end
    end
end)

addEvent("TAXI:wstawTEest", true)
addEventHandler("TAXI:wstawTEest", root, function(plr, dta)
	wstawTAXO(dta)
end)

function wstawTAXO(data)
	if data then
		guiGridListClear(GUIEditor.gridlist[1])
		for i,v in ipairs(data) do 
			local row = guiGridListAddRow(GUIEditor.gridlist[1]);
			local money = string.format("%.2f", v[4]/100)
			local dist = string.format("%.2f", v[1]/100)
			--local kursData = findCurs(v[8]);
			local x,y,z = getElementPosition(localPlayer)
			local test = getDistanceBetweenPoints3D(x, y, z, v[12], v[13], v[14])
			local disct = string.format("%.2f", test/100)
			
			if v[6] then dokad = "???"; else dokad = v[3] end
			if v[7] then money = "???"; else money = "$"..money end
			
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v[2].." → ".. dokad, false, false)
			guiGridListSetItemData(GUIEditor.gridlist[1], row, 1, v[8]);
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, ""..disct.." km", false, false)
			if test <= 1000 then
				guiGridListSetItemColor(GUIEditor.gridlist[1], row, 2, 57, 140, 38)
			elseif test <= 2500 then
				guiGridListSetItemColor(GUIEditor.gridlist[1], row, 2, 255, 153, 0)
			end
			guiGridListSetItemData(GUIEditor.gridlist[1], row, 2, dist);
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, money, false, false)
			guiGridListSetItemData(GUIEditor.gridlist[1], row, 3, v[15]);
			--guiGridListSetItemColor(GUIEditor.gridlist[1], row, 3, 57, 140, 38)
		end
	else
		if not ( guiGetEnabled(GUIEditor.button[3]) == false or guiGetEnabled(GUIEditor.button[4]) == false or guiGetEnabled(GUIEditor.button[5]) == false or guiGetEnabled(GUIEditor.button[6]) == false) then
			guiSetEnabled(GUIEditor.button[3], false)
			triggerServerEvent("TAXI:datalvl", localPlayer, localPlayer, 1)
		end
	end
end


function endJobTaxi(plr, seat)
	if seat ~= 0 then return end
	if plr and plr == localPlayer then
        guiSetVisible(GUIEditor.window[1],false)
		showCursor(false)
		setElementData(plr,"player:GUIblock",false)
	end
end
addEventHandler("onClientVehicleStartExit", root, endJobTaxi)
addEventHandler("onClientVehicleExit", root, endJobTaxi)