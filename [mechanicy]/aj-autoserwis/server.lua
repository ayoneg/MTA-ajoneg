--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2023 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt auto serwisu.
]]--

local autostrefy = {
	{
		cuboid={89.96484375, -166.865234375, 1.59375, 8, 4, 3},-- cuboid w ktorym musi znalezc sie pojazd
    	mpos={100.9228515625, -162.0576171875, 2.5179996490479}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
		name={100.40625, -164.8408203125, 3}
	},
}

local naprawa = {}

function getText(id)
    obj=getElementsByType('text')
    for i,v in pairs(obj) do
		if tonumber(getElementData(v,"autoserwis:id")) == tonumber(id) and getElementData(v,"autoserwis") then
		    return v
		end
    end	
	return false
end

function odliczajNaprawe(id,czas)
	local el = getText(id)
	if el then
		if getElementData(el,"autoserwis:time") == 0 then setElementData(el,"autoserwis:time",czas) end
		timee = getElementData(el,"autoserwis:time") or czas
		if timee ~= nil then
			timee = timee - 1
			setElementData(el,"name","Stanowisko naprawcze\nPozostało: "..timee.." s.")
			setElementData(el,"autoserwis:time",timee)
			if timee == 0 then
				setElementData(el,"name","Stanowisko naprawcze\nWOLNE")
			end
		end
	end
end

for i,v in ipairs(autostrefy) do 
	cubo = createColCuboid(unpack(v.cuboid))
	setElementData(cubo,"autoserwis",true)
	marker = createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1, 0,0,0,100)
	blip = createBlip(v.mpos[1], v.mpos[2], v.mpos[3], 27, 1, 0,255,5,255, -60, 500)
	setElementData(marker,"autoserwis:data",cubo)
	setElementData(marker,"autoserwis",true)
	t = createElement("text")
	setElementData(t,"name","Komputer")
	setElementData(t,"scale",1.3)
	setElementData(t,"distance",17)
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3]+0.5)
	
	t2 = createElement("text")
	setElementData(t2,"name","Stanowisko naprawcze\nWOLNE")
	setElementData(t2,"scale",2)
	setElementData(t2,"distance",15)
	setElementData(t2,"autoserwis",true)
	setElementData(t2,"autoserwis:id",i)
	setElementData(t2,"autoserwis:time",nil)
	setElementPosition(t2,v.name[1], v.name[2], v.name[3]+1.1)
	
end

--   triggerServerEvent("naprawaElementu", resourceRoot, naprawiany_pojazd, czesc, koszt)
addEvent("naprawaElementuAuto", true)
addEventHandler("naprawaElementuAuto", resourceRoot, function(pojazd, czesc, koszt, czas)
	if naprawa[pojazd] then
		outputChatBox("#841515✖#e7d9b0 Zaczekaj, aktualnie trwa naprawa poajzdu.", client,231, 217, 176,true)
		return
	end
	
	if type(czesc) == "number" then
		if koszt>getPlayerMoney(client) then return end
		takePlayerMoney(client,(koszt*100))
		outputChatBox("#388E00✔#e7d9b0 Pojazd jest teraz naprawiany, koszt naprawy to #388E00"..koszt.."$#e7d9b0.", client,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Naprawa pojazdu sotanie zakończona za "..czas.." sekund.", client,231, 217, 176,true)
		
		naprawnik = setTimer(odliczajNaprawe, 1000, czas, 1, czas)
		naprawa[pojazd] = setTimer(timer_naprawy, (czas*1000), 1, client, pojazd, czesc, koszt)
		koniec = setTimer(koniecNaprawy, (czas*1000), 1, client, pojazd)
	else
		if koszt>getPlayerMoney(client) then return end
		for i,v in ipairs(czesc) do
			naprawa[pojazd] = setTimer(timer_naprawy, (czas*1000), 1, client, pojazd, v[1], v[2])
		end
		takePlayerMoney(client,(koszt*100))
		outputChatBox("#388E00✔#e7d9b0 Pojazd jest teraz naprawiany, koszt naprawy to #388E00"..koszt.."$#e7d9b0.", client,231, 217, 176,true)
		outputChatBox("#7AB4EAⒾ#e7d9b0 Naprawa pojazdu sotanie zakończona za "..czas.." sekund.", client,231, 217, 176,true)
		
		koniec = setTimer(koniecNaprawy, (czas*1000), 1, client, pojazd)
		naprawnik = setTimer(odliczajNaprawe, 1000, czas, 1, czas)
	end
	
	setVehicleLocked(pojazd, true)
	setElementData(pojazd,"vehicle:salon",true)
end)

function koniecNaprawy(client,pojazd)
	outputChatBox("#7AB4EAⒾ#e7d9b0 Naprawa pojazdu została zakończona.", client,231, 217, 176,true)
	setVehicleLocked(pojazd, false)
	setElementData(pojazd,"vehicle:salon",false)
	naprawa[pojazd] = false
end

function timer_naprawy(client, pojazd, czesc, koszt)
	if (czesc==-1) then
		local vps={}
		local vds={}
		local vls={}

		for i=0,6 do          vps[i]=getVehiclePanelState(pojazd,i)     end
		for i=0,3 do          vds[i]=getVehicleDoorState(pojazd,i) end
		for i=0,3 do          vls[i]=getVehicleLightState(pojazd,i) end

		fixVehicle(pojazd)
		--setElementHealth (pojazd, 1000)

		for i=0,6 do      setVehiclePanelState(pojazd, i, vps[i])    end
		for i=0,3 do      setVehicleDoorState(pojazd, i, vds[i])    end
		for i=0,3 do      setVehicleLightState(pojazd, i, vls[i])    end

		triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
	elseif czesc>=0 and czesc<=6 then
		setVehiclePanelState(pojazd, czesc, 0)
		triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
	elseif czesc>=10 and czesc<20 then
		local drzwi=czesc-10
		setVehicleDoorState(pojazd, drzwi, 0)
		triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
	elseif czesc>=20 then
		local swiatlo=czesc-20
		setVehicleLightState(pojazd, swiatlo, 0)
		triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
	end
end