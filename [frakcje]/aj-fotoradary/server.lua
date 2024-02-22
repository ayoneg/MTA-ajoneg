--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt fotoradarów.
]]--

local lista = {
	{	-- the strip (KGP)
		kordy={2186.59765625, 2333.865234375, 10.523826599121},
		cuboid={2185.6513671875, 2320.4267578125, 10.361676216125, 10},
		predkosc=90,
		mnoznik=0.75,
    	rotacja={0,0,0},
		nazwa="Kontrola prędkości",
		code="TSF",
	},
	{	-- fotoradar gielda 
		kordy={1713.654296875, 1941.001953125, 10.8203125},
		cuboid={1707.3291015625, 1927.0869140625, 10.671875, 10},
		predkosc=60,
		mnoznik=1.5,
    	rotacja={0,0,-30},
		nazwa="Kontrola prędkości",
		code="GF",
	},
	{	-- fotoradar mech lv 
		kordy={1013.8271484375, 1553.396484375, 10.8203125},
		cuboid={1007.4208984375, 1540.2822265625, 10.671875, 10},
		predkosc=90,
		mnoznik=0.75,
    	rotacja={0,0,-30},
		nazwa="Kontrola prędkości",
		code="MF",
	},
	{	-- fotoradar um lv 
		kordy={2421.78515625, 1141.8193359375, 10.812517166138},
		cuboid={2427.3447265625, 1129.26171875, 10.671875, 10},
		predkosc=60,
		mnoznik=1.5,
    	rotacja={0,0,30},
		nazwa="Kontrola prędkości",
		code="UMF",
	},
}

function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=tonumber(speed*180)
	return kmh
end

function findID(ID)
	if ID then
		local ele = getElementByID(ID)
		return ele
	end
	return false
end

for i,v in ipairs(lista) do
	obj = createObject(16101, v.kordy[1], v.kordy[2], v.kordy[3]-2, v.rotacja[1], v.rotacja[2], v.rotacja[3])
	obszar = createColSphere(v.cuboid[1], v.cuboid[2], v.cuboid[3]-1, v.cuboid[4]);
	setElementData(obszar,"fotoradar",true)
	setElementData(obszar,"fotoradar:vmax",v.predkosc)
	setElementData(obszar,"fotoradar:cashe",0)
	setElementData(obszar,"fotoradar:code",v.code)
	setElementData(obszar,"fotoradar:mnoznik",v.mnoznik)
	setElementData(obszar,"fotoradar:id",i)
	t = createElement("text")
	setElementData(t,"name",v.nazwa)
	setElementID(t,i)
	setElementPosition(t,v.kordy[1], v.kordy[2], v.kordy[3]+4)
	setElementInterior(t, 0)
	setElementDimension(t, 0)
	setElementFrozen(obj,true)
end

function poliMandaty(plr)
	-- poli money
	if plr then
		local uid = getElementData(plr,"player:dbid") or 0;
		if uid > 0 then
			local zap = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id=?",uid);
			local razem = zap[1].user_polimoney
			local razem = razem / 100;
			if razem == 0 then
				setPlayerWantedLevel(plr, 0)
			elseif razem > 0 and razem <= 1500 then
				setPlayerWantedLevel(plr, 1)
			elseif razem > 1500 and razem <= 3500 then
				setPlayerWantedLevel(plr, 2)
			elseif razem > 3500 and razem <= 6000 then
				setPlayerWantedLevel(plr, 3)
			elseif razem > 6000 and razem <= 10000 then
				setPlayerWantedLevel(plr, 4)
			elseif razem > 10000 and razem <= 15000 then
				setPlayerWantedLevel(plr, 5)
			elseif razem > 15000 then
				setPlayerWantedLevel(plr, 6)
			end
		end
	end
end
addEvent("policja:refreshwantedlvl",true)
addEventHandler("policja:refreshwantedlvl", root, function(plr)
	poliMandaty(plr)
end)

addEventHandler('onColShapeHit', resourceRoot, function(el, md)
	if not el and not md then return end
	if getElementType(el) == 'vehicle' then
		local plr = getVehicleController(el)
		if plr then
			local uid = getElementData(plr,"player:dbid") or 0;
			if uid > 0 then
				local sirens = getVehicleSirensOn(el) -- jeśli to pojazd służb alarmowo [!]
				if not sirens then
					local cashe = getElementData(source,"fotoradar:cashe") or 0;
					if cashe < 10000 then -- limit fot
						local vmx = getElementData(source,"fotoradar:vmax") or 600;
						local speed = math.floor(getElementSpeed(el));
						if vmx <= speed then
							triggerClientEvent("fotoradar:blysk",root,plr)
							--dodaj cashe
							local cashe = cashe + 1
							setElementData(source,"fotoradar:cashe",cashe)
							--kary
							local mnoznik = getElementData(source,"fotoradar:mnoznik") or 1;
							cost = tonumber((vmx * speed) * mnoznik); -- ( 150km/h * limit ) * 50% = 90$
							local money = string.format("%.2f", cost/100)
							veh = getVehicleName(el)
							code = getElementData(source,"fotoradar:code")
							triggerClientEvent("fotoradar:info",root,plr,veh,speed,tostring(money),cashe,code)
							local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_polimoney=user_polimoney+? WHERE user_id=?",cost,uid);
							-- poli money
							poliMandaty(plr)	
						end
					else
						local getID = getElementData(source,"fotoradar:id") or 0;
						local element = findID(getID)
						local spr1 = getElementData(element,"value") or false;
						if element and not spr1 then
							local nazwa = getElementData(element,"name")
							setElementData(t,"name",nazwa.."\n\n[ZAPEŁNIONY]")
							setElementData(t,"value",true)
						end
					end
				end
			end
		end
	end
end)








