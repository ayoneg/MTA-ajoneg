--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt cygana pojazdów.
]]--

---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- -----

local blokada = {}
addEventHandler("onClientColShapeHit", root, function(el,md)
    if (not md) then return end
	if getElementType(el) == "player" then
	    local sprcol = getElementData(source,"cuboid:nameID") or false;
		if sprcol == "salon" and el==localPlayer then
			if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then
	    		return 
			end
			outputChatBox("#7AB4EAⒾ#e7d9b0 Aby zakupić ten pojazd, wejdź jako #EBB85Dkierowca#e7d9b0 i wpisz #EBB85D/kuppojazd#e7d9b0.",231, 217, 176,true)
			blokada[localPlayer] = getTickCount()+15000; -- 15 sek zabezpieczenia
		end
	end
end)
--[[
addEventHandler("onClientColShapeLeave", root, function(el,md)
    if (not md) then return end
	if getElementType(el) == "player" then
	    local sprcol = getElementData(source,"cuboid:nameID") or false;
		if sprcol == "salon" and el==localPlayer then
			
		end
	end
end)]]--
---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- -----