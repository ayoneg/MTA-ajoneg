--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt dodatkowy do SAPD - kajdanki.
]]--

-------------------------------------------------------------------------
------ kajdanki typu #2 (~ limit graczy, wyglada jakbys go ruchal) ------
-------------------------------------------------------------------------
--[[
function zakuty()
	local dokogo=getElementData(localPlayer,"player:zakujBY")
	if (not dokogo or not isElement(dokogo)) then
		setElementData(localPlayer,"player:zakujBY", nil)
		removeEventHandler("onClientPreRender", root, zakuty)
		return
	end
	if (getElementInterior(dokogo)~=getElementInterior(localPlayer) or getElementDimension(dokogo)~=getElementDimension(localPlayer)) then
		triggerServerEvent("zlap:nadajdimint", root, localPlayer, dokogo)
		return
	end
--	local xz,yz,zz = getElementRotation(dokogo)
--	setElementAttachedOffsets(localPlayer)
--	setElementRotation(localPlayer, xz, yz, zz)
	local xz,yz,zz = getElementRotation(dokogo)
	local xzm,yzm,zzm = getElementRotation(localPlayer)
	if xz~=xzm or yz~=yzm or zz~=zzm then
--		setElementRotation(localPlayer,xz,yz,zz)
		triggerServerEvent("zlap:rotationchek", root, localPlayer, dokogo)
	end
	

	local x,y,z=getElementPosition(dokogo)
	local x2,y2,z2=getElementPosition(localPlayer)
	local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if (dist>10) then
		setElementPosition(localPlayer, x+math.random(-1,1), y+math.random(-1,1), z+math.random(0,10)/10)
		return
	end
end


addEvent("zakuj:refresh", true)
addEventHandler("zakuj:refresh", resourceRoot, function(kto)
	if kto and kto == localPlayer then
		local dokogo = getElementData(localPlayer,"player:zakujBY") or false;
		if dokogo then
			addEventHandler("onClientPreRender", root, zakuty)
		else
			removeEventHandler("onClientPreRender", root, zakuty)
		end
	end
end)

]]--
-------------------------------------------------------------------------
------ kajdanki typu #1 (unlimited graczy, biegaja jak psy za toba) -----
-------------------------------------------------------------------------
local function follow()
	local dokogo=getElementData(localPlayer,"player:zlapBY")
	if (not dokogo or not isElement(dokogo)) then
		setElementData(localPlayer,"player:zlapBY", nil)
		removeEventHandler("onClientPreRender", root, follow)
		return
	end
	if (getElementInterior(dokogo)~=getElementInterior(localPlayer) or getElementDimension(dokogo)~=getElementDimension(localPlayer)) then
		triggerServerEvent("zlap:nadajdimint", root, localPlayer, dokogo)
		return
	end
	local vehicle = getPedOccupiedVehicle(dokogo) or false
	local vehicle2 = getPedOccupiedVehicle(localPlayer) or false
	if vehicle then
		if not vehicle2 then
			triggerServerEvent("zlap:wtepajdoauta", root, localPlayer, vehicle)
			return
		end
	elseif vehicle2 then
		if not vehicle then
			triggerServerEvent("zlap:wtepajzauta", root, localPlayer)
			return
		end
	end	
	local x,y,z=getElementPosition(dokogo)
	local x2,y2,z2=getElementPosition(localPlayer)
	local kat=0
	kat=math.deg(math.atan(-1*(x2-x)/(y2-y)))
	if (y2-y)<0 then
		kat=kat+180.0
	end
	kat=(kat+180)%360
	setPedRotation(localPlayer, kat)
	local dist=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
	if (dist<=0.4) then 
		-- martwa strefa
		return 
	end
	if (dist<1.4) then
		setPedControlState(localPlayer, "forwards", false)
	else
		setPedControlState(localPlayer, "forwards", true)
	end
	if (dist>30) then
	  setElementPosition(localPlayer, x+math.random(-1,1), y+math.random(-1,1), z+math.random(0,10)/10)
	  return
	end
	if (dist>5) then
		setPedControlState(localPlayer, "sprint", true)
		setPedControlState(localPlayer, "walk", false)
	else
		setPedControlState(localPlayer, "walk", true)
		setPedControlState(localPlayer, "sprint", false)
	end
end

addEvent("zlap:refresh", true)
addEventHandler("zlap:refresh", resourceRoot, function(kto)
	if kto and kto == localPlayer then
		local dokogo = getElementData(localPlayer,"player:zlapBY") or false;
		if dokogo then
			addEventHandler("onClientPreRender", root, follow)
		else
			removeEventHandler("onClientPreRender", root, follow)
		end
	end
end)
