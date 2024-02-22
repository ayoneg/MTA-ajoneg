addEventHandler('onClientResourceStart', resourceRoot,
	function()
		local uSound = playSound3D('http://rs6-krk2-cyfronet.rmfstream.pl/RMFMAXXX48', 1085.287109375, 1738.072265625, 27.063272476196) 
  setSoundMinDistance(uSound,36)
  setSoundMaxDistance(uSound,145)
  setSoundVolume(uSound,0.2)
	end
)

blipmech1lv = createBlip(1087.9873046875, 1738.748046875, 10.8203125, 27, 1, 0,255,5,255, -1000, 500)
bliplakiernialv = createBlip(1053.021484375, 1727.7197265625, 10.8203125, 63, 1, 0,255,5,255, -1000, 500)



local mch = {}

mch.okno = guiCreateWindow(0.61, 0.42, 0.16, 0.23, "Warsztat samochodowy", true)
guiWindowSetMovable(mch.okno, false)
guiWindowSetSizable(mch.okno, false)
mch.okno_desc = guiCreateLabel(0.04, 0.14, 0.91, 0.36, "Warsztat: Whitewood Estates LV\n\nStanowiska: 3\n\nZatrudnienie w urzędzie miasta LV.", true, mch.okno)  
guiSetVisible(mch.okno, false)

addEvent("pokazPlrGUI", true)
addEventHandler("pokazPlrGUI", root,function(opis_button)
--    mch.button_start = guiCreateButton(0.05, 0.11, 0.89, 0.49, opis_button, true, mch.okno)
	mch.button_start = guiCreateButton(0.04, 0.54, 0.91, 0.42, opis_button, true, mch.okno)
    if guiGetVisible(mch.okno) == false then
    showCursor(true, false)
    guiSetVisible(mch.okno, true)
    end			
end)

addEventHandler("onClientGUIClick", root, function()
    if source == mch.button_start then
	    local sprr10 = getElementData(localPlayer,"player:duty") or "mechanik-lv";
		triggerServerEvent("sprGraczaFrakcje",localPlayer,sprr10,localPlayer)
	end
end)

addEvent("ukryjPlrGUI", true)
addEventHandler("ukryjPlrGUI", root,function()
    if guiGetVisible(mch.okno) == true then
    showCursor(false)
    guiSetVisible(mch.okno, false)
	destroyElement(mch.button_start)
    end	
end)
