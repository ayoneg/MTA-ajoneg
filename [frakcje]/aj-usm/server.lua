--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt urzędowego strażnika miejskiego.
]]--

--======================
-- TUTAJ KWESTIA INTERIORU
local USM_int = createMarker(2546.7045898438, 2172.1225585938, 0.75354409217834+0.65, "arrow", 1.3, 255,255,255,50)
local USM = createMarker(2548.791015625, 2172.0361328125, 10.8203125+0.65, "arrow", 1.3, 255,255,255,50)
local BLIP = createBlipAttachedTo(USM, 59, 2, 255, 0, 0, 255, 0, 300)

addEventHandler("onMarkerHit", USM, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementPosition(el, 2549.6020507812, 2172.0258789062, 0.75354409217834)
end)

addEventHandler("onMarkerHit", USM_int, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementPosition(el, 2544.5390625, 2171.8359375, 10.8203125)
end)
--======================