create or replace procedure testmodGUI_0 is
begin
    modGUI.ApriPagina('Home', 1);
    
    /* ---------------------------------- Sidenav - La barra di navigazione laterale ------------------------------------ */
    
    
    /* ------------------------------------------ Menu Laterale Principale -----------------------------------------------*/
    
    /* IMPORTANTE l'id del menu laterale principale va settato anche nella costante mySidenav presente nel file Costanti.pks, poichè viene usato anche in un'altra parte del codice*/
    /* IMPORTANTE l'id deve essere ASSOLUTAMENTE UNIVOCO, si consiglia di iniziare gli id con il nomeUtente o nomeRuolo per evitare dispiaceri dopo il merge da parte dei Sistemisti*/
    modGUI.ApriMenuLat(1, 'dav-mySidenav');
        /*Aggiunta di un nuovo link di collegamento con testo 'Home' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Home', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Gruppo 1' e link che porta al sub-menu di id 'dav-subMenu1' e hasSub settato a true*/
        modGUI.Collegamento('Gruppo 1', 'dav-subMenu1', true);
        /*Aggiunta di un nuovo link di collegamento con testo 'Gruppo 2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Gruppo 2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Gruppo 3' e link che porta al sub-menu di id 'dav-subMenu3' e hasSub settato a true*/
        modGUI.Collegamento('Gruppo 3', 'dav-subMenu3', true);
    /*Chiusura del blocco menu laterale*/
    modGUI.ChiudiMenuLat;
    
    
    /* ------------------------------------------ Sub-Menu Laterale raggiungibile da quello Principale -----------------------------------------------*/
    
    /* Sub-menu di id 'dav-subMenu1' chiamato dal link 'Gruppo 1', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, 'dav-subMenu1', true, 'Gruppo 1');
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 1.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 1.2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 1.3' e link che porta al sub-sub-menu di id 'dav-subSubMenu1-3' e hasSub settato a true*/
        modGUI.Collegamento('Pacchetto 1.3', 'dav-subSubMenu1-3', true);
    modGUI.ChiudiMenuLat;
    
    /* Sub-menu di id 'dav-subMenu3' chiamato dal link 'Gruppo 3', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, 'dav-subMenu3', true, 'Gruppo 3');
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 3.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 3.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 3.2' e link che porta al sub-sub-menu di id 'dav-subSubMenu3-2' e hasSub settato a true*/
        modGUI.Collegamento('Pacchetto 3.2', 'dav-subSubMenu3-2', true);
        /*Aggiunta di un nuovo link di collegamento con testo 'Pacchetto 3.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Pacchetto 3.3', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
    modGUI.ChiudiMenuLat;
    
    
    /* ------------------------------------------ Sub-Sub-Menu Laterale raggiungibile dai Sub-Menu -----------------------------------------------*/
    
    /* Sub-Sub-menu di id 'dav-subSubMenu1-3' chiamato dal link 'Pacchetto 1.3', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, 'dav-subSubMenu1-3', true, 'Pacchetto 1.3');
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 1.3.3' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 1.3.3', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
    modGUI.ChiudiMenuLat;
    
    /* Sub-Sub-menu di id 'dav-subSubMenu3-2' chiamato dal link 'Pacchetto 3.2', IMPORTANTE settare sempre il paramentro parentName (terzo parametro) con il nome del link chiamante*/
    modGUI.ApriMenuLat(1, 'dav-subSubMenu3-2', true, 'Pacchetto 3.2');
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 3.2.1' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 3.2.1', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 3.2.2' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 3.2.2', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /*Aggiunta di un nuovo link di collegamento con testo 'Operazione 3.2.3' e link settato attraverso concatenamento di costanti*/
        modGUI.Collegamento('Operazione 3.2.3', Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
    modGUI.ChiudiMenuLat;

/*---------------------------------------------------------------------------------------------------------------------------------------------------*/

    
    /* ---------------------------------- Topnav - La barra di navigazione classica orizzontale ------------------------------------ */
    
    /* Apertura Blocco menu di navigazion */
	modGUI.ApriMenuNav(1);    
    
        /* ----------- Primo link principale(senza sub-menu) -------------- */
        modGUI.CollegamentoNav('Home',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        
        /* ----------- Secondo link principale (con sub-menu => hasSub settato a 'true' e tipoSub settato a 'primo') -------------- */
        modGUI.CollegamentoNav('Gruppo 1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1, true, 'primo');
        
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
        /* -- Chiusura sub-nav (operazione obbligotoria per le sub-navs) -- */
        modGUI.ChiudiCollegamentoSubNav;
        
        /* ----------- Secondo link principale(senza sub-menu) -------------- */
        modGUI.CollegamentoNav('Gruppo 2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        
        /* ----------- Terzo link principale(con sub-menu => hasSub settato a 'true' e tipoSub settato a 'primo') -------------- */
        modGUI.CollegamentoNav('Gruppo 3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1, true, 'primo');
            /* ----------- Primo link sub-menu (senza sub-sub-menu) -------------- */
            modGUI.CollegamentoNav('Pacchetto 3.1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
            /* ----------- Secondo link sub-menu (con sub-sub-menu => hasSub settato a 'true' e tipoSub settato a 'secondo') -------------- */
            modGUI.CollegamentoNav('Pacchetto 3.2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1, true, 'secondo');
                /* ----------- Primo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 3.2.1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
                /* ----------- Secondo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 3.2.2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
                /* ----------- Terzo link sub-sub-menu -------------- */
                modGUI.CollegamentoNav('Operazione 3.2.3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
            /* -- Chiusura sub-sub-nav (operazione obbligotoria per le sub-navs) -- */
            modGUI.ChiudiCollegamentoSubNav;
            /* ----------- Terzo link sub-menu (senza sub-sub-menu) -------------- */
            modGUI.CollegamentoNav('Pacchetto 3.3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || 1);
        /* -- Chiusura sub-nav (operazione obbligotoria per le sub-navs) -- */
        modGUI.ChiudiCollegamentoSubNav;
    
    /* Chiusura Blocco menu di navigazione */
    modGUI.ChiudiMenuNav(1);
    
	modGUI.Intestazione(1, 'Benvenuto sul sito di Una Cervecita Fresca');
	modGUI.ChiudiPagina;
        
end testmodGUI_0;