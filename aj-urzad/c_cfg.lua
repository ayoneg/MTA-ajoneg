--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Uniwersalny skrypt urzędów.
]]--
local screenW, screenH = guiGetScreenSize()

local egzaminy = {}
egzaminy.okno = guiCreateWindow((screenW - 892) / 2, (screenH - 502) / 2, 892, 502, "Egzaminy  teorytyczne", false)
guiWindowSetSizable(egzaminy.okno, false)
egzaminy.lista = guiCreateGridList(42, 44, 806, 374, false, egzaminy.okno)
guiGridListAddColumn(egzaminy.lista, "Nazwa", 0.70)
guiGridListAddColumn(egzaminy.lista, "Koszt", 0.20)
--guiGridListAddColumn(egzaminy.lista, "Posiadane", 0.3)
egzaminy.select_btn = guiCreateButton(42, 428, 352, 47, "Wybierz egzamin z listy", false, egzaminy.okno)
egzaminy.exit_btn = guiCreateButton(496, 428, 352, 47, "Zamknij", false, egzaminy.okno)    
guiSetVisible(egzaminy.okno, false);
guiGridListSetSortingEnabled(egzaminy.lista, false)	

local egzamin = {}
egzamin.okno = guiCreateWindow((screenW - 598) / 2, (screenH - 339) / 2, 598, 339, "EGZAMIN  URZĘDOWY  [1/10]", false)
guiWindowSetMovable(egzamin.okno, false)
guiWindowSetSizable(egzamin.okno, false)
egzamin.trescpytania = guiCreateMemo(30, 47, 539, 66, "Pytanie: --", false, egzamin.okno)
egzamin.btnA = guiCreateButton(30, 149, 254, 62, "A) --", false, egzamin.okno)
egzamin.btnB = guiCreateButton(315, 149, 254, 62, "B) --", false, egzamin.okno)
egzamin.btnC = guiCreateButton(30, 242, 254, 62, "C) --", false, egzamin.okno)
egzamin.btnD = guiCreateButton(315, 242, 254, 62, "D) --", false, egzamin.okno)    
guiSetVisible(egzamin.okno, false);
guiMemoSetReadOnly(egzamin.trescpytania, true)

addEvent("startEgzaminUM", true)
addEventHandler("startEgzaminUM", root, function(plr, tresc, odpA, odpB, odpC, odpD, id, exid)
	if plr == localPlayer then
		if exid>=2 then
			id = id%10;
			if id == 0 then id = 10; end
		end
		guiSetText(egzamin.okno,"EGZAMIN  URZĘDOWY  ["..id.."/10]")
		guiSetText(egzamin.trescpytania,"Pytanie: "..tresc)
		guiSetText(egzamin.btnA,"A) "..odpA)
		guiSetText(egzamin.btnB,"B) "..odpB)
		guiSetText(egzamin.btnC,"C) "..odpC)
		guiSetText(egzamin.btnD,"D) "..odpD)
		showCursor(true);
		guiSetVisible(egzamin.okno, true);
		guiSetVisible(egzaminy.okno, false);
	end
end)

addEvent("zamknijEgzaminNOW", true)
addEventHandler("zamknijEgzaminNOW", root, function(plr)
	if plr == localPlayer then
		if guiGetVisible(egzaminy.okno) == true then showCursor(false); guiSetVisible(egzaminy.okno, false); end
		if guiGetVisible(egzamin.okno) == true then showCursor(false); guiSetVisible(egzamin.okno, false); end
	end
end)

addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == egzaminy.lista then
    	local slRow, slCol = guiGridListGetSelectedItem(egzaminy.lista)
    	if not slRow or slCol ~= 1 then return end
		guiSetText(egzaminy.select_btn, "Rozpocznij egzamin")
	end

	if source == egzaminy.select_btn then
		local selectedRow = guiGridListGetSelectedItem(egzaminy.lista);
		if selectedRow < 0 then return end
		local value = guiGridListGetItemData(egzaminy.lista, selectedRow, 1)
		local cost = tonumber(guiGridListGetItemData(egzaminy.lista, selectedRow, 2))
		triggerServerEvent("sprawdzEgzaminyZacznij", root, value, cost, localPlayer)
    end
	-- egzaminy ABCD
	if source == egzamin.btnA then
		-- #1
		triggerServerEvent("udzielonaODPsprSERW", root, 1, localPlayer)
	end
	if source == egzamin.btnB then
		-- #2
		triggerServerEvent("udzielonaODPsprSERW", root, 2, localPlayer)
	end
	if source == egzamin.btnC then
		-- #3
		triggerServerEvent("udzielonaODPsprSERW", root, 3, localPlayer)
	end
	if source == egzamin.btnD then
		-- #4
		triggerServerEvent("udzielonaODPsprSERW", root, 4, localPlayer)
	end
	
    if source == egzaminy.exit_btn then
    	if guiGetVisible(egzaminy.okno) == true then showCursor(false); guiSetVisible(egzaminy.okno, false); end
    end
end)

addEvent("pokazEgzaminyUM", true)
addEventHandler("pokazEgzaminyUM", root, function(result)
	guiGridListClear(egzaminy.lista)
	for i,eg in pairs(result) do
		local row=guiGridListAddRow(egzaminy.lista);
		guiGridListSetItemText(egzaminy.lista, row, 1, eg.egzamin_name, false, false);
		guiGridListSetItemData(egzaminy.lista, row, 1, eg.egzamin_id)
		local cost = string.format("%.2f", eg.egzamin_cost/100)
		guiGridListSetItemText(egzaminy.lista, row, 2, cost.."$", false, false);
		guiGridListSetItemData(egzaminy.lista, row, 2, eg.egzamin_cost)
--		guiGridListSetItemText(egzaminy.lista, row, 3, "-", false, false);
	end
end)

addEventHandler("onClientMarkerHit", root, function(el,md)
	if not md then return end
    if el ~= localPlayer then return end
    if not guiGetVisible(egzaminy.okno) then
		local coDD = getElementData(source,"um:egzaminy") or false;
		if coDD then
			showCursor(true);
			guiSetVisible(egzaminy.okno, true);
			triggerServerEvent("wyslijZapytanieOEGZAMINY", root, el);
		end
    end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
    if el ~= localPlayer then return end
    if guiGetVisible(egzaminy.okno) then
		local coDD = getElementData(source,"um:egzaminy") or false;
		if coDD then
			showCursor(false);
			guiSetVisible(egzaminy.okno, false);
		end
    end
end)


---------------------------------------------

local lista={}
local cena_zmiany = 147500; -- cena tablicy
	
lista.okno=guiCreateWindow(0.35, 0.22, 0.30, 0.45, "Tabela pojazdów", true);
guiWindowSetSizable(lista.okno, false);
guiWindowSetMovable(lista.okno, false);
lista.nowalista_veh=guiCreateGridList(0.03, 0.09, 0.93, 0.55, true, lista.okno);
guiGridListAddColumn(lista.nowalista_veh, "ID", 0.2);
guiGridListAddColumn(lista.nowalista_veh, "Pojazd", 0.44);
guiGridListAddColumn(lista.nowalista_veh, "Aktualna tablica", 0.32);
lista.descinfo=guiCreateLabel(0.10, 0.67, 0.8, 0.11, "Upewnij się, że nie popełniłeś błędów w nowej tablicy. \nCzynności nie da się cofnąć!", true, lista.okno);
lista.edit=guiCreateEdit(0.03, 0.77, 0.46, 0.11, "", true, lista.okno);
local money = string.format("%.2f", cena_zmiany/100)
lista.submit=guiCreateButton(0.51, 0.77, 0.46, 0.11, "Zmień tablicę: "..money.."$", true, lista.okno);
lista.anuluj=guiCreateButton(0.03, 0.90, 0.94, 0.11, "Zamknij", true, lista.okno);
guiSetVisible(lista.okno, false);
guiGridListSetSortingEnabled(lista.nowalista_veh, false)	


addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == lista.submit then
		local selectedRow = guiGridListGetSelectedItem(lista.nowalista_veh);
		local nowa_tablica = guiGetText(lista.edit);
		
		if selectedRow < 0 then return end
		if string.len(nowa_tablica) < 0 then outputChatBox("* Tablica powinna zawierać minimalnie 1 znak!", 255, 0, 0); return end
		if string.len(nowa_tablica) > 8 then outputChatBox("* Tablica powinna zawierać maksymalnie 8 znaków!", 255, 0, 0); return end
		--// potem jeszcze sprawdzimy czy ma tyle SiAnA w BAZIE
		if cena_zmiany > getPlayerMoney(localPlayer) then outputChatBox("* Nie posiadasz przy sobie tyle gotówki!", 255, 0, 0); return end
		
		local veh_id= tostring(guiGridListGetItemText(lista.nowalista_veh, selectedRow, 1));
		local veh_modelname = tostring(guiGridListGetItemText(lista.nowalista_veh, selectedRow, 2));
		triggerServerEvent("onClientRenderNew", root, veh_id, nowa_tablica, cena_zmiany)
    end
    if source == lista.anuluj then
    	if guiGetVisible(lista.okno) == true then showCursor(false); guiSetVisible(lista.okno, false); end
    end
end)

addEvent("onClientReturn", true)
addEventHandler("onClientReturn", root, function(result)
	guiGridListClear(lista.nowalista_veh)
	for i,veh in pairs(result) do
		local row=guiGridListAddRow(lista.nowalista_veh);
		guiGridListSetItemText(lista.nowalista_veh, row, 1, veh.veh_id, false, false);
		guiGridListSetItemText(lista.nowalista_veh, row, 2, getVehicleNameFromModel(veh.veh_modelid), false, false);
		guiGridListSetItemText(lista.nowalista_veh, row, 3, veh.veh_tablica, false, false);
	end
end)

addEventHandler("onClientMarkerHit", root, function(el,md)
	if not md then return end
    if el ~= localPlayer then return end
    if not guiGetVisible(lista.nowalista_veh) then
		local coDD = getElementData(source,"um:tablice") or false;
		if coDD then
			showCursor(true);
			guiSetVisible(lista.okno, true);
			triggerServerEvent("onClientReturnEnd", root, el);
		end
    end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
    if el ~= localPlayer then return end
    if guiGetVisible(lista.nowalista_veh) then
		local coDD = getElementData(source,"um:tablice") or false;
		if coDD then
			showCursor(false);
			guiSetVisible(lista.okno, false);
		end
    end
end)
	
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- poj org
local okn = {}
okn.panel = guiCreateWindow(0.28, 0.30, 0.44, 0.39, "Panel pojazdów organizacji", true)
guiWindowSetSizable(okn.panel, false)

okn.panellista = guiCreateGridList(0.02, 0.08, 0.60, 0.86, true, okn.panel)
guiGridListAddColumn(okn.panellista, "ID", 0.3)
guiGridListAddColumn(okn.panellista, "Pojazd", 0.3)
guiGridListAddColumn(okn.panellista, "Organizacja", 0.3)
okn.btn_przepisz = guiCreateButton(0.64, 0.08, 0.34, 0.15, "Przepisz na organizacje", true, okn.panel)
okn.btn_exit = guiCreateButton(0.64, 0.26, 0.34, 0.15, "Wyjdz", true, okn.panel)    
guiSetVisible(okn.panel, false);	
guiGridListSetSortingEnabled(okn.panellista, false)	

		
addEvent("pokazPojazdyOrg", true)
addEventHandler("pokazPojazdyOrg", root, function(result)
	guiGridListClear(okn.panellista)
	for i,veh in pairs(result) do
		local row=guiGridListAddRow(okn.panellista);
		guiGridListSetItemText(okn.panellista, row, 1, veh.veh_id, false, false);
		guiGridListSetItemText(okn.panellista, row, 2, getVehicleNameFromModel(veh.veh_modelid), false, false);
		if veh.veh_groupowner > 0 then 
			text="na organizacji"; 
			value=1
		else 
			text="-"; 
			value=0
		end
		guiGridListSetItemText(okn.panellista, row, 3, text, false, false);
		guiGridListSetItemData(okn.panellista, row, 3, value)
	end
end)
		
addEventHandler("onClientMarkerHit", root, function(el,md)
	if not md then return end
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	local coDD = getElementData(source,"um:vehsorg") or false;
	if coDD then
		local plrorg = getElementData(el,"player:orgID") or 0;
		if plrorg > 0 then
			guiSetVisible(okn.panel, true);
			showCursor(true);
			triggerServerEvent("wyslijZapytanieOPojazdy", root, el);
		end
	end
end)

addEventHandler("onClientGUIClick", root, function(btn,state)	
	if source == okn.panellista then
    	local slRow, slCol = guiGridListGetSelectedItem(okn.panellista)
    	if not slRow or slCol ~= 1 then return end
		local value = guiGridListGetItemData(okn.panellista, slRow, 3)
		if value == 1 then
			guiSetText(okn.btn_przepisz, "Odpisz pojazd")
		else
			guiSetText(okn.btn_przepisz, "Przepisz pojazd")
		end
	end
	if source == okn.btn_przepisz then
    	local slRow, slCol = guiGridListGetSelectedItem(okn.panellista)
    	if not slRow or slCol ~= 1 then return end
    	local car_id = guiGridListGetItemText(okn.panellista, slRow, 1)
    	if not car_id then return end
		local value = guiGridListGetItemData(okn.panellista, slRow, 3)
		triggerServerEvent("przepiszPojNaORG", root, car_id, value, localPlayer)
	end
    if source == okn.btn_exit then
		guiSetVisible(okn.panel, false);
		showCursor(false);
	end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
	if el~=localPlayer then return end
	local coDD = getElementData(source,"um:vehsorg") or false;
	if coDD then
		guiSetVisible(okn.panel, false);
		showCursor(false);
	end
end)


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

organizacja = {}		

organizacja.panel = guiCreateWindow(0.17, 0.17, 0.66, 0.65, "Panel organizacji", true)
        guiWindowSetMovable(organizacja.panel, true) -- true
        guiWindowSetSizable(organizacja.panel, false)

        organizacja.tabpanel = guiCreateTabPanel(0.01, 0.11, 0.98, 0.77, true, organizacja.panel)

        organizacja.tab_1 = guiCreateTab("Regulamin", organizacja.tabpanel)

        organizacja.regulamin = guiCreateMemo(0.02, 0.18, 0.45, 0.76, "cos tutaj napisze kiedys ...", true, organizacja.tab_1)
        guiMemoSetReadOnly(organizacja.regulamin, true)
        organizacja.informacje = guiCreateMemo(0.53, 0.18, 0.45, 0.76, "Co otrzymują gracze będący w organizacji?\n\n* czat organizacyjny w grze,\n* panel członków pod klawiszem F5,\n* własny system zarządzania organizacją,\n* oraz wiele innych!\n\n\nAby stworzyć organizacje, musisz spełnić poniższe wymagania:\n\n* rozegrane 50 godzin na serwerze,\n* 10 tysięcy dolarów gotówki,\n* conajmniej 3 aktywne osoby.\n\n\nAby dołączyć do organizacji, musisz spełnić poniższe wymagania:\n\n* rozegrane 30 godzin na serwerze.", true, organizacja.tab_1)
        guiMemoSetReadOnly(organizacja.informacje, true)
        organizacja.regulamin_org_desc = guiCreateLabel(0.03, 0.12, 0.23, 0.04, "Regulamin organizacji:", true, organizacja.tab_1)
        guiSetFont(organizacja.regulamin_org_desc, "default-bold-small")
        guiLabelSetVerticalAlign(organizacja.regulamin_org_desc, "center")
        organizacja.informacje_org_desc = guiCreateLabel(0.54, 0.12, 0.23, 0.04, "Informacje:", true, organizacja.tab_1)
        guiSetFont(organizacja.informacje_org_desc, "default-bold-small")
        guiLabelSetVerticalAlign(organizacja.informacje_org_desc, "center")

        organizacja.tab_2 = guiCreateTab("Lista organizacji", organizacja.tabpanel)

        organizacja.grindlist = guiCreateGridList(0.02, 0.05, 0.96, 0.90, true, organizacja.tab_2)
        guiGridListAddColumn(organizacja.grindlist, "Nazwa", 0.2)
        guiGridListAddColumn(organizacja.grindlist, "Skrót", 0.1)
		guiGridListAddColumn(organizacja.grindlist, "Strona / Discord", 0.35)
		guiGridListAddColumn(organizacja.grindlist, "Data rejestracji", 0.2)
        guiGridListAddColumn(organizacja.grindlist, "Członkowie", 0.1)

        organizacja.tab_3 = guiCreateTab("Rejestracja organizacji", organizacja.tabpanel)

        organizacja.nazwa_org = guiCreateEdit(0.26, 0.18, 0.29, 0.08, "", true, organizacja.tab_3) -- 1111
        guiEditSetMaxLength(organizacja.nazwa_org, 30)
        organizacja.nazwa_org_desc = guiCreateLabel(0.08, 0.18, 0.17, 0.08, "Nazwa organizacji:", true, organizacja.tab_3)
        guiLabelSetHorizontalAlign(organizacja.nazwa_org_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.nazwa_org_desc, "center")
        organizacja.skrot_org_desc = guiCreateLabel(0.55, 0.18, 0.17, 0.08, "Skrót organizacji:", true, organizacja.tab_3)
        guiLabelSetHorizontalAlign(organizacja.skrot_org_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.skrot_org_desc, "center")
        organizacja.skrot_org = guiCreateEdit(0.72, 0.18, 0.16, 0.08, "", true, organizacja.tab_3) --edit 1
        guiEditSetMaxLength(organizacja.skrot_org, 4)
        organizacja.link_strony_desc = guiCreateLabel(0.08, 0.31, 0.17, 0.08, "Strona / Discord org.:", true, organizacja.tab_3)
        guiLabelSetHorizontalAlign(organizacja.link_strony_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.link_strony_desc, "center")
        organizacja.link_strony = guiCreateEdit(0.26, 0.31, 0.29, 0.08, "brak", true, organizacja.tab_3) --edit 2
        guiEditSetMaxLength(organizacja.link_strony, 200)
        organizacja.hex_color_desc = guiCreateLabel(0.55, 0.31, 0.17, 0.08, "Kolor (hex, podaj bez #):", true, organizacja.tab_3)
        guiLabelSetHorizontalAlign(organizacja.hex_color_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.hex_color_desc, "center")
        organizacja.hex_color = guiCreateEdit(0.72, 0.31, 0.16, 0.08, "787878", true, organizacja.tab_3)  --edit 2
        guiEditSetMaxLength(organizacja.hex_color, 6)
        organizacja.nazwy_rang_desc = guiCreateLabel(0.08, 0.44, 0.17, 0.08, "Nazwy rang:", true, organizacja.tab_3)
        guiLabelSetHorizontalAlign(organizacja.nazwy_rang_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.nazwy_rang_desc, "center")
        organizacja.lider_org = guiCreateEdit(0.26, 0.44, 0.14, 0.08, "Lider", true, organizacja.tab_3)  --edit 2
        guiEditSetMaxLength(organizacja.lider_org, 30)
        organizacja.vicelider_org = guiCreateEdit(0.41, 0.44, 0.14, 0.08, "Vice Lider", true, organizacja.tab_3)  --edit 2
        guiEditSetMaxLength(organizacja.vicelider_org, 30)
        organizacja.czlonek_org = guiCreateEdit(0.56, 0.44, 0.15, 0.08, "Członek", true, organizacja.tab_3)  --edit 2
        guiEditSetMaxLength(organizacja.czlonek_org, 30)
        organizacja.rekrut_org = guiCreateEdit(0.72, 0.44, 0.16, 0.08, "Nowy", true, organizacja.tab_3)  --edit 2
        guiEditSetMaxLength(organizacja.rekrut_org, 30)
        organizacja.opis_org = guiCreateMemo(0.08, 0.56, 0.80, 0.19, "Opis organizacji...", true, organizacja.tab_3)  --edit 2
        organizacja.koszt_zalozenia_desc = guiCreateLabel(0.09, 0.82, 0.17, 0.13, "Kosz założenia organizacji: 10000$", true, organizacja.tab_3)
        guiSetFont(organizacja.koszt_zalozenia_desc, "default-bold-small")
        guiLabelSetColor(organizacja.koszt_zalozenia_desc, 28, 143, 5)
        guiLabelSetVerticalAlign(organizacja.koszt_zalozenia_desc, "center")
        organizacja.rejestracja_org = guiCreateButton(0.62, 0.82, 0.26, 0.13, "Rejestracja", true, organizacja.tab_3)
		organizacja.zgoda_regulamin = guiCreateCheckBox(0.08, 0.77, 0.47, 0.05, "Zapoznałem/am się z regulaminem organizacji oraz w pełni się z nim zgadzam.", false, true, organizacja.tab_3)
		
        organizacja.tab_4 = guiCreateTab("Edycja organizacji", organizacja.tabpanel)
		
        organizacja.nazwa_org2 = guiCreateEdit(0.26, 0.18, 0.29, 0.08, "", true, organizacja.tab_4) -- 1111
        guiEditSetMaxLength(organizacja.nazwa_org2, 30)
        organizacja.nazwa_org_desc = guiCreateLabel(0.08, 0.18, 0.17, 0.08, "Nazwa organizacji:", true, organizacja.tab_4)
        guiLabelSetHorizontalAlign(organizacja.nazwa_org_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.nazwa_org_desc, "center")
        organizacja.skrot_org_desc = guiCreateLabel(0.55, 0.18, 0.17, 0.08, "Skrót organizacji:", true, organizacja.tab_4)
        guiLabelSetHorizontalAlign(organizacja.skrot_org_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.skrot_org_desc, "center")
        organizacja.skrot_org2 = guiCreateEdit(0.72, 0.18, 0.16, 0.08, "", true, organizacja.tab_4) --edit 1
        guiEditSetMaxLength(organizacja.skrot_org2, 4)
        organizacja.link_strony_desc = guiCreateLabel(0.08, 0.31, 0.17, 0.08, "Strona / Discord org.:", true, organizacja.tab_4)
        guiLabelSetHorizontalAlign(organizacja.link_strony_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.link_strony_desc, "center")
        organizacja.link_strony2 = guiCreateEdit(0.26, 0.31, 0.29, 0.08, "brak", true, organizacja.tab_4) --edit 2
        guiEditSetMaxLength(organizacja.link_strony2, 200)
        organizacja.hex_color_desc = guiCreateLabel(0.55, 0.31, 0.17, 0.08, "Kolor (hex, podaj bez #):", true, organizacja.tab_4)
        guiLabelSetHorizontalAlign(organizacja.hex_color_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.hex_color_desc, "center")
        organizacja.hex_color2 = guiCreateEdit(0.72, 0.31, 0.16, 0.08, "787878", true, organizacja.tab_4)  --edit 2
        guiEditSetMaxLength(organizacja.hex_color2, 6)
        organizacja.nazwy_rang_desc = guiCreateLabel(0.08, 0.44, 0.17, 0.08, "Nazwy rang:", true, organizacja.tab_4)
        guiLabelSetHorizontalAlign(organizacja.nazwy_rang_desc, "center", false)
        guiLabelSetVerticalAlign(organizacja.nazwy_rang_desc, "center")
        organizacja.lider_org2 = guiCreateEdit(0.26, 0.44, 0.14, 0.08, "Lider", true, organizacja.tab_4)  --edit 2
        guiEditSetMaxLength(organizacja.lider_org2, 30)
        organizacja.vicelider_org2 = guiCreateEdit(0.41, 0.44, 0.14, 0.08, "Vice Lider", true, organizacja.tab_4)  --edit 2
        guiEditSetMaxLength(organizacja.vicelider_org2, 30)
        organizacja.czlonek_org2 = guiCreateEdit(0.56, 0.44, 0.15, 0.08, "Członek", true, organizacja.tab_4)  --edit 2
        guiEditSetMaxLength(organizacja.czlonek_org2, 30)
        organizacja.rekrut_org2 = guiCreateEdit(0.72, 0.44, 0.16, 0.08, "Nowy", true, organizacja.tab_4)  --edit 2
        guiEditSetMaxLength(organizacja.rekrut_org2, 30)
        organizacja.opis_org2 = guiCreateMemo(0.08, 0.56, 0.80, 0.19, "Opis organizacji...", true, organizacja.tab_4)  --edit 2
        organizacja.koszt_zalozenia_desc = guiCreateLabel(0.09, 0.82, 0.17, 0.13, "Koszt edycji organizacji: 5000$", true, organizacja.tab_4)
        guiSetFont(organizacja.koszt_zalozenia_desc, "default-bold-small")
        guiLabelSetColor(organizacja.koszt_zalozenia_desc, 28, 143, 5)
        guiLabelSetVerticalAlign(organizacja.koszt_zalozenia_desc, "center")
        organizacja.edycja_org = guiCreateButton(0.62, 0.82, 0.26, 0.13, "Edytuj organizacje", true, organizacja.tab_4)
		organizacja.zgoda_regulamin2 = guiCreateCheckBox(0.08, 0.77, 0.47, 0.05, "Zapoznałem/am się z regulaminem organizacji oraz w pełni się z nim zgadzam.", false, true, organizacja.tab_4)

        organizacja.exit_button = guiCreateButton(0.69, 0.89, 0.30, 0.10, "Zamknij panel", true, organizacja.panel)
		
		guiSetVisible(organizacja.panel, false);		
	
addEventHandler("onClientGUIClick", root, function(btn,state)	
    if source == organizacja.edycja_org then
		-- odbieramy dane ze zgłoszenia
		local org_name = guiGetText(organizacja.nazwa_org2);
		local org_shortname = guiGetText(organizacja.skrot_org2);
--		local org_shortname = org_shortname:gsub('[%p%c%s]', '') -- code
		local org_pageurl = guiGetText(organizacja.link_strony2);
		local org_hexcolor = guiGetText(organizacja.hex_color2);
--		local org_hexcolor = org_hexcolor:gsub('[%p%c%s]', '') -- code
		
		local org_lidername = guiGetText(organizacja.lider_org2);
--		local org_lidername = org_lidername:gsub('[%p%c%s]', '') -- code
		local org_vicelidername = guiGetText(organizacja.vicelider_org2);
--		local org_vicelidername = org_vicelidername:gsub('[%p%c%s]', '') -- code
		local org_czlonek = guiGetText(organizacja.czlonek_org2);
--		local org_czlonek = org_czlonek:gsub('[%p%c%s]', '') -- code
		local org_rekrut = guiGetText(organizacja.rekrut_org2);
--		local org_rekrut = org_rekrut:gsub('[%p%c%s]', '') -- code`
		local org_desc = guiGetText(organizacja.opis_org2);
		
		local org_zgodaregulamin = guiCheckBoxGetSelected(organizacja.zgoda_regulamin2)
		
		local plr_money = getPlayerMoney();
		local plr_org = getElementData(localPlayer,"player:orgID") or 0;
		local plr_orgRank = getElementData(localPlayer,"player:orgRank") or 0;
		local cena_org = 5000 * 100; -- 5k (bo to edit)
		
		-- czas sprawdzić dane :)
		if plr_org == 0 then
			outputChatBox("* Aby edytować organizacje, musisz w niej być.",255,0,0)
			return
		end
		if plr_orgRank ~= 1 then
			outputChatBox("* Aby edytować organizacje, musisz być liderem.",255,0,0)
			return
		end
		if org_zgodaregulamin == false then
			outputChatBox("* Brak zgody na regulamin organizacji.",255,0,0)
			return
		end
		if string.len(org_name) < 5 then
			outputChatBox("* Nazwa organizacji, powinna składać się z minimalnie 5 znaków.",255,0,0)
			return
		end
		if string.len(org_shortname) < 2 then
			outputChatBox("* Skrót organizacji, powinien składać się z minimalnie 2 znaków.",255,0,0)
			return
		end
		if string.len(org_hexcolor) < 6 then
			outputChatBox("* Kod koloru, powinien posiadać minimalnie 6 znaków.",255,0,0)
			return
		end
		if string.len(org_lidername) < 1 then
			outputChatBox("* Nazwa rangi 'Lider', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_vicelidername) < 1 then
			outputChatBox("* Nazwa rangi 'Vice Lider', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_czlonek) < 1 then
			outputChatBox("* Nazwa rangi 'Członek', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_rekrut) < 1 then
			outputChatBox("* Nazwa rangi 'Nowy', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_desc) > 500 then
			outputChatBox("* Opis organizacji, powinien składać się z maksymalnie 500 znaków.",255,0,0)
			return
		end
		if tonumber(plr_money) < tonumber(cena_org) then
			outputChatBox("* Nie posiadasz wystarczającej kwoty przy sobie.",255,0,0)
			return
		end
		-- wysylamy na serwer
		triggerServerEvent("sprOrgCzNastepnaEdit", root, localPlayer, org_name, org_shortname, org_pageurl, org_hexcolor, org_lidername, org_vicelidername, org_czlonek, org_rekrut, org_desc, cena_org);
	end -----   -----   -----   -----   -----   -----   -----   -----   -----   -----   -----
    if source == organizacja.rejestracja_org then
		-- odbieramy dane ze zgłoszenia
		local org_name = guiGetText(organizacja.nazwa_org);
		local org_shortname = guiGetText(organizacja.skrot_org);
--		local org_shortname = org_shortname:gsub('[%p%c%s]', '') -- code
		local org_pageurl = guiGetText(organizacja.link_strony);
		local org_hexcolor = guiGetText(organizacja.hex_color);
--		local org_hexcolor = org_hexcolor:gsub('[%p%c%s]', '') -- code
		
		local org_lidername = guiGetText(organizacja.lider_org);
--		local org_lidername = org_lidername:gsub('[%p%c%s]', '') -- code
		local org_vicelidername = guiGetText(organizacja.vicelider_org);
--		local org_vicelidername = org_vicelidername:gsub('[%p%c%s]', '') -- code
		local org_czlonek = guiGetText(organizacja.czlonek_org);
--		local org_czlonek = org_czlonek:gsub('[%p%c%s]', '') -- code
		local org_rekrut = guiGetText(organizacja.rekrut_org);
--		local org_rekrut = org_rekrut:gsub('[%p%c%s]', '') -- code`
		local org_desc = guiGetText(organizacja.opis_org);
		
		local org_zgodaregulamin = guiCheckBoxGetSelected(organizacja.zgoda_regulamin)
		
		local plr_money = getPlayerMoney();
		local plr_org = getElementData(localPlayer,"player:orgID") or 0;
		local cena_org = 10000 * 100; -- 10k
--		outputDebugString(org_hexcolor)
		
		-- czas sprawdzić dane :)
		if plr_org ~= 0 then
			outputChatBox("* Aby założyć organizacje, musisz opuścić aktualną.",255,0,0)
			return
		end
		if org_zgodaregulamin == false then
			outputChatBox("* Brak zgody na regulamin organizacji.",255,0,0)
			return
		end
		if string.len(org_name) < 5 then
			outputChatBox("* Nazwa organizacji, powinna składać się z minimalnie 5 znaków.",255,0,0)
			return
		end
		if string.len(org_shortname) < 2 then
			outputChatBox("* Skrót organizacji, powinien składać się z minimalnie 2 znaków.",255,0,0)
			return
		end
		if string.len(org_pageurl) < 1 then
			outputChatBox("* Organizacja powinna posaia",255,0,0)
			return
		end
		if string.len(org_hexcolor) < 6 then
			outputChatBox("* Kod koloru, powinien posiadać minimalnie 6 znaków.",255,0,0)
			return
		end
		if string.len(org_lidername) < 1 then
			outputChatBox("* Nazwa rangi 'Lider', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_vicelidername) < 1 then
			outputChatBox("* Nazwa rangi 'Vice Lider', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_czlonek) < 1 then
			outputChatBox("* Nazwa rangi 'Członek', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_rekrut) < 1 then
			outputChatBox("* Nazwa rangi 'Nowy', powinna posiadać minimalnie 1 znak.",255,0,0)
			return
		end
		if string.len(org_desc) > 500 then
			outputChatBox("* Opis organizacji, powinien składać się z maksymalnie 500 znaków.",255,0,0)
			return
		end
		if tonumber(plr_money) < tonumber(cena_org) then
			outputChatBox("* Nie posiadasz wystarczającej kwoty przy sobie.",255,0,0)
			return
		end
		-- wysylamy na serwer
		triggerServerEvent("sprOrgCzNastepna", root, localPlayer, org_name, org_shortname, org_pageurl, org_hexcolor, org_lidername, org_vicelidername, org_czlonek, org_rekrut, org_desc, cena_org);
	end
    if source == organizacja.exit_button then
		guiSetVisible(organizacja.panel, false);
		showCursor(false);
	end
end)
	
addEventHandler("onClientMarkerHit", root, function(el,md)
	if not md then return end
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	local coDD = getElementData(source,"um:org") or false;
	if coDD then
	guiSetVisible(organizacja.panel, true);
	showCursor(true);
	
		local setORG = getElementData(localPlayer,"player:orgID") or 0;
		local rankORG = getElementData(localPlayer,"player:orgRank") or 0;
		if setORG > 0 and rankORG == 1 then guiSetEnabled(organizacja.tab_4, true); else guiSetEnabled(organizacja.tab_4, false); end
		if setORG > 0 then guiSetEnabled(organizacja.tab_3, false); else guiSetEnabled(organizacja.tab_3, true); end
	
		if setORG > 0 and rankORG == 1 then
			triggerServerEvent("daneOrgEdit", root, localPlayer, setORG);
			guiSetText(organizacja.nazwa_org2, getElementData(localPlayer,"player:orgNAME"))
			guiSetText(organizacja.skrot_org2, getElementData(localPlayer,"player:orgShortNAME"))
			
			addEvent("wyslinDaneOrgNow", true)
			addEventHandler("wyslinDaneOrgNow", root, function(org_pageurl, org_colorHEX, org_desc, org_lidername, org_vicelidername, org_czlonek, org_rekrut)

				guiSetText(organizacja.link_strony2, org_pageurl)
				guiSetText(organizacja.hex_color2, org_colorHEX)
				guiSetText(organizacja.opis_org2, org_desc)
		
				guiSetText(organizacja.lider_org2, org_lidername)
				guiSetText(organizacja.vicelider_org2, org_vicelidername)
				guiSetText(organizacja.czlonek_org2, org_czlonek)
				guiSetText(organizacja.rekrut_org2, org_rekrut)

			end)
		end
	
	triggerServerEvent("pokazListeOrg", root, el);
	end
end)

addEvent("pokazListeOdswiezonaORG", true)
addEventHandler("pokazListeOdswiezonaORG", root, function(result)
    guiGridListClear(organizacja.grindlist)
    for i,org in pairs(result) do
	local row=guiGridListAddRow(organizacja.grindlist);
	guiGridListSetItemText(organizacja.grindlist, row, 1, org.org_name, false, false);
	guiGridListSetItemText(organizacja.grindlist, row, 2, org.org_shortname, false, false);
	guiGridListSetItemText(organizacja.grindlist, row, 3, org.org_webpage, false, false); -- "https://discord.gg/"..
	guiGridListSetItemText(organizacja.grindlist, row, 4, org.org_createdata, false, false);
	guiGridListSetItemText(organizacja.grindlist, row, 5, org.org_czlonkowie, false, false);
    end
end)

addEventHandler("onClientMarkerLeave", root, function(el,md)
	if el~=localPlayer then return end
	local coDD = getElementData(source,"um:org") or false;
	if coDD then
		guiSetVisible(organizacja.panel, false);
		showCursor(false);
	end
end)
		
addEvent("zamknijPanelOrg", true)
addEventHandler("zamknijPanelOrg", root, function()
	guiSetVisible(organizacja.panel, false);
	showCursor(false);
end)	
		
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
praca = {}	
praca.okno = guiCreateWindow(0.29, 0.30, 0.42, 0.39, "Urząd pracy", true)
guiWindowSetMovable(praca.okno, false)
guiWindowSetSizable(praca.okno, false)
praca.gridlist = guiCreateGridList(0.02, 0.08, 0.97, 0.77, true, praca.okno)
guiGridListAddColumn(praca.gridlist, "Nazwa", 0.2)
guiGridListAddColumn(praca.gridlist, "Miejsca", 0.10)
guiGridListAddColumn(praca.gridlist, "Wym. PG / REP", 0.10)
--guiGridListAddColumn(praca.gridlist, "Wym. reputacja", 0.10)
guiGridListAddColumn(praca.gridlist, "Opis", 0.57)
praca.button_takejob = guiCreateButton(0.01, 0.88, 0.60, 0.10, "Wybierz z listy", true, praca.okno)
praca.button_exit = guiCreateButton(0.63, 0.88, 0.36, 0.10, "Wyjdź", true, praca.okno)
guiSetVisible(praca.okno, false);
guiGridListSetSortingEnabled(praca.gridlist, false)	

addEventHandler("onClientMarkerHit", root, function(el,md)
	if not md then return end
	if el~=localPlayer then return end
	if isPedInVehicle(el) then return end
	local coDD = getElementData(source,"um:joblist") or false;
	if coDD then
		guiSetVisible(praca.okno, true);
		showCursor(true);
		local jblcode = getElementData(source,"um:joblistCODE") or false;
		if jblcode then
			triggerServerEvent("odswiezJobs", root, el, jblcode);
		end
--		triggerServerEvent("sprTwojaJob", root, el);
	end
end)

addEvent("pokazNazweButton", true)
addEventHandler("pokazNazweButton", root, function(nambtn)
	guiSetText(praca.button_takejob, nambtn)
end)


addEvent("pokazListeOdswiezona", true)
addEventHandler("pokazListeOdswiezona", root, function(result)
    guiGridListClear(praca.gridlist)
    for i,v in pairs(result) do
	local row=guiGridListAddRow(praca.gridlist);
	guiGridListSetItemText(praca.gridlist, row, 1, v.job_name, false, false);
	guiGridListSetItemText(praca.gridlist, row, 2, v.job_activeslot.."/"..v.job_maxslot, false, false);
	guiGridListSetItemText(praca.gridlist, row, 3, v.job_wymPG.." / "..v.job_wymREP, false, false);
--	guiGridListSetItemText(praca.gridlist, row, 4, v.job_wymREP, false, false);
	guiGridListSetItemText(praca.gridlist, row, 4, v.job_desc, false, false);
	guiGridListSetItemData(praca.gridlist, row, 1, v.job_code)
    end
end)


addEventHandler("onClientMarkerLeave", root, function(el,md)
	if el~=localPlayer then return end
	local coDD = getElementData(source,"um:joblist") or false;
	if coDD then
		guiSetVisible(praca.okno, false);
		showCursor(false);
	end
end)

local czas_job = {}

addEventHandler("onClientGUIClick", root, function(btn,state)
    if source == praca.button_takejob then
--	local newtime = getTickCount() - czas_job[localPlayer]
	if czas_job[localPlayer] and getTickCount() < czas_job[localPlayer] then
	    outputChatBox("#e7d9b0* Zaczekaj #EBB85D15#e7d9b0 sekund!",255,255,255,true)
	    return 
	end
    local slRow, slCol = guiGridListGetSelectedItem(praca.gridlist)
    if not slRow or slCol ~= 1 then return end
    local code = guiGridListGetItemData(praca.gridlist, slRow, slCol)
	local job_name = guiGridListGetItemText(praca.gridlist, slRow, 1)
	triggerServerEvent("sprColesThere", root, localPlayer, code, job_name);
	czas_job[localPlayer] = getTickCount()+15000; -- 15 sek zabezpieczenia
	end
	
	if source == praca.gridlist then
    local slRow, slCol = guiGridListGetSelectedItem(praca.gridlist)
    if not slRow or slCol ~= 1 then return end
    local code = guiGridListGetItemData(praca.gridlist, slRow, slCol)
	triggerServerEvent("sprTwojaJob", root, localPlayer, code);
	end
	
    if source == praca.button_exit then
	guiSetVisible(praca.okno, false);
	showCursor(false);
	end
end)
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------