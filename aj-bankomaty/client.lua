----------------------------------
local sw,sh = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
addEventHandler("onClientPreRender", root, function()
if not getElementData(localPlayer,"player:dbid") then return end
	local x,y,z = getElementPosition(localPlayer)
	local ulica = getZoneName(x,y,z, false)
	local ulica2 = getZoneName(x,y,z, true)
	if ulica2~=ulica then ulica = "   "..ulica.."\n"..ulica2 else ulica = "   "..ulica end
	if dxSetAspectRatioAdjustmentEnabled then
		dxSetAspectRatioAdjustmentEnabled(true)
	end
	if isPlayerHudComponentVisible("radar") and getElementInterior(localPlayer) == 0 and getElementData(localPlayer,"player:hud2") == true then
		--dxDrawText(ulica, sw*4.2/20, sh*18/20, sw*4/20, sh*18/20+sh*1/21.9, tocolor(255, 255, 255), 1.4, "Arial", "left", "center", false)
        dxDrawText(ulica, (screenW * 0.2052) + 1, (screenH * 0.8787) + 1, (screenW * 0.3849) + 1, (screenH * 0.9269) + 1, tocolor(0, 0, 0, 166), 1.1, "diploma", "left", "center", false, false, false, false, false)
        dxDrawText(ulica, screenW * 0.2052, screenH * 0.8787, screenW * 0.3849, screenH * 0.9269, tocolor(255, 255, 255, 200), 1.1, "diploma", "left", "center", false, false, false, false, false)
		--dxDrawText(ulica, 171, 551, 488, 642, tocolor(255, 255, 255, 255), 1.50, dxfont0_tak, "center", "center", false, false, false, false, false)
		
	end
end)
---------------------------------------
--test hud monmey

local screenW, screenH = guiGetScreenSize()
local lp = getLocalPlayer() -- ^^
local money = 0
local addmoney = false

local licze = false
local gtmoney = 0
function liczeStop(ile)
	if not licze then
		gtmoney = ile
		licze = true
	end
end

function render()
    if getElementData(localPlayer,"player:dbid") and getElementData(localPlayer,"player:spawn") and getElementData(localPlayer,"player:pokazKase") and getElementData(localPlayer,"player:hud2") == true then
	
	
	local currentMoney = getPlayerMoney(lp)
	if currentMoney ~= money then
	local ile = currentMoney-money
	
	if ile >= 0 then znaczek = "+ "; color = tocolor(47, 90, 38, 255); end
	if ile < 0 then znaczek = "- "; color = tocolor(128, 0, 0, 255); ile=ile*(-1) end
	liczeStop(ile)
		if currentMoney < money then 
			local moneydiff = money-currentMoney
			local abzug = math.ceil(moneydiff/20)
			money = money-abzug
		else 
			local moneydiff = currentMoney-money
			local abzug = math.ceil(moneydiff/20)
			money = money+abzug
		end
		
		addmoney = gtmoney
		addmoney = string.format("%.2f", addmoney/100)
	else
		if addmoney then
			addmoney = false
			licze = false
			gtmoney = 0
		end
	end
	
--	local addmoney = getElementData("",add)
        local money = string.format("%.2f", money/100)
		
		local screenW, screenH = guiGetScreenSize()
		local scale = (screenH * 0.0024)

        dxDrawText("$"..money, (screenW * 0.7818) - 1, (screenH * 0.2350) - 1, (screenW * 0.9510) - 1, (screenH * 0.2813) - 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, (screenW * 0.7818) + 1, (screenH * 0.2350) - 1, (screenW * 0.9510) + 1, (screenH * 0.2813) - 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, (screenW * 0.7818) - 1, (screenH * 0.2350) + 1, (screenW * 0.9510) - 1, (screenH * 0.2813) + 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, (screenW * 0.7818) + 1, (screenH * 0.2350) + 1, (screenW * 0.9510) + 1, (screenH * 0.2813) + 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..money, screenW * 0.7818, screenH * 0.2350, screenW * 0.9510, screenH * 0.2813, tocolor(47, 90, 38, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
		if addmoney then
			dxDrawText(znaczek.."$"..addmoney, (screenW * 0.7818) - 1, (screenH * 0.2813) - 1, (screenW * 0.9510) - 1, (screenH * 0.3276) - 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
			dxDrawText(znaczek.."$"..addmoney, (screenW * 0.7818) + 1, (screenH * 0.2813) - 1, (screenW * 0.9510) + 1, (screenH * 0.3276) - 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
			dxDrawText(znaczek.."$"..addmoney, (screenW * 0.7818) - 1, (screenH * 0.2813) + 1, (screenW * 0.9510) - 1, (screenH * 0.3276) + 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
			dxDrawText(znaczek.."$"..addmoney, (screenW * 0.7818) + 1, (screenH * 0.2813) + 1, (screenW * 0.9510) + 1, (screenH * 0.3276) + 1, tocolor(0, 0, 0, 255), scale, "pricedown", "right", "center", false, false, false, false, false)
			dxDrawText(znaczek.."$"..addmoney, screenW * 0.7818, screenH * 0.2813, screenW * 0.9510, screenH * 0.3276, color, scale, "pricedown", "right", "center", false, false, false, false, false)
		end
   end
end

addEventHandler("onClientRender", root, render)
---------------------------------------





--------------------------------
local bankomaty={
{1879.19140625, 2341.130859375, 9.90, -0.00, 0.00, 90.16, 0, 0},
{2445.2529296875, 2380.765625, 11.163512229919, 0, 0, 0, 0, 0},
{1734.65, 1853.2, 9.8203125, 0, 0, 180, 0, 0},
{2498.79296875, 1022.87890625, 9.8203125, 0, 0, 0, 0, 0},
{377.064453125, 168.07421875, 1007.3828125, 0, 0, -90, 3, 300},
--{916.8447265625, 2044.1220703125, 9.820312, 0, 0, -90, 0, 0}, -- jedna 4 mili
{2019.3193359375, 1014.4794921875, 9.820312, 0, 0, 90, 0, 0},
{-94.083984375, 1083.232421875, 18.7421875, 0, 0, 180, 0, 0},
{-256.21484375, 2605.837890625, 61.858154296875, 0, 0, 180, 0, 0},
{-2281.947265625, 2299.4296875, 3.977644920349, 0, 0, 90, 0, 0},

{1048.328125, 1797.189453125, 10.8203125-1, 0, 0, -180, 0, 0}, -- mechanik lv

{-87.865234375, 1372.4228515625, 10.2734375-1, 0, 0, 100, 0, 0}, -- cygan fc

{2528.2255859375, 1518.001953125, 10.819393157959-1, 0, 0, 180, 0, 0}, -- osredek wypoczynkowy
{2621.6337890625, 2346.3232421875, 10.8203125-1, 0, 0, 20, 0, 0}, -- rockhotel
}

for i,v in ipairs(bankomaty) do

	v.obiekt=createObject(2618,v[1],v[2],v[3],v[4],v[5],v[6])
	setElementInterior(v.obiekt,v[7] or 0)
	setElementDimension(v.obiekt,v[8] or 0)
	setElementFrozen(v.obiekt,true)
	setObjectBreakable ( v.obiekt, false )
	
	if v[8] ~= 0 and v[7] ~= 0 then else
	v.mapicon=createBlip(v[1],v[2],v[3], 52, 1, 5,255,5,255, -1000, 400)
	--v.mapicon=exports.customblips:createCustomBlip (v[1],v[2], 25, 25, "radar_cash.png", 400)
--	v.mapicon=exports.customblips:createCustomBlip(v[1], v[2], 20, 20, "radarcash.png" )
	end
	
	v.cs=createColSphere(v[1],v[2],v[3]+1, 1)
	setElementInterior(v.cs,v[7] or 0)
	setElementDimension(v.cs,v[8] or 0)
	
	v.text=createElement('text')
	setElementData(v.text,"name","Bankomat")
	setElementPosition(v.text,v[1],v[2],v[3]+2)
	setElementInterior(v.text,v[7] or 0)
	setElementDimension(v.text,v[8] or 0)
end



--marker BANKOMAT ------------------------------------------------------------------------------------------	
--marker BANKOMAT ------------------------------------------------------------------------------------------

--        okno = guiCreateWindow(0.40, 0.32, 0.20, 0.37, "Bankomat", true)
        okno = guiCreateWindow(0.40, 0.22, 0.21, 0.53, "Bankomat", true)
        guiWindowSetSizable(okno, false)
		--exitbanko = guiCreateButton(0.90, 0.05, 0.05, 0.05, "X", true, okno)
        exitbanko = guiCreateButton(0.10, 0.82, 0.81, 0.13, "Anuluj", true, okno)    		
		
		
        input_ = guiCreateEdit(0.10, 0.35, 0.81, 0.07, "", true, okno)
        button_wplac = guiCreateButton(0.10, 0.48, 0.81, 0.08, "Wpłać gotówkę", true, okno)
        --input_wyplac = guiCreateEdit(0.10, 0.58, 0.81, 0.07, "", true, okno)
        button_wyplac = guiCreateButton(0.10, 0.57, 0.81, 0.08, "Wypłać gotówkę", true, okno)
        guiSetVisible(okno, false);
		guiSetProperty(input_, "ValidationString", "^[0-9]*$")
		--guiSetProperty(input_wyplac, "ValidationString", "^[0-9]*$")
	
addEventHandler("onClientColShapeHit", resourceRoot, function(el,md)
    if not md or el~=localPlayer then return end
    if not guiGetVisible(okno) then

        showCursor(true);
        guiSetVisible(okno, true);
        triggerServerEvent("sprBankoKase", root, el);

    end
end)

addEventHandler("onClientGUIClick", root, function(btn,state)
	if source == button_wyplac then
		local get_kwote = tonumber(guiGetText(input_)) or 0;
		local get_kwote = (get_kwote*100)
		if get_kwote == 0 or get_kwote < 1 then 
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłową kwote!",231, 217, 176,true) return end
		if 99999999 < getPlayerMoney(localPlayer)+get_kwote then 
		outputChatBox("#841515✖#e7d9b0 Błąd, osiągnięto limit gotówki przy sobie!",231, 217, 176,true) return end
		
		get_kwote = math.floor(get_kwote);
		
		triggerServerEvent("wyplacGotowke", root, get_kwote)
    end
	if source == button_wplac then
		local get_kwote = tonumber(guiGetText(input_)) or 0;
		local get_kwote = (get_kwote*100)
		if get_kwote == 0 or get_kwote < 1 then 
		
		outputChatBox("#841515✖#e7d9b0 Błąd, podano nieprawidłową kwote!",231, 217, 176,true)  return end
		get_kwote = math.floor(get_kwote);
		
		triggerServerEvent("wplacGotowke", root, get_kwote)
    end
    if source == exitbanko then
    	if guiGetVisible(okno) == true then showCursor(false); destroyElement(desc); guiSetVisible(okno, false); end
    end
end)

addEvent("onClientCloseBankomat", true)
addEventHandler("onClientCloseBankomat", root, function(result)
     if guiGetVisible(okno) == true then showCursor(false); destroyElement(desc); guiSetVisible(okno, false); end
end)

addEvent("onClientReturnBankomat", true)
addEventHandler("onClientReturnBankomat", root, function(result)
--if guiGetVisible(desc) == true then destroyElement(desc); end
         local money = result[1].user_bankmoney;
         local money = string.format("%.2f", money/100)
         desc = guiCreateLabel(0.11, 0.12, 0.77, 0.15, "Właściciel: "..result[1].user_nickname.."\nNumer konta: "..result[1].user_id.." (UID)\n\nStan konta: "..money.."$", true, okno,231, 217, 176,true)
		 guiLabelSetVerticalAlign(desc, "center")  
		 
		 guiSetVisible(desc, true);

end)
	
--marker urzad ------------------------------------------------------------------------------------------	
--marker urzad ------------------------------------------------------------------------------------------


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