--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt stacji paliw.
]]--

local stacje = exports["aj-dbcon"]:wyb("SELECT * FROM server_cpn");
if #stacje > 0 then
	for i,cpn in ipairs(stacje) do
		local kordy = split(cpn.cpn_xyz, ",")
		local dimint = split(cpn.cpn_dimint, ",")
		
		local sphe = createColSphere(kordy[1], kordy[2], kordy[3], cpn.cpn_size)
		setElementData(sphe,"cpn",true)
		setElementData(sphe,"cpn:cost",cpn.cpn_cost)
		if (cpn.cpn_icon)==1 then createBlipAttachedTo(sphe,49,2,255,0,0,155,-1002,400) end
		setElementDimension(sphe, (dimint[1] or 0))
		setElementInterior(sphe, (dimint[2] or 0))
		
		t = createElement("text")
		setElementData(t,"name","Dystrybutor paliwa")
		setElementPosition(t, kordy[1], kordy[2], kordy[3]+1.5)
		setElementInterior(t, 0)
		setElementDimension(t, 0)
	end
end


function tankowanie(gracz)
	if isElement(gracz) then
		local veh = getPedOccupiedVehicle(gracz) or false;
		if veh then
			local cpncost = tonumber(getElementData(gracz,"cpn:cost")) or false;
			if cpncost then
				local mojecost = tonumber(getPlayerMoney(gracz))
				local policz = tonumber(mojecost-cpncost)
				if policz <= 0 then 
					outputChatBox("#841515✖#e7d9b0 Nie posiadasz tyle gotówki!", el,231, 217, 176,true)
					return
				end
				local paliwo = getElementData(veh,"vehicle:paliwo") or 0;
				local maxpaliwo = getElementData(veh,"vehicle:maxpaliwo") or 25;
				local licze = paliwo + 1
				if licze > maxpaliwo then 
--					outputChatBox("#841515✖#e7d9b0 Nie można zatankować więcej!", el,231, 217, 176,true)			
					return 
				end
				local uid = getElementData(gracz,"player:dbid") or 0;
				if uid > 0 then
					local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-'"..cpncost.."'  WHERE user_id = '"..uid.."'");
					local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_bankmoney=user_bankmoney+"..cpncost.." WHERE user_id = '22'");
				end
				takePlayerMoney(gracz,cpncost)
				setElementData(veh,"vehicle:paliwo",licze)
			end
		end
	end
end


addEventHandler("onColShapeHit", root, function(gracz,md)
	if not md then return end
	local cpn = getElementData(source,"cpn") or false;
	if not cpn then return end
	if isElement(gracz) and getElementType(gracz) == "player" then
		local cpncost = tonumber(getElementData(source,"cpn:cost")) or false;
		if cpncost then
			local seat = getPedOccupiedVehicleSeat(gracz) or false
			if seat and seat == 0 then
				setElementData(gracz,"cpn:cost",cpncost)
				bindKey(gracz, "space", "down", tankowanie, gracz)
				triggerClientEvent("cpn:panel",root,gracz,cpncost)
			end
		end
	end
end)

addEventHandler("onColShapeLeave", root, function(gracz,md)
	local cpn = getElementData(source,"cpn") or false;
	if not cpn then return end
	if isElement(gracz) and getElementType(gracz) == "player" then
		local seat = getPedOccupiedVehicleSeat(gracz) or false
		if seat and seat == 0 then
			removeElementData(gracz,"cpn:cost")
			unbindKey(gracz, "space", "down", tankowanie)
			triggerClientEvent("cpn:panel",root,gracz,cpncost)
		end
	end
end)