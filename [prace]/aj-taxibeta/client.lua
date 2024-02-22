--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt BETA pracy taxi.
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

local blokada = {}
addEventHandler("onClientColShapeHit", root, function(el,md)
    if (not md) then return end
	if getElementType(el) == "player" then
	    local sprcol = getElementData(source,"TAXI:player") or false;
		local uid = getElementData(el,"player:dbid") or 0;
		if sprcol == uid and el==localPlayer then
			if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then
	    		return 
			end
			addEventHandler("onClientRender", root, dxDrawTextFunk)
			blokada[localPlayer] = getTickCount()+2000; -- 2 sek zabezpieczenia
		end
	end
end)

addEventHandler("onClientColShapeLeave", root, function(el,md)
    if (not md) then return end
	if getElementType(el) == "player" then
	    local sprcol = getElementData(source,"TAXI:player") or false;
		local uid = getElementData(el,"player:dbid") or 0;
		if sprcol == uid and el==localPlayer then
			removeEventHandler("onClientRender", root, dxDrawTextFunk) 
		end
	end
end)

addEvent("removeInfoTAXI", true)
addEventHandler("removeInfoTAXI", root, function()
    if isEventHandlerAdded("onClientRender", root, dxDrawTextFunk) then
        removeEventHandler("onClientRender", root, dxDrawTextFunk) 
    end
end)

------ dp info ------------ dp info ------------ dp info ------
function dxDrawTextFunk()
    dxDrawText("#7AB4EAⒾ #ffffffZatrzymaj pojazd w tym obszarze, aby rozpocząć / zakończyć zlecenie użyj klaksonu.", screenW * 0.3182, screenH * 0.7685, screenW * 0.6818, screenH * 0.7880, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, true, false)
end
------ dp info ------------ dp info ------------ dp info ------