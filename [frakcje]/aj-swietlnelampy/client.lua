--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt frakcji SAPD beta.
]]--

-- other
local delay = {}
addEventHandler("onClientRender", root,function()
	local uid = getElementData(localPlayer,"player:dbid") or 0;
	if uid > 0 then
	    local vehicle = getPedOccupiedVehicle(localPlayer) or false
		if vehicle then
			if delay[vehicle] and getTickCount() < delay[vehicle] then return end -- delay
			local code = getElementData(vehicle,"vehicle:frakcjaCODE") or false
			if tostring(code)=="SAPD" or tostring(code)=="SAMC" or tostring(code)=="PSP" then
				local sirens = getVehicleSirensOn(vehicle)
				local kiero = getVehicleOccupant(vehicle) or false;
				if kiero==localPlayer then
					if sirens then
						setElementData(vehicle,"vehicle:lightSirens",true)
						delay[vehicle] = getTickCount()+2000; -- ms
					else
						setElementData(vehicle,"vehicle:lightSirens",false)
					end
				end
			end
		end
	end
end)
