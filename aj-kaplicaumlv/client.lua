local marker = createMarker(2491.3662109375, 918.5234375, 11.6, "arrow", 1.3, 255,255,255,50)
local marker_interio = createMarker(2256.5283203125, 850.9638671875, 100.3, "arrow", 1.3, 255,255,255,50)
    setElementInterior(marker_interio, 18)
	setElementDimension(marker_interio, 200)
	
	
--local blipulvkaplica = createBlip(2487.16796875, 918.796875, 11.0234375, 60,2,0,0,0,0,0,500)
blipulvkaplica = createBlip(2487.16796875, 918.796875,8.7, 60, 1, 0,255,5,255, -100, 500)

--local blipinfoulv = createPickup(2470.2919921875, 1022.62109375, 10.8203125, 3, 1239, 150)     

-- // wejscie urzad lv
addEventHandler("onClientMarkerHit", marker, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    triggerServerEvent("onGraczWejdzieKaplica", el)
end)
-- // wyjscie urzad lv
addEventHandler("onClientMarkerHit", marker_interio, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    triggerServerEvent("onGraczWyjdzieKaplica", el)
end)

local screenW, screenH = guiGetScreenSize()

addEvent( "pokazInfoOltaz", true )
addEventHandler( "pokazInfoOltaz", localPlayer,function(value,plr_rep,plr,variant)
if plr == localPlayer then

if isEventHandlerAdded("onClientRender", root, pokazNapisyEtc) then
    removeEventHandler("onClientRender", root, pokazNapisyEtc) 
end

function pokazNapisyEtc()
        dxDrawRectangle(screenW * 0.7891, screenH * 0.5287, screenW * 0.2109, screenH * 0.0824, tocolor(1, 0, 0, 166), false)
		if variant == "plus" then
		    dxDrawText("#ffffff"..plr_rep.." #388E00+"..value, screenW * 0.7932, screenH * 0.5333, screenW * 0.9948, screenH * 0.6019, tocolor(254, 254, 254, 254), 3.00, "default-bold", "center", "center", false, false, false, true, false)
		else
		    dxDrawText("#ffffff"..plr_rep.." #ff0000-"..value, screenW * 0.7932, screenH * 0.5333, screenW * 0.9948, screenH * 0.6019, tocolor(254, 254, 254, 254), 3.00, "default-bold", "center", "center", false, false, false, true, false)
		end
		
        dxDrawText("Reputacja:", (screenW * 0.7911) + 1, (screenH * 0.5037) + 1, (screenW * 0.9594) + 1, (screenH * 0.5287) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "bottom", false, false, false, false, false)
        dxDrawText("Reputacja:", screenW * 0.7911, screenH * 0.5037, screenW * 0.9594, screenH * 0.5287, tocolor(255, 255, 255, 255), 1.00, "default", "left", "bottom", false, false, false, false, false)	
end
addEventHandler("onClientRender", root, pokazNapisyEtc)		
	
setTimer(function()
removeEventHandler("onClientRender", root, pokazNapisyEtc) 
end, 7500, 1)
end
end)

--[[
addEventHandler("onClientRender", root, function()
    local sprkaplice = getElementData(localPlayer,"player:kaplica") or false;
	if sprkaplice == true then
	    local plr_id = getElementData(p,"player:dbid") or 0;
		if plr_id > 0 then
		    --wysylamy do serwera gotowe info co ma zrobic :)
		end
	end
end)	
-- to zadziala, ale tylko po stronie kienta, czyli kazdy w innym czasie otrzyma rep, strona serv zapewnia nadanie rep w tym samaym czasie
]]
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


--[[
addEventHandler("onClientPickupHit", blipinfoulv, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    pokaz()
end)
addEventHandler("onClientPickupLeave", blipinfoulv, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
    pokaz()
end)


        okienko_infoulv = guiCreateWindow(0.36, 0.38, 0.28, 0.24, "INFORMACJA", true)
        guiWindowSetSizable(okienko_infoulv, false)

        okienko_infoulvtext = guiCreateMemo(20, 35, 499, 204, "Urząd Las Venturas - Wita!\n\nCo tutaj znajdę?\n- Egzaminy teorytyczne.\n- Możliwość zatrudnienia się w pobliskich warsztatach.\n- Opłacanie mandatów.\n- Zmiana tablic rejestracyjnych pojazdów.\n\nStan na: 10.05.2021r.", false, okienko_infoulv)
        guiMemoSetReadOnly(okienko_infoulvtext, true)   
        guiSetVisible(okienko_infoulv,false)



function pokaz()
	if guiGetVisible(okienko_infoulv) == true then
	     guiSetVisible(okienko_infoulv,false)
	else
	     guiSetVisible(okienko_infoulv,true)
	end	
end
]]--