--// urzad lv wejscie
addEvent("onGraczWejdzieKaplica", true)
addEventHandler("onGraczWejdzieKaplica", root, function()
    setElementInterior(source, 18, 2259.9375, 850.7099609375, 99.681976318359)
	setElementDimension(source, 200)
    local rotX, rotY, rotZ = getElementRotation(source) -- get the local players's rotation
	setElementRotation(source,0,0,rotZ+90)
     	--fadeCamera ( source, true, 1.0, 255, 0, 0 )
		setCameraTarget(source, source)
end)

--// urzad lv wyjscie
addEvent("onGraczWyjdzieKaplica", true)
addEventHandler("onGraczWyjdzieKaplica", root, function()
    setElementInterior(source, 0, 2485.5234375, 918.806640625, 10.8203125)
	setElementDimension(source, 0)
    local rotX, rotY, rotZ = getElementRotation(source) -- get the local players's rotation
	setElementRotation(source,0,0,rotZ)
     	--fadeCamera ( source, true, 1.0, 255, 0, 0 )
		setCameraTarget(source, source)
end)


local rep_plus = createColCuboid(2256.5266113281, 846.23303222656, 99.681983947754-1, 33, 9.4, 7.0)
    setElementInterior(rep_plus, 18)
	setElementDimension(rep_plus, 200)
local rep_minus = createColCuboid(2283.6623535156, 848.98400878906, 99.681976318359, 1.5, 4, 2)
    setElementInterior(rep_minus, 18)
	setElementDimension(rep_minus, 200)

function oltazHit(plr,md)
if not md then return end
    if source == rep_minus then
    if getElementType(plr) == "player" then
	    local plr_id = getElementData(plr,"player:dbid") or 0;
		if plr_id > 0 then
--		     outputChatBox("Zawiodłem się na Tobie człowieku!",plr)
             local value = 1;
			 local variant = "minus"
			 local kaplicacode = "kaplica-um-lv"
			 local plr_rep = getElementData(plr,"player:reputacja") or 0;
			 triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,plr,variant)
			 local nev_repo = plr_rep - value;
			 setElementData(plr,"player:reputacja",nev_repo)
			 local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja-'"..value.."' WHERE user_id='"..plr_id.."'");
			 local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..plr_id.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
			 killPed( plr, plr )
		end
	end
	end
	if source == rep_plus then
    if getElementType(plr) == "player" then
	    local plr_id = getElementData(plr,"player:dbid") or 0;
		if plr_id > 0 then
--		     outputChatBox("Zawiodłem się na Tobie człowieku!",plr)
             local result = exports["aj-dbcon"]:wyb("SELECT * FROM server_rephistory WHERE rep_userid='"..plr_id.."' AND timediff(NOW(),rep_data)<'24:00:00' AND rep_kaplicacode='kaplica-um-lv' AND rep_value='plus'");
			 local sprkaplicainfo = getElementData(plr,"player:kaplicainfo") or false;
	         if #result > 0 and sprkaplicainfo == false then 
			     outputChatBox("* Dziś już otrzymałeś/aś reputację, przyjdź jutro.",plr)
				 setElementData(plr,"player:kaplicainfo",true)
			     return 
			 end
			 setElementData(plr,"player:kaplica",true)
			 --setElementData(plr,"player:kaplicainfo",false)
		end
	end
	end
end
addEventHandler("onColShapeHit", root, oltazHit) 


function oltazLeave(plr,md)
    if getElementType(plr) == "player" then
	    removeElementData(plr,"player:kaplica")
	end
end
addEventHandler("onColShapeLeave", root, oltazLeave) 



setTimer(function()
	local players=getElementsByType('player')
	for _, p in pairs(players) do
	    sprkaplice = getElementData(p,"player:kaplica") or false;
		if sprkaplice == true then
		    local plr_id = getElementData(p,"player:dbid") or 0;
		    if plr_id > 0 then
				local value = math.random(1,4);
				local variant = "plus"
				local kaplicacode = "kaplica-um-lv"
				local plr_rep = getElementData(p,"player:reputacja") or 0;
				triggerClientEvent("pokazInfoOltaz",root,value,plr_rep,p,variant)
			    local nev_repo = plr_rep + value;
				setElementData(p,"player:reputacja",nev_repo)
			    local query = exports["aj-dbcon"]:upd("UPDATE server_users SET user_reputacja=user_reputacja+'"..value.."' WHERE user_id='"..plr_id.."'");
				local query = exports["aj-dbcon"]:upd("INSERT INTO server_rephistory SET rep_userid='"..plr_id.."', rep_value='"..variant.."', rep_count='"..value.."', rep_data=NOW(), rep_kaplicacode='"..kaplicacode.."'");
				removeElementData(p,"player:kaplica")
			end
		end
	end
end, 600000, 0) -- 600000ms 10min
