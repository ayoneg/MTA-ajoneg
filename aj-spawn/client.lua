
--// tutej sprawdzamy

function sprBlip(blipID,blipOwner)
	for id, blip in ipairs(getElementsByType("blip")) do
		local blipCar = getElementData(blip,"blip:car") or false;
		if blipCar then 
			local getBlipID = tonumber(getElementData(blip,"blip:owner")) or 0;
			local getBlipCar = tonumber(getElementData(blip,"blip:ownerCar")) or 0;
			if getBlipID > 0 and getBlipCar > 0 and getBlipID == blipID and blipOwner == getBlipCar then
				return true
			end
		end
	end
	return false
end

addEvent("vehicleblips", true)
addEventHandler("vehicleblips", root, function(plr)
if plr ~= localPlayer then return end
	for id, veh in ipairs(getElementsByType("vehicle")) do
		if uid == tonumber(getElementData(veh,"vehicle:owner")) then
			--createBlipAttachedTo(veh,0,0,5000,0,0.3,0,255,0,255,1,99999)
    		destroyBlipsAttachedTo(veh)
		end
	end
end)

setTimer(function()
	local uid = getElementData(localPlayer,"player:dbid") or 0;
		if uid > 0 then
		for i,v in pairs(getElementsByType("vehicle")) do
			if getElementData(v,"vehicle:owner") == uid then
				if not sprBlip(uid,getElementData(v,"vehicle:id")) then
					name = createBlipAttachedTo(v, 0, 1, 255, 0, 0, 255)
					setElementData(name,"blip:car",true)
					setElementData(name,"blip:owner",uid)
					setElementData(name,"blip:ownerCar",getElementData(v,"vehicle:id"))
	--				outputDebugString("twoze blip")
				end
			end
			if getElementData(localPlayer,"player:orgID") > 0 and getElementData(v,"vehicle:groupowner") == getElementData(localPlayer,"player:orgID") and getElementData(v,"vehicle:owner") ~= uid then
				if not sprBlip(uid,getElementData(v,"vehicle:id")) then
					name = createBlipAttachedTo(v, 0, 1, 0, 0, 255, 255)
					setElementData(name,"blip:car",true)
					setElementData(name,"blip:owner",uid)
					setElementData(name,"blip:ownerCar",getElementData(v,"vehicle:id"))
				end
			end
			-- frakcje
			duty = getElementData(localPlayer,"player:frakcja") or false;
			owner = getElementData(v,"vehicle:owner") or false;
			if owner == 22 and duty then
				if not sprBlip(uid,getElementData(v,"vehicle:id")) then
					local frCODE = getElementData(localPlayer,"player:frakcjaCODE") or false;
					local frplrCODE = getElementData(v,"vehicle:frakcjaCODE") or false;
	--				outputDebugString(tostring(frplrCODE).." / "..tostring(frCODE))
					if tostring(frCODE)==tostring(frplrCODE) and frCODE~=false and frplrCODE~=false then
						name = createBlipAttachedTo(v, 0, 1, 0, 255, 0, 255)
						setElementData(name,"blip:car",true)
						setElementData(name,"blip:owner",uid)
						setElementData(name,"blip:ownerCar",getElementData(v,"vehicle:id"))
					end
				end
			elseif owner == 22 and not duty then -- poza duty frakcji usuwa z mapy
				destroyBlipsAttachedTo(v)
			end
		end
	end
end, 10000, 0)


addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		destroyBlipsAttachedTo(source)
	end
end)

addEventHandler("onClientElementDataChange", root,function(dataName)
	if getElementType(source) == "vehicle" and dataName == "vehicle:owner" then
		destroyBlipsAttachedTo(source)
	end
	if getElementType(source) == "vehicle" and dataName == "vehicle:groupowner" then
		destroyBlipsAttachedTo(source)
	end
end)

function destroyBlipsAttachedTo(elemente)
	local attached = getAttachedElements(elemente)
	if (attached) then
		for k,element in ipairs(attached) do
			if getElementType(element) == "blip" then
				destroyElement(element)
			end
		end
	end
end