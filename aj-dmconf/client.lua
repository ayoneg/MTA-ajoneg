--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt STREFY DM BETA.
]]--

local dm = {}
local screenW, screenH = guiGetScreenSize()

dm.panel = guiCreateWindow((screenW - 424) / 2, (screenH - 405) / 2, 424, 405, "Dostępne \"produkty\":", false)
guiWindowSetSizable(dm.panel, false)

dm.btn_1 = guiCreateButton(61, 57, 302, 59, "Kebab łagodny - 10$", false, dm.panel)
dm.btn_2 = guiCreateButton(61, 136, 302, 59, "Kebab na ostrym - 15$", false, dm.panel)
dm.btn_3 = guiCreateButton(61, 215, 302, 59, "Deagle - 55$", false, dm.panel)
dm.btn_exit = guiCreateButton(61, 322, 302, 36, "Zamknij", false, dm.panel)    
guiSetVisible(dm.panel, false)

addEventHandler("onClientGUIClick", root, function()
	if source == dm.btn_1 then
		-- dodaje HP
		local cena = 1000;
		local ID = "HP1";
		triggerServerEvent("nadajGraczowiDMShop",resourceRoot,localPlayer,cena,ID)
		guiSetVisible(dm.panel, false)
		showCursor(false)
	end
	if source == dm.btn_2 then
		-- dodaje HP 2
		local cena = 1500;
		local ID = "HP2";
		triggerServerEvent("nadajGraczowiDMShop",resourceRoot,localPlayer,cena,ID)
		guiSetVisible(dm.panel, false)
		showCursor(false)
	end
	if source == dm.btn_3 then
		-- dodaje dEAGLE
		local cena = 5500;
		local ID = "DEAGLE";
		triggerServerEvent("nadajGraczowiDMShop",resourceRoot,localPlayer,cena,ID)
		guiSetVisible(dm.panel, false)
		showCursor(false)
	end
	if source == dm.btn_exit then
		guiSetVisible(dm.panel, false)
		showCursor(false)
	end
end)

addEvent("createBigExplosion", true)
addEventHandler("createBigExplosion",resourceRoot,function(plr,x,y,z)
	if localPlayer==plr then
		createExplosion(x, y, z+math.random(16,20), 0, false, math.random(-1,3), false)
	end
end)

local bbgs = {}
local modeleFire = { [1912]=true,[1913]=true,[1914]=true, }

addEventHandler("onClientPlayerWeaponFire",localPlayer,function(wep,_,_,hitX,hitY,hitZ)
	if bbgs[localPlayer] and getTickCount() < bbgs[localPlayer] then return end
	if wep == 42 and math.random(1,1000)<=75 then -- 7,5% szans
		for k, v in ipairs(getElementsByType("object",resourceRoot)) do
			if modeleFire[getElementModel(v)] then
				local fX,fY,fZ = getElementPosition(v)
				local dist = getDistanceBetweenPoints2D(hitX,hitY,fX,fY)
				if dist < 1 then
					triggerServerEvent("removeFireFromWorld",resourceRoot,v,source)
					bbgs[localPlayer] = getTickCount()+3500;
				end
			end
		end
	end
end)

local dm_shop_vis = createMarker(2112.681640625, -1216.53515625, 23.8046875-1, "cylinder", 2, 255,255,255,50)
local dm_shop = createColSphere(2112.681640625, -1216.53515625, 23.8046875, 1)

addEventHandler("onClientColShapeHit", dm_shop, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
	if el ~= localPlayer then return end
	guiSetVisible(dm.panel, true)
	showCursor(true)
end)

addEventHandler("onClientColShapeLeave", dm_shop, function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
	if el ~= localPlayer then return end
	guiSetVisible(dm.panel, false)
	showCursor(false)
end)