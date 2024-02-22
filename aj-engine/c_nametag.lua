local sw, sh = guiGetScreenSize()

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
    dxDrawText("#ffffff"..salonCar, sx-(sw/10),sy,sx+(sw/10),sy, tocolor(255,255,255,255), 1.1, "default-bold", "center","center",false,false,false,true,true)
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