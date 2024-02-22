local MODEL=407

addEventHandler("onClientResourceStart", resourceRoot, function()
	txd = engineLoadTXD("firetruk.txd")
	engineImportTXD(txd, MODEL)
	dff = engineLoadDFF("firetruk.dff", MODEL)
	engineReplaceModel(dff, MODEL)
end)


