--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--

local notis = {
	{2470.2919921875, 1022.62109375, 10.8203125, 0, 0, "Informacja", "Urząd Las Venturas - Wita!\n\nCo tutaj znajdę?\n- Egzaminy teorytyczne.\n- Możliwość zatrudnienia się w pobliskich warsztatach.\n- Opłacanie mandatów.\n- Zmiana tablic rejestracyjnych pojazdów.\n\nStan na: 10.05.2021r."},
	{2489.3857421875, 923.2900390625, 11.0234375, 0, 0, "Informacja", "Kaplica Las Venturas — Witamy!\n\nJest to świetne miejsce, aby otrzymać pozytywną reputację, jedynym ograniczeniem jest czas. Wejdź do kapliczki i pozostań kilka minut na mszy, a na pewno zostaniesz wynagrodzony!"},
	{2517.1923828125, 998.796875, 10.8203125, 0, 0, "Budowa trwa!", "Zwykła budowa, nie zabrakło tutaj bezdomnych."},
	{2835.4892578125, 932.34375, 10.9765625, 0, 0, "Informacja", "Dorywcza praca transportera kontenerów\n\nAby rozpocząć tutaj pracę, należy posiadać zdany egzamin teoretyczny, jak i praktyczny kategorii C, dodatkowo posiadać co najmniej 1000 punktów gry.\n\nPraca polega na rozwożeniu kontenerów w różne lokacje SA. Dostępne mamy 4 poziomy, wraz z większym poziomem rośnie nasze wynagrodzenie!"},
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
  
for i,noti in ipairs(notis) do
	local pic = createPickup(noti[1], noti[2], noti[3], 3, 1239, 150)
	nadajTEXTswiat(noti[6], noti[1], noti[2], noti[3])
	
	setElementData(pic,"noti",true)
	setElementData(pic,"noti:desc",noti[7])
	
	setElementInterior(pic, (noti[4] or 0))
	setElementDimension(pic, (noti[5] or 0))
end


addEventHandler("onPickupHit", getRootElement(),function(gracz)
    if (getElementType(gracz) == "player") then
		if isPedInVehicle(gracz) then return end
		local noti = getElementData(source,"noti") or false;
		if noti then
			local notidesc = getElementData(source,"noti:desc") or "";
			triggerClientEvent(gracz, "pokazNoti", root, notidesc, gracz)
		end
    end
end)

addEventHandler("onPickupLeave", getRootElement(),function(gracz)
    if (getElementType(gracz) == "player") then
		local noti = getElementData(source,"noti") or false;
		if noti then
			triggerClientEvent(gracz, "zamknijNoti", root, gracz)
		end
    end
end)