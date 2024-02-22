--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	TEST TEST
]]--

defi = {}
local screenW, screenH = guiGetScreenSize()
local aktywne = {}

defi.okno = guiCreateWindow((screenW - 556) / 2, (screenH - 254) / 2, 556, 254, "Defibrylator", false)
guiWindowSetSizable(defi.okno, false)
	
defi.btn_zatokowy = guiCreateButton(327, 29, 219, 31, "Rytm zatokowy", false, defi.okno)
defi.btn_migotanie = guiCreateButton(327, 70, 219, 31, "Migotanie komór", false, defi.okno)
defi.btn_asystolia = guiCreateButton(327, 111, 219, 31, "Asystolia", false, defi.okno)
defi.btn_losowo = guiCreateButton(327, 152, 219, 31, "Losowanie wyboru", false, defi.okno)
defi.btn_exit = guiCreateButton(327, 213, 219, 31, "Zamknij", false, defi.okno)
defi.imagetype = guiCreateStaticImage(10, 80, 307, 154, ":aj-log2/ajoneg.png", false, defi.okno)
defi.nametype = guiCreateLabel(10, 29, 307, 31, "KOMPUTER: ---", false, defi.okno)
guiLabelSetHorizontalAlign(defi.nametype, "center", false)
guiLabelSetVerticalAlign(defi.nametype, "center")    
guiSetVisible(defi.okno, false)

local defifunctions = {
	{
		name="Rytm zatokowy",
		img=":aj-testy/zatokowy.png",
		song=":aj-testy/zatokowy.mp3",
		volume=1.5,
	},
	{
		name="Migotanie komór",
		img=":aj-testy/migotanie.png",
		song=":aj-testy/migotanie.mp3",
		volume=3.5,
	},
	{
		name="Asystolia",
		img=":aj-testy/asystolia.jpg",
		song=":aj-testy/asystolia.mp3",
		volume=1,
	},
}

addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == defi.btn_exit then
		showCursor(false)
		guiSetVisible(defi.okno, false)
		defibry = sprDefiBlisko(localPlayer);
		setElementData(defibry,"defi:used",false)
	end
	
	if source == defi.btn_zatokowy then
		defibry = sprDefiBlisko(localPlayer);
		if not aktywne[defibry] then
			playSound(1,defibry)
		end
	end
	
	if source == defi.btn_migotanie then
		defibry = sprDefiBlisko(localPlayer);
		if not aktywne[defibry] then
			playSound(2,defibry)
		end
	end
	
	if source == defi.btn_asystolia then
		defibry = sprDefiBlisko(localPlayer);
		if not aktywne[defibry] then
			playSound(3,defibry)
		end
	end
	
	if source == defi.btn_losowo then
		defibry = sprDefiBlisko(localPlayer);
		if not aktywne[defibry] then
			local calosc = #defifunctions
			local rand = math.random(1,calosc)
			playSound(rand,defibry)
		end
	end
	
end)

function removeactive(obj)
	aktywne[obj] = false
end

function playSound(type,defibry)
	local vv = getType(type)
	aktywne[defibry] = playSound3D(vv.song, 0, 0, 2000, false)
	setSoundVolume(aktywne[defibry], vv.volume)
	setSoundEffectEnabled(aktywne[defibry],"compressor",true)
	setSoundMinDistance(aktywne[defibry],1)
	setSoundMaxDistance(aktywne[defibry],25)
	attachElements(aktywne[defibry], defibry) -- nakladam
	guiStaticImageLoadImage(defi.imagetype,vv.img)
	guiSetText(defi.nametype, "KOMPUTER: "..vv.name)
	setTimer(removeactive, 5000, 1, defibry)
	triggerServerEvent("localInfoChat",root,localPlayer,"odczytał wynik defibrylatora #EBB85D"..vv.name.."#e7d9b0.",45)
end

function getType(type)
	for i, v in ipairs(defifunctions) do
		if i == type then
			return v
		end
	end
	return false
end

function sprDefiBlisko(gracz)
	x,y,z = getElementPosition(gracz)
	for k, v in ipairs(getElementsByType("object",root)) do
		local defib = getElementData(v,"defi") or false
		if defib then
			fX,fY,fZ = getElementPosition(v)
			dist = getDistanceBetweenPoints3D(x,y,z,fX,fY,fZ)
			if tonumber(dist) < 1.7 then
				local used = getElementData(v,"defi:used") or false
				if not used or used==localPlayer then
					return v
				end
			end
		end
	end
	return false
end

function chceckdefi()
	local defib = getElementsByType('object')
	for _, def in pairs(defib) do
		local defib = getElementData(def,"defi") or false
		if defib then
			return true
		end
	end	
	return false
end

function defifn()
	wynik = chceckdefi()
	if not wynik then
		local e = getCameraTarget()
		local x,y,z = getElementPosition(e)
		local _,_,rz = getElementRotation(e)
		local rrz = math.rad(rz)
		local x = x + (1 * math.sin(-rrz))
		local y = y + (1 * math.cos(-rrz))
		--setElementPosition(e, x, y, z)
		
		obj = createObject(1238, x, y, z-0.65)
		setElementData(obj,"defi",true)
	else
		-- jesli mamy defi
		defibry = sprDefiBlisko(localPlayer);
		if defibry then
			guiSetVisible(defi.okno, true)
			showCursor(true)
			setElementData(defibry,"defi:used",localPlayer)
		end
	end
end

bindKey("e", "down", defifn)












