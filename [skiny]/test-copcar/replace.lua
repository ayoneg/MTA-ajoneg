txd = engineLoadTXD("copcarla.txd")
engineImportTXD(txd, 596)
dff = engineLoadDFF("copcarla.dff", 596)
engineReplaceModel(dff, 596)