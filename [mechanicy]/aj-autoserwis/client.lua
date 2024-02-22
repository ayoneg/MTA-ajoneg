--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2023 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt auto serwisu.
]]--

local w_m={}

--utils
function math.round(number, decimals, method)
		decimals = decimals or 0
		local factor = 10 ^ decimals
		if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
		else return tonumber(("%."..decimals.."f"):format(number)) end
end

function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) fields[#fields+1] = c end)
	return fields
end


w_m.wnd = guiCreateWindow(0.25, 0.25, 0.51, 0.50, "Panel serwisowy", true)

w_m.grid = guiCreateGridList(0.02, 0.07, 0.96, 0.77, true, w_m.wnd)
guiGridListAddColumn(w_m.grid, "Nazwa części", 0.35)
guiGridListAddColumn(w_m.grid, "Stan części", 0.2)
guiGridListAddColumn(w_m.grid, "Koszt naprawy", 0.2)
guiGridListAddColumn(w_m.grid, "Czas naprawy", 0.2)
w_m.btn_napraw = guiCreateButton(0.02, 0.86, 0.32, 0.11, "Napraw", true, w_m.wnd)
w_m.btn_zamknij = guiCreateButton(0.35, 0.86, 0.32, 0.11, "Zamknij", true, w_m.wnd)
w_m.lbl_info = guiCreateLabel(0.71, 0.87, 0.26, 0.10, "", true, w_m.wnd)
guiLabelSetHorizontalAlign(w_m.lbl_info, "center", false)
guiLabelSetVerticalAlign(w_m.lbl_info, "center")
guiGridListSetSelectionMode(w_m.grid,1)
guiGridListSetSortingEnabled(w_m.grid,false)

w_m.lbl_costinfo = guiCreateLabel(0.71, 0.87, 0.26, 0.12, "", true, w_m.wnd)
w_m.lbl_timeinfo = guiCreateLabel(0.71, 0.87, 0.26, 0.06, "", true, w_m.wnd)
guiLabelSetHorizontalAlign(w_m.lbl_costinfo, "center", false)
guiLabelSetVerticalAlign(w_m.lbl_timeinfo, "center") 
guiLabelSetHorizontalAlign(w_m.lbl_timeinfo, "center", false)
guiLabelSetVerticalAlign(w_m.lbl_timeinfo, "center")       
guiSetVisible(w_m.wnd,false)

local naprawiany_pojazd=nil
local czas_naprawy=nil

local function kosztNaprawySilnika(v)
	local vhp=1000-getElementHealth(v)
	local cenapojazdu=getVehicleHandling(v).monetary or 10000
	local przebieg=(10000-math.min(getElementData(v,"vehicle:przebieg") or 5000,9999))/10000
	return vhp/1000*cenapojazdu*przebieg*0.012 -- it's that simple
end

local function kosztNaprawyElementu(v)
	local cenapojazdu=getVehicleHandling(v).monetary or 10000
	local przebieg=(10000-math.min(getElementData(v,"vehicle:przebieg") or 5000,9999))/10000
	return cenapojazdu*przebieg*0.008 -- it's that simple
end

local function kosztCzasuNaprawy(v)
	local cenapojazdu=getVehicleHandling(v).monetary or 10000
	local przebieg=(10000-math.min(getElementData(v,"vehicle:przebieg") or 5000,9999))/10000
	return cenapojazdu*przebieg*0.0005
end

local panele={
	[0]="Karoseria lewy przód",
	[1]="Karoseria prawy przód",
	[2]="Karoseria lewy tył",
	[3]="Karoseria prawy tył",
	[4]="Szyba przednia",
	[5]="Zderzak z przodu",
	[6]="Zderzak z tyłu"
}
local stanyPaneli={
	[0]="100%",
	[1]="66%",
	[2]="33%",
	[3]="0%",
}
local nazwyDrzwi={
	[0]="Maska",
	[1]="Bagażnik",
	[2]="Drzwi lewy przód",
	[3]="Drzwi prawy przód",
	[4]="Drzwi lewy tył",
	[5]="Drzwi prawy tył"
}

local nazwySwiatel={
	[0]="Światło lewy przód",
	[1]="Światło prawy przód",
	[2]="Światło lewy tył",
	[3]="Światło prawy tył"
}

local function fillVehicleData(v)
	guiGridListClear(w_m.grid)
	do
	if getElementHealth(v) ~= 1000 then
		local row=guiGridListAddRow(w_m.grid)
		guiGridListSetItemText(w_m.grid,row, 1, "Silnik",false,false)
		guiGridListSetItemData(w_m.grid,row, 1, -1)
		guiGridListSetItemText(w_m.grid,row, 2, math.round(getElementHealth(v)/10).."%", false, true)
		guiGridListSetItemText(w_m.grid,row, 3, math.round(math.abs(kosztNaprawySilnika(v))+2).."$", false, true)
		guiGridListSetItemText(w_m.grid,row, 4, math.round(math.abs(kosztCzasuNaprawy(v))+5+(math.round((1000-getElementHealth(v))/88)*2)).."s", false, true)
	end
	
	end
	-- drzwi
	for i=0,5 do
		local stan=getVehicleDoorState(v, i)
		if stan==2 or stan==3 or stan==4 then
			local koszt=kosztNaprawyElementu(v)*2/6
			local row=guiGridListAddRow(w_m.grid)
			guiGridListSetItemText(w_m.grid,row, 1, nazwyDrzwi[i],false,false)
			guiGridListSetItemData(w_m.grid,row, 1, i+10)
			guiGridListSetItemText(w_m.grid,row, 2, "0%", false, true)
			guiGridListSetItemText(w_m.grid,row, 3, math.round(koszt+2).."$", false, true)
			guiGridListSetItemText(w_m.grid,row, 4, math.round(math.abs(kosztCzasuNaprawy(v))+0.6+(stan*2)).."s", false, true)
		end
	end
	for i=0,3 do
		local stan=getVehicleLightState(v, i)
		if stan==1 then
			local koszt=kosztNaprawyElementu(v)*2/6
			local row=guiGridListAddRow(w_m.grid)
			guiGridListSetItemText(w_m.grid,row, 1, nazwySwiatel[i],false,false)
			guiGridListSetItemData(w_m.grid,row, 1, i+20)
			guiGridListSetItemText(w_m.grid,row, 2, "0%", false, true)
			guiGridListSetItemText(w_m.grid,row, 3, math.round(koszt+2).."$", false, true)
			guiGridListSetItemText(w_m.grid,row, 4, math.round(math.abs(kosztCzasuNaprawy(v))+(stan*2)-1).."s", false, true)
		end
	end
	for i,panel in pairs(panele) do
	local stan = getVehiclePanelState(v, i)
	if stan ~= 0 then
		local koszt=kosztNaprawyElementu(v)*(getVehiclePanelState(v,i))/6
		local row=guiGridListAddRow(w_m.grid)
		guiGridListSetItemText(w_m.grid,row, 1, panel,false,false)
		guiGridListSetItemData(w_m.grid,row, 1, i)
		local stan=stanyPaneli[getVehiclePanelState(v,i)]
		guiGridListSetItemText(w_m.grid,row, 2, stan, false, true)
		guiGridListSetItemText(w_m.grid,row, 3, math.round(koszt+2).."$", false, true)
		guiGridListSetItemText(w_m.grid,row, 4, math.round(math.abs(kosztCzasuNaprawy(v))+(getVehiclePanelState(v,i)*2)).."s", false, true)
	end
	end

end


addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
	if not md or el~=localPlayer then return end
    if isPedInVehicle(el) then return end

	local cs=getElementData(source, "autoserwis:data")
	if not cs then return end

	local pojazdy=getElementsWithinColShape(cs,"vehicle")

	if #pojazdy<1 then
		--outputChatBox("#841515✖#e7d9b0 Na stanowisku naprawczym nie ma pojazdu.",231, 217, 176,true)
		return
	end
	if #pojazdy>1 then
		outputChatBox("#841515✖#e7d9b0 Na stanowisku naprawczym jest zbyt dużo pojazdów.",231, 217, 176,true)
		return
	end
	allCost = setTimer(function(plr) 
		
	end, 1000, 0, el)
	
	if not isElementFrozen(pojazdy[1]) then
		outputChatBox("#841515✖#e7d9b0 Zaciągnij ręczny przez naprawą pojazdu.",231, 217, 176,true)
		return
	end
	
	if getVehicleEngineState(pojazdy[1]) then
		outputChatBox("#841515✖#e7d9b0 Wyłącz śilnik przed naprawą pojazdu.",231, 217, 176,true)
		return
	end
	
	fillVehicleData(pojazdy[1])
	guiSetEnabled(w_m.btn_napraw, false)
	guiSetText(w_m.lbl_info,"")
	
	guiSetVisible(w_m.wnd, true)
	showCursor(true);
	guiSetText(w_m.btn_napraw, string.format("Napraw (%s)", getVehicleName(pojazdy[1])) )
	naprawiany_pojazd=pojazdy[1]
end)

addEventHandler("onClientMarkerLeave", resourceRoot, function(el,md)
	if el~=localPlayer then return end
	guiSetVisible(w_m.wnd, false)
	showCursor(false);
	naprawiany_pojazd=nil
	if allCost and isTimer(allCost) then killTimer(allCost) end
end)

addEventHandler("onClientGUIClick", w_m.btn_zamknij, function()
	guiSetVisible(w_m.wnd, false)
	naprawiany_pojazd=nil
	showCursor(false);
	if allCost and isTimer(allCost) then killTimer(allCost) end
end, false)

addEventHandler("onClientGUIClick", w_m.grid, function()
	guiSetText(w_m.lbl_info,"")
	selectedRow= guiGridListGetSelectedItem ( w_m.grid) or -1
	if (selectedRow<0) then
		guiSetEnabled(w_m.btn_napraw,false)
		return
	end
	
	local multirepair = {}
	local rows = guiGridListGetSelectedItems(w_m.grid)
	for k,v in ipairs(rows) do
		if (k/3 == math.round(k/3)) then --kazde 3 wyniki sa takie same, pomijamy je
			table.insert(multirepair,v)
		end
	end
	
	totalkoszt = 0
	
	for k,v in ipairs(multirepair) do
		local koszt = guiGridListGetItemText(w_m.grid, v.row, 3)
		local koszt = koszt:split("$")
		local koszt = tonumber(koszt[1])
		totalkoszt = totalkoszt+koszt
	end
	
	local multirepairtime = {}
	local rows = guiGridListGetSelectedItems(w_m.grid)
	for k,v in ipairs(rows) do
		if (k/3 == math.round(k/3)) then --kazde 3 wyniki sa takie same, pomijamy je
			table.insert(multirepairtime,v)
		end
	end
	
	totaltime = 0
	
	for k,v in ipairs(multirepairtime) do
		local times = guiGridListGetItemText(w_m.grid, v.row, 4)
		local times = times:split("s")
		local times = tonumber(times[1])
		totaltime = totaltime+times
	end
	
	guiSetText(w_m.lbl_info, string.format("W sumie do zapłaty: %s$",totalkoszt))
	guiSetText(w_m.lbl_timeinfo, string.format("Czas naprawy: %ss.",totaltime))
	guiSetEnabled(w_m.btn_napraw, true)
	czas_naprawy = totaltime
end)

local napraw_lu=getTickCount()
local donaprawy={}
local cl_koszt = 0

addEventHandler("onClientGUIClick", w_m.btn_napraw, function()
	if getTickCount()-napraw_lu<1000 then return end

	if not naprawiany_pojazd or not isElement(naprawiany_pojazd) then return end

	selectedRow= guiGridListGetSelectedItem ( w_m.grid) or -1
	if selectedRow<0 then return end
	local rows = guiGridListGetSelectedItems(w_m.grid)
	
	local multirepair = {}
	--musimy sprawdzic, czy gracz zaznaczyl KILKA rowow, czy JEDEN	//karer - takie male udogodnienie
	for k,v in ipairs(rows) do
		if (k/3 == math.round(k/3)) then --kazde 3 wyniki sa takie same, pomijamy je
			table.insert(multirepair,v)
		end
	end
	
	guiSetText(w_m.lbl_info,"")
	if #multirepair == 1 then
		local koszt = guiGridListGetItemText(w_m.grid, selectedRow, 3)
		local koszt = koszt:split("$")
		local koszt = tonumber(koszt[1])
		if not koszt then return end
		if koszt<=0 then
		guiSetText(w_m.lbl_info,"Ta część jest sprawna.")
		return
		end

		local czesc=guiGridListGetItemData(w_m.grid, selectedRow, 1) -- numer panelu lub -1==silnik
		napraw_lu=getTickCount()
		triggerServerEvent("naprawaElementuAuto", resourceRoot, naprawiany_pojazd, czesc, koszt, czas_naprawy)	
	elseif #multirepair > 1 then
		cl_koszt = 0
		for i,v in ipairs(multirepair) do
			local selectedRow = v.row
			local koszt = guiGridListGetItemText(w_m.grid, selectedRow, 3)
			local koszt = koszt:split("$")
			local koszt = tonumber(koszt[1])
			if not koszt then return end
			if koszt<=0 then
				break
			end
			
			cl_koszt = cl_koszt+koszt
			
			
			local times = guiGridListGetItemText(w_m.grid, selectedRow, 4)
			local times = times:split("s")
			local times = tonumber(times[1])

			local czesc=guiGridListGetItemData(w_m.grid, selectedRow, 1) -- numer panelu lub -1==silnik
			napraw_lu=getTickCount()
			table.insert(donaprawy,{czesc, koszt, times})
			--triggerServerEvent("naprawaElementuAuto", resourceRoot, naprawiany_pojazd, czesc, koszt, czas_naprawy)	
		end
		
		triggerServerEvent("naprawaElementuAuto", resourceRoot, naprawiany_pojazd, donaprawy, cl_koszt, czas_naprawy)	
	else
		--
	end
	guiSetVisible(w_m.wnd, false)
	showCursor(false);
end, false)

-- triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
addEvent("refreshVehicleData", true)
addEventHandler("refreshVehicleData", resourceRoot, function(pojazd)
	naprawiany_pojazd=pojazd
	fillVehicleData(pojazd)
end)