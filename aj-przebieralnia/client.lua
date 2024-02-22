local sc,sy = guiGetScreenSize()

local wyb_skiny = createMarker(161.3671875, -83.251953125, 1001.8046875-1, "cylinder", 1.8, 255, 255, 255, 22)
setElementInterior(wyb_skiny, 18)
setElementDimension(wyb_skiny,300)
local ped = createPed(93, 161.4736328125, -80.2109375, 1001.8046875, 180)
setElementInterior(ped, 18)
setElementDimension(ped, 300)
setElementFrozen(ped, true)

local skiny_meskie = {0, 1, 2, 7, 14, 15, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 72, 73, 78, 79, 80, 81, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 168, 170, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 234, 235, 236, 241, 242, 247, 249, 250, 252, 253, 254, 255, 258, 259, 260, 269, 270, 271, 272, 290, 291, 292, 293, 294, 295, 297, 299, 303, 306, 307, 308, 311, 312}
local skiny_damskie = {12, 13, 31, 38, 39, 40, 41, 54, 55, 56, 76, 77, 88, 89, 90, 91, 93, 129, 130, 131, 140, 141, 148, 150, 151, 157, 169, 172, 190, 191, 192, 193, 194, 195, 196, 197, 199, 207, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 243, 263}

local skiny_meskie_prem = {20, 82, 83, 84, 97, 124, 125, 126, 248, 261, 262, 296, 300, 301, 302, 310} -- test

local skiny_damskie_prem = {9, 11, 87, 178, 198, 211, 214, 244, 245, 246, 256, 257, 298, 304} -- test

local lst = {}
lst.przok = guiCreateWindow(0.70, 0.39, 0.19, 0.49, "Przebieralnia (beta)", true)
guiWindowSetMovable(lst.przok, false)
guiWindowSetSizable(lst.przok, false)
lst.przgrdlist_all = guiCreateGridList(0.04, 0.06, 0.92, 0.91, true, lst.przok)
guiGridListAddColumn(lst.przgrdlist_all, "ID skina", 0.9)    
guiSetVisible(lst.przok, false)	
guiGridListSetSortingEnabled(lst.przgrdlist_all, false)

function pokazSkiny()

    guiGridListClear(lst.przgrdlist_all) -- me
	local spr_plec = getElementData(localPlayer,"player:plec") or 0;
	
	if spr_plec == 0 then
    local row = guiGridListAddRow(lst.przgrdlist_all)
    guiGridListSetItemText(lst.przgrdlist_all, row, 1, "Skiny  męskie", true, false)
	guiGridListSetItemColor(lst.przgrdlist_all, row, 1, 14, 0, 255)
    for i,v in ipairs(skiny_meskie) do
        local row = guiGridListAddRow(lst.przgrdlist_all)
        guiGridListSetItemText(lst.przgrdlist_all, row, 1, v, false, false)
    end
	-- // tutaj premium boy
	
    local row = guiGridListAddRow(lst.przgrdlist_all)
    guiGridListSetItemText(lst.przgrdlist_all, row, 1, "Skiny  premium", true, false)
	guiGridListSetItemColor(lst.przgrdlist_all, row, 1, 239, 208, 12)
    for i,v in ipairs(skiny_meskie_prem) do
        local row = guiGridListAddRow(lst.przgrdlist_all)
        guiGridListSetItemText(lst.przgrdlist_all, row, 1, v, false, false)
		guiGridListSetItemData(lst.przgrdlist_all, row, 1, "player:premium")
    end
	end
	
	if spr_plec == 1 then
    local row = guiGridListAddRow(lst.przgrdlist_all)
    guiGridListSetItemText(lst.przgrdlist_all, row, 1, "Skiny  damskie", true, false)
	guiGridListSetItemColor(lst.przgrdlist_all, row, 1, 255, 0, 97) -- ROZOWY <33
    for i,v in ipairs(skiny_damskie) do
        local row = guiGridListAddRow(lst.przgrdlist_all)
        guiGridListSetItemText(lst.przgrdlist_all, row, 1, v, false, false)
    end
	-- // tutaj premium girl
	
    local row = guiGridListAddRow(lst.przgrdlist_all)
    guiGridListSetItemText(lst.przgrdlist_all, row, 1, "Skiny  premium", true, false)
	guiGridListSetItemColor(lst.przgrdlist_all, row, 1, 239, 208, 12)
    for i,v in ipairs(skiny_damskie_prem) do
        local row = guiGridListAddRow(lst.przgrdlist_all)
        guiGridListSetItemText(lst.przgrdlist_all, row, 1, v, false, false)
		guiGridListSetItemData(lst.przgrdlist_all, row, 1, "player:premium")
    end

	end

	

end


addEventHandler("onClientGUIClick", root, function()
    if source == lst.przgrdlist_all then
    local slRow, slCol = guiGridListGetSelectedItem(lst.przgrdlist_all)
    if not slRow or slCol ~= 1 then return end
    local premium = guiGridListGetItemData(lst.przgrdlist_all, slRow, slCol)
	local plr_premium = getElementData(localPlayer, "player:premium") or 0;
    if premium and tonumber(plr_premium) ~= 1 then
        outputChatBox("* Ten skin jest dostępny dla graczy Premium.")
        return
    end
    local skin_id = guiGridListGetItemText(lst.przgrdlist_all, slRow, slCol)
    if not skin_id then return end
    triggerServerEvent("zmianaSkinaGraczowi", localPlayer, tonumber(skin_id))
	-- // tutaj premium // jeszcze nie ma
	end
end)

addEventHandler("onClientMarkerLeave", wyb_skiny, function(el, md)
    if el ~= localPlayer then return end
    if guiGetVisible(lst.przok) == true then
    showCursor(false)
    guiSetVisible(lst.przok, false)
    end
end)


addEventHandler("onClientMarkerHit", wyb_skiny, function(el,md)
    if el ~= localPlayer then return end
    if guiGetVisible(lst.przok) == false then
    pokazSkiny()
    showCursor(true, false)
    guiSetVisible(lst.przok, true)
    end
end)