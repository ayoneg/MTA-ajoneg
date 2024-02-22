--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt ładowania zasobów serwera.
]]--

---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- -----
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()
    addEventHandler("onClientRender",root,pokazInfoDownload)
    local function check()
        if isTransferBoxActive() then
            setTimer(check, 1000, 1)
        else
            removeEventHandler("onClientRender", root, pokazInfoDownload)
        end
    end
    setTimer(check, 1000, 1)
end)

function pokazInfoDownload()
    dxDrawText("AJONEG @ TESTSERWER - AJONEG.TS.IO", screenW * 0.2651, screenH * 0.0963, screenW * 0.7349, screenH * 0.2194, tocolor(58, 242, 240, 255), 3.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Trwa pobieranie zasobów serwera...", screenW * 0.3781, screenH * 0.4444, screenW * 0.6224, screenH * 0.5556, tocolor(255, 255, 255, 255), 1.60, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Forum: www.ajoneg.ts3dns.eu/forum/", screenW * 0.3781, screenH * 0.9830, screenW * 0.6224, screenH * 0.9441, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, false, false)
end