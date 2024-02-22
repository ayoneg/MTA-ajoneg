--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--

okienko_infoulv = guiCreateWindow(0.37, 0.36, 0.27, 0.28, "Tablica informacyjna", true)
guiWindowSetSizable(okienko_infoulv, false)
okienko_infoulvtext = guiCreateMemo(0.05, 0.13, 0.90, 0.79,  "--- lodaing ---", true, okienko_infoulv)
guiMemoSetReadOnly(okienko_infoulvtext, true)    	
guiSetVisible(okienko_infoulv,false)

addEvent("pokazNoti", true)
addEventHandler("pokazNoti", root, function(desc,plr)
	if plr==localPlayer then
		guiSetText(okienko_infoulvtext, desc)
	    guiSetVisible(okienko_infoulv, true)
	end
end)

addEvent("zamknijNoti", true)
addEventHandler("zamknijNoti", root, function(plr)
	if plr==localPlayer then
	    guiSetVisible(okienko_infoulv, false)
	end
end)