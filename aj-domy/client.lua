--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt domów.
]]--

local blokada = {}

function usunblipyDomow()
	for i,blip in ipairs(getElementsByType("blip")) do
		local blipdesc = getElementData(blip,"blip:dompokaz") or false;
		if blipdesc then
			destroyElement(blip)
		end
	end
end

-- pokaz domy (bind pokazuje domy na całej mapie)
function pokazdomy()
	if blokada[localPlayer] and getTickCount() < blokada[localPlayer] then return end
	local czypokazuje = getElementData(localPlayer,"player:pokazblipydomow") or false;
	if czypokazuje then
		usunblipyDomow()
		setElementData(localPlayer,"player:pokazblipydomow", false)
		blokada[localPlayer] = getTickCount()+2000; -- 2 sek zabezpieczenia
	else
	for i,pickup in ipairs(getElementsByType("pickup")) do
		local getID = getElementData(pickup,"dom:id") or 0;
		if tonumber(getID) > 0 then
			local domowner = getElementData(pickup,"dom:owner") or 0;
			if tonumber(domowner) > 0 then
				blip = createBlipAttachedTo(pickup, 32, 2, 0, 0, 0, 255, 1000, 16383.0)
				setElementData(blip,"blip:dompokaz",true)
			else
				blip = createBlipAttachedTo(pickup, 31, 2, 0, 0, 0, 255, 1000, 16383.0)
				setElementData(blip,"blip:dompokaz",true)
			end
			setElementData(localPlayer,"player:pokazblipydomow", true)
		end
	end
	end
end
bindKey("i", "down", pokazdomy)


local sw, sh = guiGetScreenSize()
addEventHandler("onClientRender", root,function()
local rootx, rooty, rootz = getCameraMatrix()

for i,sphare in ipairs(getElementsByType("marker")) do
	local ifcol = getElementData(sphare,"dom:sphareAudio") or false;
	
	if ifcol then
	local x,y,z=getElementPosition(sphare)
	if x ~= 0 and y ~= 0 and z ~= 0 then
	local sx,sy=getScreenFromWorldPosition(x,y,z+1.3) -- 1.3
	if sx and sy then
	
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 16; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	
	local konsola = getElementData(sphare,"dom:sphareAudioName") or "";
	
	local dim = getElementDimension(localPlayer) or 0;
	local dim2 = getElementDimension(sphare) or 0;
	if dim == dim2 then
	dxDrawText("#000000"..konsola:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy-9,sx+(sw/10)+1,sy-9, tocolor(0,0,0,255), 1, "default-bold", "center","center",true,true,false,true,true)
    dxDrawText("#ffffff"..konsola:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy-10,sx+(sw/10),sy-10, tocolor(255,255,255,255), 1, "default-bold", "center","center",true,true,false,true,true)
	end
	

	end	
    end
	end
	
	end -- enf fck
end

for i,domy in ipairs(getElementsByType("pickup")) do
	local x,y,z=getElementPosition(domy)
	local sx,sy=getScreenFromWorldPosition(x,y,z)
	if sx and sy then
	local ifdom = getElementData(domy,"dom") or false;
	
	if ifdom then
	local x,y,z=getElementPosition(domy)
	local sx,sy=getScreenFromWorldPosition(x,y,z+0.8) -- 1.3
	if sx and sy then
	
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 16; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,domy ) then	
	
	local domName = getElementData(domy,"dom:name") or "";
	local domOwner = getElementData(domy,"dom:ownerName") or "brak...";
	local domOwnerGroup = getElementData(domy,"dom:ownerGroupName") or "";
	
	local dim = getElementDimension(localPlayer) or 0;
--	local domDIM = getElementData(domy,"dom:dimID") or 0;
	if dim == 0 then
	dxDrawText("#000000"..domName:gsub("#%x%x%x%x%x%x","").."\n\n"..domOwner:gsub("#%x%x%x%x%x%x","").."\n"..domOwnerGroup:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy-9,sx+(sw/10)+1,sy-9, tocolor(0,0,0,255), 1, "default-bold", "center","center",true,true,false,true,true)
    dxDrawText("#ffffff"..domName:gsub("#%x%x%x%x%x%x","").."\n\n"..domOwner:gsub("#%x%x%x%x%x%x","").."\n"..domOwnerGroup:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy-10,sx+(sw/10),sy-10, tocolor(255,255,255,255), 1, "default-bold", "center","center",true,true,false,true,true)
	end
	
	end
	end	
    end

	
	end -- enf fck
	
	end
end
end)


local dom = {}
dom.okno = guiCreateWindow((sw - 629) / 2, (sh - 289) / 2, 629, 289, "Panel nieruchomości", false)
guiWindowSetSizable(dom.okno, false)

dom.btn_zwolnij = guiCreateButton(25, 33, 276, 37, "Zwolnij", false, dom.okno)
dom.btn_oplac = guiCreateButton(25, 80, 276, 37, "Opłać", false, dom.okno)
dom.btn_przepiszorg = guiCreateButton(25, 127, 276, 37, "Przepisz na organizacje", false, dom.okno)
dom.btn_exit = guiCreateButton(25, 234, 276, 37, "Zamknij panel", false, dom.okno)
dom.btn_zamknij = guiCreateButton(25, 174, 276, 37, "Zamknij drzwi", false, dom.okno)
dom.btn_wejdz = guiCreateButton(332, 33, 276, 84, "Wejdź do środka", false, dom.okno)
dom.desc_info = guiCreateLabel(332, 147, 276, 111, "Opłacony: dd-mm-rrrr\n\nWłaściciel: AjoN\n\nOrganizacja: HauWaa\n\nDoba: 100$", false, dom.okno)

dom.desc_hacked2 = guiCreateLabel(36, 119, 210, 20, "", false, dom.okno)
guiSetVisible(dom.desc_hacked2, false)

guiLabelSetHorizontalAlign(dom.desc_info, "center", false)
guiLabelSetVerticalAlign(dom.desc_info, "center")   
guiSetVisible(dom.okno, false)


dom.okno2 = guiCreateWindow((sw - 339) / 2, (sh - 351) / 2, 339, 351, "Opłać nieruchomość", false)
guiWindowSetSizable(dom.okno2, false)
guiSetAlpha(dom.okno2, 0.90)

dom.input_days = guiCreateEdit(35, 56, 270, 56, "", false, dom.okno2)
dom.desc_info2 = guiCreateLabel(36, 33, 210, 23, "Na ile dni (max 30):", false, dom.okno2)
guiLabelSetVerticalAlign(dom.desc_info2, "center")
dom.btn_zaplac = guiCreateButton(36, 173, 269, 70, "Potwierdzam i płace", false, dom.okno2)
dom.btn_exit2 = guiCreateButton(35, 253, 269, 70, "Zamknij", false, dom.okno2)
--dom.desc_info3 = guiCreateLabel(36, 119, 210, 44, "Cena za dobe: 100$\n\nRazem do zapłaty: 1700$", false, dom.okno2)
dom.desc_info3 = guiCreateLabel(36, 119, 210, 20, "Cena za dobe: --$", false, dom.okno2)
dom.desc_hacked = guiCreateLabel(36, 119, 210, 20, "", false, dom.okno2)
guiSetVisible(dom.desc_hacked, false)
dom.desc_info4 = guiCreateLabel(36, 143, 210, 20, "Razem do zapłaty: --$", false, dom.okno2)  
guiLabelSetVerticalAlign(dom.desc_info3, "center")    
guiSetVisible(dom.okno2, false)
guiSetProperty(dom.input_days, "ValidationString", "^[0-9]*$")	
guiEditSetMaxLength(dom.input_days, 2)

dom.oknopotwierdzam = guiCreateWindow((sw - 350) / 2, (sh - 215) / 2, 350, 215, "Potwierdzenie działania", false)
guiWindowSetSizable(dom.oknopotwierdzam, false)

dom.potwierdzam_btn = guiCreateButton(17, 34, 315, 61, "Potwierdzam zwolnienie nieruchomości", false, dom.oknopotwierdzam)
guiSetFont(dom.potwierdzam_btn, "default-bold-small")
guiSetProperty(dom.potwierdzam_btn, "NormalTextColour", "FFFF0000")
dom.potwierdzam_exit_btn = guiCreateButton(17, 110, 315, 84, "Anuluj", false, dom.oknopotwierdzam)   
guiSetVisible(dom.oknopotwierdzam, false)

-- audio
local konsola = {}
local screenW, screenH = guiGetScreenSize()
konsola.okno = guiCreateWindow((screenW - 469) / 2, (screenH - 332) / 2, 469, 332, "Konsola audio", false)
guiWindowSetSizable(konsola.okno, false)

konsola.input_url = guiCreateEdit(45, 56, 379, 52, "", false, konsola.okno)
konsola.btn_uruchom = guiCreateButton(44, 180, 380, 69, "Uruchom", false, konsola.okno)
konsola.btn_zamknij = guiCreateButton(44, 259, 185, 44, "Zamknij", false, konsola.okno)
konsola.btn_stop = guiCreateButton(239, 259, 185, 44, "Zatrzymaj audio", false, konsola.okno)
konsola.desc_info = guiCreateLabel(44, 118, 380, 48, "Podaj bezpośredni link do utworu lub streamu.", false, konsola.okno)
guiLabelSetHorizontalAlign(konsola.desc_info, "center", false)
guiLabelSetVerticalAlign(konsola.desc_info, "center")    
guiSetVisible(konsola.okno, false)


function wybDomek(domID) -- funkcja wybiera domek po id
	for i,pickup in ipairs(getElementsByType("pickup")) do
		local getID = getElementData(pickup,"dom:id") or 0;
		if tonumber(getID) > 0 and tonumber(getID) == tonumber(domID) then
			return pickup
		end
	end
end

addEvent("closeOknoDomku",true)
addEventHandler("closeOknoDomku",root,function(plr)
	if plr == localPlayer then
		showCursor(false)
		guiSetVisible(dom.okno, false)
		guiSetVisible(dom.okno2, false)
		guiSetVisible(dom.oknopotwierdzam, false)
	end
end)

addEventHandler("onClientGUIChanged", getRootElement(), function(element)
	if source == dom.input_days then
		local doba = tonumber(guiGetText(dom.desc_hacked)) or 0;
		local liczzinput = tonumber(guiGetText(element)) or 0;
		if liczzinput < 1 then liczzinput = 1 end
		local cena = doba * liczzinput; -- (doba * dni) = cena
		if cena > 0 then
			guiSetText(dom.desc_info4, "Razem do zapłaty: "..cena.."$")
		end
	end
end)

addEventHandler("onClientGUIClick", getRootElement(), function(btn,state)
	if source == dom.btn_oplac then
		guiSetVisible(dom.okno2, true)
		guiMoveToBack(dom.okno)
		guiSetVisible(dom.oknopotwierdzam, false)
	end
	
	if source == dom.btn_zamknij then
		local id = tonumber(guiGetText(dom.desc_hacked2)) or 0;
		if id > 0 then
			local domek = wybDomek(id) or false;
			if domek ~= false then
				if getElementData(domek,"dom:zamek") > 0 then value=0; else value=1; end
				triggerServerEvent("zamknijZamekDomu",localPlayer,localPlayer,domek,value)
			end
		end
	end
	
	if source == dom.btn_zwolnij then
		guiSetVisible(dom.oknopotwierdzam, true)
		guiMoveToBack(dom.okno)
		guiSetVisible(dom.okno2, false)
	end
	
	if source == dom.potwierdzam_btn then
		local id = tonumber(guiGetText(dom.desc_hacked2)) or 0;
		if id > 0 then
			local domek = wybDomek(id) or false;
			if domek ~= false then
				triggerServerEvent("zwolnijDom",localPlayer,localPlayer,domek)
			end
		end
	end
	
	if source == dom.btn_przepiszorg then
		local id = tonumber(guiGetText(dom.desc_hacked2)) or 0;
		if id > 0 then
			local domek = wybDomek(id) or false;
			if domek ~= false then
				local plr_orgID = getElementData(localPlayer,"player:orgID") or 0;
				if tonumber(plr_orgID) > 0 then
					local domORG = getElementData(domek,"dom:ownergroup") or 0;
					if tonumber(domORG) > 0 then value=1 else value=0 end
					triggerServerEvent("przepiszDomNaORG",localPlayer,localPlayer,domek,plr_orgID,value)
				else
					outputChatBox("* Nie należysz do żadnej organizacji.",255,0,0)
				end
			end
		end
	end
	
	if source == dom.btn_zaplac then
		local id = tonumber(guiGetText(dom.desc_hacked2)) or 0;
		if id > 0 then
			local domek = wybDomek(id) or false;
			if domek ~= false then
				local getDays = tonumber(guiGetText(dom.input_days)) or 0;
				if getDays > 0 then
					if getDays > 30 then
						outputChatBox("* Nieruchomość można opłacić na maksymalnie miesiąc (30 dni) do przodu.",255,0,0)
						return
					end
					triggerServerEvent("cz2WynajmijDomekNOW",localPlayer,localPlayer,domek,getDays)
				end
			end
		end
	end
	
	if source == dom.btn_wejdz then
		local id = tonumber(guiGetText(dom.desc_hacked2)) or 0;
		if id > 0 then
			local domek = wybDomek(id) or false;
			if domek ~= false then
				local px = getElementData(domek,"dom:wejscie") or false;
				local drzwi = getElementData(domek,"dom:zamek") or 0;
				local plr_id = getElementData(localPlayer,"player:dbid") or 0;
				local owner = getElementData(domek,"dom:owner") or 0;
				local ownerGroup = getElementData(domek,"dom:ownergroup") or 0;
				local plr_orgID = getElementData(localPlayer,"player:orgID") or 0;
				if ( tonumber(drzwi) == 0 ) or ( tonumber(plr_id) == tonumber(owner) ) or ( tonumber(ownerGroup) == tonumber(plr_orgID) and tonumber(plr_orgID) > 0 ) then
					if px then
						local dimID = getElementData(domek,"dom:dimID") or 0;
						local intID = getElementData(domek,"dom:intID") or 0;
						local rootINT = getElementData(domek,"dom:rootINT") or 0;
--						setElementInterior(localPlayer, intID, px[1], px[2], px[3])
--						setElementDimension(localPlayer, dimID)
		
--						setElementRotation(localPlayer,0,0,rootINT,"default",true)
--						setCameraTarget(localPlayer, localPlayer)
						
						triggerServerEvent("setElementDimIntAll",localPlayer,localPlayer,px[1],px[2],px[3],rootINT,intID,dimID)
					
						showCursor(false)
						guiSetVisible(dom.okno, false)
						guiSetVisible(dom.okno2, false)
						guiSetVisible(dom.oknopotwierdzam, false)
					end
				else
					outputChatBox("* Drzwi lokalu są zamknięte.",255,0,0)
				end
			end
		end
	end
	
	if source == dom.btn_exit2 then
		guiSetVisible(dom.okno2, false)	
	end
	
	if source == dom.potwierdzam_exit_btn then
		guiSetVisible(dom.oknopotwierdzam, false)	
	end
	
	if source == dom.btn_exit then
		showCursor(false)
		guiSetVisible(dom.okno, false)
		guiSetVisible(dom.okno2, false)
		guiSetVisible(dom.oknopotwierdzam, false)
	end	
	
	-- audtio -------------------------------------------------------- 	-- audtio --------------------------------------------------------
	-- audtio -------------------------------------------------------- 	-- audtio --------------------------------------------------------
	-- audtio -------------------------------------------------------- 	-- audtio --------------------------------------------------------
	if source == konsola.btn_uruchom then
		local getAudioId = getElementData(localPlayer,"audiozoneID") or 0;
		if tonumber(getAudioId) > 0 then
			local geturl = tostring(guiGetText(konsola.input_url))
			if geturl then
				local audio = wybAudioCol(getAudioId)
				setElementData(audio,"dom:sphareAudioURL",geturl)
				setElementData(audio,"dom:sphareAudioON",true)
				outputChatBox("* Uruchamiam...")
			end
		end
	end
	
	if source == konsola.btn_stop then
		local getAudioId = getElementData(localPlayer,"audiozoneID") or 0;
		if tonumber(getAudioId) > 0 then
			local audio = wybAudioCol(getAudioId)
			setElementData(audio,"dom:sphareAudioURL","")
			setElementData(audio,"dom:sphareAudioON",false)
		end
	end
	
	if source == konsola.btn_zamknij then
		showCursor(false)
		guiSetVisible(konsola.okno, false)
	end
end)

addEventHandler("onClientPickupLeave",getRootElement(),function(plr,dm)
	if getElementType(plr) ~= "player" then return end
	if not dm then return end
	if plr == localPlayer then
	local gtType = getElementData(source,"dom") or false; 
	if gtType then
		showCursor(false)
		guiSetVisible(dom.okno, false)
		guiSetVisible(dom.okno2, false)
		guiSetVisible(dom.oknopotwierdzam, false)
	end
	end
end)

addEventHandler("onClientPickupHit",getRootElement(),function(plr,dm)
	if getElementType(plr) ~= "player" then return end
	if isPedInVehicle(plr) then return end
	if not dm then return end
	if plr == localPlayer then
	local gtType = getElementData(source,"dom") or false; 
	if gtType then
		local p = getElementData(source,"dom:wejscie") or {0, 0, -20}
		if not p then return end
		local id = getElementData(source,"dom:id") or 0;
		local dim = getElementData(source,"dom:dimID") or 0;
		local int = getElementData(source,"dom:intID") or 0;
		local rootS = getElementData(source,"dom:rootINT") or 0;
		local owner = getElementData(source,"dom:owner") or 0;
		local ownerGroup = getElementData(source,"dom:ownergroup") or 0;
		local cost = getElementData(source,"dom:cost") or 0;
		local zamek = getElementData(source,"dom:zamek") or 0;
		local ownerName = getElementData(source,"dom:ownerName") or "";
		local ownerGroupName = getElementData(source,"dom:ownerGroupName") or "";
		
		local oplacony = getElementData(source,"dom:data") or 0;
--		setElementInterior(plr, int, p[1], p[2], p[3])
--		setElementDimension(plr, dim)
		
--		setElementRotation(plr,0,0,root,"default",true)
--		setCameraTarget(plr, plr)
		if guiGetVisible(dom.okno) == false then
			showCursor(true)
			guiSetVisible(dom.okno, true)
			local uid = getElementData(localPlayer,"player:dbid") or 0;
			if uid == owner then
				guiSetEnabled(dom.btn_zwolnij, true)
				guiSetEnabled(dom.btn_oplac, true)
				guiSetEnabled(dom.btn_przepiszorg, true)
				guiSetEnabled(dom.btn_zamknij, true)
				guiSetText(dom.btn_oplac, "Opłać")
				if zamek == 1 then 
					guiSetText(dom.btn_zamknij, "Otwórz drzwi") 
				else
					guiSetText(dom.btn_zamknij, "Zamknij drzwi") 
				end
			elseif owner == 0 then
				guiSetEnabled(dom.btn_zwolnij, false)
				guiSetEnabled(dom.btn_oplac, true)
				guiSetEnabled(dom.btn_przepiszorg, false)
				guiSetEnabled(dom.btn_zamknij, false)
				guiSetText(dom.btn_oplac, "Wykup dom")
				
			else
				guiSetEnabled(dom.btn_zwolnij, false)
				guiSetEnabled(dom.btn_oplac, false)
				guiSetEnabled(dom.btn_przepiszorg, false)
				guiSetEnabled(dom.btn_zamknij, false)
				guiSetText(dom.btn_zwolnij, "Zwolnij dom")
			end
			
			guiSetText(dom.desc_info3, "Cena za dobe: "..cost.."$")
			guiSetText(dom.desc_hacked, cost)
			guiSetText(dom.desc_hacked2, id) -- id domku
			
			if owner > 0 then
				if ownerGroup > 0 then
					guiSetText(dom.desc_info, "Opłacony do: "..oplacony.."\n\nWłaściciel: "..ownerName.."\n\nOrganizacja: "..ownerGroupName.."\n\nDoba: "..cost.."$")
					guiSetText(dom.btn_przepiszorg, "Odpisz z organizacji")
				else
					guiSetText(dom.desc_info, "Opłacony do: "..oplacony.."\n\nWłaściciel: "..ownerName.."\n\nDoba: "..cost.."$")
					guiSetText(dom.btn_przepiszorg, "Przepisz na organizacje")
				end
			else
				guiSetText(dom.desc_info, "Doba: "..cost.."$")
				guiSetText(dom.btn_przepiszorg, "Przepisz na organizacje")
			end
		end
	end
	end
end)
--[[
local webBrowser = createBrowser(1280, 720, false, false) 
function webBrowserRender()
    local x, y = 110.7, 1024.15 
    dxDrawMaterialLine3D(x, y, 23.25, x, y, 14.75, webBrowser, 18.2, tocolor(255, 255, 255, 255), x, y+1, 19)
--	local object = createObject(2267, x, y, 14.75, 0, 0, 180)
	
end

addEventHandler("onClientBrowserCreated",webBrowser,function()
		loadBrowserURL(webBrowser, "https://www.youtube.com/embed/Y2fXIsP70gU?autoplay=1&showinfo=0&rel=0&controls=0&disablekb=1")
		addEventHandler("onClientRender", root, webBrowserRender)
end)
]]

addEventHandler("onClientMarkerHit",root,function(el,md)
	if not md then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
	local gtType = getElementData(source,"dom:marker") or false;
	if gtType then
		local p = getElementData(source,"dom:wyjscie") or {0, 0, -20}
		if not p then return end
		local rootZ = getElementData(source,"dom:root") or 0;
		triggerServerEvent("setElementDimIntAll",localPlayer,el,p[1],p[2],p[3],rootZ,0,0)
--		setElementInterior(el, 0, p[1], p[2], p[3])
--		setElementDimension(el, 0)
		
--		setElementRotation(el,0,0,rootZ,"default",true)
--		setCameraTarget(el, el)
	end
end)

---- skrypt audio w domkach ---- ---- skrypt audio w domkach ----
---- skrypt audio w domkach ---- ---- skrypt audio w domkach ----
---- skrypt audio w domkach ---- ---- skrypt audio w domkach ----

function wybAudioCol(domID)
	for i,colshape in ipairs(getElementsByType("colshape")) do
		local getID = getElementData(colshape,"dom:sphareAudioID") or 0;
		if tonumber(getID) > 0 and tonumber(getID) == tonumber(domID) then
			return colshape
		end
	end
end

local aktywne = {}

addEventHandler("onClientColShapeHit",root,function(el,dim)
	if not dim then return end
    if getElementType(el) ~= "player" then return end
    if isPedInVehicle(el) then return end
	if el ~= localPlayer then return end
	local getAudio = getElementData(source,"dom:sphareAudio") or false;
	if getAudio then
		local getAudioId = getElementData(source,"dom:sphareAudioID") or 0;
		if getAudioId > 0 then
			local uid = getElementData(el,"player:dbid") or 0;
			local orgID = getElementData(el,"player:orgID") or 0;
			local owner = getElementData(source,"dom:sphareAudioOwner") or 0;
			local ownerG = getElementData(source,"dom:sphareAudioOwnerGroup") or 0;
			if ( tonumber(uid) > 0 and tonumber(uid) == tonumber(owner) ) or ( tonumber(orgID) > 0 and tonumber(orgID) == tonumber(ownerG) ) then
				setElementData(el,"audiozone",true)
				setElementData(el,"audiozoneID",getAudioId)
				showCursor(true)
				guiSetVisible(konsola.okno, true)
			end
		end
	end
end)

addEventHandler("onClientColShapeLeave",root,function(el,dim)
--    if getElementType(el) ~= "player" then return end
	if not dim then return end
	if el ~= localPlayer then return end
	local getAudio = getElementData(source,"dom:sphareAudio") or false;
	if getAudio then
		local getAudioId = getElementData(source,"dom:sphareAudioID") or 0;
		if getAudioId > 0 then
			setElementData(el,"audiozone",false)
			setElementData(el,"audiozoneID",0)	
			showCursor(false)
			guiSetVisible(konsola.okno, false)
		end
	end
end)

--[[ gui is here
addCommandHandler("audio", function(cmd,value,value2)
	local uid = getElementData(localPlayer,"player:dbid") or 0;
	if uid > 0 then
		local audioperm = getElementData(localPlayer,"audiozone") or false;
		if audioperm then
		if not value then 
			outputChatBox("* Użycie: /audio <url/off> <link (pomiń jak off)>")
			return 
		end
			if tostring(value) == "url" and tostring(value2) then
				-- zapodaj muze
				local getAudioId = getElementData(localPlayer,"audiozoneID") or 0;
				if tonumber(getAudioId) > 0 then
					local audio = wybAudioCol(getAudioId)
					setElementData(audio,"dom:sphareAudioURL",tostring(value2))
					setElementData(audio,"dom:sphareAudioON",true)
				end
			else
				-- wylacz muze
				local getAudioId = getElementData(localPlayer,"audiozoneID") or 0;
				if tonumber(getAudioId) > 0 then
					local audio = wybAudioCol(getAudioId)
					setElementData(audio,"dom:sphareAudioURL","")
					setElementData(audio,"dom:sphareAudioON",false)
				end
			end
		end
	end
end)
]]--

addEventHandler("onClientElementDataChange",root,function(eleData, _)
	if getElementType(source) ~= "colshape" then return end
	if eleData == "dom:sphareAudioON" then
	local getData = getElementData(source,eleData)
	if getData == true then
		local sirID = getElementData(source,"dom:sphareAudioURL");
		aktywne[source] = playSound3D(sirID, 0, 0, 2000, false)
		setSoundVolume(aktywne[source], 1.0)
		setSoundEffectEnabled(aktywne[source],"compressor",true)
  	    setSoundMinDistance(aktywne[source],16)
  	    setSoundMaxDistance(aktywne[source],50)
		setElementDimension(aktywne[source],getElementDimension(source))
		setElementInterior(aktywne[source],getElementInterior(source))
		attachElements(aktywne[source], source) -- nakladam
	else
		if not aktywne[source] then return end
		stopSound(aktywne[source])
	end
	end
end)











		