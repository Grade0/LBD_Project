CREATE OR REPLACE PACKAGE body gruppo3 AS 

  /*****************************************************/
 /* PROCEDURE PER VISUALIZZARE CLIENTI, BIRRAI O LOTTI*/
/*****************************************************/
procedure visualizzaDati(
    idSessione number,
    valore varchar
    )
is 
begin
    if valore = 'cliente' then
        
       gruppo3.visualizzaClienti(IDSESSIONE);
    else if valore = 'birrai' then
        
        gruppo3.cercaBirrai(IDSESSIONE);
    else if valore = 'lotti' then
        gruppo3.visualizzaLotti(IDSESSIONE);
        
    end if;
    end if;
    end if;
end visualizzaDati;

procedure stampaBirrai(
    idSessione number,
    metodi in metodoTab default EmptyMetodoTab)
is
    ilotti lotti%RowType;
    ilbirraio birrai%rowtype;
    birrai_tab birraiTab;
    i number;
    laricetta ricette%Rowtype;
begin
    modGUI.APRIPAGINA('Birrai', 1);
    modGUI.CREAMENUPRINCIPALE(1);
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Cognome');
    modGUI.IntestazioneTabella('Telefono');
    modGUI.IntestazioneTabella('Indirizzo');
    modGUI.IntestazioneTabella('Ragione sociale');
    modGUI.IntestazioneTabella('Visualizza lotti');
    i:=metodi.first;
    while(i is not null)
    loop
        for ilbirraio in(
            select distinct * from birrai where idbirraio in(
                select idbirraio from lotti where idricetta in (
                    select idricetta from ricette where rtrim(metodologie)=rtrim(metodi(i))
                )
            )
        )
        LOOP
            if birrai_tab.exists(ilbirraio.idbirraio) = false then 
                birrai_tab(ilbirraio.idbirraio):= ilbirraio;
            end if;
        end LOOP;
        i:=metodi.next(i);
    end loop;

    i:= birrai_tab.first;
    while(i is not null)
    LOOP
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(birrai_tab(i).nome);
        modGUI.ELEMENTOTABELLA(birrai_tab(i).cognome);
        modGUI.ELEMENTOTABELLA(birrai_tab(i).telefono);
        modGUI.ELEMENTOTABELLA(birrai_tab(i).indirizzo);
        modGUI.ELEMENTOTABELLA(birrai_tab(i).ragione_sociale);
        
        MODGUI.ApriElementoTabella;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'gruppo3.visualizzaLotti', idSessione);
        MODGUI.bottoneInfo;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('id_birraio', birrai_tab(i).idbirraio);
        modGUI.ChiudiFormHidden;

        modGUI.ChiudiElementoTabella;
        modGUI.ChiudiRigaTabella;
        i:= birrai_tab.next(i);
    end LOOP;                 
    modGUI.CHIUDIRIGATABELLA;
    modGUI.CHIUDITABELLA;
    modGUI.CHIUDIPAGINA;
end stampaBirrai;

procedure cercaBirrai(
    idSessione number
    )
is
begin
    modGUI.APRIPAGINA('ricerca dei Birrai', IDSESSIONE); 
    modGUI.CREAMENUPRINCIPALE(IDSESSIONE);
    modGUI.intestazione(1, 'Cerca birrai per ricetta');
    modGUI.APRIFORM(Costanti.root || 'gruppo3.stampaBirrai','filtroBirraiRicetta',IDSESSIONE);
    modGUI.APRIBLOCCO('<b>Filtri per metodologia:</b>');
    modGUI.CHECKBOX('whole grain', 'metodi', 'whole grain');
    modGUI.CHECKBOX('extract', 'metodi', 'extract');
    modGUI.CHECKBOX('mixed', 'metodi', 'mixed');
    modGUI.CHIUDIBLOCCO;
    --modGUI.APRIBLOCCO('Filtri per ingrediente');
    --modGUI.CHECKBOX('malto', 'ingrediente', 'malto');
    --modGUI.CHECKBOX('luppolo', 'ingrediente', '');
    --modGUI.CHECKBOX('', 'ingrediente', '');
    --modGUI.CHIUDIBLOCCO;
    modGUI.ritcarrello;
    modGUI.ritcarrello;
    modGUI.APRIBLOCCO;
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'filtroBirraiRicetta', testo=>'Cerca');
    modGUI.CHIUDIBLOCCO;
    modGUI.CHIUDIFORM;
    
    --modGUI.paragrafo('ricerca per lotti');
    --modGUI.APRIFORM(Costanti.root || 'procedura che visualizza i birrai per lotti','filtroBirraiLotti',1);
    
    --modGUI.CHIUDIFORM;
    
end cercaBirrai;

procedure visualizzaClienti(
    idSessione number
)
is 
    cursor clienti_cur is 
        select *
        from clienti;
    ibirrai clienti_cur%Rowtype;
begin
        modGUI.APRIPAGINA('visualizza Cliente', IDSESSIONE); 
        modGUI.CREAMENUPRINCIPALE(IDSESSIONE);
        modGUI.Intestazione(1, 'Esempio di utilizzo di modGUI');
        
        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Cognome');
        modGUI.IntestazioneTabella('Telefono');
        modGUI.IntestazioneTabella('Indirizzo');
        modGUI.IntestazioneTabella('Ragione sociale');
        modGUI.IntestazioneTabella('Operazioni');
        modGUI.CHIUDIRIGATABELLA;
          FOR ibirrai IN clienti_cur
          LOOP
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(ibirrai.nome);
            modGUI.ELEMENTOTABELLA(ibirrai.cognome);
            modGUI.ELEMENTOTABELLA(ibirrai.telefono);
            modGUI.ELEMENTOTABELLA(ibirrai.indirizzo);
            modGUI.ELEMENTOTABELLA(ibirrai.ragione_sociale);
            
            MODGUI.ApriElementoTabella;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneDettagli', 1);
            MODGUI.bottoneInfo;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('IdRecord', 20);
            modGUI.ChiudiFormHidden;

            modGUI.ChiudiElementoTabella;
            modGUI.ChiudiRigaTabella;

          END LOOP;
        modGUI.CHIUDITABELLA;
        modGUI.CHIUDIPAGINA;
end visualizzaClienti;
/*
procedure immettiParametri (
    nome in Clienti.nome%type,
    cognome in Clienti.cognome%type,
    ragione_sociale in Clienti.ragione_sociale%type
)
is 
begin
    visualizzaClienti;
end immettiParametri;

procedure cercaCliente(
    nome in Clienti.nome%type,
    cognome in Clienti.cognome%type,
    ragione_sociale in Clienti.ragione_sociale%type
)
is
begin
    visualizzaClienti;
end cercaCliente;
*/

procedure visualizzaLotti(
    idSessione NUMBER,
    /*Da modificare dopo aggiornamento modGUI*/
    id_birraio lotti.IDBIRRAIO%type default -1
)
is
    ilotti lotti%rowtype;
BEGIN
    modGUI.APRIPAGINA('visualizza Lotti', IDSESSIONE); 
    modGUI.CREAMENUPRINCIPALE(IDSESSIONE);
    modGUI.Intestazione(1, 'Lotti in vendita');
    
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome lotto');
    modGUI.IntestazioneTabella('Litri residui');
    modGUI.IntestazioneTabella('Prezzo/litro');
    modGUI.IntestazioneTabella('Operazioni');
    modGUI.CHIUDIRIGATABELLA;
    if id_birraio = -1 then
        for ilotti in (select * from lotti where stato = 'vendita' or stato = 'produzione' ORDER BY PREZZO_AL_LITRO)
        LOOP
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(ilotti.nome);
            modGUI.ELEMENTOTABELLA(ilotti.litri_residui);
            modGUI.ELEMENTOTABELLA(ilotti.prezzo_al_litro);
            MODGUI.ApriElementoTabella;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'Gruppo3.DettagliLotti', idSessione);
            MODGUI.bottoneInfo;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('id_lotto', ilotti.idlotto);
            modGUI.ChiudiFormHidden;

            MODGUI.APRIFORMHIDDEN(Costanti.root || 'GRUPPO3.inserisciCarrello', 1);
            MODGUI.bottoneCart;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('id_lotto', ilotti.idlotto);
            modGUI.PassaParametro('laquantita', 1);
            modGUI.ChiudiFormHidden;

            modGUI.ChiudiElementoTabella;
	        modGUI.ChiudiRigaTabella;

            
        end LOOP;
    else 
        for ilotti in (select * from lotti where stato = 'vendita' and IDBIRRAIO=id_birraio ORDER BY PREZZO_AL_LITRO)
        LOOP
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(ilotti.nome);
            modGUI.ELEMENTOTABELLA(ilotti.litri_residui);
            modGUI.ELEMENTOTABELLA(ilotti.prezzo_al_litro);
            
            MODGUI.ApriElementoTabella;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'Gruppo3.DettagliLotti', idSessione);
            MODGUI.bottoneInfo;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('id_lotto', ilotti.idlotto);
            modGUI.ChiudiFormHidden;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneModifica', 1);
            MODGUI.bottoneEdit;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('IdRecord', 20);
            modGUI.ChiudiFormHidden;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneElimina', 1);
            MODGUI.bottoneDelete;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('IdRecord', 20);
            modGUI.ChiudiFormHidden;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneCarrello', 1);
            MODGUI.bottoneCart;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('IdRecord', 20);
            modGUI.ChiudiFormHidden;

            modGUI.ChiudiElementoTabella;
            modGUI.ChiudiRigaTabella;
        end LOOP;
    end if;
    MODGUI.chiudiTabella;
    MODGUI.ritcarrello;
    MODGUI.ritcarrello;
    modGUI.ChiudiPagina;
END visualizzaLotti;

procedure DettagliLotti(
    idSessione number,
    id_lotto Lotti.idlotto%type
)
is
    illotto Lotti%rowtype;
    laricetta Ricette%rowtype;
    ilbirraio Birrai%rowtype;

begin
    select * into illotto from Lotti where idlotto=id_lotto;
    select * into laricetta from Ricette where idricetta = illotto.idricetta;
    select * into ilbirraio from Birrai where idbirraio=illotto.idbirraio;
    modGUI.APRIPAGINA('Dettagli Lotto', idSessione);
    modGUI.CREAMENUBACKOFFICE(idSessione);
    modGUI.Intestazione(1, 'DETTAGLI LOTTO');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>NOME LOTTO</b>');
    modGUI.ELEMENTOTABELLA(illotto.nome);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>BIRRAIO</b>');
    modGUI.ELEMENTOTABELLA(ilbirraio.nome);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>RICETTA</b>');
    modGUI.ELEMENTOTABELLA(laricetta.nome);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>QUANTITA</b>');
    modGUI.ELEMENTOTABELLA(illotto.litri_residui);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>METOLOGIA</b>');
    modGUI.ELEMENTOTABELLA(laricetta.metodologie);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>PREZZO</b>');
    modGUI.ELEMENTOTABELLA(illotto.prezzo_al_litro);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>DATA INIZIO PRODUZIONE</b>');
    modGUI.ELEMENTOTABELLA(illotto.inizio_produzione);
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>DATA FINE PRODUZIONE</b>');
    modGUI.ELEMENTOTABELLA(illotto.fine_produzione);
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>DATA SCADENZA</b>');
    modGUI.ELEMENTOTABELLA(illotto.scadenza);
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>STATO</b>');
    modGUI.ELEMENTOTABELLA(illotto.stato);
    modGUI.ChiudiRigaTabella;
    modGUI.CHIUDITABELLA;
    
    MODGUI.ritcarrello;
    MODGUI.ritcarrello;
    modGUI.CHIUDIPAGINA;
end DettagliLotti;
/*
procedure visualizzaRecensioni(
    idSessione number
)
IS
BEGIN
        modGUI.APRIPAGINA('Recensioni', idSessione); 
        modGUI.CREAMENUPRINCIPALE(idSessione);
        modGUI.Intestazione(idSessione, 'Visualizzazione Recensioni');
        
        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Cognome');
        modGUI.IntestazioneTabella('Email');
        modGUI.IntestazioneTabella('Telefono');
        modGUI.IntestazioneTabella('Indirizzo');
        modGUI.IntestazioneTabella('Ragione sociale');
        modGUI.CHIUDIRIGATABELLA;
END visualizzaRecensioni;
*/

  /******************************************/
 /* PROCEDURE PER LA GESTIONE DEL CARRELLO*/
/****************************************/
procedure inserisciCarrello(
    idSessione number,
    id_lotto lotti.IDLOTTO%type,
    laquantita lotti.LITRI_PRODOTTI%type
)
is 
    exist number;
begin
    select count(*) into exist from carrello where carrello.IDSESSIONE = idSessione and idlotto=id_lotto;

    if(exist >= 1) then
        update CARRELLO
            set quantita= quantita+laquantita
        where 
            carrello.idSessione = idSessione AND
            idlotto=id_lotto;

        modGUI.PaginaFeedback('SUCCESSO', 'Quantita lotto aggiornato correttamente nel carrello', COSTANTI.root || 'VisualizzaLotti', IDSESSIONE);
    else 
        modGUI.PaginaFeedback('SUCCESSO', 'Lotto inserito correttamente', COSTANTI.root || 'VisualizzaLotti', IDSESSIONE);
        insert into carrello (idSessione, idlotto, quantita)
        values(idSessione, id_lotto, laquantita);
    
    end if;
    
end inserisciCarrello;

procedure eliminaDaCarrello(
    id_sessione number,
    id_lotto lotti.IDLOTTO%type
)
is 
BEGIN
    delete from carrello where idSessione=idSessione and idlotto=id_lotto;
END eliminaDaCarrello;

procedure confermaCarrello(
    idSessione number,
    id_cliente number default 1, --DA SOSTITUIRE CON IDCLIENTE NELLA TABELLA SESSIONI
    iLotti in lottiTab default EmptylottiTab
)
IS

    i number;
    laquantita carrello.QUANTITA%type;
    id_ordine ORDINICLIENTI.IDORDINE%type;
    ilprezzo lotti.PREZZO_AL_LITRO%type;
    lostato lotti.STATO%type;
    prezzoTOT number;

    
BEGIN
    id_ordine := idOrdini_seq.nextVal;
    insert into ORDINICLIENTI(idordine, idcliente, data_ordine, stato)
    values(id_ordine, id_cliente, to_date(sysdate,'dd/mm/yyyy'), 'prenotato');

    i:=iLotti.first;
    prezzoTOT:= 0;
    while(i is not null)
    LOOP
        select QUANTITA into laquantita from carrello where carrello.IDSESSIONE=idSessione and IDLOTTO=iLotti(i).idlotto;
        select PREZZO_AL_LITRO, STATO into ilprezzo, lostato from lotti where idlotto=iLotti(i).idlotto;

        insert into ORDINICLIENTILOTTI(idordine, idlotto, numero_litri, prezzo_litro, pronto)
        values(id_ordine, ilotti(i).idlotto, laquantita, ilprezzo, lostato); 
        prezzoTOT:=prezzoTOT + (ilprezzo*laquantita);
        i:=iLotti.next(i);
    end LOOP;
    
    update ORDINICLIENTI
    set PREZZO_TOTALE = prezzoTOT
    where IDORDINE = id_ordine;

END confermaCarrello;

procedure modificaCarrello(
    id_sessione number,
    iLotti in lottiTab default EmptylottiTab,
    laquantita lotti.LITRI_PRODOTTI%type
)
IS
BEGIN
    update carrello
    set quantita = laquantita
    where idSessione = id_sessione;
END modificaCarrello;

procedure visualizzaCarrello(
    idSessione number
)
is 
    ilcarrello carrello%rowtype;
    quantitaOrdinata number;
    illotto lotti%rowtype;
    totale number;
    i number;
begin
    modGUI.APRIPAGINA('Carrello', idSessione);
    modGUI.CREAMENUBACKOFFICE(idSessione);
    modGUI.INTESTAZIONE(1, 'Il mio Carrello');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome lotto');
    modGUI.IntestazioneTabella('Quantit&agrave;');
    modGUI.IntestazioneTabella('Prezzo/litro');
    modGUI.IntestazioneTabella('Totale parziale');
    modGUI.IntestazioneTabella('Elimina prodotto');
    modGUI.CHIUDIRIGATABELLA;
    totale := 0;
    for ilcarrello in (select * from carrello where carrello.idSessione=idSessione)
    LOOP 
        select * into illotto from lotti where lotti.idlotto=ilcarrello.idlotto;
        select quantita into quantitaOrdinata from carrello where carrello.idSessione=idSessione and carrello.idlotto=ilcarrello.idlotto;
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(illotto.nome);
        modGUI.ApriElementoTabella;

            MODGUI.APRIFORMHIDDEN('ModificaCarrello', idSessione);
            
            modGUI.ApriInlineSelect('quantita');
            for i in 1..illotto.litri_residui 
            LOOP
                if(quantitaOrdinata != i) then
                    modGUI.AGGIUNGIOPZIONESELECT(i, i);
                else
                    modGUI.AGGIUNGIOPZIONESELECT(i,i, true);
                end if;
            end loop;
            modGUi.ChiudiInlineSelectConBottone;
        
            modgui.ChiudiFormHidden;

        MODGUI.ChiudiElementoTabella;

        modGUI.ELEMENTOTABELLA(illotto.prezzo_al_litro);
        modGUi.ELEMENTOTABELLA('&euro; ' || quantitaOrdinata*illotto.prezzo_al_litro || ',00');
        MODGUI.ApriElementoTabella;
        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneElimina', 1);
        MODGUI.bottoneDelete;
        /* eventuale parametro da passare */
        modGUI.ChiudiFormHidden;
        modgui.ChiudiElementoTabella;
        totale := totale + quantitaOrdinata*illotto.prezzo_al_litro;
        modGUI.CHIUDIRIGATABELLA;
    end loop;

    modGUI.CHIUDITABELLA;
    modGUI.INTESTAZIONE(2, 'Totale Carrello: &euro; ' || totale || ',00', classe => 'right');
    modGUI.APRIDIV(classe=>'centered');
    
    modGUI.ApriFormHidden(Costanti.root || 'confermaCarrello', idSessione);
	modGUI.Bottone('Conferma Carrello', classe => 'verde');
	modGUI.ChiudiFormHidden;
    MODGUI.ChiudiElementoTabella;

    
    modGUI.ApriFormHidden(Costanti.root || 'annullaCarrello', idSessione);
	modGUI.Bottone('Annulla Carrello', classe => 'rosso');
	modGUI.ChiudiFormHidden;

    modGUI.CHIUDIDIV;
    modGUI.ritcarrello;
    modGUI.ritcarrello;
    modGUI.ritcarrello;
    


    modGUI.CHIUDIPAGINA;
end visualizzaCarrello;
END GRUPPO3;