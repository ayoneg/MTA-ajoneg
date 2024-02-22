--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--

-- // wejscie/wejscie urzad
addEventHandler("onClientMarkerHit", root, function(el,md)
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	local um = getElementData(source,"urzad") or false;
	if um then
		local inout = getElementData(source,"urzad:spc") or false;
		if inout then -- jesli wchdzi
			triggerServerEvent("wtepajGraczaUM", el, el, true, source)
		else -- wychodzi
			triggerServerEvent("wtepajGraczaUM", el, el, false, source)
		end
	end
end)