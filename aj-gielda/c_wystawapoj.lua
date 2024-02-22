--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt giełdy pojazdów.
]]--

local create_sell = createMarker(1728.0048828125, 1858.5537109375, 10.8203125-4, "cylinder", 7, 0, 0, 0, 66, root)
local create_obszar = createColSphere(1728.0048828125, 1858.5537109375, 10.8203125, 4)

        local gielda = {}
        gielda.okno = guiCreateWindow(0.62, 0.62, 0.20, 0.26, "Wystaw pojazd", true)
        guiWindowSetSizable(gielda.okno, false)

        gielda.input_cost = guiCreateEdit(0.13, 0.20, 0.75, 0.18, "", true, gielda.okno)
        gielda.btn_submit = guiCreateButton(0.13, 0.53, 0.75, 0.19, "Wystaw pojazd", true, gielda.okno)
        gielda.desc_cost = guiCreateLabel(0.14, 0.09, 0.44, 0.11, "Cena:", true, gielda.okno)
        guiLabelSetVerticalAlign(gielda.desc_cost, "center")
        gielda.btn_exit = guiCreateButton(0.13, 0.75, 0.75, 0.13, "Zamknij", true, gielda.okno) 
        guiEditSetMaxLength(gielda.input_cost, 6)
		guiSetVisible(gielda.okno, false)
		guiSetProperty(gielda.input_cost, "ValidationString", "^[0-9]*$") 
		
addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == gielda.btn_submit then
		local cost = tonumber(guiGetText(gielda.input_cost)) or 0;
		if cost > 0 then
			local vehicle = getPedOccupiedVehicle(localPlayer) or false;
			if vehicle then
				guiSetVisible(gielda.okno, false)
				showCursor(false)
				setElementData(localPlayer,"player:GUIblock",false)
				triggerServerEvent("stronaServeraStartGielda",root,localPlayer,vehicle,cost)
			end
		end
	end

	if source == gielda.btn_exit then
		guiSetVisible(gielda.okno, false)
		showCursor(false)
		setElementData(localPlayer,"player:GUIblock",false)
	end
end)

addEventHandler("onClientColShapeHit",create_obszar,function(theElement)
    if getElementType(theElement) == "vehicle" then
        local driver = getVehicleOccupant(theElement) or false;
		if driver and driver==localPlayer then
			local plr_id = getElementData(driver,"player:dbid") or 0;
			if plr_id > 0 then
				guiSetVisible(gielda.okno, true)
				showCursor(true)
				setElementData(localPlayer,"player:GUIblock",true)
			end
		end
    end
end)

addEventHandler("onClientColShapeLeave",create_obszar,function(theElement)
	local plr_id = getElementData(theElement,"player:dbid") or 0;
	if plr_id > 0 then
		guiSetVisible(gielda.okno, false)
		showCursor(false)
		setElementData(localPlayer,"player:GUIblock",false)
	end
end)

function sprOnline(uid)
	for i, user in ipairs(getElementsByType("player")) do
	local uidus = getElementData(user,"player:dbid") or 0;
	if uidus > 0 then
		if uidus == uid then
			return true -- online
		end
	end
	end
end

local sw, sh = guiGetScreenSize()
addEventHandler("onClientRender", root,function()
local rootx, rooty, rootz = getCameraMatrix()

for i,vehicle in ipairs(getElementsByType("vehicle")) do
	local x,y,z=getElementPosition(vehicle)
	local sx,sy=getScreenFromWorldPosition(x,y,z)
	if sx and sy then
	local gieldaCar=getElementData(vehicle,"vehicle:gielda") or false;
	local gieldaOpis=getElementData(vehicle,"vehicle:gieldaOpis") or "";
	
	local gieldaTune = getElementData(vehicle,"vehicle:gieldaTune") or "";
	local gieldaTune2 = getElementData(vehicle,"vehicle:gieldaTune2") or "";
	local gieldaOwner = getElementData(vehicle,"vehicle:owner") or 0;
	local gieldaOwnerName = getElementData(vehicle,"vehicle:gieldaOwnerName") or "brak";
--	local gieldaWheels = getElementData(vehicle,"vehicle:gieldaWheels") or "";

	
	if gieldaCar then
	local x,y,z=getElementPosition(vehicle)
	local sx,sy=getScreenFromWorldPosition(x,y,z+1) -- 1.3
	if sx and sy then
	
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 7; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,vehicle ) then
	if sprOnline(gieldaOwner) then
		desc = "Sprzedawca: "..gieldaOwnerName.." ";
		desc2 = "online";
		color1 = "#009933";
	else
		desc = "Sprzedawca: "..gieldaOwnerName.." ";
		desc2 = "offline";
		color1 = "#ff3300";
	end
	
	
	dxDrawText(""..desc.."("..desc2..")#000000\n"..gieldaOpis:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy-9,sx+(sw/10)+1,sy-9, tocolor(0,0,0,255), 1.1, "default", "center","center",true,true,false,true,true)
    dxDrawText("#ffffff"..desc.."("..color1..desc2.."#ffffff)\n"..gieldaOpis:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy-10,sx+(sw/10),sy-10, tocolor(255,255,255,255), 1.1, "default", "center","center",true,true,false,true,true)
	
	dxDrawText(""..gieldaTune:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy+38,sx+(sw/10)+1,sy+38, tocolor(0,0,0,255), 1.1, "default", "center","center",true,true,false,true,true)
    dxDrawText("#9999ff"..gieldaTune:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy+37,sx+(sw/10),sy+37, tocolor(255,255,255,255), 1.1, "default", "center","center",true,true,false,true,true)
	
	dxDrawText("\n"..gieldaTune2:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy+56,sx+(sw/10)+1,sy+56, tocolor(0,0,0,255), 1.1, "default", "center","center",true,true,false,true,true)
    dxDrawText("\n#63b65d"..gieldaTune2:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy+55,sx+(sw/10),sy+55, tocolor(255,255,255,255), 1.1, "default", "center","center",true,true,false,true,true)
	
--	dxDrawText(""..gieldaWheels:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy+76,sx+(sw/10)+1,sy+76, tocolor(0,0,0,255), 1.1, "default", "center","center",false,false,false,true,true)
--    dxDrawText("#63b65d"..gieldaWheels:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy+75,sx+(sw/10),sy+75, tocolor(255,255,255,255), 1.1, "default", "center","center",false,false,false,true,true)
	end
	end	
    end

	
	end -- enf fck
	
	end
end
end)