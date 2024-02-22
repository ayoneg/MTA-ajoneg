--[[
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author Karer <karer.programmer@gmail.com>
@author RacheT <rachet@pylife.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--



-- uniwersalny kod wspoldzielony pomiedzy warsztatami

local strefyNapraw={

	--idlewood
  warsztatLV={
    cuboid={1094.1611328125, 1742.556640625, 10.8203125-1, 9, 5, 5 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1105.484375, 1748.05078125, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id="mechanik-lv", -- nameid frakcji ktora ma do tego dostep
  },
  
  warsztatLV2={
    cuboid={1094.1611328125, 1735.033203125, 09.8203125, 9, 5, 5 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1105.310546875, 1740.4521484375, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id="mechanik-lv", -- nameid frakcji ktora ma do tego dostep
  },
  
  warsztatLV3={
    cuboid={1094.1611328125, 1727.837890625, 9.8203125, 9, 5, 5 },-- cuboid w ktorym musi znalezc sie pojazd
    mpos={1105.3828125, 1732.7529296875, 10.8203125}, -- pozycja markera w ktorym gracz bedzie stal aby naprawiac
    faction_id="mechanik-lv", -- nameid frakcji ktora ma do tego dostep
  },

  
  
}

for i,v in pairs(strefyNapraw) do
  v.cs=createColCuboid(unpack(v.cuboid))
  v.marker=createMarker(v.mpos[1], v.mpos[2], v.mpos[3]-1, "cylinder", 1, 0,0,0,100)
  setElementData(v.marker,"cs",v.cs)
  setElementData(v.marker,"m:duty",v.faction_id)
  
  t=createElement("text")
  setElementData(t,"name","Komputer")
  setElementPosition(t, v.mpos[1], v.mpos[2], v.mpos[3])
end

--   triggerServerEvent("naprawaElementu", resourceRoot, naprawiany_pojazd, czesc, koszt)
addEvent("naprawaElementu", true)
addEventHandler("naprawaElementu", resourceRoot, function(pojazd, czesc, koszt)
  outputDebugString("Naprawa elementu " .. czesc .. " za " .. koszt)
  if koszt>getPlayerMoney(client) then
    return
  end
	takePlayerMoney(client,(koszt*100))
  if (czesc==-1) then
--    setElementHealth(pojazd, 1000)

    local vps={}
    local vds={}
    local vls={}

    for i=0,6 do          vps[i]=getVehiclePanelState(pojazd,i)     end
    for i=0,3 do          vds[i]=getVehicleDoorState(pojazd,i) end
    for i=0,3 do          vls[i]=getVehicleLightState(pojazd,i) end

    fixVehicle(pojazd)

    for i=0,6 do      setVehiclePanelState(pojazd, i, vps[i])    end
    for i=0,3 do      setVehicleDoorState(pojazd, i, vds[i])    end
    for i=0,3 do      setVehicleLightState(pojazd, i, vls[i])    end

    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=0 and czesc<=6 then
    setVehiclePanelState(pojazd, czesc, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=10 and czesc<20 then
    local drzwi=czesc-10
    setVehicleDoorState(pojazd, drzwi, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  elseif czesc>=20 then
    local swiatlo=czesc-20
    setVehicleLightState(pojazd, swiatlo, 0)
    triggerClientEvent(client, "refreshVehicleData", resourceRoot, pojazd)
  end
end)