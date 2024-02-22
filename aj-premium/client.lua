--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt sklepu premium.
]]--
local sw,sh = guiGetScreenSize()

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

-- Modified version for DX Text
function isCursorOverText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end

local pokaz = false
local pdesc = "Jakie korzyści płyną, z posiadania konta premium?\n\n- Złoty nick oraz ID na czacie;\n- Dostęp do czatu premium (/v);\n- ECO DRIVE 10% mniejsze spalanie;\n- PG w pracach naliczane podwójnie;\n- Premia serwerowa 150$ za pełną godzinę gry;\n- Dodatkowe sloty na pojazdy;\n- Skiny premium w przebieralni;\n- Wsparcie finansowe serwera AjonEG.";
local pdesc2 = "Jak mogę zdobyć / kupić Punkty Premium?\n\nAktualnie pp może tylko przyznać administracja ROOT.\nW przyszłości takowe punkty będzie można zakupić\nza realną gotówkę bądź zdobyć za ukończone osiągnięcia."

addEventHandler("onClientRender", root,function()
	if pokaz then
		local player_pp = getElementData(localPlayer,"player:premiumPoints") or 0;
        dxDrawImage((sw-991)/2, (sh-538)/2, 991, 538, ":aj-log2/back10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("SKLEP PREMIUM", (sw-190)/2 + 1, (sh-620)/2 + 1, 1195 + 1, 261 + 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, false, false)
        dxDrawText("SKLEP PREMIUM", (sw-190)/2, (sh-620)/2, 1195, 261, tocolor(245, 183, 75, 255), 2.00, "default", "left", "top", false, false, false, false, false)
		
        dxDrawText(pdesc, (sw-920)/2 + 1, (sh-360)/2 + 1, 841 + 1, 595 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText(pdesc, (sw-920)/2, (sh-360)/2, 841, 595, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		
        dxDrawText(pdesc2, (sw-920)/2 + 1, (sh+50)/2 + 1, 841 + 1, 595 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText(pdesc2, (sw-920)/2, (sh+50)/2, 841, 595, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		
        dxDrawText("Saldo Punktów Premium: "..player_pp, (sw-940)/2 + 1, (sh-502)/2 + 1, 841 + 1, 318 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText("Saldo Punktów Premium: "..player_pp, (sw-940)/2, (sh-502)/2, 841, 318, tocolor(245, 183, 75, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		
        dxDrawRectangle((sw-991)/2, (sh-430)/2, 991, 9, tocolor(103, 103, 103, 255), false)
        dxDrawRectangle((sw-10)/2, (sh-390)/2, 10, 455, tocolor(103, 103, 103, 66), false)
		
		if isMouseInPosition((sw+95)/2, (sh-345)/2, 402, 46) then color1=tocolor(42, 53, 69, 255); else color1=tocolor(42, 53, 69, 177); end
        dxDrawRectangle((sw+95)/2, (sh-345)/2, 402, 46, color1, false)
        dxDrawText("Kup pakiet premium 30 dni", (sw+110)/2 + 1, (sh-320)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1.20, "default","left", "top", false, false, false, false, false)
        dxDrawText("Kup pakiet premium 30 dni", (sw+110)/2, (sh-320)/2, 1417, 403, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 750 pp.", (sw+110)/2 + 1, (sh-360)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 750 pp.", (sw+110)/2, (sh-360)/2, 1417, 403, tocolor(245, 183, 75, 255), 1, "default", "left", "top", false, false, false, false, false)
		
		if isMouseInPosition((sw+95)/2, (sh-200)/2, 402, 46) then color2=tocolor(42, 53, 69, 255); else color2=tocolor(42, 53, 69, 177); end
        dxDrawRectangle((sw+95)/2, (sh-200)/2, 402, 46, color2, false)
        dxDrawText("Kup pakiet premium 45 dni + 2 sloty", (sw+110)/2 + 1, (sh-175)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText("Kup pakiet premium 45 dni + 2 sloty", (sw+110)/2, (sh-175)/2, 1417, 403, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 1050 pp.", (sw+110)/2 + 1, (sh-215)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 1050 pp.", (sw+110)/2, (sh-215)/2, 1417, 403, tocolor(245, 183, 75, 255), 1, "default", "left", "top", false, false, false, false, false)
		
		if isMouseInPosition((sw+95)/2, (sh-55)/2, 402, 46) then color3=tocolor(42, 53, 69, 255); else color3=tocolor(42, 53, 69, 177); end
        dxDrawRectangle((sw+95)/2, (sh-55)/2, 402, 46, color3, false)
        dxDrawText("Kup pakiet premium 60 dni + 3 slotów", (sw+110)/2 + 1, (sh-30)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText("Kup pakiet premium 60 dni + 3 slotów", (sw+110)/2, (sh-30)/2, 1417, 403, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 1400 pp.", (sw+110)/2 + 1, (sh-70)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 1400 pp.", (sw+110)/2, (sh-70)/2, 1417, 403, tocolor(245, 183, 75, 255), 1, "default", "left", "top", false, false, false, false, false)
		
		if isMouseInPosition((sw+95)/2, (sh+90)/2, 402, 46) then color4=tocolor(42, 53, 69, 255); else color4=tocolor(42, 53, 69, 177); end
        dxDrawRectangle((sw+95)/2, (sh+90)/2, 402, 46, color4, false)
        dxDrawText("Kup slot na pojazd +5 slotów", (sw+110)/2 + 1, (sh+115)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, false, false, false, false)
        dxDrawText("Kup slot na pojazd +5 slotów", (sw+110)/2, (sh+115)/2, 1417, 403, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 200 pp.", (sw+110)/2 + 1, (sh+75)/2 + 1, 1417 + 1, 403 + 1, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Koszt: 200 pp.", (sw+110)/2, (sh+75)/2, 1417, 403, tocolor(245, 183, 75, 255), 1, "default", "left", "top", false, false, false, false, false)
		
		if isMouseInPosition(((sw+760)/2), ((sh-515)/2), 100, 37) then colorex=tocolor(255, 0, 0, 255); else colorex=tocolor(166, 166, 166, 255); end
        dxDrawText("[ Zamknij ]", (sw+800)/2, (sh-502)/2, 1427, 318, colorex, 1.20, "default", "left", "top", false, false, false, false, false)
	end
end)

local warX = 145
local warY = 290

addEventHandler("onClientClick", root, function(btn,state)
if pokaz then
	if btn=="left" and state=="down" then
		if isMouseInPosition(((sw+760)/2), ((sh-518)/2), 100, 37) then
			pokaz = false
			showCursor(false)
		end
		-- pakiet numer 1 : 30 D
		if isMouseInPosition((sw+95)/2, (sh-345)/2, 402, 46) then
			local offer = 1
			triggerServerEvent("premium:zakup",localPlayer,localPlayer,offer)
			pokaz = false
			showCursor(false)
		end
		-- pakiet numer 2 : 45 D
		if isMouseInPosition((sw+95)/2, (sh-200)/2, 402, 46) then
			local offer = 2
			triggerServerEvent("premium:zakup",localPlayer,localPlayer,offer)
			pokaz = false
			showCursor(false)
		end
		-- pakiet numer 3 : 60 D
		if isMouseInPosition((sw+95)/2, (sh-55)/2, 402, 46) then
			local offer = 3
			triggerServerEvent("premium:zakup",localPlayer,localPlayer,offer)
			pokaz = false
			showCursor(false)
		end
		-- inne
		-- pakiet numer 4 : SLOTY : 5
		if isMouseInPosition((sw+95)/2, (sh+90)/2, 402, 46) then
			local offer = 4
			triggerServerEvent("premium:zakup",localPlayer,localPlayer,offer)
			pokaz = false
			showCursor(false)
		end
	end
end
end)


function premium(cmd,value)
	if pokaz then
		pokaz = false
		showCursor(false)
	else
		pokaz = true
		showCursor(true)
		triggerServerEvent("premium:refreshpoins",localPlayer,localPlayer)
	end
end
addCommandHandler("premium", premium)




