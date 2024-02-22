
local visu_markC = createMarker(-2033.4345703125, -117.453125, 1035.171875-1, "cylinder", 2, 255,255,255,50)
    setElementInterior(visu_markC, 3)
	setElementDimension(visu_markC, 500)
local marker_gpC = createColSphere(-2033.4345703125, -117.453125, 1035.171875, 1)
    setElementInterior(marker_gpC, 3)
	setElementDimension(marker_gpC, 500)


addEventHandler("onClientColShapeHit", marker_gpC, function(el,md)
	if not md or el~=localPlayer then return end
	if isPedInVehicle(el) then return end
--	if getElementData(el,"player:katB") == 1 then 
--		outputChatBox("#EBB85DSzkoła jazdy#e7d9b0: posiadasz już prawa jazdy!", 255, 255, 255, true)
--		return 
--	end
		triggerServerEvent("respPojazdPrawkaC", localPlayer, localPlayer)
end)

addEvent("nadajOgranicznik", true)
addEventHandler("nadajOgranicznik", root, function(plr)
    setElementData(plr,"player:vehicleogranicznik",60)
end)

addEvent("startTimerClientSideC", true)
addEventHandler("startTimerClientSideC", root, function(plr,text)
if localPlayer == plr then
    test=setTimer(function()
	    triggerServerEvent("removeEgzaminServerSideC",localPlayer,localPlayer,text)
	end, 540000, 1) --- 540000
end
end)

addEvent("killTimerClientSideC", true)
addEventHandler("killTimerClientSideC", root, function(plr)
if localPlayer == plr then
    killTimer(test)
end
end)
