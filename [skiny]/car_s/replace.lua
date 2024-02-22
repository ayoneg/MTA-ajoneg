txd = engineLoadTXD("bravura.txd")
engineImportTXD(txd, 401)
dff = engineLoadDFF("bravura.dff", 401)
engineReplaceModel(dff, 401)

dff = engineLoadDFF("stratum_new.dff", 561)
engineReplaceModel(dff, 561)

txd = engineLoadTXD("pizzaboy.txd")
engineImportTXD(txd, 448)

txd = engineLoadTXD("vgnmall.txd")
engineImportTXD(txd, 6947)

-- laweta
dff = engineLoadDFF("dft30.dff", 578)
engineReplaceModel(dff, 578)

-- kontenery
txd = engineLoadTXD("continx.txd")
engineImportTXD(txd, 2932)
txd = engineLoadTXD("continx.txd")
engineImportTXD(txd, 2934)
txd = engineLoadTXD("continx.txd")
engineImportTXD(txd, 2935)