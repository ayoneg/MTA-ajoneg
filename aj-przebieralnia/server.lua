
local markerprz = createMarker(2102.5068359375, 2257.373046875, 11.634375, "arrow", 1.3, 255,144,0,50)
local markerprz_interio = createMarker(161.39453125, -96.5693359375, 1002.5046875, "arrow", 1.3, 255,144,0,50)
    setElementInterior(markerprz_interio, 18)
	setElementDimension(markerprz_interio, 300)
	
local sksksk = createBlip(2102.5068359375, 2257.373046875, 11.634375, 45, 1, 5,255,5,255, -1000, 400);	
--blipulvkaplica = createBlip(2487.16796875, 918.796875,8.7, 60, 1, 0,255,5,255, 1, 500)


addEventHandler("onMarkerHit",markerprz, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 18, 161.412109375, -93.267578125, 1001.8046875)
	setElementDimension(el, 300)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,360,"default",true)
		setCameraTarget(el, el)
end)

addEventHandler("onMarkerHit", markerprz_interio, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
    setElementInterior(el, 0, 2105.9912109375, 2257.3935546875, 11.0234375)
	setElementDimension(el, 0)
    local rotX, rotY, rotZ = getElementRotation(el) -- get the local players's rotation
	setElementRotation(el,0,0,rotZ)
		setElementRotation(el,0,0,rotZ,"default",true)
end)

addEvent("zmianaSkinaGraczowi", true)
addEventHandler("zmianaSkinaGraczowi", root, function(skin_id)
	setElementModel(source, skin_id)
	local uid = getElementData(source,"player:dbid")
	local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_skin = '"..skin_id.."' WHERE user_id = '"..uid.."'")
end)

