txd = engineLoadTXD("sffd1.txd")
engineImportTXD(txd, 279)
dff = engineLoadDFF("sffd1.dff", 279)
engineReplaceModel(dff, 279)