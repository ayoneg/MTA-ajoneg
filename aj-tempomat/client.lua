--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt tempomatu pojazdów.
]]--

local tempomaty = {nil, 200, 140, 90, 60, 20}
local aktualny_tempomat = 1

function getElementSpeed(element)
    sx,sy,sz=getElementVelocity(element)
	speed=(sx^2 + sy^2 + sz^2)^(0.5)
	kmh=speed*180
	return kmh
end

addEventHandler("onClientVehicleEnter", root, function(plr,seat)
	if not plr or seat~=0 then return end
	if plr~=localPlayer then return end
	if source then
		if getVehicleType(source)=="Automobile" then
			bindKey("mouse1", "down", tempomatdown, source)
			bindKey("mouse2", "down", tempomatup, source)
		end
	end
end)

addEventHandler("onClientVehicleExit", root, function(plr,seat)
	if not plr or seat~=0 then return end
	if plr~=localPlayer then return end
	if source then
		if getVehicleType(source)=="Automobile" then
			unbindKey("mouse1", "down", tempomatdown)
			unbindKey("mouse2", "down", tempomatup)
		end
	end
end)

function tempomatup(veh)
	local blokada = getElementData(localPlayer,"player:GUIblock") or false
	if not blokada then
		if veh then
			aktualny_tempomat = aktualny_tempomat + 1
			if aktualny_tempomat>#tempomaty then aktualny_tempomat=1 end
			aktualny = tempomaty[aktualny_tempomat]
			if aktualny ~= nil then
				outputChatBox("(( Ogranicznik został ustawiony na "..aktualny.." km/h. ))", 132, 132, 132, true)
			else
				outputChatBox("(( Ogranicznik został wyłączony. ))", 132, 132, 132, true)
			end
		end
	end
end

function tempomatdown(veh)
	local blokada = getElementData(localPlayer,"player:GUIblock") or false
	if not blokada then
		if veh then
			aktualny_tempomat = aktualny_tempomat - 1
			if aktualny_tempomat<1 then aktualny_tempomat=#tempomaty end
			aktualny = tempomaty[aktualny_tempomat]
			if aktualny ~= nil then
				outputChatBox("(( Ogranicznik został ustawiony na "..aktualny.." km/h. ))", 132, 132, 132, true)
			else
				outputChatBox("(( Ogranicznik został wyłączony. ))", 132, 132, 132, true)
			end
		end
	end
end

function tempomat()
	local aktualny = tempomaty[aktualny_tempomat]
	local plr = localPlayer
	if plr then
		local veh = getPedOccupiedVehicle(plr)
		if veh then
			if getVehicleController(veh) ~= plr then return end
			if not isVehicleOnGround(veh) then return end
			if not getVehicleType(veh)=="Automobile"  then return end
			local vx,vy,vz = getElementVelocity(veh)
			setElementData(veh,"vehicle:tempomat",aktualny) -- na potrzeby licznika
			local predkosc = (vx^2 + vy^2 + vz^2)^(0.5) *1.0*180
			if aktualny then
				if predkosc > aktualny then
					setElementVelocity(veh, vx*0.9,vy*0.9,vz*0.9)
				end
			end
		end
	end
end
setTimer(tempomat, 20, 0)





