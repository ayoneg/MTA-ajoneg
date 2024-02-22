txd = engineLoadTXD("club.txd")
engineImportTXD(txd, 589)
dff = engineLoadDFF("club.dff", 589)
engineReplaceModel(dff, 589)