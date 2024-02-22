--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt organizacji.
]]--
----------------------------- PANEL ORG F5 CFG -----------------------------------
local panelorg = {}

panelorg.okno = guiCreateWindow(0.20, 0.19, 0.60, 0.62, "Panel organizacji", true)
        guiWindowSetSizable(panelorg.okno, false)
        panelorg.lista = guiCreateGridList(0.03, 0.11, 0.94, 0.71, true, panelorg.okno)
--		guiGridListAddColumn(panelorg.lista, "UID", 0.05)
        guiGridListAddColumn(panelorg.lista, "Nick", 0.2)
        guiGridListAddColumn(panelorg.lista, "Ranga", 0.2)
        guiGridListAddColumn(panelorg.lista, "Dołączył/a", 0.2)
        guiGridListAddColumn(panelorg.lista, "Ostatnio aktywny/a", 0.2)
        guiGridListAddColumn(panelorg.lista, "Status", 0.12)
        guiGridListAddRow(panelorg.lista)
        panelorg.edit_btn = guiCreateButton(0.03, 0.85, 0.29, 0.11, "Edytuj", true, panelorg.okno)
        panelorg.kick_btn = guiCreateButton(0.33, 0.85, 0.29, 0.11, "Wyrzuć z organizacji", true, panelorg.okno)
        panelorg.addmemeber_btn = guiCreateButton(0.63, 0.85, 0.34, 0.11, "Dodaj", true, panelorg.okno)  
		guiSetVisible(panelorg.okno,false)
		guiGridListSetSortingEnabled(panelorg.lista, false)
			
        panelorg.okno2 = guiCreateWindow(0.39, 0.33, 0.22, 0.39, "Panel edycji członków", true)
        guiWindowSetSizable(panelorg.okno2, false)

        panelorg.listarang = guiCreateComboBox(0.11, 0.16, 0.77, 0.39, "", true, panelorg.okno2)
        panelorg.btn_edit = guiCreateButton(0.11, 0.62, 0.77, 0.17, "Edytuj", true, panelorg.okno2)
        panelorg.btn_exit = guiCreateButton(0.11, 0.82, 0.77, 0.10, "Anuluj", true, panelorg.okno2)   
		guiSetVisible(panelorg.okno2,false)
		
		
        panelorg.okno3 = guiCreateWindow(0.39, 0.37, 0.22, 0.26, "Dodawanie do organizacji", true)
        guiWindowSetSizable(panelorg.okno3, false)

        panelorg.inputzapki = guiCreateEdit(0.07, 0.25, 0.85, 0.19, "", true, panelorg.okno3)
        panelorg.btnzapki = guiCreateButton(0.07, 0.62, 0.84, 0.26, "Wyślij zaproszenie", true, panelorg.okno3)
        panelorg.desczapki2 = guiCreateLabel(0.07, 0.46, 0.84, 0.12, "Zanim gracz dołączy, musi zaakceptować wysłane zaproszenie.", true, panelorg.okno3)
        guiLabelSetHorizontalAlign(panelorg.desczapki2, "center", false)
        guiLabelSetVerticalAlign(panelorg.desczapki2, "center")
        panelorg.desczapki = guiCreateLabel(0.07, 0.10, 0.84, 0.12, "Podaj dokładne ID gracza.", true, panelorg.okno3)
        guiLabelSetHorizontalAlign(panelorg.desczapki, "center", false)
        guiLabelSetVerticalAlign(panelorg.desczapki, "center") 
        guiSetProperty(panelorg.inputzapki, "ValidationString", "^[0-9]*$")		
		guiSetVisible(panelorg.okno3,false)

		--
		
addEvent("pokaListeRangNOW", true)
addEventHandler("pokaListeRangNOW", root, function(result)
    guiComboBoxClear(panelorg.listarang)
	for i, v in pairs(result) do
	    if v.orgrank_value ~= 1 then
			guiComboBoxAddItem(panelorg.listarang, v.orgrank_name)
		end
	end
	guiComboBoxSetSelected(panelorg.listarang, 1)
end)	
		
addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == panelorg.edit_btn then
--        local selected = guiComboBoxGetSelected(panelorg.listarang)
--        if not selected then return end
        local selectedRow=guiGridListGetSelectedItem(panelorg.lista)
        if not selectedRow or selectedRow < 0 then return end
--		local userUID = guiGridListGetItemData(panelorg.lista, selectedRow, 1)
--		local plr_rankID = getElementData
		guiSetVisible(panelorg.okno2,true)
		guiSetVisible(panelorg.okno3,false)
		guiMoveToBack(panelorg.okno)
		triggerServerEvent("pokazListeRangORG", root, localPlayer);
	end
	
	if source == panelorg.btn_edit then -- spr edit
        local selected = guiComboBoxGetSelected(panelorg.listarang)
        if not selected then return end
        local selectedRow=guiGridListGetSelectedItem(panelorg.lista)
        if not selectedRow or selectedRow < 0 then return end
--		local userUID = guiGridListGetItemText(panelorg.lista, selectedRow, 1)
		local userUID = guiGridListGetItemData(panelorg.lista, selectedRow, 1)
		local sel = selected + 2 -- bo zwraca 0 od gory, a lidera nie mozna nadac
--		outputChatBox(userUID.." na rank: "..sel)
		
		triggerServerEvent("zmianaRangiUseraORG", root, localPlayer, userUID, sel);
	end
	
	if source == panelorg.addmemeber_btn then -- panel dodawania
	if guiGetVisible(panelorg.okno3) then
		guiSetVisible(panelorg.okno3,false)
		guiSetText(panelorg.addmemeber_btn, "Dodaj")
	else
		guiSetVisible(panelorg.okno3,true)
		guiSetVisible(panelorg.okno2,false)
		guiMoveToBack(panelorg.okno)
		guiSetText(panelorg.addmemeber_btn, "Anuluj dodawanie")
	end
	end
	
	if source == panelorg.kick_btn then
        local selectedRow=guiGridListGetSelectedItem(panelorg.lista)
        if not selectedRow or selectedRow < 0 then return end
		local userUID = guiGridListGetItemData(panelorg.lista, selectedRow, 1)
--		outputChatBox("Kikujesz z org: uid: "..userUID)
		triggerServerEvent("kickTypazORG", root, localPlayer, userUID);
	end
	
	if source == panelorg.btnzapki then -- tutaj wysylamy zape
		local adduser_ID = guiGetText(panelorg.inputzapki) or 0;
		if string.len(adduser_ID) > 0 then
		if tonumber(adduser_ID) < 0 or tonumber(adduser_ID) > 11 then
			outputChatBox("* Błąd, ID powinno składać z conajmnij jednej cyfry.",255,0,0)
			return
		end
		if not sprOnlineID(adduser_ID) then
			outputChatBox("* Błąd, błędne ID gracza, lub gracz się wylogował.",255,0,0)
			return
		end
		triggerServerEvent("wyslijZapkeDoORG", root, localPlayer, adduser_ID);
		end
	end
	
	if source == panelorg.btn_exit then
		guiSetVisible(panelorg.okno2,false)
	end
end)
	
addEvent("zamknijPanelZarOrg", true)
addEventHandler("zamknijPanelZarOrg", root, function()
	guiSetVisible(panelorg.okno2,false)
--	showCursor(false);
end)		
		
local blokada = {}	
function panelORG()

local setORG = getElementData(localPlayer,"player:orgID") or 0;
local rankORG = getElementData(localPlayer,"player:orgRank") or 0;

if tonumber(setORG) > 0 and ( tonumber(rankORG) == 1 or tonumber(rankORG) == 2 ) then -- lider i vlider
	guiSetEnabled(panelorg.edit_btn, true);
	guiSetEnabled(panelorg.kick_btn, true);
	guiSetEnabled(panelorg.addmemeber_btn, true);
else 
	guiSetEnabled(panelorg.edit_btn, false);
	guiSetEnabled(panelorg.kick_btn, false);
	guiSetEnabled(panelorg.addmemeber_btn, false);
end

if tonumber(setORG) > 0 then 
	if guiGetVisible(panelorg.okno) then
		guiSetVisible(panelorg.okno,false)
		guiSetVisible(panelorg.okno2,false)
		guiSetVisible(panelorg.okno3,false)
		showCursor(false);
	else
	if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then
	    outputChatBox("* Zaczekaj...", 255, 0, 0, true)
	    return 
	end
		guiSetVisible(panelorg.okno,true)
		showCursor(true);
		triggerServerEvent("pokazListeCzlonkowOrg", root, localPlayer);
		blokada[localPlayer] = getTickCount()+3500; -- 3,5 sek zabezpieczenia
	end
end
end
addCommandHandler("panelorganizacji", panelORG)

function sprOnlineID(id)
	for i, user in ipairs(getElementsByType("player")) do
	local idu = getElementData(user,"id") or 0;
		if tonumber(idu) == tonumber(id) then
			return true -- online
		end
	end
end


function sprOnline(uid)
	for i, user in ipairs(getElementsByType("player")) do
	local uidus = getElementData(user,"player:dbid") or 0;
	if uidus > 0 then
		if uidus == uid then
			return true -- online
		end
	end
	end
end

addEvent("pokazListeCzlonkowOrgNOW", true)
addEventHandler("pokazListeCzlonkowOrgNOW", root, function(result)
    guiGridListClear(panelorg.lista)
    for i,org in pairs(result) do
	local row=guiGridListAddRow(panelorg.lista);
	
	triggerServerEvent("wybUseraDane", root, org.orguser_userid, row)
	triggerServerEvent("wybOrgUserDane", root, org.orguser_rank, row, localPlayer)
	
--	guiGridListSetItemText(panelorg.lista, row, 1, org.orguser_userid, false, false);
	guiGridListSetItemText(panelorg.lista, row, 1, "-", false, false);
	guiGridListSetItemData(panelorg.lista, row, 1, org.orguser_userid);
	guiGridListSetItemText(panelorg.lista, row, 2, "-", false, false);
	guiGridListSetItemText(panelorg.lista, row, 3, org.orguser_joindata, false, false);
	if sprOnline(org.orguser_userid) then
		guiGridListSetItemText(panelorg.lista, row, 4, "Teraz", false, false);
	else
		guiGridListSetItemText(panelorg.lista, row, 4, "-", false, false);
		triggerServerEvent("wybUseraDaneData", root, org.orguser_userid, row)
	end
	if sprOnline(org.orguser_userid) then
		guiGridListSetItemText(panelorg.lista, row, 5, "Online", false, false);
		guiGridListSetItemColor(panelorg.lista, row, 5, 0, 222, 0)
	else
		guiGridListSetItemText(panelorg.lista, row, 5, "Offline", false, false);
		guiGridListSetItemColor(panelorg.lista, row, 5, 222, 0, 0)
	end

    end
end)

addEvent("pokazUserName", true)
addEventHandler("pokazUserName", root, function(user_nickname,row)
	guiGridListSetItemText(panelorg.lista, row, 1, user_nickname, false, false);
end)

addEvent("pokazUserNameData", true)
addEventHandler("pokazUserNameData", root, function(user_lastlogindata,row)
	guiGridListSetItemText(panelorg.lista, row, 4, user_lastlogindata, false, false);
end)


addEvent("pokazUserORGName", true)
addEventHandler("pokazUserORGName", root, function(user_rankname,row)
	guiGridListSetItemText(panelorg.lista, row, 2, user_rankname, false, false);
end)
----------------------------------------------------------------------------------
local blokadabanko = {
    [3] = true,
--	IDorg = true,
}


        local crea = createColSphere(2460.240234375, 2384.046875, 12.25354385376, 1)
	    setElementInterior(crea, 0)
	    setElementDimension(crea, 0)
        local bo = {}
        bo.okno = guiCreateWindow(0.20, 0.21, 0.60, 0.59, "Bankomat organizacji", true)
        guiWindowSetSizable(bo.okno, false)

        bo.lista = guiCreateGridList(0.02, 0.07, 0.65, 0.88, true, bo.okno)
        guiGridListAddColumn(bo.lista, "Nick", 0.2)
        guiGridListAddColumn(bo.lista, "Kwota", 0.15)
        guiGridListAddColumn(bo.lista, "Data", 0.2)
        guiGridListAddColumn(bo.lista, "Opis", 0.4)
        bo.exit_btn = guiCreateButton(0.68, 0.82, 0.30, 0.13, "Zamknij", true, bo.okno)
        bo.kwota = guiCreateEdit(0.68, 0.11, 0.30, 0.08, "", true, bo.okno)
        guiEditSetMaxLength(bo.kwota, 6)
        bo.opis = guiCreateEdit(0.68, 0.26, 0.30, 0.08, "", true, bo.okno)
        guiEditSetMaxLength(bo.opis, 200)
        bo.wplac_btn = guiCreateButton(0.68, 0.40, 0.30, 0.13, "Wpłać", true, bo.okno)
        bo.kwota_desc = guiCreateLabel(0.68, 0.07, 0.18, 0.04, "Kwota:", true, bo.okno)
        guiLabelSetVerticalAlign(bo.kwota_desc, "center")
        bo.opis_desc = guiCreateLabel(0.68, 0.22, 0.18, 0.04, "Opis:", true, bo.okno)
        guiLabelSetVerticalAlign(bo.opis_desc, "center")
        bo.wyplac_btn = guiCreateButton(0.68, 0.54, 0.30, 0.07, "Wypłać", true, bo.okno)
		
        bo.moneysum = guiCreateLabel(0.68, 0.65, 0.30, 0.10, "Ładowanie", true, bo.okno) -- Stan konta: \n\n500$
        guiLabelSetHorizontalAlign(bo.moneysum, "center", false)
        guiLabelSetVerticalAlign(bo.moneysum, "center")    
		
        guiSetVisible(bo.okno, false);
		guiSetProperty(bo.kwota, "ValidationString", "^[0-9]*$")

addEvent("pokazLogiBankORGnow", true)
addEventHandler("pokazLogiBankORGnow", root, function(result,gtmoney)
    guiGridListClear(bo.lista)
	local gtmoney = string.format("%.2f", gtmoney/100)
	guiSetText(bo.moneysum, "Stan konta: \n\n"..gtmoney.."$")
    for i,org in pairs(result) do
	local row=guiGridListAddRow(bo.lista);
	triggerServerEvent("wybUseraDaneBankoORG", root, org.orgbank_userid,row)
	
	guiGridListSetItemText(bo.lista, row, 1, org.orgbank_userid, false, false);
	local money = string.format("%.2f", org.orgbank_cash/100)
	guiGridListSetItemText(bo.lista, row, 2, money.."$", false, false)
	guiGridListSetItemText(bo.lista, row, 3, org.orgbank_data, false, false);
	guiGridListSetItemText(bo.lista, row, 4, org.orgbank_desc, false, false);
	
	if org.orgbank_value == 0 then
--		guiGridListSetItemColor(bo.lista, row, 1, 56, 177, 0)
		guiGridListSetItemColor(bo.lista, row, 2, 56, 142, 0 )
--		guiGridListSetItemColor(bo.lista, row, 3, 56, 177, 0)
--		guiGridListSetItemColor(bo.lista, row, 4, 56, 177, 0)
	else
--		guiGridListSetItemColor(bo.lista, row, 1, 199, 21, 21)
--		guiGridListSetItemColor(bo.lista, row, 2, 199, 21, 21)
--		guiGridListSetItemColor(bo.lista, row, 3, 199, 21, 21)
--		guiGridListSetItemColor(bo.lista, row, 4, 199, 21, 21)
		guiGridListSetItemColor(bo.lista, row, 2, 255, 0, 0 )
	end
	
    end
end)

addEvent("pokazUserNameBankORG", true)
addEventHandler("pokazUserNameBankORG", root, function(user_nickname,row)
--	guiSetText(bo.lista, user_nickname);
	guiGridListSetItemText(bo.lista, row, 1, user_nickname, false, false);
end)

addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == bo.wplac_btn then
--	    local org_cash = guiGetText(bo.kwota) or 0;
		local org_cash = tonumber(guiGetText(bo.kwota)) or 0;
		local org_cash=org_cash*100;
		local org_desc = guiGetText(bo.opis) or "-";
		if org_cash <= 0 then
			outputChatBox("#841515✖#e7d9b0 Błąd, minimalna kwota wpłaty to #388E001$#e7d9b0.",231, 217, 176,true)
			return
		end
		if org_cash > 99999999 then
			outputChatBox("#841515✖#e7d9b0 Błąd, maksymalna kwota wpłaty to #388E00999999$#e7d9b0.",231, 217, 176,true)
			return
		end
		if getPlayerMoney() < org_cash then
			outputChatBox("#841515✖#e7d9b0 Błąd, nie posiadasz tyle gotówki.",231, 217, 176,true)
			return
		end
		local plr_orgID = getElementData(localPlayer,"player:orgID") or 0;
		local plr_id = getElementData(localPlayer,"player:dbid") or 0;
		if blokadabanko[plr_orgID] then
			outputChatBox("#841515✖#e7d9b0 Błąd, Twoja organizacja posiada zablokowany bankomat.",231, 217, 176,true)
			return
		end
		triggerServerEvent("wplacKwoteBankoORG",localPlayer,plr_id,plr_orgID,org_cash,org_desc,localPlayer);
		triggerServerEvent("pokazLogiBankORG", root, localPlayer);
	end
	
	if source == bo.wyplac_btn then
--	    local org_cash = guiGetText(bo.kwota) or 0;
		local org_cash = tonumber(guiGetText(bo.kwota)) or 0;
		local org_cash=org_cash*100;
		local org_desc = guiGetText(bo.opis) or "-";
		if org_cash <= 0 then
			outputChatBox("#841515✖#e7d9b0 Błąd, minimalna kwota wypłaty to #388E001$#e7d9b0.",231, 217, 176,true)
			return
		end
		local money_now = getPlayerMoney() + org_cash;
		if money_now > 99999999 then
			outputChatBox("#841515✖#e7d9b0 Błąd, osiągnięto limit gotówki przy sobie.",231, 217, 176,true)
			return
		end
		local plr_orgID = getElementData(localPlayer,"player:orgID") or 0;
		local plr_id = getElementData(localPlayer,"player:dbid") or 0;
		if blokadabanko[plr_orgID] then
			outputChatBox("#841515✖#e7d9b0 Błąd, Twoja organizacja posiada zablokowany bankomat.",231, 217, 176,true)
			return
		end
		triggerServerEvent("wyplacKwoteBankoORG",localPlayer,plr_id,plr_orgID,org_cash,org_desc,localPlayer);
		triggerServerEvent("pokazLogiBankORG", root, localPlayer);
	end
	
	if source == bo.exit_btn then
        showCursor(false);
        guiSetVisible(bo.okno, false);
	end
end)
		
		
addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
    if not md or el~=localPlayer then return end
    if not guiGetVisible(bo.okno) then
	local plr_orgID = getElementData(el,"player:orgID") or 0;
	if plr_orgID > 0 then
        showCursor(true);
        guiSetVisible(bo.okno, true);
        triggerServerEvent("pokazLogiBankORG", root, el);
		local plr_orgRANK = getElementData(el,"player:orgRank") or 0;
		if plr_orgRANK == 1 then 
			guiSetEnabled(bo.wyplac_btn, true)
		else
			guiSetEnabled(bo.wyplac_btn, false)
		end
    end
	end
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(el,md)
    if not md or el~=localPlayer then return end
    if guiGetVisible(bo.okno) then
        showCursor(false);
        guiSetVisible(bo.okno, false);
        --triggerServerEvent("sprBankoKase", root, el);
    end
end)

-----------------------------------------------------------------------------------
bindKey("F5", "down", panelORG)


local gameView={"Logi serwerowe:"}

addEvent("admin:addText", true)
addEventHandler("admin:addText", root, function(text)
dbid = getElementData(localPlayer,"player:dbid") or 0;
if dbid > 0 then
	table.insert(gameView, text)	
	if #gameView > 14 then
		table.remove(gameView, 2)
	end
end
end)

