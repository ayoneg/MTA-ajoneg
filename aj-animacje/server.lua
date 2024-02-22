function stopAnimacja(plr)
    setPedAnimation(plr, false)
    unbindKey(plr, "ENTER", "down", stopAnimacja)
end

addCommandHandler("taniec",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CHAINSAW", "CSAW_Hit_2", -1, true, true )
end)

addCommandHandler("taniec2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SKATE", "skate_idle", -1, true, false )
end)

addCommandHandler("taniec3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_B", -1, true, false )
end)

addCommandHandler("taniec4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dance_loop", -1, true, false )
end)

addCommandHandler("taniec5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "DAN_Down_A", -1, true, false )
end)

addCommandHandler("taniec6",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_G", -1, true, false )
end)

addCommandHandler("taniec7",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_C2", -1, true, false )
end)

addCommandHandler("taniec8",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_b", -1, true, false )
end)

addCommandHandler("taniec9",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "DAN_Loop_A", -1, true, false )
end)

addCommandHandler("taniec10",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_d", -1, true, false )
end)

addCommandHandler("taniec11",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_D", -1, true, false )
end)

addCommandHandler("taniec12",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "strip_E", -1, true, false )
end)

addCommandHandler("taniec13",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_Loop_A", -1, true, false )
end)

addCommandHandler("taniec14",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "STRIP", "STR_Loop_B", -1, true, false )
end)

addCommandHandler("taniec15",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FINALE", "FIN_Cop1_Stomp", -1, true, false )
end)

addCommandHandler("taniec16",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DANCING", "dnce_M_a", -1, true, false )
end)

addCommandHandler("taniec17",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G10", -1, true, false )
end)

addCommandHandler("taniec18",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G11", -1, true, false )
end)

addCommandHandler("taniec19",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GFUNK", "Dance_G12", -1, true, false )
end)

addCommandHandler("taniec20",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "RUNNINGMAN", "Dance_B1", -1, true, false )
end)


------------------------------------------- NEW ------------------------------------------
addCommandHandler("rece",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "handsup", -1, false, false )
end)

addCommandHandler("joga",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "PARK", "Tai_Chi_Loop", -1, true, false )
end)

addCommandHandler("masazpiersi",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BSKTBALL", "BBALL_def_loop", -1, true, false )
end)

addCommandHandler("nalewam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "Barserve_glass", -1, false, false )
end)

addCommandHandler("podsluchuje",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "Barserve_order", -1, false, false )
end)
addCommandHandler("pije",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BAR", "dnk_stndM_loop", -1, true, false )
end)
addCommandHandler("pale",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "LOWRIDER", "M_smklean_loop", -1, true, false )
end)

addCommandHandler("leze",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "Lay_Bac_Loop", -1, true, false )
end)

addCommandHandler("leze2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle2", -1, true, false )
end)

addCommandHandler("leze3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "crckidle4", -1, true, false )
end)

addCommandHandler("leze4",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "ParkSit_W_loop", -1, false, false )
end)

addCommandHandler("leze5",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "SitnWait_loop_W", -1, true, false )
end)
addCommandHandler("siedze",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "BEACH", "ParkSit_M_loop", -1, true, false )
end)

addCommandHandler("siedze2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false )
end)

addCommandHandler("siedze3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "JST_BUISNESS", "girl_02", -1, false, false )
end)
addCommandHandler("klekam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CAMERA", "camstnd_to_camcrch", -1, false, false )
end)

addCommandHandler("klekam2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "COP_AMBIENT", "Copbrowse_nod", -1, true, false )
end)
addCommandHandler("msza",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DEALER", "DEALER_IDLE", -1, true, false )
end)

addCommandHandler("msza2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GRAVEYARD", "mrnM_loop", -1, false, false )
end)
addCommandHandler("czekam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "COP_AMBIENT", "Coplook_loop", -1, true, false )
end)

addCommandHandler("rece2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "DAM_JUMP", "DAM_Dive_Loop", -1, false, false )
end)
addCommandHandler("znakkrzyza",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "hndshkcb", -1, true, false )
end)

addCommandHandler("rzygam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FOOD", "EAT_Vomit_P", -1, true, false )
end)
addCommandHandler("jem",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "FOOD", "EAT_Burger", -1, true, false )
end)

addCommandHandler("pije2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "drnkbr_prtl", -1, true, false )
end)

addCommandHandler("pale2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "smkcig_prtl", -1, true, false )
end)

addCommandHandler("tlumacze",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_01", -1, true, false )
end)

addCommandHandler("pijany",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "CRACK", "Bbalbat_Idle_02", -1, true, false )
end)

addCommandHandler("witam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "hndshkba", -1, true, false )
end)

addCommandHandler("rozmawiam",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkH", -1, true, false )
end)

addCommandHandler("rozmawiam2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkG", -1, true, false )
end)

addCommandHandler("rozmawiam3",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GANGS", "prtial_gngtlkD", -1, true, false )
end)
addCommandHandler("nerwowy",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "GHANDS", "gsign2", -1, true, false )
end)
-------------------------------------- PART 1 ---------------------
addCommandHandler("wgotowosci",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "SWORD", "sword_IDLE", -1, true, false )
end)
addCommandHandler("umieram",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "FLOOR_hit_f", -1, false, false )
end)
addCommandHandler("umieram2",function(plr,cmd)
    if (isPedInVehicle(plr)) then
        outputChatBox("* Najpierw wysiądź z pojazdu !", plr)
        return
    end
    bindKey(plr, "ENTER", "down", stopAnimacja)
    setPedAnimation ( plr, "ped", "FLOOR_hit", -1, false, false )
end)
