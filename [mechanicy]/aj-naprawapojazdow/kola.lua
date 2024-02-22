--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author RacheT <rachet@pylife.pl>
@author karer <karer.programmer@gmail.com>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



local punkty_brania_kol={
  {1108.537109375, 1737.7880859375, 10.8203125, 2.3, faction_id="mechanik-lv"}, --idlewood
--  {1189.67,250.51,18.53,2, faction_id=18}, --montgomery


}

local warsztatyid = {
	["mechanik-lv"]=true,
--	[12]=true,
}

for i,v in ipairs(punkty_brania_kol) do
  v.marker=createMarker(v[1],v[2],v[3]-1,"cylinder", v[4], 0,0,0,100)
  setElementData(v.marker, "braniekola", true)
  setElementData(v.marker, "md:duty", v.faction_id)
  t=createElement("text")
  setElementData(t,"name","Opony")
  setElementPosition(t, v[1],v[2],v[3])
end


local function czyPracownikWarsztatu(gracz)
  local lfid=getElementData(gracz,"player:duty") or 0
  if not warsztatyid[lfid] then return false end
  return true
end

local function najblizszeKolo(gracz,pojazd)
  -- easy peasy
  local xg,yg,zg=getElementPosition(gracz)
  local najblizszeKolo=nil
  local najblizszeDist=1000

  local x,y,z=getElementPosition(pojazd)
  local _,_,rz=getElementRotation(pojazd)

  for i=1,4 do
    local rrz=math.rad(rz+45+(i-1)*90)
    local x= x + (1 * math.sin(-rrz))
    local y= y + (1 * math.cos(-rrz))
    if not najblizszeKolo or getDistanceBetweenPoints2D(x,y,xg,yg)<najblizszeDist then
      najblizszeDist=getDistanceBetweenPoints2D(x,y,xg,yg)
      najblizszeKolo=i
    end
  end
  -- ugly
  if not najblizszeKolo then return nil end
  if najblizszeKolo==4 then return 3
  elseif najblizszeKolo==3 then return 4 end
  return najblizszeKolo
end

local function zalozKolo(plr)

  local x,y,z=getElementPosition(plr)
  local _,_,rz=getElementRotation(plr)

  local rrz=math.rad(rz)
  local x= x + (1.5 * math.sin(-rrz))
  local y= y + (1.5 * math.cos(-rrz))

  local cs=createColSphere(x,y,z,2.5)
  local pojazdy=getElementsWithinColShape(cs,"vehicle")
  destroyElement(cs)
  if (#pojazdy~=1) then
    return false
  end

  -- okreslamy, kolo ktorego kola jest gracz

  local k1,k2,k3,k4=getVehicleWheelStates(pojazdy[1])
--  if (k1==0) and (k2==0) and (k3==0) and (k4==0) then return end
  local kolo=najblizszeKolo(plr,pojazdy[1])
  if not kolo then return end

  setPedAnimation(plr, "MISC", "pickup_box", 1, false, false, true, true)
  toggleControl(plr, "forward", false)
  setTimer(setPedAnimationProgress, 600, 1, plr, "pickup_box", 0.5)
  setElementData(plr, "blockSettingAnimation", true) --blokujemy ENTER
  if kolo==1 then
    k1=0
  elseif kolo==2 then
    k2=0
  elseif kolo==3 then
    k3=0
  elseif kolo==4 then
    k4=0
  end
  
  setTimer(setPedAnimation, 500, 1, plr, "ped", "phone_in")
  setTimer(setPedAnimation, 1300, 1, plr)
  setTimer(setVehicleWheelStates, 500, 1, pojazdy[1], k1, k2, k3, k4)
  setTimer(setElementData, 500, 1, plr, "blockSettingAnimation", true)
  setTimer(toggleControl, 500, 1, plr, "forward", true)
  zabierzKolo(plr,500)
end

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



addEventHandler("onMarkerHit", resourceRoot, function(el,md)
  if not md or getElementType(el)~="player" then return end
  if isPedInVehicle(el) then return end
  if not czyPracownikWarsztatu(el) then return end
  if not getElementData(source, "braniekola") then return end
  if getElementData(source, "md:duty") ~= getElementData(el, "player:duty") then return end

  if zabierzKolo(el) then return end

  local kolo=createObject(1098,0,0,0)
  setObjectScale(kolo, 0.7)
  setElementData(el,"niesioneKolo", kolo,false)
--  attachElements(kolo, el, 0,0.4,-0.2,0,0,90)
  bindKey(el, "fire", "down", zalozKolo)
  exports["bone_attach"]:attachElementToBone(kolo, el, 11, 0.1,-0.1,0)
  setPedWalkingStyle(el,66)
end)



