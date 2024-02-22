--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Praca dorywcza ogrodnika.
]]--


-- DUTY
local duty = {
	BBAc={
    	mpos={-176.439453125, -93.548828125, 3.1171875},
    	code="ogrodnik-1",
		desc="Praca dorywcza Ogrodnika",
		desc2="Na czym polega ta praca?\n\nPraca polega na roznoszeniu sadzonek ze składu we wskazane miejsca. Wynagrodzenie otrzymujemy zaraz po dostarczeniu sadzonki.\n\nW pracy jest aktywna możliwosć zdobywania dodatkowych punktów gry.",
	},
}

for i,v in pairs(duty) do
	marker = createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1.2, 78, 188, 0, 22) -- tylko visu
	sphe = createColSphere(v.mpos[1], v.mpos[2], v.mpos[3], 1)
	setElementData(sphe,"job",true)
	setElementData(sphe,"job:code",v.code)
	setElementData(sphe,"job:desc",v.desc2)
	t = createElement("text")
	setElementData(t,"name",v.desc)
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3]+1)
end


addEvent("job:ogrodnik:start", true)
addEventHandler("job:ogrodnik:start", root, function(gracz,code)
	if isElement(gracz) then
		local var = getElementData(gracz,"player:job") or false;
		if var then
			removeElementData(gracz,"player:job")
			outputChatBox(" ", gracz,231, 217, 176,true)
			outputChatBox("#841515✔#e7d9b0 Zakończono pracę.", gracz,231, 217, 176,true)
		else
			setElementData(gracz,"player:job",code)
			outputChatBox(" ", gracz,231, 217, 176,true)
			outputChatBox("#388E00✔#e7d9b0 Rozpoczynasz pracę.", gracz,231, 217, 176,true)
		end
	end
end)



addEventHandler("onColShapeHit", root, function(gracz,md)
	if not md then return end
	if isElement(gracz) and getElementType(gracz) == "player" then
		local job = getElementData(source,"job") or false;
		if not job then return end
		if isPedInVehicle(gracz) then return end
		local jobCODE = getElementData(source,"job:code") or false;
		if jobCODE=="ogrodnik-1" then
			local desc = getElementData(source,"job:desc") or "";
			triggerClientEvent("job:ogrodnik",root,gracz,desc,true,jobCODE)
		end
	end
end)

addEventHandler("onColShapeLeave", root, function(gracz,md)
	if isElement(gracz) and getElementType(gracz) == "player" then
		local job = getElementData(source,"job") or false;
		if not job then return end
		local jobCODE = getElementData(source,"job:code") or false
		if jobCODE=="ogrodnik-1" then
			triggerClientEvent("job:ogrodnik",root,gracz,nil,false)
		end
	end
end)