

addEvent("takePlrMoney", true)
addEventHandler("takePlrMoney", root, function(plr,cost)
	local ncost = cost * 100;
	takePlayerMoney(plr,ncost)
	local uid = getElementData(plr,"player:dbid") or 0;
	if uid > 0 then
		local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_money=user_money-"..ncost.." WHERE user_id = '"..uid.."'");
	end
end)

addEvent("giveSpray", true)
addEventHandler("giveSpray", root, function(plr)
    giveWeapon(plr, 41, 999, true);
end)

addEvent("removeSpray", true)
addEventHandler("removeSpray", root, function(plr)
    takeWeapon(plr, 41);
end)

addEvent("malowaniePojazdu", true)
addEventHandler("malowaniePojazdu", root, function(veh,var,color)
    if tonumber(var) == 1 then
	local colors = {getVehicleColor(veh, true) }
		colors = {
			color1 = {r = colors[1], g = colors[2], b = colors[3]},
			color2 = {r = colors[4], g = colors[5], b = colors[6]},
			color3 = {r = colors[7], g = colors[8], b = colors[9]},
			color4 = {r = colors[10], g = colors[11], b = colors[12]},
		}
		
		local colors = fromJSON(toJSON(colors))
		setVehicleColor(veh, color[1], color[2], color[3], colors.color2.r, colors.color2.g, colors.color2.b, colors.color3.r, colors.color3.g, colors.color3.b, colors.color4.r, colors.color4.g, colors.color4.b)
	end
    if tonumber(var) == 2 then
	local colors = {getVehicleColor(veh, true) }
		colors = {
			color1 = {r = colors[1], g = colors[2], b = colors[3]},
			color2 = {r = colors[4], g = colors[5], b = colors[6]},
			color3 = {r = colors[7], g = colors[8], b = colors[9]},
			color4 = {r = colors[10], g = colors[11], b = colors[12]},
		}
		
		local colors = fromJSON(toJSON(colors))
		setVehicleColor(veh, colors.color1.r, colors.color1.g, colors.color1.b, color[1], color[2], color[3], colors.color3.r, colors.color3.g, colors.color3.b, colors.color4.r, colors.color4.g, colors.color4.b)
	end
end)






