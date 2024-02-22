--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt usuwania obiektów z mapy.
]]--


----- texty ----- texty ----- texty ----- texty ----- texty ----- texty ----- texty 
local textynamapie = {
	{"Praca dorywcza [Holowniki]", 1, 22, 1908.5107421875, 2309.787109375, 12.8203125},
	{"Szkoła jazdy\nkategoria C", 1, 22, 1707.3427734375, 950.3154296875, 12.5203125},
	{"Szkoła jazdy\nkategoria B", 1, 22, -145.7158203125, 1172.439453125, 21.3421875},
--	{"Urząd miasta LV", 1, 22, 2474.4765625, 1024.251953125, 12.5},
	{"Kaplica", 1, 22, 2491.3662109375, 918.5234375, 11.6+1},
	{"Przebieralnia", 1, 22, 2102.5068359375, 2257.373046875, 11.634375+1},
	{"Praca dorywcza [FastEats]", 1, 22, 2330.703125, 2532.2158203125, 10.8203125+1.2},
	{"Brama wyjazdowa, nie zastawiać!", 1, 22, 1989.8603515625, 2123.1962890625, 13.454118728638},
	
	{"Stanowisko tune nr.2", 1, 22, 1967.517578125, 2154.1796875, 13.99}, -- tune stano 1
	{"Stanowisko tune nr.1", 1, 22, 1967.517578125, 2146.220703125, 13.99}, -- tune stano 1
	{"Lakiernia pojazdów", 1, 22, 1967.517578125, 2162.220703125, 13.99},
	
	{"Bankomat organizacji", 1, 20, 2460.240234375, 2384.046875, 12.25354385376+1},
	{"Przelew na konto 24/7", 1, 15, 2465.2924804688, 2389.4482421875, 12.8+1},
	{"Historia transakcji", 1, 15, 2465.2973632812, 2399.6552734375, 12.8+1},
	
--	{"Wyjście", 1, 15, 390.7685546875, 173.8251953125, 1009+1, 3, 300},
--	{"Zmiana tablic rejestracyjnych", 1, 15, 358.390625, 179.8154296875, 1006.3828125+3, 3, 300},
--	{"Pojazdy organizacji", 1, 15, 358.23828125, 186.9208984375, 1008.3828125+1, 3, 300},
--	{"Organizacje", 1, 15, 358.537109375, 161.3115234375, 1008.3828125+1, 3, 300},
--	{"Urząd pracy", 1, 15, 358.5205078125, 167.142578125, 1008.3828125+1, 3, 300},
--	{"Punkt załadunku, nie zastawiać!", 1, 22, 2804.3525390625, 965.173828125, 14.474781990051}, -- lawety stano

	{"Wyjazd, nie zastawiać!", 1, 20, 1698.5224609375, 961.4150390625, 14, 0, 0},
	
	-- HOLOWNIKI LV
	{"Respawn pojazdów, nie zastawiać!", 1, 20, 1908.8173828125, 2324.03515625, 13, 0, 0},
	
	-- SAPD
	{"KGP LV", 1, 20, 2287.0732421875, 2432.3671875, 10.8203125+1.5, 0, 0},
	{"Wyjście", 1, 20, 246.3564453125, 107.30078125, 1003.21875+1.5, 10, 997},
}

for i,p in ipairs(textynamapie) do
	t = createElement("text")
	setElementData(t,"name",p[1])
	setElementData(t,"scale",p[2])
	setElementData(t,"distance",p[3])
	setElementPosition(t,p[4],p[5],p[6])
	setElementInterior(t, (p[7] or 0))
	setElementDimension(t, (p[8] or 0))
end

----- pedy na mapie ----- pedy na mapie ----- pedy na mapie ----- pedy na mapie ----- pedy na mapie 
local pedynamapie={
	{"Kasia", 9, 2467.5649414062, 2389.873046875, 12.25354385376, 90, 0, 0, "INT_OFFICE", "OFF_Sit_Idle_Loop"},
	{"Kinga", 11, 2467.4799804688, 2399.875, 12.25354385376, 90, 0, 0, "INT_OFFICE", "OFF_Sit_Idle_Loop"},
	{"Tomasz", 17, 2452.5263671875, 2366.5556640625, 12.25354385376, 0, 0, 0, "INT_OFFICE", "OFF_Sit_Idle_Loop"},
	{"Strażnik", 71, 2452.5712890625, 2384.39453125, 12.25354385376, 180, 0, 0, "DEALER", "DEALER_IDLE"},
	
	{"", 17, 355.37109375, 186.9931640625, 1008.3784790039, -90, 3, 300, "brak"},
	{"", 12, 355.451171875, 179.64453125, 1008.3782958984, -90, 3, 300, "brak"},
	{"", 57, 355.4033203125, 161.2109375, 1008.3784179688, -90, 3, 300, "brak"},
	{"", 76, 355.279296875, 167.3427734375, 1008.3787231445, -90, 3, 300, "brak"},
}

for i,v in ipairs(pedynamapie) do
	local ped = createPed(v[2], v[3], v[4], v[5], v[6])
	setElementData(ped,"ped:name",v[1])
	if tostring(v[9]) ~= "brak" then
		setElementData(ped,"ped:ANI",true)
		setElementData(ped,"ped:ANIun",v[9])
		setElementData(ped,"ped:ANIuntu",v[10])
	end
	setElementInterior(ped, v[7])
	setElementDimension(ped, v[8])
	setElementFrozen(ped, true)
	if tostring(v[9]) ~= "brak" then
		setTimer(function()
			setPedAnimation(ped, v[9], v[10], -1, true, false)
		end, 150, 1)
	end
end

--------------------------------------------------------------------------------------------
local mostFCLV = createRadarArea(587.3984375, 1842.9736328125, 333, 20, 0, 0, 0, 255, root)
local drogarockshore = createRadarArea(2646.140625, 912.419921875, 110, 15, 0, 0, 0, 255, root)
------ obiekty ------ obiekty ------ obiekty ------ obiekty ------ obiekty ------ obiekty

local obiektynamapie={
	{ -- tune lv
		kordy={1937.95, 2157, 11},
    	rotacja={0,0,0},
    	obj_id=1025,
		nazwa="Offroad",
	},
	{ -- tune lv
		kordy={1937.95, 2158.5, 11},
    	rotacja={0,0,0},
    	obj_id=1073,
		nazwa="Shadow",
	},
	{ -- tune lv
		kordy={1937.95, 2160, 11},
    	rotacja={0,0,0},
    	obj_id=1074,
		nazwa="Mega",
	},
	{ -- tune lv
		kordy={1937.95, 2161.5, 11},
    	rotacja={0,0,0},
    	obj_id=1075,
		nazwa="Rimshine",
	},
	{ -- tune lv
		kordy={1937.95, 2163, 11},
    	rotacja={0,0,0},
    	obj_id=1076,
		nazwa="Wires",
	},
	{ -- tune lv
		kordy={1937.95, 2164.5, 11},
    	rotacja={0,0,0},
    	obj_id=1077,
		nazwa="Classic",
	},
	{ -- tune lv
		kordy={1937.95, 2157, 12.5},
    	rotacja={0,0,0},
    	obj_id=1078,
		nazwa="Twist",
	},
	{ -- tune lv
		kordy={1937.95, 2158.5, 12.5},
    	rotacja={0,0,0},
    	obj_id=1079,
		nazwa="Cutter",
	},
	{ -- tune lv
		kordy={1937.95, 2160, 12.5},
    	rotacja={0,0,0},
    	obj_id=1080,
		nazwa="Switch",
	},
	{ -- tune lv
		kordy={1937.95, 2161.5, 12.5},
    	rotacja={0,0,0},
    	obj_id=1081,
		nazwa="Grove",
	},
	{ -- tune lv
		kordy={1937.95, 2163, 12.5},
    	rotacja={0,0,0},
    	obj_id=1082,
		nazwa="Import",
	},
	{ -- tune lv
		kordy={1937.95, 2164.5, 12.5},
    	rotacja={0,0,0},
    	obj_id=1083,
		nazwa="Dollar",
	},
	{ -- tune lv
		kordy={1937.95, 2157, 14},
    	rotacja={0,0,0},
    	obj_id=1084,
		nazwa="Trance",
	},
	{ -- tune lv
		kordy={1937.95, 2158.5, 14},
    	rotacja={0,0,0},
    	obj_id=1085,
		nazwa="Atomic",
	},
	{ -- tune lv
		kordy={1937.95, 2160, 14},
    	rotacja={0,0,0},
    	obj_id=1096,
		nazwa="Ahab",
	},
	{ -- tune lv
		kordy={1937.95, 2161.5, 14},
    	rotacja={0,0,0},
    	obj_id=1097,
		nazwa="Virtual",
	},
	{ -- tune lv
		kordy={1937.95, 2163, 14},
    	rotacja={0,0,0},
    	obj_id=1098,
		nazwa="Access",
	},
	
	-- strafa DM start
	{
		kordy={2073.140625, -1197.4814453125, 23.3},
    	rotacja={0,0,0},
    	obj_id=12957,
		nazwa="",
	},
	{
		kordy={ 2068.7216796875, -1199.61328125, 23.7},
    	rotacja={0,0,0},
    	obj_id=1358,
		nazwa="",
	},
	{
		kordy={2112.8935546875, -1215.4736328125, 23.968751907349},
    	rotacja={0,0,-90},
    	obj_id=1342,
		nazwa="",
	},
}

for i,v in ipairs(obiektynamapie) do
	obj = createObject(v.obj_id, v.kordy[1], v.kordy[2], v.kordy[3], v.rotacja[1], v.rotacja[2], v.rotacja[3])
	t = createElement("text")
	setElementData(t,"name",v.nazwa.."\nID:"..(v.obj_id))
	setElementPosition(t,v.kordy[1], v.kordy[2], v.kordy[3]-0.5)
	setElementInterior(t, 0)
	setElementDimension(t, 0)
	setElementFrozen(obj,true)
end








local removeObj = removeWorldModel(1413, 24, 76.6650390625, 1217.1552734375, 18.828733444214, 0) -- plot stacja FC
local removeObj = removeWorldModel(16284, 37,  93.1943359375, 1178.2236328125, 18.6640625, 0) -- linie FC























