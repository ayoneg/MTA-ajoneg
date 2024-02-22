--==================--  --==================--  --==================--
addEventHandler("onClientRender", root, function()
	local rootx,rooty,rootz=getCameraMatrix()
	local dim=getElementDimension(localPlayer)
	local int=getElementInterior(localPlayer)
	
	local texty=getElementsByType("text")
	for i,text in pairs(texty) do
		if text and isElement(text) and getElementDimension(text) == dim and getElementInterior(text) == int then
			local x,y,z=getElementPosition(text)
			local dist=getDistanceBetweenPoints3D(rootx,rooty,rootz,x,y,z)
			local distance = getElementData(text,"distance") or 15;
			if dist < distance then
				local sx,sy=getScreenFromWorldPosition(x,y,z, 100, true)
				if sx and sy then
					local name=getElementData(text,"name")
					local scale = getElementData(text,"scale") or 1; -- 1 to domyslna wartosc
					local font = getElementData(text,"font") or "default";
					local color = getElementData(text,"color") or tocolor(255,255,255,255)
					if not name then return end
					if isLineOfSightClear( rootx,rooty,rootz, x,y,z, true, true, false, true, false, true, true,text ) then
						local plar = getElementData(localPlayer,"player:robimisje") or false;
						if not plar then
							dxDrawText(name, sx-1, sy-1, sx-1, sy-1, tocolor(0,0,0,255), scale, font, "center", "center", false)
							dxDrawText(name, sx+1, sy-1, sx+1, sy-1, tocolor(0,0,0,255), scale, font, "center", "center", false)
							dxDrawText(name, sx-1, sy+1, sx-1, sy+1, tocolor(0,0,0,255), scale, font, "center", "center", false)
							dxDrawText(name, sx+1, sy+1, sx+1, sy+1, tocolor(0,0,0,255), scale, font, "center", "center", false)
							dxDrawText(name, sx, sy, sx, sy, color, scale, font, "center", "center", false)
						end
					end
        		end
        	end
        end
    end
end)
--==================--  --==================--  --==================--