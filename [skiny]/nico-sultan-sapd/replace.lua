txd = engineLoadTXD("sultan.txd")
engineImportTXD(txd, 560)
dff = engineLoadDFF("sultan.dff", 560)
engineReplaceModel(dff, 560)