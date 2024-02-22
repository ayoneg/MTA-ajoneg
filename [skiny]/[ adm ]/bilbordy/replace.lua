skin_id = 7300
txd = engineLoadTXD("vgsn_billboard.txd")
engineImportTXD(txd, skin_id)
dff = engineLoadDFF("vgsn_addboard01.dff", skin_id)
engineReplaceModel(dff, skin_id)