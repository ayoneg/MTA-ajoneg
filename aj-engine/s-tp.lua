--// KOMENDY (nasze) TPEKI
addCommandHandler("gp", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
    local gracz = el
	local x,y,z = getElementPosition(gracz)
    outputChatBox("Pozycja to: "..x..", "..y..", "..z,el,0,255,0)

end
end)

--[[
addCommandHandler("tplist", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
    local gracz = el
	local x,y,z = getElementPosition(gracz)
    outputChatBox("Pozycja to: "..x..", "..y..", "..z,el,0,255,0)

end
end)
]]--

addCommandHandler("tpkgp", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 241.6552734375, 108.7978515625, 1003.21875)
	setElementDimension(gracz,997)
	setElementInterior(gracz,10)
	end
end
end)

addCommandHandler("tppp", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz,  1970.5888671875, 2485.681640625, 11.178249359131)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	end
end
end)

addCommandHandler("tpum", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2480.3037109375, 1020.9521484375, 10.8203125)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	end
end
end)

addCommandHandler("tpmech", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1087.8779296875, 1726.2841796875, 10.8203125)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	end
end
end)


addCommandHandler("tpbank", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2437.578125, 2375.98046875, 10.8203125)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	end
end
end)

addCommandHandler("tpgielda", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1754.1953125, 1851.4033203125, 10.8203125)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	end
end
end)

addCommandHandler("tp14mili", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 899.6953125, 2039.640625, 10.8203125)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tplp", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -236.8896484375, 2652.7666015625, 62.6999168396)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpbm", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -2277.0908203125, 2281.0732421875, 4.9717783927917)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpprawko", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -154.50390625, 1177.7734375, 19.7421875)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpprawkoc", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1679.5234375, 940.2978515625, 10.8203125)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpdune", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1093.7880859375, 1290.2802734375, 10.8203125)
	setElementRotation(gracz, 0 , 0, 0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpcygan", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -14.1611328125, 1385.7578125, 9.171875)
	setElementRotation(gracz, 0 , 0, 180, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpeats", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2352.451171875, 2529.6748046875, 10.8203125)
	setElementRotation(gracz, 0 , 0, 180, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tptransport", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2847.3203125, 943.6943359375, 11.1)
	setElementRotation(gracz, 0 , 0, 90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tppp2", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 40.1103515625, 1182.8193359375, 19.108200073242)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tposiedle", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 895.19921875, 1965.67578125, 10.8203125)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)


addCommandHandler("tptune", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1956.0224609375, 2174.9736328125, 10.8203125)
	setElementRotation(gracz, 0 , 0, -180, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpwilla", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1248.8447265625, -2043.732421875, 148.5546875)
	setElementRotation(gracz, 0 , 0, -0, "default", true)
	setElementDimension(gracz,999)
	setElementInterior(gracz,9)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tptaxo", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2820.1044921875, 1982.5166015625, 10.8203125)
	setElementRotation(gracz, 0 , 0, -0, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpsf", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -2628.2685546875, -5.828125, 6.1328125)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpsf2", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -1973.7802734375, 884.4521484375, 44.910568237305)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpmc", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, -2353.90234375, -1635.2626953125, 483.40524291992)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tpls", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 1974.296875, -1234.9326171875, 19.754196166992)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

addCommandHandler("tppc", function(el,md)
if getElementData(el,"admin:poziom") >= 5 and getElementData(el,"admin:zalogowano") == "true" then
local gracz = el
    if isPedInVehicle(el) then 
	outputChatBox("* Najpierw wyjdź z auta.", el)
	else
    setElementPosition(gracz, 2287.1015625, 13.5654296875, 26.189168930054)
	setElementRotation(gracz, 0 , 0, -90, "default", true)
	setElementDimension(gracz,0)
	setElementInterior(gracz,0)
	setCameraTarget(gracz)
	end
end
end)

