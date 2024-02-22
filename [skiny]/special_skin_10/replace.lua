skin_id = 10
txd = engineLoadTXD("skin.txd")
engineImportTXD(txd, skin_id)
dff = engineLoadDFF("skin.dff", skin_id)
engineReplaceModel(dff, skin_id)