--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt zegarów auta.
]]--

local sw, sh = guiGetScreenSize()
local srodek = 305 --265
local tick = 0
local tick2 = 0
local tick3 = 0
local jednostka = "km/h";
local left = 20
local up = 40

-- spalanie śr
local sprzeb = 0
local spaliwo = 0

local bikes = {
	[510]=true,
	[509]=true,
	[481]=true,
	}
local rnow = false
--

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

--
function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=speed*180
	kmh = tonumber(math.floor(kmh));
	return kmh
end

addEventHandler('onClientVehicleEnter', root, function(plr, seat)
	if plr == localPlayer then
		if bikes[getElementModel(source)] then return end
		if isEventHandlerAdded("onClientRender", root, zegary) then
			removeEventHandler("onClientRender", root, zegary) 
		end
		addEventHandler('onClientRender', root, zegary);
		rnow = source
		spaliwo = 0
		sprzeb = 0
	end
end);

addEventHandler('onClientVehicleExit', root, function(plr, seat)
	if plr == localPlayer then
		removeEventHandler('onClientRender', root, zegary);
		rnow = false
		spaliwo = 0
		sprzeb = 0
	end
end);

function zegary()
	if isElement(rnow) then
		local hud = getElementData(localPlayer,"player:hud2") or false;
		if not hud then return end
		local veh = getPedOccupiedVehicle(localPlayer) or false;
		if veh then
		local veh_przebieg = tonumber(getElementData(rnow,"vehicle:przebieg") or 0);
		local veh_przebieg2 = string.format("%.1f", veh_przebieg)
		local veh_paliwo = tonumber(getElementData(rnow,"vehicle:paliwo") or 0);
		local veh_paliwo2 = string.format("%.1f", veh_paliwo)
		local veh_maxpaliwo = getElementData(rnow,"vehicle:maxpaliwo") or 25;
		local veh_maxpaliwo2 = string.format("%.1f", veh_maxpaliwo)
		local sirens = getElementData(rnow,"vehicle:syrenyON") or false;
		local tempomat = getElementData(rnow,"vehicle:tempomat") or false;
		
		dxDrawImage(sw-260-left, sh-260-up, 250, 250, ":aj-zegary/back-1a.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		
		if not getVehicleEngineState(rnow) or getElementHealth(rnow) <= 500 then
			if getElementHealth(rnow) <= 500 and getVehicleEngineState(rnow) then
				if (getTickCount() - tick2) > 800 then
					alpha3 = 0;
				end
				if (getTickCount() - tick2) > 1600 then
					alpha3 = 255;
					tick2 = getTickCount();
				end
			else
				alpha3 = 255
			end
			dxDrawImage(sw-125-left, sh-90-up, 32, 32, ":aj-zegary/engine.png", 0, 0, 0, tocolor(255, 255, 255, alpha3 or 255), false)
		end
		if isElementFrozen(rnow) then
			dxDrawImage(sw-170-left, sh-90-up, 32, 32, ":aj-zegary/brake.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
		
        dxDrawText(getVehicleName(rnow), sw-srodek + 1, sh-475-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText(getVehicleName(rnow), sw-srodek, sh-475-(up*2), sw, sh, tocolor(88, 88, 88, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		
		if isVehicleLocked(rnow) then zamek="[ZAMEK]"; else zamek=""; end
		if sirens then syreny="[DŹW. ON]"; else syreny=""; end
		dxDrawText(zamek.." "..syreny, sw-srodek + 1, sh-420-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText(zamek.." "..syreny, sw-srodek, sh-420-(up*2), sw, sh, tocolor(200, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		
		
		if tempomat then
			desc = "[OGRANICZNIK: "..tempomat.."km/h]";
		else
			desc = "[OGRANICZNIK: OFF]";
		end
		dxDrawText(desc, sw-srodek + 1, sh-330-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText(desc, sw-srodek, sh-330-(up*2), sw, sh, tocolor(100, 100, 100, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		
		dxDrawText(getElementSpeed(rnow).." "..jednostka, sw-srodek + 1, sh-280-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 2.00, "clear", "center", "center", false, true, false, false, false)
        dxDrawText(getElementSpeed(rnow).." "..jednostka, sw-srodek, sh-280-(up*2), sw, sh, tocolor(255, 255, 255, 255), 2.00, "clear", "center", "center", false, true, false, false, false)
		

		local licze = (veh_paliwo / veh_maxpaliwo) * 100;
		if licze > 100 then licze = 100 end
		dxDrawRectangle(sw-182-left, (sh-107-up), 100, 3, tocolor(33, 33, 33, 255), false)
		dxDrawRectangle(sw-182-left, (sh-107-up), licze, 3, tocolor(255, 219, 77, 55), false)
		
		dxDrawText("E", sw-srodek-90 + 1, sh-190-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText("E", sw-srodek-90, sh-190-(up*2), sw, sh, tocolor(155, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText("F", sw-210 + 1, sh-190-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText("F", sw-210, sh-190-(up*2), sw, sh, tocolor(155, 155, 155, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		
		local spl = 0
		
		if (getTickCount() - tick3) > 2000 then
			desc2 = veh_paliwo2.." / "..veh_maxpaliwo2.." L";
		end
		if (getTickCount() - tick3) > 11000 then
			-- odbieram dane koduje
			if veh_przebieg ~= sprzeb then
				przeb = veh_przebieg - sprzeb
				sprzeb = veh_przebieg
			end
			if veh_paliwo ~= spaliwo then
				plaiw = (veh_paliwo - spaliwo)*(-1)
				spaliwo = veh_paliwo
			end
			if przeb==veh_przebieg or plaiw==veh_paliwo then
				desc2 = veh_paliwo2.." / "..veh_maxpaliwo2.." L";
			else
				desc2 = ""..string.format("%.2f", przeb).."KM ~ "..string.format("%.2f", plaiw).."L";
			end
			tick3 = getTickCount();
			
		end
		
		dxDrawText(desc2, sw-srodek + 1, sh-230-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText(desc2, sw-srodek, sh-230-(up*2), sw, sh, tocolor(100, 100, 100, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		
		if veh_paliwo <= 9 and veh_paliwo > 5 then
			if (getTickCount() - tick) > 800 then
				alpha = 0;
			end
			if (getTickCount() - tick) > 1600 then
				alpha = 255;
				tick = getTickCount();
			end
        elseif veh_paliwo <= 5 then
			if (getTickCount() - tick) > 200 then
				alpha = 0;
			end
			if (getTickCount() - tick) > 600 then
				alpha = 255;
				tick = getTickCount();
			end
		else
			alpha = 0;
		end
		dxDrawImage(sw-180-left, sh-110-up, 32, 32, ":aj-zegary/dot.png", 0, 0, 0, tocolor(255, 255, 255, alpha or 0), false);
		
		dxDrawText(veh_przebieg2.." km", sw-srodek + 1, sh-65-(up*2) + 1, sw + 1, sh + 1, tocolor(0, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		dxDrawText(veh_przebieg2.." km", sw-srodek, sh-65-(up*2), sw, sh, tocolor(255, 0, 0, 255), 1.00, "clear", "center", "center", false, true, false, false, false)
		end
	end
end














