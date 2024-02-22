--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt startu pracy mechanika/tunera/lakiernika.
]]--

bliptunelv = createBlip(1950.36328125, 2175.892578125, 10.893982887268, 55, 1, 0,255,5,255, -60, 500)
bliplakiernialv = createBlip(1982.326171875, 2162.03125, 10.835376739502, 63, 1, 0,255,5,255, -69, 500)

blipmech1lv = createBlip(1087.9873046875, 1738.748046875, 10.8203125, 27, 1, 0,255,5,255, -60, 500)
bliplakiernialv2 = createBlip(1053.021484375, 1727.7197265625, 10.8203125, 63, 1, 0,255,5,255, -70, 500)


local mch = {}
mch.okno = guiCreateWindow(0.61, 0.42, 0.16, 0.23, "Ładowanie ---", true)
guiWindowSetMovable(mch.okno, false)
guiWindowSetSizable(mch.okno, false)
mch.okno_desc = guiCreateLabel(0.04, 0.14, 0.91, 0.36, "---", true, mch.okno)  
mch.button_start = guiCreateButton(0.04, 0.54, 0.91, 0.42, "---", true, mch.okno)
guiSetVisible(mch.okno, false)


-- jak gracz wejdzie
addEventHandler("onClientMarkerHit", root, function(el,md)
	local getjob = getElementData(source,"tunerstart") or false
    if getjob then
	local _,_,z = getElementPosition(source)
	local _,_,z2 = getElementPosition(el)
	if (z+3) > z2 and (z-3) < z2 then
		if getElementType(el)~="player" then return end
		if isPedInVehicle(el) then return end
		if el==localPlayer then
		local getCODE = getElementData(source,"m:duty") or false
		if not getCODE then return end
		if getElementData(el,"player:duty") == getCODE then
		    opis_button = "Zakończ pracę";
		else
		    opis_button = "Rozpocznij pracę";
		end
		local get_desc2 = getElementData(source,"m:desc2") or "";
		local get_desc3 = getElementData(source,"m:desc3") or "";
		local get_empl = getElementData(source,"m:maxEmployes") or 1;
		
		guiSetText(mch.button_start,tostring(opis_button))
		guiSetText(mch.okno,tostring(get_desc2))
		guiSetText(mch.okno_desc,tostring(get_desc3))
		
		setElementData(el,"player:dutycode",getCODE)
		setElementData(el,"player:maxemp",get_empl)
		
    	if guiGetVisible(mch.okno) == false then
    		showCursor(true)
    		guiSetVisible(mch.okno, true)
		end
		end
	end
	end
end)



addEventHandler("onClientGUIClick", root, function()
    if source == mch.button_start then
	    local sprr10 = getElementData(localPlayer,"player:duty") or false;
		if sprr10 then
			local getdutycode = getElementData(localPlayer,"player:dutycode") or false
			local maxemployes = getElementData(localPlayer,"player:maxemp") or 1;
			triggerServerEvent("sprGraczaFrakcjeTuneLV",localPlayer,getdutycode,getdutycode,localPlayer,maxemployes)
		else
			local getdutycode = getElementData(localPlayer,"player:dutycode") or false;
			if getdutycode then
				local maxemployes = getElementData(localPlayer,"player:maxemp") or 1;
				triggerServerEvent("sprGraczaFrakcjeTuneLV",localPlayer,getdutycode,getdutycode,localPlayer,maxemployes)
			end
		end
	end
end)

addEvent("ukryjPlrGUItunelv", true)
addEventHandler("ukryjPlrGUItunelv", root,function()
    if guiGetVisible(mch.okno) == true then
        showCursor(false)
        guiSetVisible(mch.okno, false)
    end	
end)
