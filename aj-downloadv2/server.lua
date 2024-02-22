--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt ładowania zasobów serwera.
]]--

---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- ----- ---- ---- ----- -----
addEventHandler("onPlayerJoin",root,function()
	showChat(source,false);
	setPlayerHudComponentVisible(source, "all", false)
    setCameraMatrix(source, -1834.34, 877.85, 297.09, 0.00, 0.00, 275.69)--x,y,z,r1,r2,r3    -1894.37,668.43,145.05,0.3,0.0,45.0
	setElementFrozen(source, true)
end)