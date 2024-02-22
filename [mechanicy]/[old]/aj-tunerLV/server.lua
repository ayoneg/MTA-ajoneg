
-------------------------------------------------------

local marker = createMarker(1952.8876953125, 2175.9228515625, 10.893982887268-0.90, "cylinder", 1.2, 78, 188, 0, 22)
local cs = createColCuboid(1937.6494140625, 2122.876953125, 10.8203125-0.90, 56.6, 55, 7)
local maxEmployees = 2
local code = "tune-lv"
local desc = ""
local desc2 = "Praca tuner LV"

setElementData(marker,"m:duty",code)
setElementData(cs,"m:duty",code)

local t=createElement("text")
setElementDimension(t, 0)
setElementInterior(t, 0)
setElementData(t,"name",desc.."\n"..desc2)
setElementPosition(t,1952.8876953125, 2175.9228515625, 10.893982887268)


function getEmployees(code)
    local number=0
    for i,v in ipairs(getElementsByType("player")) do
        if getElementData(v,"player:duty") == code then
            number=number+1
        end
    end
    return number
end



-- jak gracz wejdzie
addEventHandler("onMarkerHit", root, function(el,md)
    if source == marker then
		if getElementType(el)~="player" then return end
		if isPedInVehicle(el) then return end
		if getElementData(el,"player:duty") == "tune-lv" then
		    opis_button = "Zakończ pracę";
		else
		    opis_button = "Rozpocznij pracę";
		end
		triggerClientEvent(el,"pokazPlrGUItunelv",el,opis_button)
	end
end)

addEventHandler("onMarkerLeave", root, function(el,md)
    if source == marker then
		if getElementType(el)~="player" then return end
		triggerClientEvent(el,"ukryjPlrGUItunelv",el)
	end
end)


-- gdy wyjdzie z obszaru mechanika zakoncz robote
addEventHandler("onColShapeLeave", cs, function(el,md)
if getElementData(el,"player:duty") == getElementData(source,"m:duty") then
	setElementData(el,"player:duty",false)
    outputChatBox("* Zakończyłeś/aś prace.", el)
	setElementModel(el, getElementData(el,"player:skinid") or 0)
--	exports["aj-naprawapojazdow"]:zabierzKolo(el,500)
    zabierzKolo(el,500)
--   local skin=getElementData(el,"player:skin")
--   setElementModel(el,skin)
end
end)





addEvent("sprGraczaFrakcjeTuneLV",true)
addEventHandler("sprGraczaFrakcjeTuneLV", root,function(gt_code,plr)
    if gt_code == code then  -- jesli kod sie zgadza
--	outputChatBox("test",root)
	    local sprjob = getElementData(plr,"player:duty") or 0;
		local plr_uid = getElementData(plr,"player:dbid") or 0;
		if sprjob == code then
		    -- jesli pracowal, zkoncz prace
		   setElementData(plr,"player:duty",false)
    	   outputChatBox("* Zakończyłeś/aś prace.", plr)
		   setElementModel(plr, getElementData(plr,"player:skinid") or 0)
		   zabierzKolo(plr,500)
		   triggerClientEvent(plr,"ukryjPlrGUItunelv",plr)
		else
		    -- jesli nie pracowal, sprawdzam czy mzoe rozpoczac prace
    		local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_frakcje WHERE fra_frakcjaid = '"..gt_code.."' AND fra_userid = '"..plr_uid.."' LIMIT 1;")
    		if result and #result > 0 then
            	if getEmployees(code) >= maxEmployees then
                	outputChatBox("* W tej pracy pracuje już maksymalna ilość osób ("..maxEmployees..")", plr, 255, 0, 0)
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
