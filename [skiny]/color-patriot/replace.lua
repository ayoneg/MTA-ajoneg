txd = engineLoadTXD("patriot.txd")
engineImportTXD(txd, 470)
dff = engineLoadDFF("patriot.dff", 470)
engineReplaceModel(dff, 470)