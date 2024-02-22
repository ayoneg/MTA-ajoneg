--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt domów.
]]--

-- auto zwalnianie domku
function autoZwolnijDom()
	for i,pickup in ipairs(getElementsByType("pickup")) do
		local getID = getElementData(pickup,"dom:id") or 0;
		local ow = getElementData(pickup,"dom:owner") or 0;
		if getID > 0 and ow ~= 0 then
			local domdo_data = getElementData(pickup,"dom:data");
			if domdo_data then
				local czas = tostring((os.date("%Y-%m-%d")).." "..(os.date("%H:%M:%S")))
				if domdo_data < czas then
					local owner = getElementData(pickup,"dom:owner") or 0;
					if owner ~= 0 and owner ~= 22 then
						local losowa_godzina = math.random(1,12); -- zapobiega to zwalnianiu, handel poza urzedem
						local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_owner='22', dom_ownergroup='0', dom_dodata=DATE_ADD(NOW(),INTERVAL "..losowa_godzina.." HOUR) WHERE dom_id='"..getID.."'");
						odsiwezDom(getID)
						outputDebugString(" >> Zwalniam nieruchomość id: "..getID.." na bota")
					else
						local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_owner='0', dom_ownergroup='0' WHERE dom_id='"..getID.."'");
						odsiwezDom(getID)
						outputDebugString(" >> Zwalniam nieruchomość id: "..getID.." z bota")
					end
				end
			end
		end
	end
end
setTimer(autoZwolnijDom, 300000, 0) -- co 5 min (300000)

function sprDOM(domID)
	for i,pickup in ipairs(getElementsByType("pickup")) do
		local getID = getElementData(pickup,"dom:id") or 0;
		if tonumber(getID) > 0 and tonumber(getID) == tonumber(domID) then
			return pickup
		end
	end
end

function sprMARKER(markID)
	for i,marker in ipairs(getElementsByType("marker")) do
		local getID = getElementData(marker,"dom:id") or 0;
		if tonumber(getID) > 0 and tonumber(getID) == tonumber(markID) then
			return marker
		end
	end
end

-------------------- KOMENDY AND ------------------------

addCommandHandler("root.reloaddomy", function(plr,cmd)
	if getElementData(plr,"admin:poziom") >= 10 then
    	if getElementData(plr,"admin:zalogowano") == "true" then
			outputChatBox("#e7d9b0[#EBB85DADM#e7d9b0:#EBB85DDOMY#e7d9b0] Trwa przeładowywanie nieruchomości...",plr, 255, 255, 255, true)
			wyswietlDomy(plr)
    	end
	end
end)

addCommandHandler("root.dom", function(plr,cmd,domID)
	if getElementData(plr,"admin:poziom") >= 6 then
    	if getElementData(plr,"admin:zalogowano") == "true" then
			if not tonumber(domID) then 
				outputChatBox("* Użycie: /root.dom <id>",plr)
				return 
			end
			local target = sprDOM(domID);
			if not target then
				outputChatBox("* Błąd, podany dom nie istnieje!",plr,255,0,0)
				return 
			end
			
			local pos = getElementData(target,"dom:wejscie") or {0,0,-20}
			local posINT = getElementData(target,"dom:intID") or 0;
			local posDIM = getElementData(target,"dom:dimID") or 0;
			local rootZ = getElementData(target,"dom:rootINT") or 0;
			
			setElementPosition(plr, pos[1], pos[2], pos[3])
			setElementDimension(plr, tonumber(posDIM))
			setElementInterior(plr, tonumber(posINT))
			setElementRotation(plr,0,0,rootZ,"default",true)
			setCameraTarget(plr, plr)
    	end
	end
end)

-------------------- KOMENDY AND ------------------------


function wyswietlDomy(plr)
local sprdomy = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy");
if #sprdomy > 0 then
	for i,dom in ipairs(sprdomy) do
		if sprDOM(dom.dom_id) then -- reload funkcji
		local wejscie = sprDOM(dom.dom_id);
		
		local kordy = split(dom.dom_XYZ, ",")
		local kordy2 = split(dom.dom_wejscieXYZ, ",")
		local kordy3 = split(dom.dom_wyjscieXYZ, ",")
		local kordy4 = split(dom.dom_intXYZ, ",")
		
		if dom.dom_owner > 0 then iconID=1272;iconID2=32; else iconID=1273;iconID2=31; end
		
		setElementPosition(wejscie, kordy[1], kordy[2], kordy[3]+0.2)
		
		setElementData(wejscie,"dom",true)
		setElementData(wejscie,"dom:id",dom.dom_id)
		setElementData(wejscie,"dom:name",dom.dom_name)
		
		setElementData(wejscie,"dom:data",dom.dom_dodata)
		setElementData(wejscie,"dom:zamek",dom.dom_zamek)
		
		setElementData(wejscie,"dom:cost",dom.dom_cost)
		setElementData(wejscie,"dom:owner",dom.dom_owner)
		setElementData(wejscie,"dom:ownergroup",dom.dom_ownergroup)
		setElementData(wejscie,"dom:intID",dom.dom_intID)
		setElementData(wejscie,"dom:dimID",dom.dom_dimID)
		setElementData(wejscie,"dom:wejscie",{kordy2[1], kordy2[2], kordy2[3]})
		setElementData(wejscie,"dom:wyjscie",{kordy3[1], kordy3[2], kordy3[3]})
		setElementData(wejscie,"dom:rootINT",dom.dom_rootINT)
		setElementData(wejscie,"dom:root",dom.dom_root)
		
		local markerINTER = sprMARKER(dom.dom_id)
		setMarkerTarget(markerINTER, kordy4[1], kordy4[2], kordy4[3]+0.52)
		setElementData(markerINTER,"dom:id",dom.dom_id)
		setElementData(markerINTER,"dom:marker",true)
		setElementData(markerINTER,"dom:wyjscie",{kordy3[1], kordy3[2], kordy3[3]})
		setElementDimension(markerINTER, dom.dom_dimID)
		setElementInterior(markerINTER, dom.dom_intID)
		setElementData(markerINTER,"dom:root",dom.dom_root)
		
		if dom.dom_owner > 0 then
			local user = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..dom.dom_owner.."' LIMIT 1");	
			setElementData(wejscie,"dom:ownerName",user[1].user_nickname)
		end
		if dom.dom_ownergroup > 0 then
			local org = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..dom.dom_ownergroup.."' LIMIT 1");	
			setElementData(wejscie,"dom:ownerGroupName","=== "..org[1].org_name.." ===")
		end
		outputDebugString(" >> Przeładowano nieruchomość: "..(dom.dom_id).."")
		if #sprdomy == i then outputChatBox("#e7d9b0[#EBB85DADM#e7d9b0:#EBB85DDOMY#e7d9b0] Pomyślnie przeładowano #EBB85D"..#sprdomy.."#e7d9b0 nieruchomości.", plr, 255, 255, 255, true) end
		
		else -- startt funkcji
		
		local kordy = split(dom.dom_XYZ, ",")
		local kordy2 = split(dom.dom_wejscieXYZ, ",")
		local kordy3 = split(dom.dom_wyjscieXYZ, ",")
		local kordy4 = split(dom.dom_intXYZ, ",")
		local kordy5 = split(dom.dom_audioXYZ, ",")
		
		if dom.dom_owner > 0 then iconID=1272;iconID2=32; else iconID=1273;iconID2=31; end
		
		wejscie = createPickup(kordy[1], kordy[2], kordy[3]+0.2, 3, iconID, 0) 
		setElementData(wejscie,"dom",true)
		setElementData(wejscie,"dom:id",dom.dom_id)
		setElementData(wejscie,"dom:name",dom.dom_name)
		
		setElementData(wejscie,"dom:data",dom.dom_dodata)
		setElementData(wejscie,"dom:zamek",dom.dom_zamek)
		
		setElementData(wejscie,"dom:cost",dom.dom_cost)
		setElementData(wejscie,"dom:owner",dom.dom_owner)
		setElementData(wejscie,"dom:ownergroup",dom.dom_ownergroup)
		setElementData(wejscie,"dom:intID",dom.dom_intID)
		setElementData(wejscie,"dom:dimID",dom.dom_dimID)
		setElementData(wejscie,"dom:wejscie",{kordy2[1], kordy2[2], kordy2[3]})
		setElementData(wejscie,"dom:wyjscie",{kordy3[1], kordy3[2], kordy3[3]})
		setElementData(wejscie,"dom:rootINT",dom.dom_rootINT)
		setElementData(wejscie,"dom:root",dom.dom_root)
		
		markerINTER = createMarker(kordy4[1], kordy4[2], kordy4[3]+0.52, "arrow", 1.2, 255, 177, 0, 255)
		setElementData(markerINTER,"dom:id",dom.dom_id)
		setElementData(markerINTER,"dom:marker",true)
		setElementData(markerINTER,"dom:wyjscie",{kordy3[1], kordy3[2], kordy3[3]})
		setElementDimension(markerINTER, dom.dom_dimID)
		setElementInterior(markerINTER, dom.dom_intID)
		setElementData(markerINTER,"dom:root",dom.dom_root)
		
		if dom.dom_audio ~= 0 then
		audioObszar = createColSphere(kordy5[1], kordy5[2], kordy5[3]+0.52, 2)
		setElementData(audioObszar,"dom:sphareAudio",true)
		setElementData(audioObszar,"dom:sphareAudioON",false)
		setElementData(audioObszar,"dom:sphareAudioID",dom.dom_id)
		setElementData(audioObszar,"dom:sphareAudioXYZ",{kordy5[1], kordy5[2], kordy5[3]})
		setElementData(audioObszar,"dom:sphareAudioOwner",dom.dom_owner)
		setElementData(audioObszar,"dom:sphareAudioOwnerGroup",dom.dom_ownergroup)

		setElementDimension(audioObszar, dom.dom_dimID)
		setElementInterior(audioObszar, dom.dom_intID)
		audioObszarVisu = createMarker(kordy5[1], kordy5[2], kordy5[3]-1.5, "cylinder", 1.2, 255, 177, 0, 55)
		setElementDimension(audioObszarVisu, dom.dom_dimID)
		setElementInterior(audioObszarVisu, dom.dom_intID)
		setElementData(audioObszarVisu,"dom:sphareAudio",true)
		setElementData(audioObszarVisu,"dom:sphareAudioName","Konsola audio")
		end
		
		if dom.dom_owner > 0 then
			local user = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..dom.dom_owner.."' LIMIT 1");	
			setElementData(wejscie,"dom:ownerName",user[1].user_nickname)
		end
		if dom.dom_ownergroup > 0 then
			local org = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..dom.dom_ownergroup.."' LIMIT 1");	
			setElementData(wejscie,"dom:ownerGroupName","=== "..org[1].org_name.."===")
		end
		
		outputDebugString(" >> Dodano nieruchomość: "..(dom.dom_id).."")
		if #sprdomy == i then outputChatBox("#e7d9b0[#EBB85DADM#e7d9b0:#EBB85DDOMY#e7d9b0] Pomyślnie załadowano #EBB85D"..#sprdomy.."#e7d9b0 nieruchomości.", plr, 255, 255, 255, true) end
		end
	end
end
end

-- start
wyswietlDomy()

function odsiwezDom(domID)
	for i,pickup in ipairs(getElementsByType("pickup")) do
		local getID = getElementData(pickup,"dom:id") or 0;
		if tonumber(getID) > 0 and tonumber(getID) == tonumber(domID) then
--			return pickup
			local dom = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy WHERE dom_id='"..domID.."' LIMIT 1");
			setElementData(pickup,"dom:owner",dom[1].dom_owner)
			setElementData(pickup,"dom:ownergroup",dom[1].dom_ownergroup)
			setElementData(pickup,"dom:data",dom[1].dom_dodata)
			setElementData(pickup,"dom:zamek",dom[1].dom_zamek)
			
			if dom[1].dom_owner > 0 then
				local user = exports["aj-dbcon"]:wyb("SELECT * FROM server_users WHERE user_id='"..dom[1].dom_owner.."' LIMIT 1");	
				setElementData(pickup,"dom:ownerName",user[1].user_nickname)
				setPickupType(pickup, 3, 1272)
			else
				setElementData(pickup,"dom:ownerName","brak...")
				setPickupType(pickup, 3, 1273)
			end
			if dom[1].dom_ownergroup > 0 then
				local org = exports["aj-dbcon"]:wyb("SELECT * FROM server_organizacje WHERE org_id='"..dom[1].dom_ownergroup.."' LIMIT 1");	
				setElementData(pickup,"dom:ownerGroupName","=== "..org[1].org_name.." ===")
			else
				setElementData(pickup,"dom:ownerGroupName","")
			end
		end
	end
end

addEvent("setElementDimIntAll",true)
addEventHandler("setElementDimIntAll",root,function(plr,p1,p2,p3,rootZ,intID,dimID)
	setElementInterior(plr, intID, p1, p2, p3)
	setElementDimension(plr, dimID)
		
	setElementRotation(plr,0,0,rootZ,"default",true)
	setCameraTarget(plr, plr)
end)

addEvent("zamknijZamekDomu",true)
addEventHandler("zamknijZamekDomu",root,function(plr,domek,zamek)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local domID = getElementData(domek,"dom:id") or 0;
		if domID > 0 then
			local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_zamek='"..zamek.."' WHERE dom_id='"..domID.."' AND dom_owner='"..uid.."'");
			if query then
--				outputChatBox("#388E00✔#e7d9b0 Pomyślnie zamknięto drzwi.", plr,231, 217, 176,true);
				triggerClientEvent("closeOknoDomku",root,plr)
				odsiwezDom(domID)
			end
		end
	end
end)

addEvent("zwolnijDom",true)
addEventHandler("zwolnijDom",root,function(plr,domek)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local domID = getElementData(domek,"dom:id") or 0;
		if domID > 0 then
			local losowa_godzina = math.random(1,12); -- zapobiega to zwalnianiu, handel poza urzedem
			local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_owner='22', dom_ownergroup='0', dom_dodata=DATE_ADD(NOW(),INTERVAL "..losowa_godzina.." HOUR) WHERE dom_id='"..domID.."' AND dom_owner='"..uid.."'");
			if query then
				outputChatBox("#388E00✔#e7d9b0 Pomyślnie zwolniono nieruchomość.", plr,231, 217, 176,true);
				triggerClientEvent("closeOknoDomku",root,plr)
				odsiwezDom(domID)
			end
		end
	end
end)

addEvent("przepiszDomNaORG",true)
addEventHandler("przepiszDomNaORG",root,function(plr,domek,plr_orgID,value)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local domID = getElementData(domek,"dom:id") or 0;
		if domID > 0 then
			if tonumber(value) == 1 then -- odpisz
				local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_ownergroup='0' WHERE dom_id='"..domID.."' AND dom_owner='"..uid.."'");
				if query then
					local org_name = getElementData(plr,"player:orgNAME") or "";
					outputChatBox("#388E00✔#e7d9b0 Pomyślnie odpisano nieruchomość z organizacji #EBB85D"..org_name.."#e7d9b0.", plr,231, 217, 176,true);
					triggerClientEvent("closeOknoDomku",root,plr)
					odsiwezDom(domID)
				end
				return
			end
			local sprdomy = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy WHERE dom_ownergroup='"..plr_orgID.."'");
			if sprdomy and #sprdomy >= 2 then
				outputChatBox("* Organizacja przekroczyła dopuszczalną liczbę przypisanych nieruchomości!",plr,255,0,0,true)
				return
			end
			local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_ownergroup='"..plr_orgID.."' WHERE dom_id='"..domID.."' AND dom_owner='"..uid.."'");
			if query then
				local org_name = getElementData(plr,"player:orgNAME") or "";
				outputChatBox("#388E00✔#e7d9b0 Pomyślnie przepisano nieruchomość na organizacje #EBB85D"..org_name.."#e7d9b0.", plr,231, 217, 176,true)
				triggerClientEvent("closeOknoDomku",root,plr)
				odsiwezDom(domID)
			end
		end
	end
end)


addEvent("cz2WynajmijDomekNOW",true)
addEventHandler("cz2WynajmijDomekNOW",root,function(plr,domek,getDays)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local domID = getElementData(domek,"dom:id") or 0;
		if domID > 0 then
			local sprdomy = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy WHERE dom_id='"..domID.."' LIMIT 1");
			if #sprdomy > 0 then
				if sprdomy[1].dom_owner == 0 then -- jesli nie ma ownera, jest wolny
					local moneyGracz = getPlayerMoney(plr) or 0;
					local domCost = sprdomy[1].dom_cost;
					local domCost = (domCost * 100 * getDays); -- doba * 100 * dni;
					if domCost > moneyGracz then
						outputChatBox("* Nie masz tyle gotówki przy sobie!",plr,255,0,0,true)
						return
					end
					local sprdomyGracza = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy WHERE dom_owner='"..uid.."'");
					if #sprdomyGracza >= 3 then
						outputChatBox("* Nie możesz posiadać więcej niż 3 nieruchomości na raz!",plr,255,0,0,true)
						return
					end
					-- jesli wszystko git, nadajemy domek dla kupujacego
					takePlayerMoney(plr,domCost) -- kasujemy typowi kesz
					-- nizej formalnosci
					local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_owner='"..uid.."', dom_oddata=NOW(), dom_dodata=DATE_ADD(NOW(), INTERVAL "..getDays.." DAY) WHERE dom_id='"..domID.."'");
					local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..domCost.." WHERE user_id = '"..uid.."'");
					
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='"..uid.."', lbank_touserid='22', lbank_kwota='"..domCost.."', lbank_data=NOW(), lbank_desc='Zakup/opłata za domek.', lbank_type='1'");
					
					local money = string.format("%.2f", domCost/100)
					outputChatBox("#388E00✔#e7d9b0 Pomyślnie zakupiono nieruchomość za #388E00"..money.."$#e7d9b0 na okres #EBB85D"..getDays.." dni#e7d9b0.", plr,231, 217, 176,true)
					
					local transfer_text=('[DOMY] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' zakupil/a nieruchomość id: '..domID..' za ['..money..' $] na: '..getDays..' dni')
					outputServerLog(transfer_text)					
					
					triggerClientEvent("closeOknoDomku",root,plr)
					odsiwezDom(domID)
				else -- jesli dom jest juz opłacony <<<>>> HERE <<<>>>
					-- potem kod
					--local owner = getElementData(domek,"dom:owner") or 0;
					local domGracza = exports["aj-dbcon"]:wyb("SELECT * FROM server_domy WHERE dom_id='"..domID.."' LIMIT 1");
					if tonumber(domGracza[1].dom_owner) == uid then -- gdyby jednak w tym samym czasie ktos kupil dom, wykona sie dla pierwszego
					
					local moneyGracz = getPlayerMoney(plr) or 0;
					local domCost = sprdomy[1].dom_cost;
					local domCost = (domCost * 100 * getDays); -- doba * 100 * dni;
					if domCost > moneyGracz then
						outputChatBox("* Nie masz tyle gotówki przy sobie!",plr,255,0,0,true)
						return
					end
					local sprdom = exports["aj-dbcon"]:wyb("SELECT DATEDIFF(DATE_ADD(dom_dodata, INTERVAL "..getDays.." DAY), NOW()) obliczczas FROM server_domy WHERE dom_owner='"..uid.."' AND dom_id='"..domID.."'");
					local sprdomtest = exports["aj-dbcon"]:wyb("SELECT DATEDIFF(DATE_ADD(dom_dodata, INTERVAL 1 SECOND), NOW()) obliczczastest FROM server_domy WHERE dom_owner='"..uid.."' AND dom_id='"..domID.."'");
					if sprdom[1].obliczczas > 30 then
--						local oblicz = ((30 - sprdom[1].obliczczas)/2)^2;
						local oblicz = math.floor((sprdomtest[1].obliczczastest-30)*(-1));
--						outputChatBox("* Nie możesz opłacić domku na ponad 30 dni!",plr,255,0,0,true)
						if oblicz == 1 then text="dzień" else text="dni" end;
						if oblicz <= 0 then
							outputChatBox("* Nieruchomość jest już opłacona na maksymalną liczbę dni.",plr,255,0,0,true)
						else
							outputChatBox("* Maksymalnie możesz opłacić tę nieruchomość na "..oblicz.." "..text..".",plr,255,0,0,true)
						end
						return
					end
					-- jesli wszystko git, nadajemy domek dla kupujacego
					takePlayerMoney(plr,domCost) -- kasujemy typowi kesz
					-- nizej formalnosci
					local query = exports["aj-dbcon"]:upd("UPDATE server_domy SET dom_owner='"..uid.."', dom_oddata=NOW(), dom_dodata=DATE_ADD(dom_dodata, INTERVAL "..getDays.." DAY) WHERE dom_id='"..domID.."'");
					local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..domCost.." WHERE user_id = '"..uid.."'");
					
					local query = exports["aj-dbcon"]:upd("INSERT INTO server_logibankowe SET lbank_userid='"..uid.."', lbank_touserid='22', lbank_kwota='"..domCost.."', lbank_data=NOW(), lbank_desc='Zakup/opłata za nieruchomość.', lbank_type='1'");
					
					local money = string.format("%.2f", domCost/100)
					outputChatBox("#388E00✔#e7d9b0 Pomyślnie opłacono nieruchomość za #388E00"..money.."$#e7d9b0 na okres #EBB85D"..getDays.." dni#e7d9b0.", plr,231, 217, 176,true)
					
					local transfer_text=('[DOMY] '..getPlayerName(plr)..'/'..getElementData(plr,"player:dbid")..' oplacil/a nieruchomość id: '..domID..' za ['..money..' $] na: '..getDays..' dni')
					outputServerLog(transfer_text)					
					
					triggerClientEvent("closeOknoDomku",root,plr)
					odsiwezDom(domID)
					else
					outputChatBox("* Nieruchomość jest już w posiadaniu innego gracza.",plr,255,0,0,true) -- gdybysie typ spoznil
					end
					-- end
				end
			end
		end
	end
end)










