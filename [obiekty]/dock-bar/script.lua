function replaceModel() 
txd = engineLoadTXD("dockbarwhite.txd", 3578) 
engineImportTXD(txd, 3578) 
dff = engineLoadDFF("dockbarwhite.dff", 3578) 
engineReplaceModel(dff, 3578) 
end 
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)