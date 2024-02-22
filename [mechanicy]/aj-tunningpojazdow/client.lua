--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt tunera pojazdów.
]]--

--==================--  --==================--  --==================--

local tuner = {}
local screenW, screenH = guiGetScreenSize()
tuner.okno = guiCreateWindow(screenW - 622 - 10, (screenH - 715) / 2, 622, 715, "Panel tunera", false)
guiWindowSetSizable(tuner.okno, false)
tuner.listakomp = guiCreateGridList(15, 69, 590, 516, false, tuner.okno)
guiGridListAddColumn(tuner.listakomp, "Nazwa częsci", 0.7)
guiGridListAddColumn(tuner.listakomp, "Koszt", 0.25)
tuner.doli_input = guiCreateEdit(15, 595, 128, 42, "1", false, tuner.okno)
tuner.doli_info_desc = guiCreateLabel(157, 595, 125, 41, "% marży do ww. cen.", false, tuner.okno)
guiLabelSetVerticalAlign(tuner.doli_info_desc, "center")
--tuner.btn_zamontuj = guiCreateButton(16, 651, 207, 49, "Zamontuj", false, tuner.okno)
--tuner.btn_demontuj = guiCreateButton(233, 651, 207, 49, "Demontuj", false, tuner.okno)
tuner.btn_zamontuj = guiCreateButton(16, 651, 424, 49, "Wybierz element", false, tuner.okno)
tuner.btn_zamknij = guiCreateButton(450, 651, 155, 49, "Zamknij", false, tuner.okno)    
guiSetVisible(tuner.okno,false)
guiSetProperty(tuner.doli_input, "ValidationString", "^[0-9]*$")
guiEditSetMaxLength(tuner.doli_input, 2)

local kosztCzesci={
	[1025]=10000,
	[1073]=9000,
	[1074]=4500,
	[1075]=3600,
	[1076]=7500,
	[1077]=1000,--- ???
	[1078]=5000,
	[1079]=2500,
	[1080]=3200,
	[1081]=1200,
	[1082]=2450,
	[1083]=16000,
	[1084]=6700,
	[1085]=8500,
	[1096]=3200,
	[1097]=1500,
	[1098]=1900,
--  Stereo
	[1086]=300,
--  Spoilery
	[1000]=2000,
	[1001]=2500,
	[1002]=2000,
	[1003]=2500,
	[1014]=1400,
	[1015]=2000,
	[1016]=2100,
	[1023]=2400,
	[1049]=1540,
	[1050]=1300,
	[1058]=1300,
	[1060]=1750,
	[1138]=3900,
	[1139]=3400,
	[1146]=3000,
	[1147]=3550,
	[1158]=10000,
	[1162]=7500,
	[1163]=2000,
	[1164]=4500, 
--	Progi
	[1036]=1500,
	[1039]=2000,
	[1040]=1870,
	[1041]=2300,
	[1007]=1000,
	[1017]=1000,
	[1026]=1500,
	[1027]=2000,
	[1030]=1500,
	[1031]=2300,
	[1042]=1000,
	[1047]=1890,
	[1048]=1730,
	[1051]=2000,
	[1052]=1800,
	[1056]=1000,
	[1057]=1000,
	[1062]=1000,
	[1063]=1250,
	[1069]=1800,
	[1070]=1500,
	[1071]=1650,
	[1072]=1750,
	[1090]=1750,
	[1093]=1700,
	[1094]=1500,
	[1095]=1000,
	[1099]=1000,
	[1101]=1000,
	[1102]=700,
	[1106]=1000,
	[1107]=1000,
	[1108]=1000,
	[1118]=700,
	[1119]=700,
	[1120]=700,
	[1121]=700,
	[1122]=700,
	[1124]=700,
	[1133]=1000,
	[1134]=1000,
	[1137]=1000,
	
--  Bullbar . . ? [przod]
	[1100]=750,
	[1115]=750,
	[1116]=750,
	[1123]=750,
	[1125]=1000,
--  Bullbar . . ? [tył]
	[1109]=900,
	[1110]=300,
--	Front Sign [figurka itd z przodu]
	[1111]=650,
	[1112]=650,
--	Hydraulika
	[1087]=15100,
--  Wydechy
	[1034]=1900,
	[1037]=2000,
	[1044]=1800,
	[1046]=2000,
	[1018]=1700,
	[1019]=1900,
	[1020]=2000,
	[1021]=1800,
	[1022]=1800,
	[1028]=1900,
	[1029]=2000,
	[1043]=1500,
	[1044]=1000,
	[1045]=1500,
	[1059]=1500,
	[1064]=1200,
	[1065]=1300,
	[1066]=1500,
	[1089]=2000,
	[1092]=1750,
	[1104]=1650,
	[1105]=1450,
	[1113]=1200,
	[1114]=1750,
	[1126]=1000,
	[1127]=1100,
	[1129]=1000,
	[1132]=1500,
	[1135]=1000,
	[1136]=1500,
	
--  Zderzaki [tylni]
	[1149]=4000,
	[1148]=5000,
	[1150]=3000,
	[1151]=3500,
	[1154]=3000,
	[1156]=3000,
	[1159]=3500,
	[1161]=3600,
	[1167]=3000,
	[1168]=2500,
	[1175]=2500,
	[1177]=2500,
	[1178]=2900,
	[1180]=3100,
	[1183]=2700,
	[1184]=3000,
	[1186]=3000,
	[1187]=2600,
	[1192]=2000,
	[1193]=2000,
--  Zderzaki [pzrzód]
	[1171]=3500,
	[1172]=5000,
	[1140]=3500,
	[1141]=5000,
	[1117]=500,
	[1152]=3000,
	[1153]=3500,
	[1155]=3000,
	[1153]=3000,
	[1157]=3000,
	[1160]=4000,
	[1165]=4000,
	[1166]=3000,
	[1169]=3000,
	[1170]=3500,
	[1173]=3500,
	[1174]=2500,
	[1176]=2500,
	[1179]=3500,
	[1181]=2500,
	[1182]=2300,
	[1185]=3000,
	[1188]=3200,
	[1189]=2900,
	[1190]=2500,
	[1191]=2100,
--  Wloty [góra]
	[1035]=3000,
	[1038]=3500,
	[1006]=1960,
	[1032]=3000,
	[1033]=3500,
	[1053]=3500,
	[1054]=3000,
	[1055]=2000,
	[1061]=2000,
	[1068]=3250,
	[1067]=2750,
	[1088]=2300,
	[1091]=3000,
	[1103]=1500,
	[1128]=5000, -- DACH DO BLADE
	[1130]=5000, -- DACH DO SAVANNA
	[1131]=5000, -- DACH DO SAVANNA
--  Wloty [przód]
	[1004]=1400,
	[1005]=1600,
	[1011]=1400,
	[1012]=1600,
	[1142]=1200,
	[1143]=1200,
	[1144]=1000,
	[1145]=1000,
--	Dodatkowe lampy 
	[1013]=700,
	[1024]=800,
	
--  Dodatki układy others
	[1]=12000,
	[2]=20000,
	[3]=27000,
	[4]=29000,
	[5]=20000,
	[6]=22000,
	[7]=22000,
	[8]=15000,
	[9]=15000,

}

local nazwaCzesci={
--  butle
	[1008]="Atrapa nitra (W)",
	[1009]="Atrapa nitra",
	[1010]="Atrapa nitra (double)",
--  fele
	[1025]="Felgi: Offroad",
	[1073]="Felgi: Shadow",
	[1074]="Felgi: Mega",
	[1075]="Felgi: Rimshine",
	[1076]="Felgi: Wires",
	[1077]="Felgi: Classic",--- ???
	[1078]="Felgi: Twist",
	[1079]="Felgi: Cutter",
	[1080]="Felgi: Switch",
	[1081]="Felgi: Grove",
	[1082]="Felgi: Import",
	[1083]="Felgi: Dollar",
	[1084]="Felgi: Trance",
	[1085]="Felgi: Atomic",
	[1096]="Felgi: Ahab",
	[1097]="Felgi: Virtual",
	[1098]="Felgi: Access",
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
	
--  Bullbar przod
	[1100]="Chrome Grill",
	[1115]="Chrome",
	[1116]="Slamin",
	[1123]="Chrome",
	[1125]="Chrome Lights",
--  Bullbar tył
	[1109]="Chrome",
	[1110]="Slamin",
--	Front Sign figurka itd z przodu
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
	
--  Zderzaki tylni
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
--  Zderzaki pzrzód
	[1169]="Zderzak przód: Alien",
	[1170]="Zderzak przód: X-Flow",
	[1173]="Zderzak przód: X-Flow",
	[1117]="Zderzak przód: Chrome",
	[1152]="Zderzak przód: X-Flow",
	[1153]="Zderzak przód: Alien",
	[1155]="Zderzak przód: Alien",
	[1157]="Zderzak przód: X-Flow",
	[1160]="Zderzak przód: Alien",
--  Wloty góra
	[1128]="Wloty: Dach", -- DACH DO BLADE
	[1130]="Wloty: Dach", -- DACH DO SAVANNA
	[1131]="Wloty: Dach", -- DACH DO SAVANNA
	[1032]="Wloty: Alien",	
	[1033]="Wloty: X-Flow",	
	[1067]="Wloty: Alien",	
	[1068]="Wloty: X-Flow",	
--  Wloty przód
--	Dodatkowe lampy 
	[1013]="Lampa przeciw mgielne",
	[1024]="Lampa przeciw mgielne",

--  Dodatki układy others
	[1]="Układ MK1",
	[2]="Układ MK2",
	[3]="Układ MK3",
	[4]="STAGE #2",
	[5]="STAGE #1",
	[6]="Full carbon body",
	[7]="Heavyweight pack body",
	[8]="Sportowe zawieszenie",
	[9]="Standardowe zawieszenie",
}

local wykluczoneCzesci = {
	[1008]=true, -- nitro
	[1009]=true, -- nitro
	[1010]=true, -- nitro
	[1086]=true, -- stereo a po chuj to
}

local dostepneUklady = { -- spec table
	{1, "Układ MK1", 12000, "mk1"},
	{2, "Układ MK2", 20000, "mk2"},
	{3, "Układ MK3", 27000, "mk3"},
	{4, "STAGE #2", 29000, "su1"},
	{5, "STAGE #1", 20000, "su1"},
	{6, "Full carbon body", 22000, "su1"},
	{7, "Heavyweight pack body", 22000, "su1"},
	{8, "Sportowe zawieszenie", 15000, "su1"},
	{9, "Standardowe zawieszenie", 10000, "su1"},
}

local potwierdz = {}
potwierdz.okno = guiCreateWindow((screenW - 313) / 2, (screenH - 365) / 2, 313, 365, "", false)
guiWindowSetSizable(potwierdz.okno, false)
potwierdz.desc_info = guiCreateLabel(17, 38, 282, 117, "Nazwa elementu: ---\nCena: ---$", false, potwierdz.okno)
guiLabelSetHorizontalAlign(potwierdz.desc_info, "center", false)
guiLabelSetVerticalAlign(potwierdz.desc_info, "center")
potwierdz.btn_potwierdzam = guiCreateButton(17, 212, 282, 77, "Potwierdzam", false, potwierdz.okno)
potwierdz.btn_anuluj = guiCreateButton(17, 299, 282, 44, "Anuluj", false, potwierdz.okno)    
guiSetVisible(potwierdz.okno,false)

addEventHandler("onClientColShapeLeave", root, function(el,md)
    if not md or el~=localPlayer then return end
	local sproo = getElementData(source,"tuner") or false;
	if sproo then
		guiSetVisible(potwierdz.okno,false)
		showCursor(false,true)
	end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
	if not md or el~=localPlayer then return end
	local sprsource = getElementData(source,"tuner") or false;
	if sprsource then
		guiSetVisible(tuner.okno,false)
		showCursor(false,true)
		setElementData(localPlayer, "tune:car", false)
	end
end)


addEventHandler("onClientMarkerHit", resourceRoot, function(el,md)
    if not md or el~=localPlayer then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
	local sproo = getElementData(source,"tuner") or false;
	if sproo then
	
		local fid=getElementData(source, "m:duty")
		local lfid=getElementData(el, "player:duty") or -1;
		if fid~=lfid then return end -- gracz nie jest pracownikiem]]--
	
		local _,_,z = getElementPosition(source)
		local _,_,z2 = getElementPosition(el)
		if (z+3) > z2 and (z-3) < z2 then
			local cs = getElementData(source, "cs")
			if not cs then return end
			local pojazdy = getElementsWithinColShape(cs,"vehicle")
			if #pojazdy<1 then
				outputChatBox("Na stanowisku tunera nie ma żadnego pojazdu.")
				return
			end
			if #pojazdy>1 then
				outputChatBox("Na stanowisku tunera jest zbyt dużo pojazdów.")
				return
			end
			guiSetVisible(tuner.okno,true)
			
			
			local tuningowany_pojazd = pojazdy[1]
			guiGridListClear(tuner.listakomp) -- me
			
			setElementData(localPlayer, "tune:car", tuningowany_pojazd)
		
			
   		    for i=0, 16 do
				local row1 = guiGridListAddRow(tuner.listakomp)
--				guiGridListSetItemText(tuner.listakomp, row1, 1, tostring(getVehicleUpgradeSlotName(i)), true, false)
				if getVehicleUpgradeOnSlot(tuningowany_pojazd, i) ~= 0 then
					if not wykluczoneCzesci[getVehicleUpgradeOnSlot(tuningowany_pojazd, i)] then
						guiGridListSetItemText(tuner.listakomp, row1, 1, tostring(getVehicleUpgradeSlotName(i)), true, false)
						local row2 = guiGridListAddRow(tuner.listakomp)
						guiGridListSetItemText(tuner.listakomp, row2, 1, tostring("Demontaż: "..nazwaCzesci[getVehicleUpgradeOnSlot(tuningowany_pojazd,i)]), false, false)
						koszt = tonumber(kosztCzesci[getVehicleUpgradeOnSlot(tuningowany_pojazd,i)]) * 0.66; -- 66%
						guiGridListSetItemText(tuner.listakomp, row2, 2, tostring("+"..koszt.." $"), false, false)
						guiGridListSetItemColor(tuner.listakomp, row2, 1, 177, 0, 0)
						guiGridListSetItemColor(tuner.listakomp, row2, 2, 56, 142, 0 )
						guiGridListSetItemData(tuner.listakomp, row2, 1, tostring(getVehicleUpgradeOnSlot(tuningowany_pojazd,i))) -- id czesci na date
						guiGridListSetItemData(tuner.listakomp, row2, 2, "demont") -- id czesci na date
					end
				else
					for i2,v2 in ipairs(getVehicleCompatibleUpgrades(tuningowany_pojazd, i)) do
						if not wykluczoneCzesci[v2] then
							guiGridListSetItemText(tuner.listakomp, row1, 1, tostring(getVehicleUpgradeSlotName(i)), true, false)
							local row3 = guiGridListAddRow(tuner.listakomp)
							guiGridListSetItemText(tuner.listakomp, row3, 1, tostring(nazwaCzesci[v2]), false, false)
							guiGridListSetItemText(tuner.listakomp, row3, 2, tostring(kosztCzesci[v2].." $"), false, false)
							guiGridListSetItemColor(tuner.listakomp, row3, 1, 255, 255, 255)
							guiGridListSetItemData(tuner.listakomp, row3, 1, tostring(v2)) -- id czesci na date
							guiGridListSetItemData(tuner.listakomp, row3, 2, "motaz") -- id czesci na date
						end
					end
				end
			end
			
			-- tune others
			mk1 = getElementData(tuningowany_pojazd,"vehicle:mk1") or 0;
			mk2 = getElementData(tuningowany_pojazd,"vehicle:mk2") or 0;
			mk3 = getElementData(tuningowany_pojazd,"vehicle:mk3") or 0;
			su1 = getElementData(tuningowany_pojazd,"vehicle:su1") or 0;
			
			local row4 = guiGridListAddRow(tuner.listakomp)
			guiGridListSetItemText(tuner.listakomp, row4, 1, "Układy  tuningowe", true, false)
			for i3,v3 in ipairs(dostepneUklady) do
				local row5 = guiGridListAddRow(tuner.listakomp)
				if ( tonumber(mk1)==1 and tostring(v3[4])=="mk1" ) or ( tonumber(mk2)==1 and tostring(v3[4])=="mk2" ) or ( tonumber(mk3)==1 and tostring(v3[4])=="mk3" ) or ( tonumber(su1)==i3 and tostring(v3[4])=="su1" ) then 
					guiGridListSetItemText(tuner.listakomp, row5, 1, "Demontaż: "..v3[2], false, false)
					koszt = tonumber(v3[3]) * 0.66; -- 66%
					guiGridListSetItemText(tuner.listakomp, row5, 2, "+"..koszt.." $", false, false)
					guiGridListSetItemColor(tuner.listakomp, row5, 1, 177, 0, 0)
					guiGridListSetItemColor(tuner.listakomp, row5, 2, 56, 142, 0 )
					guiGridListSetItemData(tuner.listakomp, row5, 1, v3[1]) -- id czesci na date
					guiGridListSetItemData(tuner.listakomp, row5, 2, "demont") -- id czesci na date
				elseif ( tostring(v3[4])~="su1" or tonumber(su1)==0 ) then
					guiGridListSetItemText(tuner.listakomp, row5, 1, v3[2], false, false)
					guiGridListSetItemText(tuner.listakomp, row5, 2, v3[3].." $", false, false)
					guiGridListSetItemData(tuner.listakomp, row5, 1, v3[1]) -- id czesci na date
					guiGridListSetItemData(tuner.listakomp, row5, 2, "motaz") -- id czesci na date
				end
			end
			
			setTimer (function() -- 5s blokady dla stawiajacego
				showCursor(true,true)
			end, 100, 1)
		end
	end
end)


addEventHandler("onClientGUIChanged", root, function() 
    if source == tuner.doli_input then 
		local numer = tonumber(guiGetText(tuner.doli_input)) or 0;
		if numer > 50 then
			guiSetText(tuner.doli_input, 50)
		end
		if numer < 0 then
			guiSetText(tuner.doli_input, 0)
		end
	end
end)


function znajdzGracz(getID)
	local gracz = getElementsByType("player")
	for i,pp in pairs(gracz) do
		local plrid = getElementData(pp,"player:dbid") or 0;
		if tonumber(plrid) > 0 and tonumber(plrid) == tonumber(getID) then
			return pp
		end
	end
end


addEventHandler("onClientGUIClick", root, function()
    if source == tuner.listakomp then
        local slRow, slCol = guiGridListGetSelectedItem(tuner.listakomp)
        if not slRow or slCol ~= 1 then return end
		local DEMON = guiGridListGetItemData(tuner.listakomp, slRow, 2) or false;
		if DEMON ~= false then
			if tostring(DEMON) == "demont" then
				guiSetText(tuner.btn_zamontuj,"Demontuj element")
			else
				guiSetText(tuner.btn_zamontuj,"Montuj element")
			end
		end
	end

    if source == tuner.btn_zamontuj then
        local slRow, slCol = guiGridListGetSelectedItem(tuner.listakomp)
        if not slRow or slCol ~= 1 then return end
        local idELEMENTU = tonumber(guiGridListGetItemData(tuner.listakomp, slRow, 1)) or 0;
		local DEMON = guiGridListGetItemData(tuner.listakomp, slRow, 2) or false;
		local CAR = getElementData(localPlayer,"tune:car") or false;
		if not CAR then 
			outputChatBox("#841515✖#e7d9b0 Brak pojazdu na stanowisku.",231, 217, 176,true)
			return
		end
		local numer = tonumber(guiGetText(tuner.doli_input)) or 1;
		if tonumber(numer) > 50 or tonumber(numer) < 1 then return end
		
		local veh_id = getElementData(CAR,"vehicle:id") or 0;
		local veh_owner = getElementData(CAR,"vehicle:owner") or 0;
		local kiero = znajdzGracz(veh_owner);
		if not kiero then 
			outputChatBox("#841515✖#e7d9b0 Brak właściciela pojazdu.",231, 217, 176,true)
			return 
		end
		local vehicle = getPedOccupiedVehicle(kiero) or false
		if not vehicle then 
			outputChatBox("#841515✖#e7d9b0 Brak kierowcy w pojeździe.",231, 217, 176,true)
			return 
		end
		local kierodwa = getVehicleController(CAR) or false;
		if not kierodwa then 
			outputChatBox("#841515✖#e7d9b0 Brak kierowcy w pojeździe.",231, 217, 176,true)
			return 
		end
		if vehicle ~= CAR then 
			outputChatBox("#841515✖#e7d9b0 Wystąpił błąd pojazdu na stanowisku.",231, 217, 176,true)
			return 
		end
		local vehicleHealth = getElementHealth(CAR) / 10; -- def to 100 wiec przez 10 abyd ostac setke
		if vehicleHealth ~= 100 then 
			outputChatBox("#841515✖#e7d9b0 Pojazd jest za bardzo uszkodzony.",231, 217, 176,true)
			return 
		end
		local kiero_uid = getElementData(kiero,"player:dbid") or 0;
		local owner_plrid = getElementData(localPlayer,"player:dbid") or 0;
		if tonumber(veh_owner) == tonumber(owner_plrid) then
			outputChatBox("#841515✖#e7d9b0 Nie możesz tuningować prywatnych pojazdów.",231, 217, 176,true)
			return 
		end
		if tonumber(kiero_uid) == tonumber(veh_owner) then
		local numer = numer * 0.01;
		if DEMON ~= false then
			if tostring(DEMON) == "demont" then
				koszt = kosztCzesci[tonumber(idELEMENTU)]; --  * (1 + numer)
				koszt = koszt * 100;
				koszt = koszt * 0.66; -- 66%
				nazwa = nazwaCzesci[tonumber(idELEMENTU)];
				koszt_tuner = kosztCzesci[tonumber(idELEMENTU)] * numer;
				koszt_tuner = koszt_tuner * 100;
--				outputChatBox("Demontuje "..nazwa..": ("..koszt.." / "..koszt_tuner..") "..idELEMENTU.." CAR ID: "..veh_id)
				local typ = "demont";
				
				triggerServerEvent("potwierdzenieTune",root,kiero,typ,nazwa,koszt,koszt_tuner)
				
				setElementData(kiero,"tuneacc:plr",localPlayer)
				setElementData(kiero,"tuneacc:target",kiero)
				setElementData(kiero,"tuneacc:CAR",CAR)
				setElementData(kiero,"tuneacc:typ",typ)
				setElementData(kiero,"tuneacc:nazwa",nazwa)
				setElementData(kiero,"tuneacc:koszt",koszt)
				setElementData(kiero,"tuneacc:koszt_tuner",koszt_tuner)
				setElementData(kiero,"tuneacc:idELEMENTU",idELEMENTU)
						
--				local typ = "demont";
--				triggerServerEvent("nadajTune",localPlayer,localPlayer,kiero,CAR,typ,nazwa,koszt,koszt_tuner,idELEMENTU)
			else
				koszt = kosztCzesci[tonumber(idELEMENTU)] * (1 + numer);
				koszt = koszt * 100;
				nazwa = nazwaCzesci[tonumber(idELEMENTU)];
				koszt_tuner = kosztCzesci[tonumber(idELEMENTU)] * numer;
				koszt_tuner = koszt_tuner * 100;
--				outputChatBox("Montuje "..nazwa..": ("..koszt.." / "..koszt_tuner..") "..idELEMENTU.." CAR ID: "..veh_id)
				local typ = "tuning";
				
				triggerServerEvent("potwierdzenieTune",root,kiero,typ,nazwa,koszt,koszt_tuner)
				
				setElementData(kiero,"tuneacc:plr",localPlayer)
				setElementData(kiero,"tuneacc:target",kiero)
				setElementData(kiero,"tuneacc:CAR",CAR)
				setElementData(kiero,"tuneacc:typ",typ)
				setElementData(kiero,"tuneacc:nazwa",nazwa)
				setElementData(kiero,"tuneacc:koszt",koszt)
				setElementData(kiero,"tuneacc:koszt_tuner",koszt_tuner)
				setElementData(kiero,"tuneacc:idELEMENTU",idELEMENTU)
				
--				local typ = "tuning";
--				triggerServerEvent("nadajTune",localPlayer,localPlayer,kiero,CAR,typ,nazwa,koszt,koszt_tuner,idELEMENTU)
			end
		end
		
		end
	end
	
    if source == tuner.btn_zamknij then
	    guiSetVisible(tuner.okno,false)
		showCursor(false)
	end
	
	if source == potwierdz.btn_potwierdzam then
		local plr = getElementData(localPlayer,"tuneacc:plr") or false;
		local target = getElementData(localPlayer,"tuneacc:target") or false;
		local CAR = getElementData(localPlayer,"tuneacc:CAR") or false;
		local typ = getElementData(localPlayer,"tuneacc:typ") or false;
		local nazwa = getElementData(localPlayer,"tuneacc:nazwa") or false;
		local koszt = getElementData(localPlayer,"tuneacc:koszt") or false;
		local koszt_tuner = getElementData(localPlayer,"tuneacc:koszt_tuner") or false;
		local idELEMENTU = getElementData(localPlayer,"tuneacc:idELEMENTU") or false;
		triggerServerEvent("nadajTune",root,plr,target,CAR,typ,nazwa,koszt,koszt_tuner,idELEMENTU)
	    guiSetVisible(potwierdz.okno,false)
		showCursor(false)
	end
	
    if source == potwierdz.btn_anuluj then
	    guiSetVisible(potwierdz.okno,false)
		showCursor(false)
	end
end)


addEvent("pokazIntoTunne", true)
addEventHandler("pokazIntoTunne", root, function(target,typ,nazwa,koszt,koszt_tuner)
	if localPlayer == target then
	    guiSetVisible(potwierdz.okno,true)
		showCursor(true)
		
		if tostring(typ) == "demont" then
--		local koszt_tuner = koszt_tuner * 100;
--		local koszt = koszt * 100;
		local spr = tonumber(koszt) - tonumber(koszt_tuner);
		local moneyee = string.format("%.2f", spr/100)
			guiSetText(potwierdz.desc_info, "Nazwa elementu: "..nazwa.."\nCena demontażu: "..moneyee.."$")
		end
		if tostring(typ) == "tuning" then
--		local koszt_tuner = koszt_tuner * 100;
--		local koszt = koszt * 100;
		local spr = tonumber(koszt) + tonumber(koszt_tuner);
		local moneyee = string.format("%.2f", spr/100)
			guiSetText(potwierdz.desc_info, "Nazwa elementu: "..nazwa.."\nCena montażu: "..moneyee.."$")
		end
	end
--	outputChatBox("Demontuje "..nazwa..": ("..koszt.." / "..koszt_tuner..") "..idELEMENTU)
end)












