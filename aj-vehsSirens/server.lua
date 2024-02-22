--[[

	ajonoficjalny@gmail.com
	2023 czerwiec 12
	
	nakładanie oraz usuwanie syren z pojazdu

]]--

function vehSirens(auto)
	local veh_id = getElementData(auto,"vehicle:id") or 0;
	local veh_modeliddwa = getElementModel(auto)
		
	if tonumber(veh_id) == 44 then		
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 4, 2, false, false, true, true)
		setVehicleSirens(auto, 1, 0.8, 2.5, -0.3, 255, 102, 0, 255, 255)
		setVehicleSirens(auto, 2, -0.9, -2.3, 0.2, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 3, 0.8, -2.3, 0.2, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 4, -0.9, 2.5, -0.3, 255, 102, 0, 255, 255)
	end	

	if tonumber(veh_id) == 103 or ( tonumber(veh_id) >= 134 and tonumber(veh_id) <= 136 ) then		
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 4, 2, false, false, true, true)
		setVehicleSirens(auto, 1, 0.8, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 2, -0.9, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 3, 0.8, -2.3, 0.2, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 4, -0.9, -2.3, 0.2, 255, 0, 0, 255, 255)
	end	
	
	-- premier
	if tonumber(veh_id) == 141 then		
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 8, 2, false, false, true, true)
		setVehicleSirens(auto, 1, 0.8, 2.6, 0, 0, 40.8, 255, 198.9, 198.9)
		setVehicleSirens(auto, 2, -0.7, 2.6, 0, 0, 56.1, 255, 200, 200)
		setVehicleSirens(auto, 3, -0.7, -1.3, 0.7, 204, 20.4, 0, 200, 200)
		setVehicleSirens(auto, 4, 0.6, -1.3, 0.7, 0, 56.1, 255, 200, 200)
		setVehicleSirens(auto, 5, -0.9, -2.88, 0, 209.1, 20.4, 0, 200, 200)
		setVehicleSirens(auto, 6, 0.8, -2.88, 0, 214.2, 35.7, 0, 200, 200)
	end	
	
	-- huntley
	if tonumber(veh_id) == 52 then		
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 4, 2, false, false, true, true)
		setVehicleSirens(auto, 1, 1, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 2, -1, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 3, 1, -2.8, 0.2, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 4, -1, -2.8, 0.2, 255, 0, 0, 255, 255)
	end	

	if tonumber(veh_id) == 151 then		
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 4, 2, false, false, true, true)
		setVehicleSirens(auto, 1, 0.8, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 2, -0.9, 2.5, -0.3, 0, 44, 255, 255, 255)
		setVehicleSirens(auto, 3, 0.8, -2.3, 0.2, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 4, -0.9, -2.3, 0.2, 255, 0, 0, 255, 255)
	end	

	if veh_modeliddwa == 597 then
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 8, 2, true, true, false, true)
		setVehicleSirens(auto, 1, 0.8, 2.6, 0, 0, 40.8, 255, 198.9, 198.9)
		setVehicleSirens(auto, 2, -0.7, 2.6, 0, 0, 56.1, 255, 200, 200)
		setVehicleSirens(auto, 3, -0.7, -0.3, 1, 204, 20.4, 0, 200, 200)
		setVehicleSirens(auto, 4, 0.6, -0.3, 1, 0, 56.1, 255, 200, 200)
		setVehicleSirens(auto, 5, -0.9, -2.88, 0, 209.1, 20.4, 0, 200, 200)
		setVehicleSirens(auto, 6, 0.8, -2.88, 0, 214.2, 35.7, 0, 200, 200)
	end		

	if veh_modeliddwa == 416 then
		removeVehicleSirens(auto)
		addVehicleSirens(auto, 8, 2, false, false, true, true)
		setVehicleSirens(auto, 1, -0.5, 0.8, 1.3, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 2, 0.4, 0.8, 1.3, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 3, 1.1, -3.5, 1.5, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 4, -1.2, -3.5, 1.5, 255, 0, 0, 255, 255)
		setVehicleSirens(auto, 5, -0.9, 2.9, 0, 255, 255, 255, 198.9, 198.9)
		setVehicleSirens(auto, 6, 0.8, 2.9, 0, 255, 255, 255, 200, 200)
		setVehicleSirens(auto, 7, 0.2, 2.7, 0, 0, 0, 255, 200, 200)
		setVehicleSirens(auto, 8, -0.3, 2.7, 0, 0, 0, 255, 200, 200)	
	end	
end

