--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt wczytywania handingu pojazdów.
]]--

--==================--  --==================--  --==================--

setModelHandling(495,"engineAcceleration",10) -- sultan
setModelHandling(411,"engineAcceleration",10) -- infek nerf
setModelHandling(477,"engineAcceleration",9.2) -- zrka nerf
setModelHandling(429,"engineAcceleration",11.2) -- banshee nerf
setModelHandling(541,"engineAcceleration",10) -- bullet nerf
setModelHandling(541,"dragCoeff",1.7) -- bullet [buff]
setModelHandling(415,"engineAcceleration",10) -- chetah nerf
setModelHandling(480,"engineAcceleration",10) -- ??? nerf
setModelHandling(559,"engineAcceleration",9.2) -- jester nerf
setModelHandling(561,"engineAcceleration",7) -- stratum nerf
setModelHandling(506,"engineAcceleration",8.3) -- sgt nerf
setModelHandling(555,"engineAcceleration",10) -- windsor nerf
setModelHandling(558,"engineAcceleration",8) -- uranus [buff]
setModelHandling(562,"engineAcceleration",10.3) -- elegy nerf

setModelHandling(402,"engineAcceleration",8.5) -- buffalo nerf
setModelHandling(542,"engineAcceleration",7) -- clover nerf
setModelHandling(603,"engineAcceleration",9) -- fenix nerf\
setModelHandling(475,"engineAcceleration",7.6) -- sabre nerf
setModelHandling(536,"engineAcceleration",6) -- blade nerf
setModelHandling(575,"engineAcceleration",6) -- brodway nerf
setModelHandling(534,"engineAcceleration",7.2) -- Remington nerf
setModelHandling(567,"engineAcceleration",7.6) -- Savanna nerf
setModelHandling(535,"engineAcceleration",13) -- Slamvan nerf
setModelHandling(576,"engineAcceleration",6) -- Tornado nerf
setModelHandling(412,"engineAcceleration",7.3) -- Voodoo nerf

setModelHandling(579,"engineAcceleration",9) -- huntlay nerf
setModelHandling(400,"engineAcceleration",8.5) -- landstalker nerf
setModelHandling(404,"engineAcceleration",6.2) -- perrek nerf
setModelHandling(458,"engineAcceleration",7) -- solair nerf
setModelHandling(422,"engineAcceleration",7) -- bobcat nerf
setModelHandling(521,"engineAcceleration",20) -- FCR [buff]

setModelHandling(445,"engineAcceleration",6.8) -- admiral nerf
setModelHandling(507,"engineAcceleration",6.4) -- elegant nerf
setModelHandling(585,"engineAcceleration",6.4) -- eperor nerf
setModelHandling(466,"engineAcceleration",7.2) -- glendal nerf
setModelHandling(492,"engineAcceleration",7.5) -- greenwood nerf
setModelHandling(546,"engineAcceleration",6.2) -- intruder nerf
setModelHandling(551,"engineAcceleration",6.2) -- merit nerf
setModelHandling(516,"engineAcceleration",7) -- nebula nerf
setModelHandling(467,"engineAcceleration",5.4) -- oceanic nerf
setModelHandling(426,"engineAcceleration",7.4) -- premier nerf
setModelHandling(405,"engineAcceleration",9) -- sentinel nerf
setModelHandling(580,"engineAcceleration",8.5) -- stafford nerf
setModelHandling(409,"engineAcceleration",6) -- streach nerf
setModelHandling(550,"engineAcceleration",5.8) -- sunrise nerf
setModelHandling(566,"engineAcceleration",7) -- tahoma nerf
setModelHandling(540,"engineAcceleration",6.2) -- vicek nerf
setModelHandling(421,"engineAcceleration",6.6) -- Washington nerf
setModelHandling(529,"engineAcceleration",6) -- willard nerf

setModelHandling(602,"engineAcceleration",8.2) -- alpa nerf
setModelHandling(496,"engineAcceleration",9.4) -- blista c nerf
setModelHandling(518,"engineAcceleration",7.6) -- buccaneer nerf
setModelHandling(589,"engineAcceleration",10) -- club nerf
setModelHandling(419,"engineAcceleration",6.1) -- esperanto nerf
setModelHandling(587,"engineAcceleration",8.2) -- euros nerf
setModelHandling(533,"engineAcceleration",9.3) -- Feltzer nerf
setModelHandling(474,"engineAcceleration",6.1) -- hermes nerf
setModelHandling(545,"engineAcceleration",6.8) -- hustler nerf
setModelHandling(517,"engineAcceleration",7) -- Majestic nerf
setModelHandling(600,"engineAcceleration",8.5) -- picador nerf
setModelHandling(436,"engineAcceleration",6.1) -- previon nerf
setModelHandling(439,"engineAcceleration",7) -- stalion nerf
setModelHandling(549,"engineAcceleration",8.4) -- tampa nerf
setModelHandling(491,"engineAcceleration",6.2) -- Virgo nerf
--[[
function resetHandling()
	local modelId = 560
	for k,_ in pairs(getModelHandling(modelId)) do
		setModelHandling(modelId, k, nil)
	end
end
addEventHandler("onResourceStop", resourceRoot, resetHandling)
]]
--==================--  --==================--  --==================--
--[[
addCommandHandler("upgr", function(plr,cmd,id)
    if tonumber(id) then
		idt = tonumber(id)
		if idt then
			-- fsst ST
			local vehicle = getPedOccupiedVehicle(plr) or false
			if vehicle then
				if idt == 4 then -- STAGE #2
					local hand = getVehicleHandling(vehicle)
					setVehicleHandling(vehicle, "engineAcceleration", hand.engineAcceleration+(hand.engineAcceleration*0.09))
					setVehicleHandling(vehicle, "maxVelocity", hand.maxVelocity+(hand.maxVelocity*0.10))
				end
				if idt == 5 then -- STAGE #1
					local hand = getVehicleHandling(vehicle)
					setVehicleHandling(vehicle, "engineAcceleration", hand.engineAcceleration+(hand.engineAcceleration*0.0447))
					setVehicleHandling(vehicle, "maxVelocity", hand.maxVelocity+(hand.maxVelocity*0.06))
				end
				if idt == 6 then -- Full carbon body
					local hand = getVehicleHandling(vehicle)
					local getffkck = (hand.mass) * 0.20;
					setVehicleHandling(vehicle, "mass", hand.mass-(hand.mass*0.16))
					setVehicleHandling(vehicle, "turnMass",(hand.mass-(hand.mass*0.16))+(getffkck))
					setVehicleHandling(vehicle, "engineAcceleration", hand.engineAcceleration+(hand.engineAcceleration*0.02))
					setVehicleHandling(vehicle, "collisionDamageMultiplier", hand.collisionDamageMultiplier+(hand.collisionDamageMultiplier*0.05))
				end
				if idt == 7 then -- Heavyweight pack
					local hand = getVehicleHandling(vehicle)
					local getffkck = (hand.mass) * 0.20;
					setVehicleHandling(vehicle, "mass", hand.mass+(hand.mass*0.17))
					setVehicleHandling(vehicle, "turnMass",(hand.mass+(hand.mass*0.17))+(getffkck))
					setVehicleHandling(vehicle, "engineAcceleration", hand.engineAcceleration-(hand.engineAcceleration*0.02))
					setVehicleHandling(vehicle, "collisionDamageMultiplier", hand.collisionDamageMultiplier-(hand.collisionDamageMultiplier*0.25))
				end
				if idt == 8 then -- Sportowe zawieszenie
					local hand = getVehicleHandling(vehicle)
					setVehicleHandling(vehicle, "tractionBias", hand.tractionBias+(hand.tractionBias*0.11))
					setVehicleHandling(vehicle, "tractionLoss", hand.tractionLoss+(hand.tractionLoss*0.055))
				end
				if idt == 9 then -- Standardowe zawieszenie
					local hand = getVehicleHandling(vehicle)
					setVehicleHandling(vehicle, "tractionBias", hand.tractionBias+(hand.tractionBias*0.62))
					setVehicleHandling(vehicle, "tractionLoss", hand.tractionLoss+(hand.tractionLoss*0.033))
				end
				
			end
		end
	end
end)
]]--
function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling ( element ) 
        local value = handlingTable[property] 
        if value then
            return value
        end
    end
    return false
end

function nadajHandingPoj(auto,plr)
    local veh_id = getElementData(auto,"vehicle:id") or 0;
	local vehs_TUNE = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."'")
	if #vehs_TUNE > 0 then
		local vehs_HAND = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles_handing WHERE handing_vehid = '"..veh_id.."' LIMIT 1")
		if #vehs_HAND > 0 then -- jesli jest takowy, sprawdzamy co powinno zostać dodane a co nie.
			-- wypisze tavlice
			local vehmodel = vehs_TUNE[1].veh_modelid;
--			local vehsu1 = vehs_TUNE[1].veh_SU1;
			
			for i,k in pairs(getOriginalHandling(vehmodel)) do
				setVehicleHandling(auto, k, nil)
			end
			
			local handing_engineAcceleration = (vehs_HAND[1].handing_engineAcceleration) or 0;
			local handing_maxVelocity = (vehs_HAND[1].handing_maxVelocity) or 0;
			local handing_mass = (vehs_HAND[1].handing_mass) or 0;
			local handing_turnMass = (vehs_HAND[1].handing_turnMass) or 0;
			local handing_tractionLoss = (vehs_HAND[1].handing_tractionLoss) or 0;
			local handing_brakeDeceleration = (vehs_HAND[1].handing_brakeDeceleration) or 0;
			local handing_steeringLock = (vehs_HAND[1].handing_steeringLock) or 0;
			local handing_numberOfGears = (vehs_HAND[1].handing_numberOfGears) or 0;
			local handing_suspensionDamping = (vehs_HAND[1].handing_suspensionDamping) or 0;
			local handing_tractionBias = (vehs_HAND[1].handing_tractionBias) or 0;
			local handing_driveType = (vehs_HAND[1].handing_driveType) or 0;
			
			-- teraz po kolei, sprawdzamy
			
			local hand = getVehicleHandling(auto)
			setVehicleHandling(auto, "engineAcceleration", handing_engineAcceleration)
			setVehicleHandling(auto, "maxVelocity", handing_maxVelocity)
			setVehicleHandling(auto, "mass", handing_mass)
			setVehicleHandling(auto, "turnMass", handing_turnMass)
			setVehicleHandling(auto, "tractionLoss", handing_tractionLoss)
			setVehicleHandling(auto, "brakeDeceleration", handing_brakeDeceleration)
			setVehicleHandling(auto, "steeringLock", handing_steeringLock)
			setVehicleHandling(auto, "numberOfGears", handing_numberOfGears) -- hand.numberOfGears+
			setVehicleHandling(auto, "suspensionDamping", handing_suspensionDamping)
			setVehicleHandling(auto, "tractionBias", handing_tractionBias)
			setVehicleHandling(auto, "driveType", handing_driveType) -- hand.driveType
			
			local handing_tunecfg = (vehs_HAND[1].handing_tunecfg) or false;
			if handing_tunecfg then
				handing_tunecfg = split(handing_tunecfg, ",")
				if handing_tunecfg[1] and handing_tunecfg[2] and handing_tunecfg[3] and handing_tunecfg[4] and handing_tunecfg[5] and handing_tunecfg[6] and handing_tunecfg[7] and handing_tunecfg[8] then
					setElementData(auto,"vehicle:tunecfg",{handing_tunecfg[1],handing_tunecfg[2],handing_tunecfg[3],handing_tunecfg[4],handing_tunecfg[5],handing_tunecfg[6],handing_tunecfg[7],handing_tunecfg[8]})
				end
			else
				setElementData(auto,"vehicle:tunecfg",0)
			end
		end
	end
end

----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA -----
----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA -----
----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA ----- TEST BETA -----

local strefy={
	carModyfi={
		cuboid={1973.6064453125, 2151.099609375, 10.8203125-1, 8, 5, 5},-- cuboid w ktorym musi znalezc sie pojazd
    	mpos={1980.5234375, 2156.4169921875, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby zmienic parametry poj
    	faction_id="tune-lv", -- nameid frakcji ktora ma do tego dostep
	},
	carModyfi2={
		cuboid={1973.6064453125, 2143.7255859375, 10.8203125-1, 8, 5, 5},-- cuboid w ktorym musi znalezc sie pojazd
    	mpos={1977.8505859375, 2142.53515625, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby zmienic parametry poj
    	faction_id="tune-lv", -- nameid frakcji ktora ma do tego dostep
	},
}

for i,v in pairs(strefy) do
	cs=createColCuboid(unpack(v.cuboid))
	setElementData(cs,"tunercfg",true)
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1, 0,0,0,100)
	setElementData(marker,"cs",cs)
	setElementData(marker,"tunercfg",true)
	setElementData(marker,"m:duty",v.faction_id)
	t = createElement("text")
	setElementData(t,"name","Modyfikator")
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3])
end


addEvent("setVehicleNewHanding", true)
addEventHandler("setVehicleNewHanding", root, function(veh,var0,var1,var2,var3,var4,var5,var6,var7,plr)
	local getid = getElementData(veh,"vehicle:id") or 0;
	if tonumber(getid) > 0 then
		-- wartosci potrzeba przedstawic w liczbie setnej, aby ja pomnozyc
		
		local var1 = string.format("%.2f", var1/100)
		local var2 = string.format("%.2f", var2/100)
		local var3 = string.format("%.2f", var3/100)
		local var4 = string.format("%.2f", var4/100)
		local var5 = string.format("%.2f", var5/100)
--		local var6 = string.format("%.2f", var6/100)
		local var7 = string.format("%.2f", var7/100) or 0;
		
--		local varadded = string.format("%.2f", var5/50)
		
		-- sprawdzam mk poj
		local mk1 = getElementData(veh,"vehicle:mk1") or 0;
		local mk2 = getElementData(veh,"vehicle:mk2") or 0;
		local mk3 = getElementData(veh,"vehicle:mk3") or 0;
		local su1 = getElementData(veh,"vehicle:su1") or 0;
		
		if tonumber(mk3) ~= 0 or tonumber(mk2) ~= 0 or tonumber(mk1) ~= 0 then -- rewstart
			for i,k in pairs(getOriginalHandling(getElementModel(veh))) do
				setVehicleHandling(veh, k, nil)
			end
		end
	
		if tonumber(mk1) ~= 0 then -- cfg mk1
			local hand = getVehicleHandling(veh)
			local getffkck = (hand.mass) * 0.20;
			setVehicleHandling(veh,"numberOfGears",var0)
			setVehicleHandling(veh,"mass",((hand.mass)*var1))
			setVehicleHandling(veh,"turnMass",((hand.mass)*var1)+(getffkck))
			setVehicleHandling(veh,"steeringLock",((hand.steeringLock)*var3))
			local var1 = tonumber(var1)
			local hand = getVehicleHandling(veh)
			if var1 < 0.85 then 
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss+0.3)
			elseif var1 >= 0.85 and var1 < 0.99 then
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss+0.2)
			elseif var1 >= 0.99 and var1 < 1.50 then
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss+0.1)	
			elseif var1 >= 1.50 and var1 < 2.00 then
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss-0.1)
			elseif var1 >= 2.00 and var1 < 2.50 then
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss-0.2)
				setVehicleHandling(veh, "brakeDeceleration", ((hand.brakeDeceleration)*0.05)+hand.brakeDeceleration )
			elseif var1 >= 2.50 and var1 < 3 then
				setVehicleHandling(veh, "tractionLoss", hand.tractionLoss-0.3)
				setVehicleHandling(veh, "brakeDeceleration", ((hand.brakeDeceleration)*0.10)+hand.brakeDeceleration )
			end
			local var2 = tonumber(var2)
			local hand = getVehicleHandling(veh)
			if var2 < 0.85 then 
				setVehicleHandling(veh, "suspensionDamping", 0.02)
			elseif var2 >= 0.85 and var2 < 0.99 then
				setVehicleHandling(veh, "suspensionDamping", 0.1)
			elseif var2 >= 0.99 and var2 < 1.50 then
				setVehicleHandling(veh, "suspensionDamping", 0.5)
			elseif var2 >= 1.50 and var2 < 2.00 then
				setVehicleHandling(veh, "suspensionDamping", 0.8)
				setVehicleHandling(veh, "tractionBias", ((hand.tractionBias)*0.06)-hand.tractionBias )
			elseif var2 >= 2.00 and var2 < 2.50 then
				setVehicleHandling(veh, "suspensionDamping", 1)
				setVehicleHandling(veh, "tractionBias", ((hand.tractionBias)*0.09)-hand.tractionBias )
			elseif var2 >= 2.50 and var2 < 3 then
				setVehicleHandling(veh, "suspensionDamping", 2)
				setVehicleHandling(veh, "tractionBias", ((hand.tractionBias)*0.12)-hand.tractionBias )
			end
		end
		
		if tonumber(mk2) ~= 0 then -- cfg mk2
			local var4 = tonumber(var4)
			local hand = getVehicleHandling(veh)
			if var4 < 0.99 then 
				setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+((hand.maxVelocity)*0.02))
			elseif var4 >= 0.99 and var4 < 1.50 then
				setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+((hand.maxVelocity)*0.07))
			elseif var4 >= 1.50 and var4 < 2.00 then
				setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+((hand.maxVelocity)*0.09))
			elseif var4 >= 2.00 and var4 < 2.50 then
				setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+((hand.maxVelocity)*0.11))
			elseif var4 >= 2.50 and var4 < 3 then
				setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+((hand.maxVelocity)*0.12))
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.033))
			end
			local var5 = tonumber(var5)
			local hand = getVehicleHandling(veh)
			if var5 < 0.99 then 
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.06))
			elseif var5 >= 0.99 and var5 < 1.50 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.09))
			elseif var5 >= 1.50 and var5 < 2.00 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.12))
			elseif var5 >= 2.00 and var5 < 2.50 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.15))
			elseif var5 >= 2.50 and var5 < 3 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.19))
			end
		end
		
		if tonumber(mk3) ~= 0 then -- cfg mk3
			local hand = getVehicleHandling(veh)
			setVehicleHandling(veh,"driveType",tostring(var6))
			local var7 = tonumber(var7)
			local hand = getVehicleHandling(veh)
			if var7 < 0.99 then 
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.08))
			elseif var7 >= 0.99 and var7 < 1.50 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.16))
			elseif var7 >= 1.50 and var7 < 2.00 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.17))
			elseif var7 >= 2.00 and var7 < 2.50 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.20))
			elseif var7 >= 2.50 and var7 < 3 then
				setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+((hand.engineAcceleration)*0.23))
			end
		end		
		
		triggerEvent("localInfoChat",root,plr,"zmodyfikował parametry pojazdu #EBB85D"..getVehicleName(veh).."#e7d9b0.",25)
		
		if ( tonumber(mk3) ~= 0 or tonumber(mk2) ~= 0 or tonumber(mk1) ~= 0 ) and tonumber(su1) ~= 0 then -- dodatkowe uklady
			local idt = tonumber(su1)
				local text_added = "";
				if idt == 4 then -- Chipset RACE
					local hand = getVehicleHandling(veh)
					if tonumber(hand.engineAcceleration*0.09) > 0.75 then handacc = 0.75; else handacc = (hand.engineAcceleration*0.09); end -- max to +1
					if tonumber(hand.maxVelocity*0.10) > 16 then handvmx = 16; else handvmx = (hand.maxVelocity*0.10); end -- max to +16
					setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+handacc)
					setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+handvmx)
					text_added = "wgrywa Chipset RACE do pojazdu";
				end
				if idt == 5 then -- Chipset ECO
					local hand = getVehicleHandling(veh)
					if tonumber(hand.maxVelocity*0.06) > 16 then handvmx = 16; else handvmx = (hand.maxVelocity*0.06); end -- max to +16
					setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+(hand.engineAcceleration*0.0447))
					setVehicleHandling(veh, "maxVelocity", hand.maxVelocity+handvmx)
					text_added = "wgrywa Chipset ECO do pojazdu";
				end
				if idt == 6 then -- Elementy karoserii z włókna węglowego
					local hand = getVehicleHandling(veh)
					local getffkck = (hand.mass) * 0.20;
					setVehicleHandling(veh, "mass", hand.mass-(hand.mass*0.16))
					setVehicleHandling(veh, "turnMass",(hand.mass-(hand.mass*0.16))+(getffkck))
					setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration+(hand.engineAcceleration*0.02))
					setVehicleHandling(veh, "collisionDamageMultiplier", hand.collisionDamageMultiplier+(hand.collisionDamageMultiplier*0.05))
					text_added = "montuje elementy karoserii z włókna węglowego w pojeździe";
				end
				if idt == 7 then -- Wzmocnione elementy karoserii
					local hand = getVehicleHandling(veh)
					local getffkck = (hand.mass) * 0.20;
					setVehicleHandling(veh, "mass", hand.mass+(hand.mass*0.17))
					setVehicleHandling(veh, "turnMass",(hand.mass+(hand.mass*0.17))+(getffkck))
					setVehicleHandling(veh, "engineAcceleration", hand.engineAcceleration-(hand.engineAcceleration*0.02))
					setVehicleHandling(veh, "collisionDamageMultiplier", hand.collisionDamageMultiplier-(hand.collisionDamageMultiplier*0.25))
					text_added = "montuje wzmocnione elementy karoserii w pojeździe";
				end
				if idt == 8 then -- Wzmocniony drążek stabilizatora
					local hand = getVehicleHandling(veh)
					setVehicleHandling(veh, "tractionBias", hand.tractionBias+(hand.tractionBias*0.11))
					setVehicleHandling(veh, "tractionLoss", hand.tractionLoss+(hand.tractionLoss*0.055))
					text_added = "konfiguruje wzmocniony drążek stabilizatora pojazdu";
				end
				if idt == 9 then -- Standardowy drążek stabilizatora
					local hand = getVehicleHandling(veh)
					setVehicleHandling(veh, "tractionBias", hand.tractionBias+(hand.tractionBias*0.62))
					setVehicleHandling(veh, "tractionLoss", hand.tractionLoss+(hand.tractionLoss*0.033))
					text_added = "konfiguruje standardowy drążek stabilizatora pojazdu";
				end
				triggerEvent("localInfoChat",root,plr,text_added..".",25)
		end
		
		outputChatBox("#388E00✔#e7d9b0 Zmodyfikowano parametry pojazdu #EBB85D"..getVehicleName(veh).."#e7d9b0.", plr, 255, 255, 255, true)
		
--		local hand = getVehicleHandling(veh)
--		local query = exports["aj-dbcon"]:upd("")
		
	end
--	local query = exports["aj-dbcon"]:upd("UPDATE server_vehicles_handing SET ")
end)















