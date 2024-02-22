--txd = engineLoadTXD("ambulan.txd")
--engineImportTXD(txd, 416)
dff = engineLoadDFF("ambulan.dff", 416)
engineReplaceModel(dff, 416)