local screenX,screenY=guiGetScreenSize()
local px,py=(screenX/1920),(screenY/1080)

duty = getElementData(localPlayer,"player:frakcja") or false;
if duty then
	codefr = getElementData(localPlayer,"player:frakcjaCODE") or "";
end

stan=true
if duty then
	opt=1
else
	opt=2
end

local options={
[1]="Pomiar prędkości",
[2]="Odznacz pojazd",
[3]="Przenieś na parking",
[4]="Zaciągnij / Zwolnij ręczny",
}

function isPedAiming (thePedToCheck)
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=speed*180
	return kmh
end

addEventHandler("onClientRender",root,function()
    if not stan then return end
	if isPedAiming(localPlayer) then
	    target=getPedTarget(localPlayer)
		if not target then return end
		if getPedWeapon(getLocalPlayer(),newSlot) == 22 then --// ZABEZPIECZAMY
	    if getElementType(target)=="vehicle" then

		wlasciciel = getElementData(target,"vehicle:owner") or "Błąd";
		paliwo_przed = getElementData(target,"vehicle:paliwo") or 0;
		paliwo = math.floor(paliwo_przed);
		poj_baku = getElementData(target,"vehicle:poj_baku") or paliwo;
		tablica = getElementData(target,"vehicle:id") or "brak";
		
		-- dodatek do suszarki
		local screenW, screenH = guiGetScreenSize()
		vmax = tonumber(math.floor(getElementSpeed(target)));
		maxvmax = tonumber(getElementData(localPlayer,"suszenie:vmax")) or 500;
		permiss = getElementData(localPlayer,"suszenie") or false;
		mx2 = maxvmax+10
		if vmax >= 0 and vmax < maxvmax then susz_speedcolor = tocolor(255, 255, 255, 255); end
		if vmax >= maxvmax and vmax < mx2 then susz_speedcolor = tocolor(255, 155, 0, 255); end
		if vmax >= mx2 then susz_speedcolor = tocolor(255, 0, 0, 255); end
		
        dxDrawText(vmax.." KM/H", (screenW * 0.5385) + 1, (screenH * 0.4241) + 1, (screenW * 0.6484) + 1, (screenH * 0.4593) + 1, tocolor(0, 0, 0, 255), 2.20, "default", "left", "center", false, false, false, false, false)
        dxDrawText(vmax.." KM/H", screenW * 0.5385, screenH * 0.4241, screenW * 0.6484, screenH * 0.4593, susz_speedcolor, 2.20, "default", "left", "center", false, false, false, false, false)
        dxDrawText(getVehicleName(target).." (ID: "..tablica..")\nWłaściciel: "..wlasciciel.."", (screenW * 0.5385) + 1, (screenH * 0.4574) + 1, (screenW * 0.6484) + 1, (screenH * 0.5019) + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "center", false, false, false, false, false)
        dxDrawText(getVehicleName(target).." (ID: "..tablica..")\nWłaściciel: "..wlasciciel.."", screenW * 0.5385, screenH * 0.4574, screenW * 0.6484, screenH * 0.5019, tocolor(255, 255, 255, 255), 1.20, "default", "left", "center", false, false, false, false, false)
        dxDrawText("Paliwo: "..paliwo.."L", (screenW * 0.5385) + 1, (screenH * 0.4926) + 1, (screenW * 0.6484) + 1, (screenH * 0.5176) + 1, tocolor(0, 0, 0, 255), 1.40, "default", "left", "center", false, false, false, false, false)
        dxDrawText("Paliwo: "..paliwo.."L", screenW * 0.5385, screenH * 0.4926, screenW * 0.6484, screenH * 0.5176, tocolor(255, 255, 255, 255), 1.40, "default", "left", "center", false, false, false, false, false)
		if tonumber(opt)==1 and permiss then 
			susz_col2 = tocolor(0, 178, 0, 255)
		else
			susz_col2 = tocolor(187, 0, 0, 255)
		end
        dxDrawText(""..options[opt].."", (screenW * 0.5385) + 1, (screenH * 0.5176) + 1, (screenW * 0.6484) + 1, (screenH * 0.5426) + 1, tocolor(0, 0, 0, 255), 1.20, "default", "right", "center", false, false, false, false, false)
        dxDrawText(""..options[opt].."", screenW * 0.5385, screenH * 0.5176, screenW * 0.6484, screenH * 0.5426, susz_col2, 1.20, "default", "right", "center", false, false, false, false, false)
		
		end	
		end
	end
end)



addEventHandler("onClientKey",root,function(button,state)
	if isPedAiming(localPlayer) then
	    target=getPedTarget(localPlayer)
		if not target then return end
	    	if getElementType(target)=="vehicle" then
				if getPedWeapon(getLocalPlayer(),newSlot) == 22 then --// ZABEZPIECZAMY
					duty = getElementData(localPlayer,"player:frakcja") or false;
					admduty = getElementData(localPlayer,"admin:zalogowano") or "false";
					if duty then
						codefr = getElementData(localPlayer,"player:frakcjaCODE") or "";
					end
					if state and admduty=="true" and duty and ( codefr=="SAPD" or codefr=="USM" ) then -- adm
    					if button=="mouse_wheel_down" then
	    					opt=opt+1
							if opt>4 then
								opt=1
							end
						elseif button=="mouse_wheel_up" then
	    					opt=opt-1
							if opt<1 then
		    					opt=4
							end
						elseif button=="mouse1" then
							if opt==1 then
								triggerServerEvent("pomiar:predkosci",localPlayer,target,localPlayer)
							elseif opt==2 then
		    					triggerServerEvent("odznacz:pojazd",localPlayer,target)
							elseif opt==3 then
								triggerServerEvent("usun:pojazd",localPlayer,target)
							elseif opt==4 then
								triggerServerEvent("reczny:pojazd",localPlayer,target)
							end
	    				end
					elseif state and admduty=="true" then
    					if button=="mouse_wheel_down" then
	    					opt=opt+1
							if opt>4 then
								opt=2
							end
						elseif button=="mouse_wheel_up" then
	    					opt=opt-1
							if opt<2 then
		    					opt=4
							end
						elseif button=="mouse1" then
							if opt==2 then
		    					triggerServerEvent("odznacz:pojazd",localPlayer,target)
							elseif opt==3 then
								triggerServerEvent("usun:pojazd",localPlayer,target)
							elseif opt==4 then
								triggerServerEvent("reczny:pojazd",localPlayer,target)
							end
	    				end
					elseif state and codefr=="SAPD" and admduty=="false" then -- police
    					if button=="mouse_wheel_down" then
	    					opt=opt+1
							if opt>3 then
								opt=1
							end
						elseif button=="mouse_wheel_up" then
	    					opt=opt-1
							if opt<1 then
		    					opt=3
							end
						elseif button=="mouse1" then
							if opt==1 then
								triggerServerEvent("pomiar:predkosci",localPlayer,target,localPlayer)
							elseif opt==2 then
		    					triggerServerEvent("odznacz:pojazd",localPlayer,target)
							elseif opt==3 then
								triggerServerEvent("reczny:pojazd",localPlayer,target)
							end
	    				end
					elseif state and codefr=="USM" and admduty=="false" then -- police
						opt = 1
						if button=="mouse1" then
							if opt==1 then
								triggerServerEvent("pomiar:predkosci",localPlayer,target,localPlayer)
							end
	    				end
					end
				end
			end
	end
end)





