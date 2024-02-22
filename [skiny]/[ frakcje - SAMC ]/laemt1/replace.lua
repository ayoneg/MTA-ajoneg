txd = engineLoadTXD("laemt1.txd")
engineImportTXD(txd, 274)
dff = engineLoadDFF("laemt1.dff", 274)
engineReplaceModel(dff, 274)

