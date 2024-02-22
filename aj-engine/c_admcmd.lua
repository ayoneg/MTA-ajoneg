local screenW, screenH = guiGetScreenSize()
local lista = {}

function startTicker()
    if odliczanie == "GO!" then
        odliczanie = false
	    destroyElement(sphere)
	else
    	if odliczanie > 0 then
			odliczanie = odliczanie - 1
			setTimer(startTicker, 1000, 1)
			if odliczanie == 0 then odliczanie = "GO!"; end
		end
	end
end

addEventHandler("onClientRender", root, function()
    if (odliczanie) then
	lista = getElementsWithinColShape(sphere, 'player')
	 	for i,v in pairs(lista) do
			if v==localPlayer then
            	dxDrawText(odliczanie, (screenW * 0.4307) - 1, (screenH * 0.1843) - 1, (screenW * 0.5693) - 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) + 1, (screenH * 0.1843) - 1, (screenW * 0.5693) + 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) - 1, (screenH * 0.1843) + 1, (screenW * 0.5693) - 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) + 1, (screenH * 0.1843) + 1, (screenW * 0.5693) + 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, screenW * 0.4307, screenH * 0.1843, screenW * 0.5693, screenH * 0.2667, tocolor(255, 255, 255, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
			end
		end
    end
end)

addEvent("oczliczStart", true)
addEventHandler("oczliczStart", root, function(x,y,z)
	sphere = createColSphere(x,y,z, 67) --//rendering
	setElementPosition(sphere, x, y, z+1)
    odliczanie = 6
    startTicker()
end)


addCommandHandler("devmode",function()
    setDevelopmentMode(true)
end)

addCommandHandler("root.cam", function(cmd)
if getElementData(localPlayer,"admin:poziom") >= 7 then
    if getElementData(localPlayer,"admin:zalogowano") == "true" then
		x, y, z, xy, yy, zy = getCameraMatrix(localPlayer)
		outputChatBox("cam: "..x..", "..y..", "..z..", "..xy..", "..yy..", "..zy,0,255,0)
    end
end
end)