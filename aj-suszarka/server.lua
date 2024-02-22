
function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=tonumber(speed*180)
	return kmh
end

----------------------------------------------------------------------------------
--- pentla miejsc pomiaru predkosci

local suszenie = {
	{1917.619140625, 2223.537109375, 10.8203125, 4, 18, 2.4}, -- LV Redsand East
	{1933, 2223.537109375, 10.8203125, 4, 18, 2.4}, -- LV Redsand East
--	{40.7802734375, 1153.783203125, 18.6640625, 35, 27, 9}, -- test FC
}

for i,v in ipairs(suszenie) do
	obszar = createColCuboid(v[1], v[2], v[3]-1, v[4], v[5], v[6]);
	setElementData(obszar,"suszenie",true);
	setElementData(obszar,"suszenie:vmax",60);
end

function obszarhit(el,md)
	if not md or not el then return end
	local typeEle = getElementType(el) or false;
    if typeEle == "player" then
		local sphareCODE = getElementData(source,"suszenie") or false;
		if sphareCODE then
			local sphare_vmax = getElementData(source,"suszenie:vmax") or 500;
			setElementData(el,"suszenie:vmax",sphare_vmax)
			setElementData(el,"suszenie",true)
		end
	end
end

function obszarleave(el,md)
	local typeEle = getElementType(el) or false;
    if typeEle == "player" then
		local sphareCODE = getElementData(source,"suszenie") or false;
		if sphareCODE then
			removeElementData(el,"suszenie:vmax")
			removeElementData(el,"suszenie")
		end
	end
end

addEventHandler("onColShapeHit", root, obszarhit) 
addEventHandler("onColShapeLeave", root, obszarleave) 

local czas = {}

addEvent("pomiar:predkosci",true)
addEventHandler("pomiar:predkosci",root,function(el,gracz)
	if czas[source] and getTickCount() < czas[source] then return end
	duty = getElementData(source,"player:frakcja") or false;
--	admduty = getElementData(source,"admin:zalogowano") or "false";
	if duty then
		codefr = getElementData(source,"player:frakcjaCODE") or "";
	end
	local salon = getElementData(el,"vehicle:salon") or false;
	local sirens = getVehicleSirensOn(el) -- jeśli to pojazd służb alarmowo [!]
	if not salon and not sirens and codefr=="SAPD" then
--		outputChatBox("* Nie jesteś uprawnionym do wykonywania pomiaru prędkości.",source)
		predkosc = tonumber(getElementData(gracz,"suszenie:vmax")) or 500;
		predkosc2 = predkosc + 6
		if predkosc2 <= getElementSpeed(el) then
--			outputChatBox("* Nie jesteś uprawnionym do wykonywania pomiaru prędkości.",source)
			etcra = math.floor(getElementSpeed(el));
			czas[source] = getTickCount()+15000; -- 15 sek zabezpieczenia
			cost = tonumber((etcra * predkosc) * 0.5); -- ( 150km/h * limit ) * 50% = 90$
			local money = string.format("%.2f", cost/100)
			outputChatBox(" ",source)
			outputChatBox("* Wykonano zdjęcie pomiaru prędkości.",source)
			outputChatBox("#e7d9b0* Pojazd: #EBB85D"..getVehicleName(el).."#e7d9b0 / prędkość: #EBB85D"..etcra.."km/h#e7d9b0.",source, 0, 0, 0, true)
			outputChatBox("#e7d9b0* Kwota mandatu: #388E00"..money.."$#e7d9b0.",source, 0, 0, 0, true)
			outputChatBox(" ",source)
			
			-- do bazy mandatów
			kierowca = getVehicleOccupant(el)
			if kierowca then
				--jeśli jest kiero
				uid = getElementData(kierowca,"player:dbid") or 0;
				uidjb = getElementData(source,"player:dbid") or 0;
				if uid > 0 then
					local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_polimoney=user_polimoney+? WHERE user_id=?",cost,uid);
					local code = "USM";
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_jobslog SET joblog_code=?, joblog_data=NOW(), joblog_value=?, joblog_cfg='1', joblog_userid=?",code,cost,uidjb);
					--wamn
					triggerEvent("policja:refreshwantedlvl",kierowca,kierowca)
				end
				outputChatBox("#e7d9b0* Wykonano zdjęcie pomiaru prędkości przez #EBB85D"..getPlayerName(source).."#e7d9b0.", kierowca, 0, 0, 0, true)
			end
		end
	end
end)

----------------------------------------------------------------------------------


addEvent("usun:pojazd",true)
addEventHandler("usun:pojazd",root,function(el)
local salon = getElementData(el,"vehicle:salon") or false;
if salon==false then
local veh_id = getElementData(el,"vehicle:id") or "blad";
	if veh_id ~= "blad" then
    local kiero = getVehicleController(el)
	local odznaczone = getElementData(el,"vehicle:odznaczoneSUSZ") or false;
	if odznaczone == false then
	   outputChatBox("* Pojazd musi być nieużywany od 15 minut lub zostać odznaczony.",source)
	   return
	end
    if kiero then 
	outputChatBox("* Aby przenieść pojazd, musi on pozostać pusty.",source)
	return end
		
	if tonumber(veh_id) < 1000000 then
	x,y,z = getElementPosition(el)
	x = math.ceil(x)
	y = math.ceil(y)
	z = math.ceil(z)
    local transfer_text=('[SUSZARKA:PRZECHO] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' przenosi pojazd ID: '..veh_id..', z pozycji: '..x..', '..y..', '..z..'.')	
	outputServerLog(transfer_text)
    end
	
	outputChatBox("* Pomyślnie przeniesiono pojazd na parking.", source)
	exports["aj-vehs"]:zapiszPojazd(el)

	end
end
end)

addEvent("reczny:pojazd",true)
addEventHandler("reczny:pojazd",root,function(el)
local salon = getElementData(el,"vehicle:salon") or false;
if salon==false then
    if isElementFrozen(el) then
		if getVehiclePlateText(el) then
			local veh_id = getElementData(el,"vehicle:id") or 0;

			setElementFrozen(el, false)
		
	    	outputChatBox("* Pomyślnie zwolniono ręczny.",source)
			
		x,y,z = getElementPosition(el)
		x = math.ceil(x)
		y = math.ceil(y)
		z = math.ceil(z)
        local transfer_text=('[SUSZARKA:RECZNY] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' zwalnia reczny ID: '..veh_id..', z pozycji: '..x..', '..y..', '..z..'.')	
		if tonumber(veh_id) < 1000000 then
	    outputServerLog(transfer_text)
		end
		
		end
	else
		if getVehiclePlateText(el) then
			local veh_id = getElementData(el,"vehicle:id") or 0;
			if getElementSpeed(el) >= 20 then return end
				
			setElementFrozen(el, true)
		
	    	outputChatBox("* Pomyślnie zaciągnięto ręczny.",source)
			
		x,y,z = getElementPosition(el)
		x = math.ceil(x)
		y = math.ceil(y)
		z = math.ceil(z)
        local transfer_text=('[SUSZARKA:RECZNY] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' zaciaga reczny ID: '..veh_id..', na pozycji: '..x..', '..y..', '..z..'.')	
		if tonumber(veh_id) < 1000000 then
	    outputServerLog(transfer_text)
		end
			
		end
	end
end
end)


addEvent("odznacz:pojazd",true)
addEventHandler("odznacz:pojazd",root,function(el)
local salon = getElementData(el,"vehicle:salon") or false;
if salon==false then
	local veh_id = getElementData(el,"vehicle:id") or "blad";
	local odznaczoneSUSZ = getElementData(el,"vehicle:odznaczoneSUSZ") or false;
	local odznaczone = getElementData(el,"vehicle:odznaczone") or false;
    local kiero = getVehicleController(el)
    if kiero then 
		outputChatBox("* Aby odznaczyć pojazd, musi on pozostać pusty.",source)
	return end
	if not odznaczone or not odznaczoneSUSZ then
	
        setElementData(el,"vehicle:odznaczoneSUSZ",true)
		setElementData(el,"vehicle:odznaczone",true)
		outputChatBox("* Pomyślnie odznaczono pojazd.",source)
		
		x,y,z = getElementPosition(el)
		x = math.ceil(x)
		y = math.ceil(y)
		z = math.ceil(z)
        local transfer_text=('[SUSZARKA:ODZNACZ] '..getPlayerName(source)..'/'..getElementData(source,"player:dbid")..' odznaczyl/a pojazd o ID: '..veh_id..', na pozycji: '..x..', '..y..', '..z..'.')	
		if tonumber(veh_id) < 1000000 then
	    outputServerLog(transfer_text)
		end
	else
	    outputChatBox("* Pojazd jest już odznaczony.",source)
	end
end
end)

