--[[
System PG (punktów gry), wyświetlania użytkownikowi [v.1.0]
Autor: AjoN <ajonoficjalny@gmail.com>
Zakaz kopiowania, edytowania oraz udostępniania, jak i używania baz zgody autora.
]]--

local screenW, screenH = guiGetScreenSize()

local zapisTICK = {}
local opacity = 0
local opacity2 = 0
local czasPG = false

function ukryjPokazywaniePG()
	test = true
end

function ertte()
	czasPG = false
end

addEventHandler("onClientRender", root, function()
    if (czasPG) then

		if zapisTICK[localPlayer] and zapisTICK[localPlayer] > getTickCount() then
		else
			if test then
				opacity = opacity - 15
				opacity2 = opacity2 - 5
				if opacity <= 0 then opacity = 0 end
				if opacity2 <= 0 then opacity2 = 0 end
				zapisTICK[localPlayer] = getTickCount() + 50
				if opacity <= 0 or opacity2 <= 0 then ertte() end
			else
				opacity = opacity + 15
				opacity2 = opacity2 + 5
				if opacity > 255 then opacity = 255 end
				if opacity2 > 151 then opacity2 = 151 end
				zapisTICK[localPlayer] = getTickCount() + 50
			end
		end
		
		
        dxDrawRectangle(screenW * 0.2323, screenH * 0.3000, screenW * 0.5359, screenH * 0.0694, tocolor(0, 0, 0, opacity2), false)
        dxDrawImage(screenW * 0.2078, screenH * 0.3000, screenW * 0.0385, screenH * 0.0685, ":aj-log2/ajoneg.png", 0, 0, 0, tocolor(255, 255, 255, opacity), false)
        dxDrawText("Gratulacje, otrzymałeś/aś punkty gry!", (screenW * 0.2375) + 1, (screenH * 0.2713) + 1, (screenW * 0.4297) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, opacity), 1.20, "default", "left", "bottom", false, false, false, false, false)
        dxDrawText("Gratulacje, otrzymałeś/aś punkty gry!", screenW * 0.2375, screenH * 0.2713, screenW * 0.4297, screenH * 0.3000, tocolor(255, 255, 255, opacity), 1.20, "default", "left", "bottom", false, false, false, false, false)
        dxDrawText(playerIloscPG.." PG - "..playerPG, (screenW * 0.2464) + 1, (screenH * 0.3000) + 1, (screenW * 0.7578) + 1, (screenH * 0.3685) + 1, tocolor(0, 0, 0, opacity), 1.00, "default", "center", "center", false, true, false, false, false)
        dxDrawText(playerIloscPG.." PG - "..playerPG, screenW * 0.2464, screenH * 0.3000, screenW * 0.7578, screenH * 0.3685, tocolor(255, 255, 255, opacity), 1.00, "default", "center", "center", false, true, false, false, false)
        return
    end
end)

addEvent("onPlayerGetPG", true)
addEventHandler("onPlayerGetPG", root, function(tresc, ilosc)
    if source==localPlayer then
		czasPG = true
        playerPG=tresc
		playerIloscPG=ilosc
		test = false
		-- tutaj 20 sekund pokazywania na ekranie, mozna dac mniej
		if isTimer(czas) then
			killTimer(czas)
			czas=setTimer(ukryjPokazywaniePG, 10000, 1)
		else
			czas=setTimer(ukryjPokazywaniePG, 10000, 1)
		end
        --setTimer(playSoundFrontEnd, 400, 3, 5)
    end
end)

local gameView={"Logi serwerowe:"}

addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text)
dbid = getElementData(localPlayer,"player:dbid") or 0;
if dbid > 0 then
	table.insert(gameView, text)	
	if #gameView > 14 then
		table.remove(gameView, 2)
	end
end
end)
