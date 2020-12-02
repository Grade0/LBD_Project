CREATE OR REPLACE procedure testmodGUI_7 is
begin
    modGUI.ApriPagina('Home', 1);
    modGUI.ApriMenuGruppo1(IDSESSIONE  => 1, INDIRIZZO  => 'URL HomePage');


        /* ----------- Primo link sub-menu (senza sub-sub-menu) -------------- */
            modGUI.CollegamentoNav('Pacchetto 1.1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
            /* ----------- Secondo link sub-menu (senza sub-sub-menu) -------------- */
            modGUI.CollegamentoNav('Pacchetto 1.2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
            /* ----------- Terzo link sub-menu (con sub-sub-menu => hasSub settato a 'true' e tipoSub settato a 'secondo') -------------- */
            modGUI.CollegamentoNav('Pacchetto 1.3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1, true, 'secondo');
                /* ----------- Primo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 1.3.1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
                /* ----------- Secondo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 1.3.2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
                /* ----------- Terzo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 1.3.3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
            /* -- Chiusura sub-sub-nav (operazione obbligotoria per le sub-navs) -- */
            modGUI.ChiudiCollegamentoSubNav;



    modGUI.ChiudiMenuGruppo1(1);

    modGUI.MenuLatGruppo1(IDSESSIONE  => 1, INDIRIZZO  => 'URL HomePage');



    /* Sub-menu di id Costanti.subMenu1 chiamato dal link 'Gruppo 1', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, Costanti.subMenuGruppo1, true, 'Gruppo 1');
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 1.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 1.2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.3' e link che porta al sub-sub-menu di id 'dav-subSubMenu1-3' e hasSub settato a true*/
        modGUI.Collegamento('Pacchetto 1.3', 'dav-subSubMenu1-3', true);
    modGUI.ChiudiMenuLat;

    /* Sub-Sub-menu di id 'dav-subSubMenu1-3' chiamato dal link 'Pacchetto 1.3', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, 'dav-subSubMenu1-3', true, 'Pacchetto 1.3');
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.3' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.3', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
    modGUI.ChiudiMenuLat;

    

    modGUI.Intestazione(1, 'Benvenuto al HomePage di Gruppo1');
	modGUI.ChiudiPagina;

end testmodGUI_7;