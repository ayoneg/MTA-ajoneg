
-- zapis pojazdu do bazy (nie usuwa poj zmapy)
function nadajTunePoj(auto,plr)
    local veh_id = getElementData(auto,"vehicle:id") or 0;
	local vehs_TUNE = exports["aj-dbcon"]:wyb("SELECT * FROM server_vehicles WHERE veh_id = '"..veh_id.."'")
	if #vehs_TUNE > 0 then
	
	veh_mk1 = vehs_TUNE[1].veh_mk1;
	veh_mk2 = vehs_TUNE[1].veh_mk2;
	veh_mk3 = vehs_TUNE[1].veh_mk3;
	veh_SU1 = vehs_TUNE[1].veh_SU1;
	
		if tonumber(veh_mk1) ~= 0 then
		if plr then
			outputChatBox(" ",plr)
			outputChatBox("* Zaprogramowano program MK1.",plr)
			outputChatBox(" ",plr)
		end
		setElementData(auto,"vehicle:mk1",1)
		end
		
		if tonumber(veh_mk2) ~= 0 then
		if plr then
			outputChatBox(" ",plr)
			outputChatBox("* Zaprogramowano program MK2.",plr)
			outputChatBox(" ",plr)
		end
		setElementData(auto,"vehicle:mk2",1)
		end
				
		if tonumber(veh_mk3) ~= 0 then
		if plr then
			outputChatBox(" ",plr)
			outputChatBox("* Zaprogramowano program MK3.",plr)
			outputChatBox(" ",plr)
		end
		setElementData(auto,"vehicle:mk3",1)
		end
		
		if tonumber(veh_SU1) ~= 0 then
--		outputChatBox("* Zaprogramowano program SU1.",plr)
		setElementData(auto,"vehicle:su1",veh_SU1)
		end
	end
end

