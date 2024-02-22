--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt lakierni pojazdów.
]]--

local akcja = false
local obszary = {
	{1967.703125, 2158.3623046875, 10.8203125-1, 16, 8, 6}, -- lakiernia LV
	
	{1051, 1724, 10.8203125-1, 15, 7.7, 6}, -- lakiernia LV mech
}
local markery = {
--	 X, Y, Z, kolor NR (1-4), dostęp (KOD pracy)
	{1981.6767578125, 2163.90234375, 10.828125, 1, "tune-lv"},  -- lakiernia LV
	{1981.6767578125, 2160, 10.835376739502, 2, "tune-lv"},  -- lakiernia LV
	
	{1054.79296875, 1725.09765625, 10.8203125, 1, "mechanik-lv"},  -- lakiernia LV mech
	{1051.6630859375, 1724.998046875, 10.8203125, 2, "mechanik-lv"},  -- lakiernia LV mech
}

for i,p in ipairs(obszary) do
	obszartest = createColCuboid(p[1],p[2],p[3]-1,p[4],p[5],p[6])
	setElementData(obszartest,"lakiernia",true)
end

for i,p in ipairs(markery) do
	mark = createMarker(p[1],p[2],p[3]-1.2, "cylinder", 1.2, 255,255,255,77)
--	mark = createColSphere(v[1],v[2],v[3], 1)
	setElementData(mark,"lakiernia",true)
	setElementData(mark,"lakiernia:color",p[4])
	setElementData(mark,"lakiernia:code",p[5])
	t = createElement("text")
	setElementData(t,"name","Kolor "..p[4].."\nKoszt: 50$")
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementPosition(t,p[1],p[2],p[3])
end


--==================--  --==================--  --==================--

local blokada = {}

addEventHandler("onClientColShapeHit", root, function(el,md)
    if not md or el~=localPlayer then return end
	local sproo = getElementData(source,"lakiernia") or false;
	if sproo then
		akcja = true
	end
end)

addEventHandler("onClientColShapeLeave", root, function(el,md)
    if not md or el~=localPlayer then return end
	local sproo = getElementData(source,"lakiernia") or false;
	if sproo then
    	closePicker(el)
		akcja = false
		triggerServerEvent("removeSpray", localPlayer, localPlayer)
	end
end)

local spray = 0 -- jedyne rozwiazanie które dziala, dziwne 

function functiontest()
	setElementData(localPlayer,"spray:colorNR",spray)
	triggerServerEvent("giveSpray", localPlayer, localPlayer)
end

addEventHandler("onClientMarkerHit", getRootElement(), function(el,md)
    if not md or el~=localPlayer then return end
	local sproo = getElementData(source,"lakiernia") or false;
	if sproo then
	local _,_,z = getElementPosition(source)
	local _,_,z2 = getElementPosition(el)
	if (z+3) > z2 and (z-3) < z2 then
--		local spray = tonumber(getElementData(source,"lakiernia:color")) or 1;
		local CODE = getElementData(source,"lakiernia:code") or false;
		local premium = getElementData(el,"player:premium") or 0;
		spray = tonumber(getElementData(source,"lakiernia:color")) or 1;
		if ( CODE ~= false and tonumber(premium) > 0 and tostring(CODE) == "premium" ) or ( CODE ~= false and tostring(CODE) == getElementData(el,"player:duty") ) then -- tylko dla prem aktualnie
			openPicker(el, "#FFFFFF", "Wybierz kolor lakierowania")
			addEventHandler("onColorPickerOK", root, function(el, hex, r, g, b)
				if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then return end
		
				local kesz = getPlayerMoney()
				local cost = 50;
				if kesz < cost then 
					outputChatBox("#841515✖#e7d9b0 Nie posiadasz tyle gotówki przy sobie!",231, 217, 176,true)
					return 
				end
				
				triggerServerEvent("takePlrMoney",root,el,cost)
				
				setElementData(el,"spray:color",{r,g,b})
				blokada[localPlayer] = getTickCount()+200; -- 200 ms zabezpieczenia
				triggerServerEvent("localInfoChat",root,el,"miesza kolory w lakierni.",45)
				functiontest()
			end)
			
		else
			outputChatBox("#841515✖#e7d9b0 Lakiernia dostępna jest tylko dla pracowników warsztatu!",231, 217, 176,true)
		end
	end
	end
end)


function cancelTearGasChoking(weaponID) -- blokada dm
	if (weaponID==41) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerChoke", getLocalPlayer(), cancelTearGasChoking)

addEventHandler("onClientPlayerWeaponFire", localPlayer, function(weapon,_,_,_,_,_,el)
    if source~=localPlayer then return end
    if weapon ~= 41 then return end
    if not el then cancelEvent() return end
    if getElementType(el) == "vehicle" and akcja == true then
        local spraycolor=getElementData(localPlayer,"spray:color")
		if spraycolor then
			local spraycolorNR = getElementData(localPlayer,"spray:colorNR") or 1;
        	triggerServerEvent("malowaniePojazdu", root, el, spraycolorNR, {spraycolor[1],spraycolor[2],spraycolor[3]})
			return
		end
	end
end)













