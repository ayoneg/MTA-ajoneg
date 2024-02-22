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
	if getjudcfgucho then
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

