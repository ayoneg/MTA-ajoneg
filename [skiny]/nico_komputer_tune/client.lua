dff = engineLoadDFF ("mich_int_sfe.dff")
engineReplaceModel (dff, 10282)


col = engineLoadCOL( "mich_int_sfe.col" ) 
engineReplaceCOL (col, 10282)
