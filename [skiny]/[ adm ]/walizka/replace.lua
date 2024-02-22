txd = engineLoadTXD ( "briefcase.txd" ) 
engineImportTXD ( txd , 1210 )
dff = engineLoadDFF ( "briefcase.dff" ) 
engineReplaceModel ( dff , 1210 )