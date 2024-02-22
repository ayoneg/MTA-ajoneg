

local visu_mark = createMarker(-2033.4345703125, -117.4462890625, 1035.171875-2, "cylinder", 2, 255,255,255,50)
    setElementInterior(visu_mark, 3)
	setElementDimension(visu_mark, 100)
local marker_gp = createColSphere(-2033.4345703125, -117.4462890625, 1035.171875, 1)
    setElementInterior(marker_gp, 3)
	setElementDimension(marker_gp, 100)


addEventHandler("onClientColShapeHit", marker_gp, function(el,md)
	if not md or el~=localPlayer then return end
	if isPedInVehicle(el) then return end
--	if getElementData(el,"player:katB") == 1 then 
--		outputChatBox("#EBB85DSzkoła jazdy#e7d9b0: posiadasz już prawa jazdy!", 255, 255, 255, true)
--		return 
--	end
		triggerServerEvent("respPojazdPrawka", localPlayer, localPlayer)
end)

addEvent("nadajOgranicznik", true)
addEventHandler("nadajOgranicznik", root, function(plr)
    setElementData(plr,"player:vehicleogranicznik",60)
end)

addEvent("startTimerClientSideB", true)
addEventHandler("startTimerClientSideB", root, function(plr,text)
if localPlayer == plr then
    test=setTimer(function()
	    triggerServerEvent("removeEgzaminServerSideB",localPlayer,localPlayer,text)
	end, 270000, 1) ---  270000
end
end)

addEvent("killTimerClientSideB", true)
addEventHandler("killTimerClientSideB", root, function(plr)
if localPlayer == plr then
    killTimer(test)
end
end)


