--------------------------- SYSTEM USZ POJ    ----------------------------
--------------------------- SYSTEM USZ POJ    ----------------------------
local time = getTickCount()
addEventHandler("onClientRender", root, function()
	local czas = 150
	if getTickCount() - time > czas then
	time = getTickCount()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then return end
	if getElementModel(vehicle) == 509 or getElementModel(vehicle) == 481 or getElementModel(vehicle) == 510 then return end
	local kierowca = getVehicleOccupant(vehicle,0) or "brak";
	if kierowca ~= localPlayer then return end
	    if getElementHealth(vehicle) < 300 then
		    setVehicleDamageProof(vehicle, true)
			if getVehicleEngineState(vehicle) then
			losowanie_grrr = math.random(1,50)
				if losowanie_grrr > 0 and losowanie_grrr < 5 then 
					setVehicleEngineState(vehicle, false);
					outputChatBox("* Silnik pojazdu wyłączył się, wskutek odniesionych uszkodzeń.")
				end
			end
			setElementHealth(vehicle, 301)
		elseif getElementHealth(vehicle) >= 300 then
		    setVehicleDamageProof(vehicle, false)
		end
	end
end)
--------------------------- SYSTEM CZASU ONLINE ----------------------------
setTimer(function()
    player_minuty = getElementData(localPlayer,"player:minuty") or 0;
	    if player_minuty == 0 then
		    setElementData(localPlayer,"player:minuty",1)
		else
			player_minuty = player_minuty + 1;
			setElementData(localPlayer,"player:minuty",player_minuty)
		end
end, 60000, 0)

-------------------------- SYSTEM PREMIUM GRACZA --------------------------
setTimer(function()
    player_online = getElementData(localPlayer,"player:online") or 0;
	    if player_online == 0 then
		    setElementData(localPlayer,"player:online",1)
		else
			player_online = player_online + 1;
			setElementData(localPlayer,"player:online",player_online)
			
			if tonumber(player_online) == 60 then
				local sprHours = getElementData(localPlayer, "player:onlineHours") or 0;
				if sprHours == 0 then setElementData(localPlayer, "player:onlineHours", 1) end
				if sprHours > 0 then setElementData(localPlayer, "player:onlineHours", sprHours+1) end
			end
			
		end
end, 60000, 0)
-------------------------- SYSTEM PREMIUM GRACZA --------------------------


-----------------------------jdnak nie    ----------------------------------
local screenW, screenH = guiGetScreenSize()
function pidusera()
	uid = getElementData(localPlayer,"player:dbid") or 0;
	if uid > 0 then
		dxDrawText("AJONEG @ TESTSERWER - AJONEG.EU / UID: "..uid.."", screenW * 0.0031, screenH * 0.9833, screenW * 0.1245, screenH * 1.0000, tocolor(255, 255, 255, 110), 1.00, "default", "left", "bottom", false, false, false, false, false)
	end
end
addEventHandler ( "onClientRender", root, pidusera )

-----------------------------anty wybu chanie----------------------------------

function onClientExplosion(x, y, z, theType)
	if theType > 0 then
		cancelEvent()
	end
end
addEventHandler("onClientExplosion", root, onClientExplosion)



-----------------------------LOGI SERV say/do/me----------------------------------
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




