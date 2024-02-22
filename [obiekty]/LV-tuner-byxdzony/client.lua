dff = engineLoadDFF ("vgnlowbuild09.dff")
engineReplaceModel (dff, 7507)

--txd = engineLoadTXD ("vegasbuild.txd")
--engineImportTXD (txd, 7507)

col = engineLoadCOL( "vgnlowbuild09.col" ) 
engineReplaceCOL (col, 7507)
