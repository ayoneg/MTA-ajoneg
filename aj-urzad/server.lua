--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--

-- lista urzędów
local listaum = {
	{"LV" ,"Urząd miasta LV", false, "2474.572265625, 1024.0771484375, 10.8203125", "386.2412109375, 173.9248046875, 1008.3828125", "390.2939453125, 173.7275390625, 1008.3828125", "2474.1005859375, 1021.2119140625, 10.8203125", 300, 3, -180, 90},
}

function nadajTEXTswiat(text,x,y,z,int,dim)
	t = createElement("text")
	setElementData(t,"name",text)
	setElementData(t,"scale",1)
	setElementData(t,"distance",15)
	setElementPosition(t,x,y,z+1.2)
	setElementInterior(t, (int or 0))
	setElementDimension(t, (dim or 0))
end

function wyswietlUM()
	for i,um in ipairs(listaum) do
		
		-- tabela kodów
		local kordy = split(um[4], ",")
		local kordy2 = split(um[5], ",")
		local kordy3 = split(um[6], ",")
		local kordy4 = split(um[7], ",")
		
		local marker = createMarker(kordy[1], kordy[2], kordy[3]+0.52, "arrow", 1.3, 255, 255, 255, 50)
		local blip = createBlip(kordy[1], kordy[2], kordy[3], 39, 1, 0,255,5,255, -1, 500)
		setElementData(marker,"urzad",true)
		setElementData(marker,"urzad:spc",true)
		setElementData(marker,"urzad:id",i)
		setElementData(marker,"urzad:code",um[1])
		setElementData(marker,"urzad:name",um[2])
		setElementData(marker,"urzad:zamek",um[3])
		setElementData(marker,"urzad:wejscie",{kordy2[1], kordy2[2], kordy2[3]})
		setElementData(marker,"urzad:wyjscie",{kordy3[1], kordy3[2], kordy3[3]})
		setElementData(marker,"urzad:root",um[10])
		setElementData(marker,"urzad:rootINT",um[11])
		setElementData(marker,"urzad:int",um[9])
		setElementData(marker,"urzad:dim",um[8])
		setElementInterior(marker, 0)
		setElementDimension(marker, 0)
		-- text adons
		nadajTEXTswiat(um[2],kordy[1], kordy[2], kordy[3])
		
		
		local markerINT = createMarker(kordy3[1], kordy3[2], kordy3[3]+0.52, "arrow", 1.3, 255, 255, 255, 50)
		setElementData(markerINT,"urzad",true)
		setElementData(markerINT,"urzad:id",i)
		setElementDimension(markerINT, um[8])
		setElementInterior(markerINT, um[9])
		setElementData(markerINT,"urzad:wyjscie",{kordy4[1], kordy4[2], kordy4[3]})
		setElementData(markerINT,"urzad:root",um[10])
		setElementData(markerINT,"urzad:rootINT",um[11])
		-- text adons
		nadajTEXTswiat("Wyjście",kordy3[1], kordy3[2], kordy3[3], um[9], um[8])
		
		--markers UM cfg
		--tablice poj
		local tablice = createMarker(358.390625, 179.8154296875, 1006.3828125, "cylinder", 2, 255,255,255,50);
		setElementInterior(tablice, um[9])
		setElementDimension(tablice, um[8])
		setElementData(tablice,"um:tablice",true);
		nadajTEXTswiat("Zmiana tablic rejestracyjnych",358.390625, 179.8154296875, 1008.3828125, um[9], um[8])
		--pojazy org
		local vehsorg = createMarker(358.23828125, 186.9208984375, 1008.3828125-2, "cylinder", 2, 0,255,155,50);
		setElementInterior(vehsorg, um[9])
		setElementDimension(vehsorg, um[8])
		setElementData(vehsorg,"um:vehsorg",true);
		nadajTEXTswiat("Pojazdy organizacji",358.23828125, 186.9208984375, 1008.3828125, um[9], um[8])
		--org
		local org = createMarker(358.537109375, 161.3115234375, 1008.3828125-3, "cylinder", 3, 255,255,255,50);
		setElementInterior(org, um[9])
		setElementDimension(org, um[8])
		setElementData(org,"um:org",true);
		nadajTEXTswiat("Panel organizacji",358.537109375, 161.3115234375, 1008.3828125, um[9], um[8])
		--prace um
		local joblist = createMarker(358.5205078125, 167.142578125, 1008.3828125-3, "cylinder", 3, 255,144,0,50);
		setElementInterior(joblist, um[9])
		setElementDimension(joblist, um[8])
		setElementData(joblist,"um:joblist",true);
		setElementData(joblist,"um:joblistCODE",um[1]);
		nadajTEXTswiat("Urząd pracy",358.5205078125, 167.142578125, 1008.3828125, um[9], um[8])
		--egzaminy um
		local egzaminy = createMarker(361.830078125, 173.568359375, 1008.3828125-2, "cylinder", 2, 199,76,99,50);
		setElementInterior(egzaminy, um[9])
		setElementDimension(egzaminy, um[8])
		setElementData(egzaminy,"um:egzaminy",true);
		nadajTEXTswiat("Egzaminy teoretyczne",361.830078125, 173.568359375, 1008.3828125, um[9], um[8])
	end
end

wyswietlUM()


addEvent("wtepajGraczaUM", true)
addEventHandler("wtepajGraczaUM", root, function(plr,perms,marker)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		--tablica markera
		local code = getElementData(marker,"urzad:code") or "";
		local zamek = getElementData(marker,"urzad:zamek") or false;
		local wejscie = getElementData(marker,"urzad:wejscie")
		local wyjscie = getElementData(marker,"urzad:wyjscie")
		local int = getElementData(marker,"urzad:int") or 0;
		local dim = getElementData(marker,"urzad:dim") or 0;
		local root = getElementData(marker,"urzad:root") or 0;
		local rootINT = getElementData(marker,"urzad:rootINT") or 0;
		if zamek then
			outputChatBox("* Drzwi urzędu są zamknięte.",plr,255,0,0)
		else
			if perms then -- do um
				setElementInterior(plr, int, unpack(wejscie))
				setElementDimension(plr, dim)
				setElementRotation(plr,0,0,rootINT,"default",true)
				setCameraTarget(plr, plr)
			else -- z um
				setElementInterior(plr, int, unpack(wyjscie))
				setElementDimension(plr, dim)
				setElementRotation(plr,0,0,root,"default",true)
				setCameraTarget(plr, plr)
			end
		end
	end
end)



















