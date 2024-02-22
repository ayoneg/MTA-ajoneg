--[[
addEventHandler('onClientResourceStart', resourceRoot,
	function()
		local uSound = playSound3D('http://rs6-krk2-cyfronet.rmfstream.pl/RMFMAXXX48', 1085.287109375, 1738.072265625, 27.063272476196) 
  setSoundMinDistance(uSound,36)
  setSoundMaxDistance(uSound,145)
  setSoundVolume(uSound,0.2)
	end
)
]]

bliptunelv = createBlip(1950.36328125, 2175.892578125, 10.893982887268, 55, 1, 0,255,5,255, -1000, 500)
bliplakiernialv = createBlip(1982.326171875, 2162.03125, 10.835376739502, 63, 1, 0,255,5,255, -1000, 500)


local mch = {}


mch.okno = guiCreateWindow(0.61, 0.42, 0.16, 0.23, "Warsztat tuningowy", true)
guiWindowSetMovable(mch.okno, false)
guiWindowSetSizable(mch.okno, false)
mch.okno_desc = guiCreateLabel(0.04, 0.14, 0.91, 0.36, "Warsztat: Redsands East LV\n\nStanowiska: 3\n\nZatrudnienie w urzędzie miasta LV.", true, mch.okno)  
mch.button_start = guiCreateButton(0.04, 0.54, 0.91, 0.42, "--", true, mch.okno)
guiSetVisible(mch.okno, false)

addEvent("pokazPlrGUItunelv", true)
addEventHandler("pokazPlrGUItunelv", root,function(opis_button)
--    mch.button_start = guiCreateButton(0.05, 0.11, 0.89, 0.49, opis_button, true, mch.okno)
	guiSetText(mch.button_start,tostring(opis_button))
    if guiGetVisible(mch.okno) == false then
    showCursor(true)
    guiSetVisible(mch.okno, true)
    end			
end)

addEventHandler("onClientGUIClick", root, function()
    if source == mch.button_start then
	    local sprr10 = getElementData(localPlayer,"player:duty") or "tune-lv";
		triggerServerEvent("sprGraczaFrakcjeTuneLV",localPlayer,sprr10,localPlayer)
	end
end)

addEvent("ukryjPlrGUItunelv", true)
addEventHandler("ukryjPlrGUItunelv", root,function()
    if guiGetVisible(mch.okno) == true then
    showCursor(false)
    guiSetVisible(mch.okno, false)
--	destroyElement(mch.button_start)
    end	
end)
