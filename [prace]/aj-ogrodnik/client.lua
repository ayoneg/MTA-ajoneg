--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Praca dorywcza ogrodnika.
	Testy panelu rozpoczynania pracy 2.0
]]--
local sw, sh = guiGetScreenSize()
function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local pokaz = false
local button = "Rozpocznij prace"
local desc = ""
local code = false

addEventHandler("onClientRender", root,function()
	if pokaz then
        dxDrawImage(797, 370, 629, 321, ":aj-log2/back10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Praca dorywcza Ogrodnika", 850 + 1, 387 + 1, 1095 + 1, 442 + 1, tocolor(0, 0, 0, 255), 1.30, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Praca dorywcza Ogrodnika", 850, 387, 1095, 442, tocolor(255, 255, 255, 255), 1.30, "default", "center", "center", false, false, false, false, false)
        dxDrawText(desc or "", 1145 + 1, 397 + 1, 1418 + 1, 669 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "left", "top", false, true, false, false, false)
        dxDrawText(desc or "", 1145, 397, 1418, 669, tocolor(255, 255, 255, 255), 1.20, "default", "left", "top", false, true, false, false, false)
        dxDrawRectangle(834, 602, 188, 67, tocolor(22, 26, 34, 255), false)
        dxDrawText(button, 854 + 1, 602 + 1, 1000 + 1, 669 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, false, false, false)
        dxDrawText(button, 854, 602, 1000, 669, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, false, false)
        dxDrawRectangle(1040, 602, 68, 67, tocolor(43, 11, 11, 255), false)
        dxDrawText("X", 1040 + 1, 602 + 1, 1108 + 1, 669 + 1, tocolor(0, 0, 0, 255), 1.20, "default", "center", "center", false, false, false, false, false)
        dxDrawText("X", 1040, 602, 1108, 669, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, false, false)
	end
end)

function buttonname(nazwa,opis)
	button = nazwa
	desc = opis
end


addEventHandler("onClientClick", root, function(btn,state)
	if pokaz then
		if btn=="left" and state=="down" then
			-- start job
			if isMouseInPosition(834, 602, 188, 67) then
				pokaz = false
				showCursor(false)
				triggerServerEvent("job:ogrodnik:start",localPlayer,localPlayer,code)
			end
			--exit
			if isMouseInPosition(1040, 602, 68, 67) then
				pokaz = false
				showCursor(false)
			end
		end
	end
end)


addEvent("job:ogrodnik", true)
addEventHandler("job:ogrodnik", root, function(gracz,desc,duty,jcode)
	if gracz == localPlayer then
		local opis = desc or "";
		local praca = duty or false;
		local job = getElementData(gracz,"player:job") or false;
		if job then buttonname("Zakończ prace",desc) else buttonname("Rozpocznij prace",desc) end
		
		if duty then
			if pokaz then
				pokaz = false
				code = false
				showCursor(false)
			else
				pokaz = true
				code = jcode
				showCursor(true)
			end
		else
			pokaz = false
			code = false
			showCursor(false)
		end
	end
end)