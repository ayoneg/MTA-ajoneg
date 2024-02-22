local screenW, screenH = guiGetScreenSize()
local sw, sh = guiGetScreenSize()
local gameView={""}
local xtext=nil

function hidePlayerWarning()
    playerWarning=false
end

for k,v in ipairs ( getElementsByType ( "object" ) ) do
	if getElementData ( v, "sciana:raportow" ) then
		scianaplaczu = v
	end
	if getElementData(v,"sciana:text") then
		scianatekstu = v
	end
end


function raporcik()
dbid = getElementData(localPlayer,"player:dbid") or 0;
if dbid > 0 then
lvl = tonumber(getElementData(localPlayer,"admin:poziom")) or 0;
if lvl >= 5 then
    if getElementData(localPlayer,"admin:zalogowano") == "true" then
	local getjudcfgucho = getElementData(localPlayer,"player:ucho") or false;
	if getjudcfgucho == true then
	local tt={}
	reportView=getElementData(scianaplaczu,"sciana:raportow")
	for i,c in ipairs(reportView) do
		if c[1] then table.insert(tt,c[1]) end
	end
	concat22=table.concat(tt, "\n")
	--dxDrawText(concat22, screenW*(698+1)/1024, screenH*(278+1)/768, screenW*(1014+1)/1024, screenH*(496+1)/768, tocolor(0, 0, 0, 255), 1.00, "default", "right", "top", false, true)
	--dxDrawText(concat22, screenW*(698)/1024, screenH*(278)/768, screenW*(1014)/1024, screenH*(496)/768, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, true)
	
    dxDrawText(concat22, (screenW * 0.7573) + 1, (screenH * 0.6352) + 1, (screenW * 0.9870) + 1, (screenH * 0.8333) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "right", "top", false, false, false, false, false)
    dxDrawText(concat22, screenW * 0.7573, screenH * 0.6352, screenW * 0.9870, screenH * 0.8333, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, false, false, false, false)
end
end
end
end
end
addEventHandler("onClientRender", root, raporcik)



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

function uszkooo()
if getElementData(localPlayer,"admin:zalogowano") == "true" then
	local getjudcfgucho = getElementData(localPlayer,"player:ucho") or false;
	if getjudcfgucho == true then
	local tt={}
	for i,c in ipairs(gameView) do
		if c then table.insert(tt,c) end
	end
	--table.sort(tt)
	concat=table.concat(tt, "\n")
        dxDrawText(concat, (screenW * 0.0094) + 1, (screenH * 0.4778) + 1, (screenW * 0.2391) + 1, (screenH * 0.6759) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        dxDrawText(concat, screenW * 0.0094, screenH * 0.4778, screenW * 0.2391, screenH * 0.6759, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        --dxDrawText(concat, (screenW * 0.0292) + 1, (screenH * 0.4074) + 1, (screenW * 0.2589) + 1, (screenH * 0.6667) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        --dxDrawText(concat, screenW * 0.0292, screenH * 0.4074, screenW * 0.2589, screenH * 0.6667, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        --dxDrawText(concat, (screenW * 0.0292) + 1, (screenH * 0.4991) + 1, (screenW * 0.2589) + 1, (screenH * 0.6972) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        --dxDrawText(concat, screenW * 0.0292, screenH * 0.4991, screenW * 0.2589, screenH * 0.6972, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
end
end
end
addEventHandler("onClientRender", root, uszkooo)

local lista = {}

function startTicker()
    if odliczanie == "GO!" then
        odliczanie = false
	    destroyElement(sphere)
	else
    	if odliczanie > 0 then
			odliczanie = odliczanie - 1
			setTimer(startTicker, 1000, 1)
			if odliczanie == 0 then odliczanie = "GO!"; end
		end
	end
end

addEventHandler("onClientRender", root, function()
    if (odliczanie) then
	lista = getElementsWithinColShape(sphere, 'player')
	 	for i,v in pairs(lista) do
			if v==localPlayer then
            	dxDrawText(odliczanie, (screenW * 0.4307) - 1, (screenH * 0.1843) - 1, (screenW * 0.5693) - 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) + 1, (screenH * 0.1843) - 1, (screenW * 0.5693) + 1, (screenH * 0.2667) - 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) - 1, (screenH * 0.1843) + 1, (screenW * 0.5693) - 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, (screenW * 0.4307) + 1, (screenH * 0.1843) + 1, (screenW * 0.5693) + 1, (screenH * 0.2667) + 1, tocolor(0, 0, 0, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
            	dxDrawText(odliczanie, screenW * 0.4307, screenH * 0.1843, screenW * 0.5693, screenH * 0.2667, tocolor(255, 255, 255, 255), 3.50, "pricedown", "center", "center", false, false, false, false, false)
			end
		end
    end
end)

addEvent("oczliczStart", true)
addEventHandler("oczliczStart", root, function(x,y,z)
	sphere = createColSphere(x,y,z, 67) --//rendering
	setElementPosition(sphere, x, y, z+1)
    odliczanie = 6
    startTicker()
end)



addEventHandler("onClientRender", root, function()
    if (playerWarning) then
        dxDrawRectangle( 100,100,sw-200, sh-200, tocolor(255,0,0,100), true)
        dxDrawText( "Otrzymałeśa/aś ostrzeżenie:", 100, 100, sw-100, sh/2-20, tocolor(255,255,255), 3.0, "default-bold", "center", "bottom", true, true,true)
        dxDrawText( playerWarning, 100,sh/2+20, sw-100, sh-100, tocolor(0,0,0), 2.0, "default-bold", "center", "top", true, true,true )
        dxDrawText("Nie stosowanie się do ostrzeżeń, może skutkować wyrzuceniem z serwera lub banem!", 186/1280*sw, 558/720*sh, 1136/1280*sw, 588/720*sh, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "top", false, false, true, false, false)
        return
    end
end)

addEvent("onPlayerWarningReceived", true)
addEventHandler("onPlayerWarningReceived", root, function(tresc)
    if source==localPlayer then
        playerWarning=tresc
        setTimer(hidePlayerWarning, 7000, 1)
        setTimer(playSoundFrontEnd, 400, 3, 5)
    end
end)

function renderingInfo()

    dxDrawRectangle(screenW * 0.0000, screenH * 0.9435, screenW * 0.3464, screenH * 0.0472, tocolor(0, 0, 0, 156), false)
	dxDrawText(xtext:gsub("#%x%x%x%x%x%x",""), (screenW * 0.0078) + 1, (screenH * 0.9481) + 1, (screenW * 0.3380) + 1, (screenH * 0.9861) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
    dxDrawText(xtext:gsub("#%x%x%x%x%x%x",""), screenW * 0.0078, screenH * 0.9472, screenW * 0.3380, screenH * 0.9852, tocolor(255, 0, 0, 255), 1.00, "default", "center", "center", false, true, false, false, false)
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end

addEvent("admin:rendering", true)
addEventHandler("admin:rendering", root, function(text)
	xtext=text
	if isEventHandlerAdded("onClientRender",root,renderingInfo) then
		removeEventHandler ( "onClientRender", root, renderingInfo)
	end
	addEventHandler("onClientRender", root, renderingInfo)
	setTimer(function()
		removeEventHandler("onClientRender", root, renderingInfo)
	end, 10000, 1)
end)


addEvent("veh_kryptonim", true)
addEventHandler("veh_kryptonim", root, function(auto)
shader = dxCreateShader('shader.fx')
	txd = dxCreateTexture("test2.png")
	dxSetShaderValue( shader, "gTexture", txd )
engineApplyShaderToWorldTexture(shader, "vehiclepoldecals128", auto)
end)


addEventHandler("onClientRender", root,function()
local rootx, rooty, rootz = getCameraMatrix()

for i,vehicle in ipairs(getElementsByType("vehicle")) do
	local x,y,z=getElementPosition(vehicle)
	local sx,sy=getScreenFromWorldPosition(x,y,z)
	if sx and sy then
	local vopis=getElementData(vehicle,"vehicle:vopis")
	local zapelnienie=getElementData(vehicle,"vehicle:zapelnienie") or 0
	local jobCar=getElementData(vehicle,"vehicle:jobcode") or false
	
	local salonCar=getElementData(vehicle,"vehicle:desc");
	local salon=getElementData(vehicle,"vehicle:salon") or false;
	
	local gieldaCar=getElementData(vehicle,"vehicle:gielda") or false;
	local gieldaOpis=getElementData(vehicle,"vehicle:gieldaOpis") or "";
	
	if salonCar and salon==true then
	local x,y,z=getElementPosition(vehicle)
	local sx,sy=getScreenFromWorldPosition(x,y,z+1.3)
	if sx and sy then
	
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 15; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,vehicle ) then
	dxDrawText(""..salonCar:gsub("#%x%x%x%x%x%x",""), sx-(sw/10)+1,sy+1,sx+(sw/10)+1,sy+1, tocolor(0,0,0,255), 1.1, "default-bold", "center","center",false,false,false,true,true)
    dxDrawText("#ffffff"..salonCar:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy,sx+(sw/10),sy, tocolor(255,255,255,255), 1.1, "default-bold", "center","center",false,false,false,true,true)
	end
	end
			
    end
	end
	
	if vopis and salon==false then
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 28; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,vehicle ) then
    dxDrawText(vopis:gsub("#%x%x%x%x%x%x",""), sx-(sw/10),sy,sx+(sw/10),sy, tocolor(255,255,255,255), 1.0, "default", "center","center",false,true)
	end
	end
	
	else
	
	if zapelnienie >= 0 and jobCar=="dune-lv" then
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 28; -- // tutaj zmien jak chcesz wiecej mniej
	
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,vehicle ) then
    dxDrawText("Zapełnienie: "..zapelnienie.."%", sx-(sw/10),sy,sx+(sw/10),sy, tocolor(255,255,255,255), 1.0, "default", "center","center",false,true)
	end
	end
	end
	
	end
	
	end
end


for i,ped in ipairs(getElementsByType("ped")) do
	local x,y,z=getPedBonePosition(ped,1)
	local sx,sy=getScreenFromWorldPosition(x,y,z+1)
	if sx and sy then
	local vopis=getElementData(ped,"ped:name")
	if vopis then
    local flX = math.floor(sx)
    local flY = math.floor(sy)
	local skala_textu = 1.10;
	local sksh = 1.1;
	local opacity = 255;
	local distance=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
	local rend = 15; -- // tutaj zmien jak chcesz wiecej mniej
    if distance <= rend then
	if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true, ped) then
	dxDrawText(vopis:gsub("#%x%x%x%x%x%x",""), flX+1, flY+1, flX+1, flY+1, tocolor(0, 0, 0, opacity), skala_textu, "default-bold", "center", "center",false,false,false,true,true)
	dxDrawText(vopis:gsub("#%x%x%x%x%x%x",""), flX, flY, flX, flY, tocolor(166, 166, 166, opacity), skala_textu, "default-bold", "center", "center",false,false,false,true,true)
	end
	end
	end
	end
end


local font = "default-bold"; -- default-bold
--local font = dxCreateFont('Roboto-Bold.ttf', 8.3)

for i, v in ipairs(getElementsByType("player")) do
			if v == localPlayer then else
			setPlayerNametagShowing(v,false);
			--//DYSTANS RENDERU//--
			rendering = 35; --// TUTAJ ZMIEN //--
			--//DYSTANS RENDERU//--
			local x,y,z = getPedBonePosition(v,1)
			if x ~= 0 and y ~= 0 and z ~= 0 then -- wazne, bo potem wyswietla sie pod mapa na 0,0,0 nie weim czemu.
			
			local distance = getDistanceBetweenPoints3D(rootx, rooty, rootz, x, y, z)
		    local sx, sy = getScreenFromWorldPosition(x, y, z+1.1)
			
			--?? TUTAJ CZY NIE MA INVA ??--
--			if getElementAlpha(v) > 0 then
			--//TUTAJ SPRAWDZAMY CZYWIDA NA EKRANIE //--
			if sx then -- // JEŚLI TAK POKAZ, JEŚLI =/= POKAZ
			
            local flX = math.floor(sx)
            local flY = math.floor(sy)
			local skala_textu = 1.1;
			local sksh = 1.1;
			opacity = 255;
			if distance > 26 then skala_textu = 1; opacity = 177; end

			--//SPRAWDZAMY DYSTANS RENDERU
			if distance < rendering then
--			if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,v ) then
			
			wyb_premka = getElementData(v,"player:premium") or 0;
			if wyb_premka == 1 then nickcolor = "#EFD00C"; else  nickcolor = "#ffffff"; end
			
			if getElementAlpha(v) > 0 then
			--// TUTAJ WYBIERAMY ADMINA RCON
			if getElementData(v,"admin:poziom") == 10 then 
			admin_name = "RCON";
			--admin_colorid = "#FFFFFF(#cf0000"..getElementData(v,"id").."#FFFFFF)";
			admin_colorid = "#FFFFFF("..getElementData(v,"id")..")";
			--// IF JEST DUTY
			if getElementData(v,"admin:zalogowano") == "true" then
			admin_colorid = "#FFFFFF("..getElementData(v,"id").."#FFFFFF)";
			dxDrawText(""..admin_name.."", flX+sksh, (flY-16)+sksh, flX+sksh, (flY-16)+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			dxDrawText("#330000"..admin_name.."#FFFFFF", flX, flY-16, flX, flY-16, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			--// NORMALNY NICK + COL ID
		    dxDrawText(""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." ("..getElementData(v,"id")..")", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
		    dxDrawText(""..nickcolor..""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." "..admin_colorid.."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			end
			
			-- jesli admin jest na duty, to widzi, jesli nie to nie widzi // ponizej warunek pokazuje nawet poza duty
			if getElementAlpha(v) > 0 or ( getElementData(localPlayer,"admin:poziom") >= 7 and getElementData(localPlayer,"admin:zalogowano") == "true" ) then
            --if getElementAlpha(v) > 0 or getElementData(localPlayer,"admin:poziom") >= 7 then
			--// TUTAJ WYBIERAMY ADMINA
			if getElementData(v,"admin:poziom") == 7 then 
			admin_name = "Administrator";
			--admin_colorid = "#FFFFFF(#cf0000"..getElementData(v,"id").."#FFFFFF)";
			admin_colorid = "#FFFFFF("..getElementData(v,"id")..")";
			--// IF JEST DUTY
			if getElementData(v,"admin:zalogowano") == "true" then
			admin_colorid = "#FFFFFF("..getElementData(v,"id").."#FFFFFF)";
			dxDrawText(""..admin_name.."", flX+sksh, (flY-16)+sksh, flX+sksh, (flY-16)+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			dxDrawText("#cf0000"..admin_name.."", flX, flY-16, flX, flY-16, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			--// NORMALNY NICK + COL ID
		    dxDrawText(""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." ("..getElementData(v,"id")..")", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
		    dxDrawText(""..nickcolor..""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." "..admin_colorid.."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
            end
			
			
			if getElementAlpha(v) > 0 or ( getElementData(localPlayer,"admin:poziom") >= 7 and getElementData(localPlayer,"admin:zalogowano") == "true" ) then
			--// TUTAJ WYBIERAMY MODA
			if getElementData(v,"admin:poziom") == 6 then 
			admin_name = "Moderator";
			--admin_colorid = "#FFFFFF(#cf0000"..getElementData(v,"id").."#FFFFFF)";
			admin_colorid = "#FFFFFF("..getElementData(v,"id")..")";
			--// IF JEST DUTY
			if getElementData(v,"admin:zalogowano") == "true" then
			admin_colorid = "#FFFFFF("..getElementData(v,"id").."#FFFFFF)";
			dxDrawText(""..admin_name.."", flX+sksh, (flY-16)+sksh, flX+sksh, (flY-16)+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			dxDrawText("#1f6e04"..admin_name.."", flX, flY-16, flX, flY-16, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			--// NORMALNY NICK + COL ID
		    dxDrawText(""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." ("..getElementData(v,"id")..")", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
		    dxDrawText(""..nickcolor..""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." "..admin_colorid.."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			end
			
			
			
			if getElementAlpha(v) > 0 or ( getElementData(localPlayer,"admin:poziom") >= 7 and getElementData(localPlayer,"admin:zalogowano") == "true" ) then
			--// TUTAJ WYBIERAMY SUPPA
			if getElementData(v,"admin:poziom") == 5 then 
			admin_name = "Support";
			--admin_colorid = "#FFFFFF(#cf0000"..getElementData(v,"id").."#FFFFFF)";
			admin_colorid = "#FFFFFF("..getElementData(v,"id")..")";
			--// IF JEST DUTY
			if getElementData(v,"admin:zalogowano") == "true" then
			admin_colorid = "#FFFFFF("..getElementData(v,"id").."#FFFFFF)";
			dxDrawText(""..admin_name.."", flX+sksh, (flY-16)+sksh, flX+sksh, (flY-16)+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			dxDrawText("#3095bd"..admin_name.."", flX, flY-16, flX, flY-16, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			--// NORMALNY NICK + COL ID
		    dxDrawText(""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." ("..getElementData(v,"id")..")", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
		    dxDrawText(""..nickcolor..""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").." "..admin_colorid.."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			end
			
			if getElementAlpha(v) > 0 or ( getElementData(localPlayer,"admin:poziom") >= 7 and getElementData(localPlayer,"admin:zalogowano") == "true" ) then
			--// TUTAJ WYBIERAMY GRACZA
			sprawdzampoziom = getElementData(v,"admin:poziom") or 0;
			if getElementData(v,"admin:poziom") == 0 then 
			admin_colorid = "#FFFFFF("..getElementData(v,"id")..")";
			--// IF JEST DUTY
			--// NORMALNY NICK + COL ID
		    dxDrawText("("..getElementData(v,"id")..") "..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."", flX+sksh, flY+sksh, flX+sksh, flY+sksh, tocolor(0, 0, 0, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
		    dxDrawText(""..admin_colorid.." "..nickcolor..""..getPlayerName(v):gsub("#%x%x%x%x%x%x","").."", flX, flY, flX, flY, tocolor(255, 255, 255, opacity), skala_textu, font, "center", "center",false,false,false,true,true)
			end
			end
		
			end
--			end
--			end -- elementVisible
            end
			end
		end
	end

end)


addEvent("uruchomOdliczanieStart", true)
addEventHandler("uruchomOdliczanieStart", root, function(plr)
if localPlayer == plr then
    zakuppojazdu=setTimer(function()
	    triggerServerEvent("removeZakuPojCzasEnd",localPlayer,localPlayer)
	end, 30000, 1) --- 30000
end
end)

addEvent("zakonczOdliczanieEnd", true)
addEventHandler("zakonczOdliczanieEnd", root, function(plr)
if localPlayer == plr then
    killTimer(zakuppojazdu)
end
end)


