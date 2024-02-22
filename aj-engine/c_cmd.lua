
addEvent("veh_kryptonim", true)
addEventHandler("veh_kryptonim", root, function(auto)
shader = dxCreateShader('shader.fx')
	txd = dxCreateTexture("test2.png")
	dxSetShaderValue( shader, "gTexture", txd )
engineApplyShaderToWorldTexture(shader, "vehiclepoldecals128", auto)
end)

addEvent("uruchomOdliczanieStart", true)
addEventHandler("uruchomOdliczanieStart", root, function(plr)
if localPlayer == plr then
    zakuppojazdu=setTimer(function()
	    triggerServerEvent("removeZakuPojCzasEnd",localPlayer,localPlayer)
	end, 30000, 1) --- 30000
end
end)

addEvent("zakonczOdliczanieEnd", true)
addEventHandler("zakonczOdliczanieEnd", root, function(plr)
if localPlayer == plr then
    killTimer(zakuppojazdu)
end
end)
