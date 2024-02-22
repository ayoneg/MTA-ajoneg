local function spawn(player)
	if player and isElement(player) then
	local skin_gracza = getElementData(player,"player:skinid") or 0;
	local p = getElementData(player,"player:spawn") or {0, 0, -20}
	if not p then return end
	local player_id = getElementData(player,"player:dbid");
	if not player_id then 
	fadeCamera(player, true, 5)
	setElementFrozen(player, false) 
--	setCameraMatrix(player, -1834.34, 877.85, 297.09, 0.00, 0.00, 275.69)
	return end
	
    spawnPlayer(player, p[1], p[2], p[3], p[4], skin_gracza)
	
	local uid = getElementData(player,"player:dbid") or 0;
	if uid > 0 then
	triggerClientEvent(player,"vehicleblips",player,player);
	end
	
    --fadeCamera(player, false)
	setTimer(stopFadeCam, 1500, 1, player)
	setCameraTarget(player, player)
	showCursor(player,false);
		
	end
end	

function stopFadeCam(player)
    fadeCamera(player, true)
	setElementFrozen(player, false)	
end
	
local function spawnDM(player)
		local skin_gracza = getElementData(player,"player:skinid") or 0;
		spawnPlayer(player, 2023.357421875, -1253.5908203125, 23.984375, -90, skin_gracza)
		fadeCamera(player, true, 5)
		setElementFrozen(player, false) 
		setTimer(stopFadeCam, 1500, 1, player)
		setCameraTarget(player, player)
		showCursor(player,false);
end
local function onWasted()

	local strefadm = getElementData(source,"player:dmSTREFA") or false;
	if strefadm then
		setTimer(spawnDM,2500,1,source)
	else
		setTimer(spawn,2500,1,source)
	end

end

local function onJoin()

	--spawn(source)
	setTimer(spawn,2000,1,source)
    fadeCamera(source, false)

end

	addEventHandler("onPlayerJoin",root,onJoin)
	addEventHandler("onPlayerWasted",root,onWasted)
	
	addEvent("core:spawnPlayer", true)
    addEventHandler("core:spawnPlayer", root, onJoin)