--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt giełdy pojazdów.
]]--
local obszar_gieldy = createColCuboid(1717.6728515625, 1852.40625, 10.8203125-1, 39, 190, 5)

addEventHandler("onColShapeLeave",obszar_gieldy,function(theElement)
    if getElementType(theElement) == "vehicle" then
		removeElementData(theElement,"vehicle:vopis");
		removeElementData(theElement,"vehicle:gielda");
		removeElementData(theElement,"vehicle:gieldaTune");
		removeElementData(theElement,"vehicle:gieldaTune2");
		removeElementData(theElement,"vehicle:gieldaWheels");
	end
end)

local nazwaCzesci={
--  butle
	[1008]="Atrapa nitra (W)",
	[1009]="Atrapa nitra",
	[1010]="Atrapa nitra (double)",
--  fele
	[1025]="Felgi: Offroad",
	[1073]="Felgi: Grove",
	[1074]="Felgi: Cutter",
	[1075]="Felgi: Wires",
	[1076]="Felgi: Classic",
	[1077]="Felgi: Virtual",--- ???
	[1078]="Felgi: Shadow",
	[1079]="Felgi: Import",
	[1080]="Felgi: Mega",
	[1081]="Felgi: Konig",
	[1082]="Felgi: Rittle",
	[1083]="Felgi: Dolar",
	[1084]="Felgi: Ahab",
	[1085]="Felgi: Atomic",
	[1096]="Felgi: Listed",
	[1097]="Felgi: Megan +",
	[1098]="Felgi: Twist",
--  Stereo
	[1086]="Stero",
--  Spoilery
	[1000]="Spiler: Pro",
	[1001]="Spiler: Win",
	[1002]="Spiler: Drag",
	[1003]="Spiler: Alpha",
	[1014]="Spiler: Champ",
	[1015]="Spiler: Race",
	[1016]="Spiler: Worix",
	[1023]="Spiler: Furry",
	[1049]="Spiler: Mini Alpha", --- Alien
	[1050]="Spiler: Lotka X-Flow",
	[1058]="Spiler: Mini Alpha II", -- Alien
	[1060]="Spiler: Carbon X-Flow",
	[1138]="Spiler: Fury MAX I", -- Alien
	[1139]="Spiler: Default X-Flow",
	[1146]="Spiler: GTR Wing II",
	[1147]="Spiler: Fury MAX Double I",
	[1158]="Spiler: Fury JDM",
	[1162]="Spiler: Extra Wing I",
	[1163]="Spiler: Full Carbon X-Flow",
	[1164]="Spiler: Compact Alien", 
--	Progi
	[1036]="Progi: Alien",
	[1039]="Progi: X-Flow",
	[1040]="Progi: Alien",
	[1041]="Progi: X-Flow",
	[1007]="Progi: Czysty",
	[1017]="Progi: Czysty",
	[1026]="Progi: Alien",
	[1027]="Progi: Alien",
	[1030]="Progi: X-Flow",
	[1031]="Progi: X-Flow",
	[1042]="Progi: Chrome",
	[1047]="Progi: Alien",
	[1048]="Progi: X-Flow",
	[1051]="Progi: Alien",
	[1052]="Progi: X-Flow",
	[1056]="Progi: Alien",
	[1057]="Progi: X-Flow",
	[1062]="Progi: Alien",
	[1063]="Progi: X-Flow",
	[1069]="Progi: Alien",
	[1070]="Progi: X-Flow",
	[1071]="Progi: Alien",
	[1072]="Progi: X-Flow",
	[1090]="Progi: Alien",
	[1093]="Progi: X-Flow",
	[1094]="Progi: Alien",
	[1095]="Progi: X-Flow",
	[1099]="Progi: Chrome",
	[1101]="Progi: Chrome Flames",
	[1102]="Progi: Chrome Strip",
	[1106]="Progi: Chrome Arches",
	[1107]="Progi: Chrome Strip",
	[1108]="Progi: Chrome Strip",
	[1118]="Progi: Chrome Trim",
	[1119]="Progi: Wheel Covers",
	[1120]="Progi: Chrome Trim",
	[1121]="Progi: Wheelcovers",
	[1122]="Progi: Chrome Flames",
	[1124]="Progi: Chrome Arches",
	[1133]="Progi: Chrome Strip",
	[1134]="Progi: Chrome Strip",
	[1137]="Progi: Chrome Strip",
	
--  Bullbar . . ? [przod]
	[1100]="Chrome Grill",
	[1115]="Chrome",
	[1116]="Slamin",
	[1123]="Chrome",
	[1125]="Chrome Lights",
--  Bullbar . . ? [tył]
	[1109]="Chrome",
	[1110]="Slamin",
--	Front Sign [figurka itd z przodu]
	[1111]="Figurka",
	[1112]="Figurka",
--	Hydraulika
	[1087]="Hydraulika",
--  Wydechy
	[1034]="Wydech: Alien",
	[1037]="Wydech: X-Flow",
	[1044]="Wydech: Chrome",
	[1046]="Wydech: Alien",
	[1018]="Wydech: Upswept",
	[1019]="Wydech: Twin",
	[1020]="Wydech: Large",
	[1021]="Wydech: Medium",
	[1022]="Wydech: Small",
	[1028]="Wydech: Alien",
	[1029]="Wydech: X-Flow",
	[1043]="Wydech: Slamin",
	[1044]="Wydech: Chrome",
	[1045]="Wydech: X-Flow",
	[1059]="Wydech: X-Flow",
	[1064]="Wydech: Alien",
	[1065]="Wydech: Alien",
	[1066]="Wydech: X-Flow",
	[1089]="Wydech: X-Flow",
	[1092]="Wydech: Alien",
	[1104]="Wydech: Chrome",
	[1105]="Wydech: Slamin",
	[1113]="Wydech: Chrome",
	[1114]="Wydech: Slamin",
	[1126]="Wydech: Chrome",
	[1127]="Wydech: Slamin",
	[1129]="Wydech: Chrome",
	[1132]="Wydech: Slamin",
	[1135]="Wydech: Slamin",
	[1136]="Wydech: Chrome",
	
--  Zderzaki [tylni]
	[1149]="Zderzak tył: Alien",
	[1148]="Zderzak tył: X-Flow",
	[1150]="Zderzak tył: Alien",
	[1151]="Zderzak tył: X-Flow",
	[1154]="Zderzak tył: Alien",
	[1156]="Zderzak tył: X-Flow",
	[1159]="Zderzak tył: Alien",
	[1161]="Zderzak tył: X-Flow",
	[1167]="Zderzak tył: X-Flow",
	[1168]="Zderzak tył: Alien",
	[1175]="Zderzak tył: Slamin",
	[1177]="Zderzak tył: Slamin",
	[1178]="Zderzak tył: Slamin",
	[1180]="Zderzak tył: Chrome",
	[1183]="Zderzak tył: Slamin",
	[1184]="Zderzak tył: Chrome",
	[1186]="Zderzak tył: Slamin",
	[1187]="Zderzak tył: Chrome",
	[1192]="Zderzak tył: Chrome",
	[1193]="Zderzak tył: Slamin",
	[1140]="Zderzak tył: X-Flow",
	[1141]="Zderzak tył: Alien",
--  Zderzaki [pzrzód]
	[1169]="Zderzak przód: Alien",
	[1170]="Zderzak przód: X-Flow",

	[1117]="Zderzak przód: Chrome",
	[1152]="Zderzak przód: X-Flow",
	[1153]="Zderzak przód: Alien",
	[1155]="Zderzak przód: Alien",
	[1157]="Zderzak przód: X-Flow",
	[1160]="Zderzak przód: Alien",
--  Wloty [góra]
	[1128]="Wloty: Dach", -- DACH DO BLADE
	[1130]="Wloty: Dach", -- DACH DO SAVANNA
	[1131]="Wloty: Dach", -- DACH DO SAVANNA
	
	[1032]="Wloty: Alien",	
	[1033]="Wloty: X-Flow",	
--  Wloty [przód]
--	Dodatkowe lampy 
	[1013]="Lampa przeciw mgielne",
	[1024]="Lampa przeciw mgielne",
	
}


addEvent("stronaServeraStartGielda", true)
addEventHandler("stronaServeraStartGielda", root, function(plr,vehicle,cost)
	local plr_id = getElementData(plr,"player:dbid")or 0;
	if plr_id > 0 then
		local veh_id = getElementData(vehicle,"vehicle:id") or 0;
		if veh_id > 0 then
			local veh_owner = getElementData(vehicle,"vehicle:owner") or 0;
			if veh_owner > 0 and veh_owner == plr_id then
				setElementData(vehicle,"vehicle:gielda",true);
				removeElementData(vehicle,"vehicle:vopis");
				local cena = string.format("%.2f", cost)
				local przeb = string.format("%.1f", getElementData(vehicle,"vehicle:przebieg"))	
				local desc = ""..getVehicleName(vehicle).." ("..veh_id.." ID)\nPrzebieg: "..przeb.."km\nCena: "..cena.."$";
				setElementData(vehicle,"vehicle:gieldaOpis",desc);
				
				setElementData(vehicle,"vehicle:gieldaOwnerName",getPlayerName(plr));
				
				local cars = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id='"..veh_id.."'");
				veh_mk1 = cars[1].veh_mk1;
				if veh_mk1 > 0 then veh_mk1_ = "MK1" else veh_mk1_ = "" end
				veh_mk2 = cars[1].veh_mk2;
				if veh_mk2 > 0 then veh_mk2_ = ", MK2" else veh_mk2_ = "" end
				veh_mk3 = cars[1].veh_mk3;
				if veh_mk3 > 0 then veh_mk3_ = ", MK3" else veh_mk3_ = "" end
				veh_SU1 = cars[1].veh_SU1;
				if veh_SU1 > 0 then veh_SU1_ = ", SU1" else veh_SU1_ = "" end
				
				local tunedesc = veh_mk1_..veh_mk2_..veh_mk3_..veh_SU1_;
				setElementData(vehicle,"vehicle:gieldaTune",tunedesc);
				
				veh_maxpaliwo = cars[1].veh_maxpaliwo;

				veh_tune = getVehicleUpgrades(vehicle)
    			local tunedesc = "Bak "..veh_maxpaliwo.."L, "
				
				for i,v in ipairs(veh_tune) do 
					if i == 4 or i == 10 then
						tunedesc = tunedesc..tostring(nazwaCzesci[v])..",\n "; 
					else
						if i == #veh_tune then
							tunedesc = tunedesc..tostring(nazwaCzesci[v])..""; 
						else
							tunedesc = tunedesc..tostring(nazwaCzesci[v])..", "; 
						end
					end
				end
				
				local liczprzecinki = split(tunedesc, ",")
				
				setElementData(vehicle,"vehicle:gieldaTune2",tunedesc);
				
--				local wheelsdesc = "chuuuuj 2"
--				setElementData(vehicle,"vehicle:gieldaWheels",wheelsdesc);
			else
				-- poj. wystawic moze tylko wlasciciel
			end
		end
	end
end)