addEventHandler( "onClientKey", root, function(button,press)
    if button == "F1" then
	if (press) then
        sprtest()
	end
	end
end)

        F1_panel = guiCreateWindow(0.22, 0.20, 0.57, 0.60, "Panel F1", true)
        guiWindowSetMovable(F1_panel, false)
        guiWindowSetSizable(F1_panel, false)

        F1_tabpanel = guiCreateTabPanel(19, 34, 1057, 596, false, F1_panel)

        F1_tabpanel1 = guiCreateTab("Witamy!", F1_tabpanel)

        F1_textarea_witamy = guiCreateLabel(208, 66, 618, 140, "Przykładowy tekst - Nazwa serwera :-)", false, F1_tabpanel1)
        guiLabelSetHorizontalAlign(F1_textarea_witamy, "center", false)
        guiLabelSetVerticalAlign(F1_textarea_witamy, "center")

        F1_tabpanel2 = guiCreateTab("Nowości", F1_tabpanel)
        F1_textarea1 = guiCreateMemo(10, 34, 1037, 504, "11.05.2021 - AjoN, Lista zmian:\n\n* Dodano urząd miasta LV w dzielnicy Come-A-Lot niedaleko Juliusza.\n* W urzędzie znajdziemy coś takiego, jak zmianę tablic rejestracyjnych, a w miarę postępu zostaną dodane dodatkowe opcje.\n* Przed urzędem dodano parkingi, oraz heli-pad. Również znajdziemy tutaj trochę zieleni — by dero.\n* Dodano pierwszą giełdę w LV, będą na niej stacjonować aktualnie wszystkie pojazdy, bez progu minimalnego.\n* Dodano system walizek, aktualnie przechodzą testy, domyślnie będą dostępne dla administracji serwera.\n* Stacja paliw niedaleko KGP została zmieniona, prawdopodobnie powstanie również tam mechanik pojazdów.\n* Zmieniono sposób działania czatów.\n\n10.05.2021 - AjoN, Lista zmian:\n\n* Naprawiono skrypt z blipami pojazdów, został on lepiej zabezpieczony.\n* Dodano implementacje koloru premium na nicku gracza.\n* Komenda do sprawdzenia ostatnich kierowców, od teraz to /ok <id pojazdu> zamiast /ostatni — jest po prostu krócej!\n* Poprawiono komendę /kolor — od teraz wymaga minimalnie pierwszych argumentów <rgb>.\n* Dodano nowe animacje, więcej w zakładce animacje powyżej.\n* Zmieniono wygląd czatu lokalnego, wygląd ogłoszeń /r oraz wygląd nicku gracza nad skinem.\n\n09.05.2021 - AjoN, Lista zmian:\n\n* Naprawiono skrypt, który blokował wybuchanie aut, od teraz działa znacznie lepiej\n* Dodano skrypt liczący spędzony czas online na serwerze.\n* Dodano skrypt konta premium.\n* Dodano zapis uszkodzeń auta do bazy, wyjątek stanowią lampy oraz stan opon. W przyszłości zostanie to dodane!\n* Poprawiono wygląd suszarki w mniejszej rozdzielczości.\n* Interakcja z pojazdem obsługuje od teraz również SCROLL na myszce.\n* Zablokowano całkowicie podstawowe radio w pojazdach.", false, F1_tabpanel2)
        guiMemoSetReadOnly(F1_textarea1, true)  
		
        F1_tabpanel3 = guiCreateTab("Animacje", F1_tabpanel)
        F1_textarea2 = guiCreateMemo(10, 34, 1037, 504, "Lista dostępnych animacji:\n\n\n/taniec1-20 - Różne tańce wygi-bańce.\n/rece\n/rece2\n/joga\n/masazpiersi\n/nalewam\n/podsluchuje\n/pije\n/pije2\n/pale\n/pale2\n/leze\n/leze2\n/leze3\n/leze4\n/leze5\n/siedze\n/siedze2\n/siedze3\n/klekam\n/klekam2\n/msza\n/msza2\n/czekam\n/znakkrzyza\n/rzygam\n/jem\n/tlumacze\n/pijany\n/witam\n/rozmawiam\n/rozmawiam2\n/rozmawiam3\n/nerwowy\n\n\n Animacji będzie więcej :-)", false, F1_tabpanel3)
        guiMemoSetReadOnly(F1_textarea2, true)  

		sprpanel = getElementData(localPlayer,"player:F1") or false;
		guiSetVisible(F1_panel,sprpanel)

function sprtest ()
	if guiGetVisible(F1_panel) == true then
	     guiSetVisible(F1_panel,false)
		 setElementData(localPlayer,"player:F1",false)
		 showCursor(false)
	else
	     guiSetVisible(F1_panel,true)
		 setElementData(localPlayer,"player:F1",true)
		 showCursor(true)
	end	
end
