--[[
    By AjonEG <ajonoficjalny@gmail.com> @ 2021 (c)
	Wszelkie prawa zastrzeżone.
	
	Skrypt startu pracy mechanika/tunera/lakiernika.
]]--

local strefy={
	tunerstart={
		cuboid={1937.6494140625, 2122.876953125, 10.8203125-1, 56.6, 55, 7},
    	mpos={1952.892578125, 2175.8984375, 10.893982887268},
    	code="tune-lv",
		maxEmployes=2;
		desc="Praca tuner LV",
		desc2="Warsztat tuningowy",
		desc3="Warsztat: Redsands East LV\n\nStanowiska: 2\n\nZatrudnienie w urzędzie miasta LV.";
	},
	mechanikstart={
		cuboid={1049.6455078125, 1723.6474609375, 10.8203125-0.90, 67, 32.3, 10},
    	mpos={1088.8447265625, 1750.1787109375, 10.8203125},
    	code="mechanik-lv",
		maxEmployes=3;
		desc="Praca mechanik LV",
		desc2="Warsztat samochodowy",
		desc3="Warsztat: Whitewood Estates LV\n\nStanowiska: 3\n\nZatrudnienie w urzędzie miasta LV.";
	},
}

function getEmployees(code)
    local number=0
    for i,v in ipairs(getElementsByType("player")) do
        if getElementData(v,"player:duty") == code then
            number=number+1
        end
    end
    return number
end


for i,v in pairs(strefy) do
	cs=createColCuboid(unpack(v.cuboid))
	setElementData(cs,"tunerobszar",true)
	setElementData(cs,"m:duty",v.code)
	marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1.2, 78, 188, 0, 22)
--	setElementData(marker,"cs",cs)
	setElementData(marker,"tunerstart",true)
	setElementData(marker,"m:duty",v.code)
	setElementData(marker,"m:desc2",v.desc2)
	setElementData(marker,"m:desc3",v.desc3)	
	setElementData(marker,"m:maxEmployes",v.maxEmployes)
	t = createElement("text")
	setElementData(t,"name",v.desc)
	setElementData(t,"scale",1)
	setElementData(t,"distance",17)
	setElementPosition(t,v.mpos[1], v.mpos[2], v.mpos[3])
end


addEventHandler("onMarkerLeave", root, function(el,md)
	local getjob = getElementData(source,"tunerstart") or false
    if getjob then
		if getElementType(el)~="player" then return end
		triggerClientEvent(el,"ukryjPlrGUItunelv",el,getCODE)
	end
end)


-- gdy wyjdzie z obszaru mechanika zakoncz robote
addEventHandler("onColShapeLeave", root, function(el,md)
	local getjob = getElementData(source,"tunerobszar") or false
    if getjob then
		if getElementData(el,"player:duty") == getElementData(source,"m:duty") then
			removeElementData(el,"player:duty")
			removeElementData(el,"player:dutycode")
			removeElementData(el,"player:maxemp")
    		outputChatBox("* Zakończyłeś/aś prace.", el)
			setElementModel(el, getElementData(el,"player:skinid") or 0)
    		zabierzKolo(el,500)
		end
	end
end)

addEvent("sprGraczaFrakcjeTuneLV",true)
addEventHandler("sprGraczaFrakcjeTuneLV", root,function(gt_code,code,plr,maxemployes)
    if gt_code == code then  -- jesli kod sie zgadza
--	outputChatBox("test",root)
	    local sprjob = getElementData(plr,"player:duty") or 0;
		local plr_uid = getElementData(plr,"player:dbid") or 0;
		if sprjob == code then
		    -- jesli pracowal, zkoncz prace
        	removeElementData(plr,"player:duty")
        	removeElementData(plr,"player:dutycode")
        	removeElementData(plr,"player:maxemp")
        	outputChatBox("* Zakończyłeś/aś prace.", plr)
        	setElementModel(plr, getElementData(plr,"player:skinid") or 0)
        	zabierzKolo(plr,500)
        	triggerClientEvent(plr,"ukryjPlrGUItunelv",plr)
			
--			if getElementAlpha(plr) ~= 255 then
--       		setElementAlpha(plr,255); 
--				local rgb = getElementData(plr,"player:colorRGB")	
--				createBlipAttachedTo ( plr, 0, 2, 86, 129, 200 ); 
--			end
		else
		    -- jesli nie pracowal, sprawdzam czy mzoe rozpoczac prace
    		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_frakcjaid = '"..gt_code.."' AND fra_userid = '"..plr_uid.."' LIMIT 1;")
    		if result and #result > 0 then
            	if getEmployees(code) >= maxemployes then
                	outputChatBox("* W tej pracy pracuje już maksymalna ilość osób ("..maxemployes..")", plr, 255, 0, 0)
					triggerClientEvent(plr,"ukryjPlrGUItunelv",plr)
                	return
            	end
            	setElementData(plr,"player:duty",code)
            	outputChatBox("* Rozpocząłeś/aś pracę.", plr)
				local userplec = getElementData(plr,"player:plec") or 0;
				if userplec == 0 then 
				    -- 0 czyli boy
					local losujemyskina = math.random(1,3)
					if losujemyskina == 1 then setElementModel(plr, 50) end
					if losujemyskina == 2 then setElementModel(plr, 268) end
					if losujemyskina == 3 then setElementModel(plr, 305) end
				else
				    -- 1 czyly girl
					setElementModel(plr, 201)
				end
				triggerClientEvent(plr,"ukryjPlrGUItunelv",plr)
            else
			    outputChatBox("* Nie jesteś zatrudniony/a w tym warsztacie pojazdów.", plr,255,0,0)
				triggerClientEvent(plr,"ukryjPlrGUItunelv",plr)
        	end
		end
	end
end)

function zabierzKolo(el,delay)
  local niesionyObiekt=getElementData(el,"niesioneKolo")
  if niesionyObiekt then 
    if isElement(niesionyObiekt) then
      if delay then
        setTimer(destroyElement, delay, 1, niesionyObiekt)
      else
        destroyElement(niesionyObiekt)
      end
    end
    removeElementData(el,"niesioneKolo")
    setPedWalkingStyle(el,0)
    unbindKey(el, "fire", "down", zalozKolo)
    return true
  end
  return false
end








