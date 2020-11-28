CREATE OR REPLACE package body OrdiniPack AS

--TODO visualizzare gli ordini secondo i criteri di ricerca

procedure visualizzaOrdini(
    idSessione number,
    numOrdineFlag number default 0,
    dataFlag number default 0,
    prezzoFlag number default 0,
    quantitaFlag number default 0
)
is
    id_cliente Clienti.idcliente%type;
    lordine ORDINICLIENTI%rowtype;
    n_lotti number;
BEGIN
    select IDUTENTE into id_cliente from Sessioni where Sessioni.IDSESSIONE=idSessione;

    modGUI.APRIPAGINA('Ordini effetuati', idSessione);
    modGUI.CREAMENUBACKOFFICE(IDSESSIONE  => idSessione);
    modGUi.INTESTAZIONE(TIPO  => 1, TESTO  => 'Ordini effetuati');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Ordine N.');
    modGUI.IntestazioneTabella('N. Lotti');
    modGUI.IntestazioneTabella('Dettagli');
    for lordine in (select * from ORDINICLIENTI where idcliente=id_cliente)
    LOOP
        select count(*) into n_lotti from ORDINICLIENTILOTTI where idordine=lordine.idordine;
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(lordine.idordine);
        modGUI.ELEMENTOTABELLA(n_lotti);
        MODGUI.ApriElementoTabella;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'ordiniPack.DettagliOrdine', idSessione);
        MODGUI.bottoneInfo;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('id_ordine', lordine.idordine);
        modGUI.ChiudiFormHidden;

        modGUI.ChiudiElementoTabella;
        modGUI.CHIUDIRIGATABELLA;

    END LOOP;

    modGUI.CHIUDIRIGATABELLA;
    modGUI.CHIUDITABELLA;
    modGUI.CHIUDIPAGINA;
END visualizzaOrdini;

procedure DettagliOrdine(
    idSessione number,
    id_ordine ORDINICLIENTI.IDORDINE%type
)
is 
    lordine ORDINICLIENTI%rowtype;
    ordinelotto ORDINICLIENTILOTTI%ROWTYPE;
    nomelotto LOTTI.NOME%type;
BEGIN
    select * into lordine from ORDINICLIENTI where idordine=id_ordine; 
    modGUI.APRIPAGINA('Ordini effetuati', idSessione);
    modGUI.CREAMENUBACKOFFICE(IDSESSIONE  => idSessione);
    modGUi.INTESTAZIONE(TIPO  => 1, TESTO  => 'Ordini effetuati');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>Data ordine</b>');
    modGUI.ELEMENTOTABELLA(lordine.data_ordine);
    modGUI.CHIUDIRIGATABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>Stato</b>');
    modGUI.ELEMENTOTABELLA(lordine.stato);
    modGUI.CHIUDIRIGATABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('<b>Prezzo totale</b>');
    modGUI.ELEMENTOTABELLA(lordine.prezzo_totale);
    modGUI.CHIUDIRIGATABELLA;
    modGUI.CHIUDITABELLA;
    lottiAcquistati(idSessione, lordine.idordine);
    modGUI.CHIUDIPAGINA;
END;

procedure lottiAcquistati(
    idSessione number,
    id_ordine ORDINICLIENTI.idordine%type default -1    
)
is 
    id_ordine ORDINICLIENTI.IDORDINE%type;
    quantitaLotto number;
    id_cliente number;
BEGIN
    if id_ordine < 0 then 
        modGUI.APRIPAGINA('Lotti acquistati', idSessione);
        modGUI.CREAMENUBACKOFFICE(IDSESSIONE  => idSessione);
        modGUi.INTESTAZIONE(TIPO  => 1, TESTO  => 'Lotti acquistati');
        select IDUTENTE into id_cliente from SESSIONI where SESSIONI.IDSESSIONE = idSessione;
    end if;
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('nome lotto');
    modGUI.IntestazioneTabella('quantita');
    modGUI.IntestazioneTabella('prezzo/litro');
    --modGUI.IntestazioneTabella('');
    modGUI.CHIUDIRIGATABELLA;

    for ordinelotto in (select * from ORDINICLIENTILOTTI where (case when id_ordine >= 0 then ORDINICLIENTILOTTI.idordine=id_ordine else  1 end ) =1 )
    LOOP
        select nome into nomelotto from lotti where idlotto=ordinelotto.idlotto;
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(nomelotto);
        modGUI.ELEMENTOTABELLA(ordinelotto.numero_litri);
        modGUI.ELEMENTOTABELLA(ordinelotto.prezzo_litro);
        modGUI.CHIUDIRIGATABELLA;
    end LOOP;
    modGUI.CHIUDITABELLA;
END;
end OrdiniPack;