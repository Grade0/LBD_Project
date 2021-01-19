create or replace PACKAGE body gruppo3 AS

    /*stampa i birrai */
    procedure stampaBirrai(
        idSessione number,
        metodi in metodoTab default EmptyMetodoTab,
        nomeRicetta varchar default null
    )
    is
        birrai_cur birrai_cursorType;
        ilbirraio birrai%rowtype;
        birrai_tab birraiTab;
        i number;
        nlotti number;
    begin
        modGUI.APRIPAGINA('Birrai', idSessione);
        modGUI.Intestazione(1, 'Elenco Birrai');
        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Cognome');
        modGUI.IntestazioneTabella('Telefono');
        modGUI.IntestazioneTabella('Indirizzo');
        modGUI.IntestazioneTabella('Ragione sociale');
        modGUI.IntestazioneTabella('Visualizza lotti');
        i:=metodi.first;

        if i is null then
            if nomeRicetta is null THEN
                open birrai_cur for select distinct * from birrai;
            else
                open birrai_cur for select distinct b.*
                                    from birrai b, lotti l, ricette r
                                    where b.idbirraio=l.idbirraio and l.idricetta=r.idricetta and r.nome like '%' || nomeRicetta || '%';
            end if;
            loop
                fetch birrai_cur into ilbirraio;
                exit when birrai_cur%notfound;
                if birrai_tab.exists(ilbirraio.idbirraio) = false then
                    select count(*) into nlotti from lotti where idbirraio=ilbirraio.idbirraio and stato='vendita';
                    if nlotti > 0 then
                        birrai_tab(ilbirraio.idbirraio):= ilbirraio;
                    end if;
                end if;
            end loop;
            close birrai_cur;
        else
            while(i is not null)
            loop
                if nomeRicetta is null then
                    open birrai_cur for
                        select distinct b.*
                        from birrai b, lotti l, ricette r
                        where b.idbirraio=l.idbirraio and l.idricetta=r.idricetta and  rtrim(r.metodologie)=rtrim(metodi(i));
                else
                    open birrai_cur for
                        select distinct b.*
                        from birrai b, lotti l, ricette r
                        where b.idbirraio=l.idbirraio and l.idricetta=r.idricetta and  rtrim(r.metodologie)=rtrim(metodi(i)) and r.nome like '%'||nomeRicetta||'%';
                end if;
                LOOP
                    fetch birrai_cur into ilbirraio;
                    exit when birrai_cur%notfound;
                    if birrai_tab.exists(ilbirraio.idbirraio) = false then
                        select count(*) into nlotti from lotti where idbirraio=ilbirraio.idbirraio and stato='vendita';
                        if nlotti > 0 then
                            birrai_tab(ilbirraio.idbirraio):= ilbirraio;
                        end if;
                    end if;
                end LOOP;
                close birrai_cur;
                i:=metodi.next(i);
            end loop;
        end if;
        i:= birrai_tab.first;
        if i is not null then
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
                modGUI.PassaParametro('id_birraio', birrai_tab(i).idbirraio);
                modGUI.ChiudiFormHidden;

                modGUI.ChiudiElementoTabella;
                modGUI.ChiudiRigaTabella;
                i:= birrai_tab.next(i);
            end LOOP;
            modGUI.CHIUDIRIGATABELLA;
            modGUI.CHIUDITABELLA;
        else
            MODGUI.INTESTAZIONE(1,'Non ci sono birrai che soddisfano i filtri applicati' /*IN VARCHAR2*/);
        end if;
        modGUI.CHIUDIPAGINA;
    end stampaBirrai;

    procedure cercaBirrai(
        idSessione number
        )
    is
    begin
        modGUI.APRIPAGINA('ricerca dei Birrai', IDSESSIONE);
        modGUI.intestazione(1, 'Cerca birrai per ricetta');
        modGUI.APRIFORM(Costanti.root || 'gruppo3.stampaBirrai','filtroBirraiRicetta',IDSESSIONE);
        modGUI.APRIBLOCCO('<b>Filtri per metodologia:</b>');
        modGUI.CHECKBOX('whole grain', 'metodi', 'whole grain');
        modGUI.CHECKBOX('extract', 'metodi', 'extract');
        modGUI.CHECKBOX('mixed', 'metodi', 'mixed');
        modGUI.CHIUDIBLOCCO;

        modGUI.CASELLADITESTO('nomeRicetta','Nome Ricetta',suggerimento=>'Inserisci nome ricetta', tipo=>'testo');

        modGUI.ritcarrello;
        modGUI.ritcarrello;
        modGUI.APRIBLOCCO;
        modGUI.BOTTONEFORM(valida=>true,nomeForm=>'filtroBirraiRicetta', testo=>'Cerca');
        modGUI.CHIUDIBLOCCO;
        modGUI.CHIUDIFORM;


    end cercaBirrai;

    procedure visualizzaCliente(
        idSessione number,
        id_cliente number default null
    )
    is
        cursor clienti_cur is
            select *
            from clienti;
        ibirrai clienti_cur%Rowtype;

        ilcliente clienti%ROWTYPE;

        ruolo varchar2(45);
    begin
        ruolo := login.GETROLEFROMSESSION(idSessione);
        if id_cliente is null then
            select * into ilcliente from clienti where idcliente = login.GETIDUtente(idSessione);
            modGUI.APRIPAGINA('visualizza Cliente', IDSESSIONE);
            modGUI.Intestazione(1, 'I miei dati');
        else
            select * into ilcliente from clienti where idcliente = id_cliente;
            modGUI.APRIPAGINA('visualizza Cliente', IDSESSIONE);
            modGUI.Intestazione(1, 'cliente numero '|| id_cliente);
        end if;
            modGUI.APRITABELLA;
            modGUI.APRIRIGATABELLA;
            modGUI.IntestazioneTabella('Nome');
            modGUI.IntestazioneTabella('Cognome');
            modGUI.IntestazioneTabella('Telefono');
            modGUI.IntestazioneTabella('Indirizzo');
            modGUI.IntestazioneTabella('Ragione sociale');
            --si visualizza quando viene chiamata da admin nel topRecensioni
            if ruolo = 'amministratore' THEN
            modGUI.IntestazioneTabella('I suoi ORDINI');
            modGUI.IntestazioneTabella('Le sue RECENSIONI');
            end if;
            modGUI.IntestazioneTabella('Modifica');

            modGUI.CHIUDIRIGATABELLA;

            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(ilcliente.nome);
            modGUI.ELEMENTOTABELLA(ilcliente.cognome);
            modGUI.ELEMENTOTABELLA(ilcliente.telefono);
            modGUI.ELEMENTOTABELLA(ilcliente.indirizzo);
            modGUI.ELEMENTOTABELLA(ilcliente.ragione_sociale);
            --si visualizza quando viene chiamata da admin nel topRecensioni
            if ruolo = 'amministratore' THEN
                MODGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'OrdiniPack.visualizzaOrdini', idSessione);
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('id_cliente', ilcliente.idcliente);
                modGUI.ChiudiFormHidden;
                modgui.ChiudiElementoTabella;

                MODGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'recensioniPack.visualizzaRecensioni', idSessione);
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('id_cliente', ilcliente.idcliente);
                modGUI.ChiudiFormHidden;
                modgui.ChiudiElementoTabella;
            end if;
            MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'gruppo3.aggiornamentoCliente', idSessione);
            MODGUI.bottoneEdit;
            modgui.PassaParametro('id_cliente', id_cliente);
            modGUI.ChiudiFormHidden;
            modgui.ChiudiElementoTabella;

            MODGUI.chiudirigaTabella;

            modGUI.CHIUDITABELLA;

            modGUI.CHIUDIPAGINA;
    end visualizzaCliente;


    procedure aggiornamentoCliente(
        idSessione number,
        id_cliente number default null
    )
    is
        cliente clienti%rowtype;
    BEGIN
        modGUI.APRIPAGINA('modifica dati', idSessione);
        modGUI.Intestazione(1, 'modifica dati personali');
        if(login.GETROLEFROMSESSION(idSessione) = 'cliente') then
            select * into cliente from clienti where IDCLIENTE=login.GETIDUTENTE(idSessione);
        else if login.GETROLEFROMSESSION(idSessione)  = 'amministratore' and id_cliente is not null then
                select * into cliente from clienti where IDCLIENTE=id_cliente;
            end if;
        end if;

        modGUI.APRIFORM(Costanti.root || 'gruppo3.checkDatiClienti','checkClienti',IDSESSIONE);
        modGUI.CASELLADITESTO(nome=>'ilnome',etichetta=>'Nome',testo=>cliente.nome, tipo=>'alfa', require=>true, lunghezzaMax => 45);
        modGUI.CASELLADITESTO(nome=>'ilcognome',etichetta=>'Cognome',testo=>cliente.cognome, tipo=>'alfa',  require=>true, lunghezzaMax => 45);
        modGUI.CASELLADITESTO(nome=>'iltelefono',etichetta=>'Telefono',testo=>cliente.telefono, tipo=>'alfa', require=>true, lunghezzaMax => 13);
        modGUI.CASELLADITESTO(nome=>'lindirizzo',etichetta=>'Indirizzo',testo=>cliente.indirizzo, tipo=>'alfa', require=>true, lunghezzaMax => 45);
        modGUI.CASELLADITESTO(nome=>'laragioneSociale',etichetta=>'Ragione Sociale',testo=>cliente.ragione_sociale, tipo=>'alfa', lunghezzaMax => 45);

        modGUI.ritcarrello;
        modGUI.ritcarrello;
        modGUI.APRIBLOCCO;
        modGUI.BOTTONEFORM(valida=>true,nomeForm=>'checkClienti', testo=>'Conferma');
        modgui.PassaParametro('id_cliente', cliente.idcliente);
        modGUI.CHIUDIBLOCCO;
        modGUI.CHIUDIFORM;

        modGUi.ChiudiPagina;
    END aggiornamentoCliente;

    procedure checkDatiClienti(
        idSessione number,
        id_cliente number,
        ilnome VARCHAR2,
        ilcognome VARCHAR2,
        iltelefono VARCHAR2,
        lindirizzo VARCHAR2,
        laragioneSociale VARCHAR2
    )
    IS
        --id_cliente number;
        rs clienti.ragione_sociale%type;
        exist number;
    BEGIN
        --id_cliente := login.GETIDUTENTE(idSessione);
        select RAGIONE_SOCIALE into rs from clienti where idcliente=id_cliente;

        if laragioneSociale != rs then
            select count(*) into exist from CLIENTI where RAGIONE_SOCIALE=laragioneSociale;
            if exist > 0 and laragioneSociale!='privato' THEN
                MODGUI.PAGINAFEEDBACK('ERRORE','ragione sociale già registrato, riprovare', COSTANTI.root || 'gruppo3.aggiornamentoCliente' , idSessione);
                RETURN;
            end IF;
        end if;

        UPDATE CLIENTI
        set
            nome = ilnome,
            cognome = ilcognome,
            telefono = iltelefono,
            indirizzo = lindirizzo,
            RAGIONE_SOCIALE = laragioneSociale
        where IDCLIENTE = id_cliente;
        MODGUI.PAGINAFEEDBACK('SUCCESSO', 'dati modificati correttamente', Costanti.root || 'modGUI.PAGINAPRINCIPALE', idSessione);
    END checkDatiClienti;


    procedure visualizzaLotti(
        idSessione NUMBER,
        id_birraio lotti.IDBIRRAIO%type default null,
        id_ricetta ricette.idricetta%type default null
    )
    is
        lottiCur lotti_cursorType;
        ilotti lotti%rowtype;
        quantitaOrdinata number;
    BEGIN
        modGUI.APRIPAGINA('visualizza Lotti', IDSESSIONE);
        modGUI.Intestazione(1, 'Lotti in vendita');

        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome lotto');
        modGUI.IntestazioneTabella('Litri residui');
        modGUI.IntestazioneTabella('Prezzo/litro');
        modGUI.IntestazioneTabella('Dettagli lotto');
        if login.GETROLEFROMSESSION(idSessione) = 'cliente' then
            modGUI.IntestazioneTabella('Aggiungi nel carrello');
        end if;
        modGUI.CHIUDIRIGATABELLA;

        if id_birraio is null then
            if id_ricetta is null then
                open lottiCur for   select * from lotti
                                    where   (stato = 'vendita' or stato = 'produzione')
                                            and to_date(pubblicazione, 'dd/mm/yyyy') <= to_date(SYSDATE, 'dd/mm/yyyy')
                                            and (to_date(SYSDATE, 'dd/mm/yyyy') < to_date(scadenza, 'dd/mm/yyyy') or scadenza is null)
                                    ORDER BY PREZZO_AL_LITRO;
            else
                --operazione da admin (no interessa lo stato dei lotti)
                open lottiCur for select * from lotti where idricetta= id_ricetta ORDER BY litri_residui desc , PREZZO_AL_LITRO;
            end if;
        else
            open lottiCur for   select * from lotti
                                where   (stato = 'vendita' or stato = 'produzione')
                                        and to_date(pubblicazione, 'dd/mm/yyyy') <= to_date(SYSDATE, 'dd/mm/yyyy')
                                        and (to_date(SYSDATE, 'dd/mm/yyyy') < to_date(scadenza, 'dd/mm/yyyy') or scadenza is null)
                                        and IDBIRRAIO=id_birraio
                                ORDER BY PREZZO_AL_LITRO;
        end if;

        loop
            FETCH lottiCur into ilotti;
            exit when lottiCur%notfound;
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(ilotti.nome);
            modGUI.ELEMENTOTABELLA(ilotti.litri_residui);
            modGUI.ELEMENTOTABELLA(ilotti.prezzo_al_litro);

            MODGUI.ApriElementoTabella;

            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'Gruppo3.DettagliLotti', idSessione);
            MODGUI.bottoneInfo;
            modGUI.PassaParametro('id_lotto', ilotti.idlotto);
            modGUI.ChiudiFormHidden;
            MODGUI.ChiudiElementoTabella;

            if login.GETROLEFROMSESSION(idSessione) = 'cliente' then
                MODGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GRUPPO3.inserisciCarrello', idSessione);

                modGUI.PassaParametro('id_lotto', ilotti.idlotto);
                    modGUI.ApriInlineSelect('laquantita');
                        modGUI.AGGIUNGIOPZIONESELECT(1, 1, true);
                        for i in 2..ilotti.litri_residui
                        LOOP
                            modGUI.AGGIUNGIOPZIONESELECT(i, i);
                        end loop;
                        modGUi.ChiudiInlineSelect;
                    MODGUI.bottoneCart;
                modGUI.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
            end if;

            modGUI.ChiudiRigaTabella;
        end loop;
        close lottiCur;
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
        select count(*) into exist from carrello where carrello.ID_SESSIONE = idSessione and idlotto=id_lotto;

        if(exist >= 1) then
            update CARRELLO
                set quantita= quantita+laquantita
            where
                carrello.id_Sessione = idSessione AND
                idlotto=id_lotto;

            modGUI.PaginaFeedback('SUCCESSO', 'Quantita lotto aggiornato correttamente nel carrello', COSTANTI.root || 'Gruppo3.VisualizzaLotti', IDSESSIONE);
        else
            modGUI.PaginaFeedback('SUCCESSO', 'Lotto inserito correttamente', COSTANTI.root || 'gruppo3.VisualizzaLotti', IDSESSIONE);
            insert into carrello (id_Sessione, idlotto, quantita)
            values(idSessione, id_lotto, laquantita);

        end if;

    end inserisciCarrello;

    procedure eliminaDaCarrello(
        idSessione number,
        id_lotto number default null,
        flag number default null
    )
    is
    BEGIN
        if id_lotto is not null THEN
            delete from carrello where id_Sessione=idSessione and idlotto = id_lotto;
            modGUI.REINDIRIZZA(Costanti.root || 'Gruppo3.visualizzaCarrello?idSessione=' || idSessione);
        ELSE
            delete from carrello where id_Sessione=idSessione;
            if flag is null then
                modGUI.PAGINAFEEDBACK('SUCCESSO', 'Carrello eliminato', Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
            end if;
        end if;
    END eliminaDaCarrello;

    procedure confermaCarrello(
        idSessione number
        --iLotti in lottiTab default EmptylottiTab
    )
    IS

        i number;
        --id_lotto lotti.idlotto%type;
        --laquantita carrello.QUANTITA%type;
        id_ordine ORDINICLIENTI.IDORDINE%type;
        ilprezzo lotti.PREZZO_AL_LITRO%type;
        lostato lotti.STATO%type;
        epronto number;
        prezzoTOT number;

        carrello_rec carrello%rowtype;
        id_cliente number;
    BEGIN
        prezzoTOT := 0;
        id_ordine := idOrdiniClienti_seq.nextval;
        id_cliente := login.GETIDUtente(idSessione);
        --modgui.intestazione(1, id_ordine);

        insert into ORDINICLIENTI(idordine, idcliente, data_ordine, stato)
        values(id_ordine, id_cliente, to_date(sysdate,'dd/mm/yyyy'), 'in preparazione');

        for carrello_rec in (select * from carrello where carrello.id_Sessione=idSessione)
        LOOP
            select PREZZO_AL_LITRO, STATO into ilprezzo, lostato from lotti where idlotto=carrello_rec.idlotto;

            insert into ORDINICLIENTILOTTI(idordine, idlotto, numero_litri, prezzo_litro, pronto)
            values(id_ordine, carrello_rec.idlotto, carrello_rec.quantita, ilprezzo, 0);
            if lostato='vendita' then
                update ORDINICLIENTILOTTI
                set pronto=1
                where idordine=id_ordine;
            end if;

            prezzoTOT:=prezzoTOT + (ilprezzo * carrello_rec.quantita);

        end loop;

        update ORDINICLIENTI
        set
            PREZZO_TOTALE = prezzoTOT
        where IDORDINE = id_ordine;
        --modgui.intestazione(1, 'ciao');
        modGUI.PAGINAFEEDBACK('SUCCESSO', 'Ordine confermato correttamente', Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
        gruppo3.eliminaDaCarrello(idSessione, flag => 1);
    exception
        when others then
            modGUI.PAGINAFEEDBACK('ERRORE', 'Ops, un lotto che hai selezionato lo hanno gia comprato altri, selezionane un altro!', Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
    END confermaCarrello;

    procedure modificaCarrello(
        idSessione number,
        id_lotto number,
        laquantita lotti.LITRI_PRODOTTI%type
    )
    IS
    BEGIN
        update carrello
        set quantita = laquantita
        where idSessione = id_Sessione and idlotto = id_lotto;
        modGUI.REINDIRIZZA( Costanti.root || 'gruppo3.visualizzaCarrello?idSessione=' || idSessione );
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
        n_lotti number;
    begin
        modGUI.APRIPAGINA('Carrello', idSessione);
        modGUI.INTESTAZIONE(1, 'Il mio Carrello');
        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome lotto');
        modGUI.IntestazioneTabella('Quantit;');
        modGUI.IntestazioneTabella('Prezzo/litro');
        modGUI.IntestazioneTabella('Totale parziale');
        modGUI.IntestazioneTabella('Elimina prodotto');
        modGUI.CHIUDIRIGATABELLA;
        totale := 0;
        for ilcarrello in (select * from carrello where carrello.id_Sessione=idSessione)
        LOOP
            select * into illotto from lotti where lotti.idlotto=ilcarrello.idlotto;
            select quantita into quantitaOrdinata from carrello where carrello.id_Sessione=idSessione and carrello.idlotto=ilcarrello.idlotto;
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(illotto.nome);
            modGUI.ApriElementoTabella;

                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'gruppo3.modificaCarrello', idSessione);
                modGUI.PASSAPARAMETRO('id_lotto', illotto.idlotto);
                modGUI.ApriInlineSelect('laquantita');
                for i in 1..illotto.litri_residui
                LOOP
                    if(quantitaOrdinata != i) then
                        modGUI.AGGIUNGIOPZIONESELECT(i, i);
                    else
                        modGUI.AGGIUNGIOPZIONESELECT(i,i, true);
                    end if;
                end loop;
                modGUi.ChiudiInlineSelect;
                MODGUI.bottoneEdit;
                modgui.ChiudiFormHidden;

            MODGUI.ChiudiElementoTabella;

            modGUI.ELEMENTOTABELLA(illotto.prezzo_al_litro);
            modGUi.ELEMENTOTABELLA('&euro; ' || quantitaOrdinata*illotto.prezzo_al_litro || ',00');
            MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'gruppo3.eliminaDacarrello', IDSESSIONE);
            MODGUI.PASSAPARAMETRO('id_lotto' ,illotto.idlotto);
            MODGUI.bottoneDelete;
            /* eventuale parametro da passare */
            modGUI.ChiudiFormHidden;
            modgui.ChiudiElementoTabella;
            totale := totale + quantitaOrdinata*illotto.prezzo_al_litro;
            modGUI.CHIUDIRIGATABELLA;
        end loop;

        modGUI.CHIUDITABELLA;


        select count(*) into n_lotti from CARRELLO where carrello.id_Sessione=idSessione;
        if n_lotti > 0 then
            modGUI.INTESTAZIONE(2, 'Totale Carrello: &euro; ' || totale || ',00', classe => 'right');
            modGUI.APRIDIV(classe=>'centered');
            modGUI.ApriFormHidden(Costanti.root || 'gruppo3.confermaCarrello', idSessione);
            modGUI.Bottone('Conferma Carrello', classe => 'verde');
            modGUI.ChiudiFormHidden;

            modGUI.ApriFormHidden(Costanti.root || 'gruppo3.eliminaDaCarrello', idSessione);
            modGUI.Bottone('Annulla Carrello', classe => 'rosso');
            modGUI.ChiudiFormHidden;
        else
            modGUI.INTESTAZIONE(2, 'Non hai ancora selezionato lotti ');
        end if;
        modGUI.CHIUDIDIV;
        modGUI.ritcarrello;
        modGUI.ritcarrello;
        modGUI.ritcarrello;

        modGUI.CHIUDIPAGINA;
    end visualizzaCarrello;
    END GRUPPO3;

/

create or replace package BODY opBirrai AS

procedure visualizzaAnnotazioni(
    idSessione number,
    id_lotto lotti.idlotto%type default null
) IS
    --cursor annotazioni_cur is (select a.* from ANNOTAZIONI a, Lotti l, BIRRAI b where a.idlotto=l.idlotto and b.idbirraio=l.idbirraio);
    annotazioni_cur annotazioni_cursorType;
    annotazioni_rec annotazioni%rowtype;
    nomelotto lotti.nome%type;
begin
    if id_lotto is not null then
        open annotazioni_cur for select a.* from ANNOTAZIONI a, Lotti l, BIRRAI b where a.idlotto=l.idlotto and b.idbirraio=l.idbirraio and b.idbirraio=login.GETIDUTENTE(idSessione);
    else
        open annotazioni_cur for select * from ANNOTAZIONI a where a.idbirraio=login.GETIDUTENTE(idSessione);
    end if;

    modgui.APRIPAGINA('Annotazioni lotti', idSessione);
    modGUI.Intestazione(1, 'Visualizza le annotazioni');
    MODGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    MODGUI.INTESTAZIONETABELLA('Nome lotto');
    MODGUI.INTESTAZIONETABELLA('Annotazione');
    MODGUI.INTESTAZIONETABELLA('Data rilascio');
    modgui.chiudirigatabella;

    loop
        fetch annotazioni_cur into annotazioni_rec;
        exit when annotazioni_cur%notfound;
        select nome into nomelotto from lotti where lotti.idlotto=annotazioni_rec.idlotto;
        modgui.APRIRIGATABELLA;
        MODGUI.ELEMENTOTABELLA(nomelotto);
        MODGUI.ELEMENTOTABELLA(annotazioni_rec.annotazione);
        MODGUI.ELEMENTOTABELLA(annotazioni_rec.rilascio);
        modgui.chiudirigatabella;
    end loop;

    MODGUI.chiuditabella;
    modgui.chiudipagina;
end visualizzaAnnotazioni;

procedure modificaStatoLotto(
    idSessione number,
    id_lotto lotti.idlotto%type
) IS
    statoLotto lotti.stato%type;
    illotto lotti%rowtype;
BEGIN

    select stato into statoLotto from LOTTI where idlotto = id_lotto;
    modGUI.APRIPAGINA('modifica dati Lotti', idSessione);
    modGUI.Intestazione(1, 'modifica dati Lotti');

    modGUI.APRIFORM(Costanti.root || 'opBirrai.aggiungiDatiLotto','aggiungiDatiLotto',IDSESSIONE);
    select * into illotto from Lotti where idlotto = id_lotto;
    modgui.PassaParametro('id_lotto', id_lotto);
    modGUI.APRIBLOCCOSELECT(ETICHETTA  => 'Stato del lotto');

    modGUI.APRISELECT(NOME  => 'new_stato');
    if illotto.stato = 'produzione' or illotto.stato = 'vendita' then
        modGUI.AGGIUNGIOPZIONESELECT(VALORE  => 'vendita', ETICHETTA  => 'Vendita');
    end if;
    modGUI.AGGIUNGIOPZIONESELECT(VALORE  => 'archiviato' , ETICHETTA  => 'Archiviato');
    modGUI.ChiudiSelect;
    modGUI.ChiudiBloccoselect;
    --modGUI.CASELLADITESTO(nome=>'data_fine_profuzione',etichetta=>'fine produzione', testo=>to_date(illotto.fine_produzione, 'dd/mm/yyyy'), tipo=>'date', lunghezzaMax => 10);
    --modGUI.CASELLADITESTO(nome=>'data_scadenza',etichetta=>'scadenza', testo=>to_date(illotto.scadenza, 'dd/mm/yyyy'), tipo=>'date', lunghezzaMax => 10);
    --modGUI.CASELLADITESTO(nome=>'data_pubblicazione',etichetta=>'pubblicazione', testo=>to_date(illotto.pubblicazione, 'dd/mm/yyyy'), tipo=>'date', lunghezzaMax => 10);

    htp.print('
    <div class="form-group row">
      <label for="' || 'data_fine_produzione' ||'" class="col-lg-2 col-lg-push-2 control-label">'
      || 'fine produzione' ||'</label>
      <div class="col-lg-3 col-lg-push-2">');
    htp.prn('<input type="date" name="data_fine_produzione" value="'|| TO_CHAR(to_date(illotto.fine_produzione),'yyyy-mm-dd') ||'" maxlength="10">');
    htp.print(' </div> </div>');
    htp.print('
    <div class="form-group row">
      <label for="' || 'data_scadenza' ||'" class="col-lg-2 col-lg-push-2 control-label">'
      ||'scadenza' ||'</label>
      <div class="col-lg-3 col-lg-push-2">');
    htp.prn('<input type="date" name="data_scadenza" value="'|| TO_CHAR(to_date(illotto.scadenza),'yyyy-mm-dd') ||'" maxlength="10">');
    htp.print(' </div> </div>');
    htp.print('
    <div class="form-group row">
      <label for="' || 'data_pubblicazione' ||'" class="col-lg-2 col-lg-push-2 control-label">'
      || 'pubblicazione' ||'</label>
      <div class="col-lg-3 col-lg-push-2">');
    htp.prn('<input type="date" name="data_pubblicazione" value="'|| TO_CHAR(to_date(illotto.pubblicazione), 'yyyy-mm-dd') ||'" maxlength="10">');
    htp.print(' </div> </div>');

    modGUI.ritcarrello;
    modGUI.ritcarrello;
    modGUI.APRIBLOCCO;
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'aggiungiDatiLotto', testo=>'Conferma');
    modGUI.CHIUDIBLOCCO;
    modGUI.CHIUDIFORM;

    modGUi.ChiudiPagina;

END modificaStatoLotto;

procedure aggiungiDatiLotto(
    idSessione number,
    id_lotto number,
    new_stato varchar2,
    data_fine_produzione varchar2 default null,
    data_scadenza varchar2 default null,
    data_pubblicazione varchar2 default null
)
IS
BEGIN
    update LOTTI
    set
        stato = new_stato,
        FINE_PRODUZIONE = to_date(data_fine_produzione, 'yyyy/mm/dd'),
        SCADENZA =to_date(data_scadenza, 'yyyy/mm/dd'),
        PUBBLICAZIONE = to_date(data_pubblicazione, 'yyyy/mm/dd')
    where idlotto = id_lotto;
    modGUI.PAGINAFEEDBACK('SUCCESSO','campi modificati con successo', 'operazioniCataniaStasula.visualizzaLottiBirraio',idSessione);
END aggiungiDatiLotto;

procedure produciLotto(
    idSessione number
)
is
    CURSOR r(v_nidbirraio Birrai.idbirraio%TYPE) is
        SELECT r.idricetta,nome,utilizzabile,metodologie,istruzioni
        FROM RicetteCondivise rc, Ricette r
        WHERE rc.IDRICETTA = r.IDRICETTA AND rc.idbirraio=v_nidbirraio AND r.utilizzabile=1
        ORDER BY r.utilizzabile DESC, r.nome;
    ricetta_r r%rowtype;
begin
    modgui.APRIPAGINA('produzione lotto', idSessione);
    modGUI.Intestazione(1, 'Inizia la produzione!');

    modGUI.APRIFORM(Costanti.root || 'opBirrai.inserisciLotto','creaLotto',IDSESSIONE);
    modGUI.CASELLADITESTO(nome=>'nomeLotto',etichetta=>'Nome del lotto', tipo=>'alfa', require=>true, lunghezzaMax => 45);
    modGUI.CASELLADITESTO(nome=>'descrizioneLotto',etichetta=>'descrizione', tipo=>'alfa', lunghezzaMax => 45);
    modGUI.Apribloccoselect('Seleziona la ricetta');
    open r(login.getidutente(idSessione));
    modGUI.ApriSelect('id_ricetta');
    LOOP
        fetch r into ricetta_r;
        exit when r%notfound;
        modGUI.AGGIUNGIOPZIONESELECT(ricetta_r.idricetta, ricetta_r.nome);
    end loop;
    modGUi.ChiudiSelect;
    modGUI.ChiudiBloccoselect;
    modGUI.CASELLADITESTO(nome=>'litri',etichetta=>'litri che vuoi produrre', tipo=>'number', require=>true, lunghezzaMax => 10);
    modGUI.CASELLADITESTO(nome=>'prezzoVendita',etichetta=>'prezzo di vendita', tipo=>'number', require=>true, lunghezzaMax => 5);

    modGUI.apriblocco;
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'creaLotto', testo=>'Conferma');
    modGUI.chiudiBlocco;
    modGUI.chiudiform;
end produciLotto;

procedure inserisciLotto(
    idSessione number,
    nomeLotto varchar2,
    descrizioneLotto varchar2 default null,
    id_ricetta ricette.idricetta%type,
    litri number,
    prezzoVendita number
)is
begin
    insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, litri_prodotti, stato, litri_residui, prezzo_al_litro)
    values(idlotti_seq.nextval, id_ricetta, login.getidutente(idSessione), nomeLotto, descrizioneLotto, to_date(SYSDATE, 'dd/mm/yyyy'), litri, 'produzione', litri, prezzoVendita);
    modGUI.PAGINAFEEDBACK('SUCCESSO', 'lotto inserito correttamente', Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
exception 
    when others then
        modGUI.PAGINAFEEDBACK('ERRORE', 'ingredienti non sufficienti', Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
end inserisciLotto;

end opBirrai;

/

CREATE OR REPLACE package body OrdiniPack AS

--TODO visualizzare gli ordini secondo i criteri di ricerca

procedure visualizzaOrdini(
    idSessione number,
    id_cliente number default null,
    flag varchar2 default 'dataDesc'
)
is
    --id_cliente Clienti.idcliente%type;
    ordini_cur ordiniclienti_cursorType;
    lordine ORDINICLIENTI%rowtype;
    n_lotti number;
BEGIN
    --id_cliente:=login.GETIDUTENTE(idSessione);

    modGUI.APRIPAGINA('Ordini effetuati', idSessione);
    modGUi.INTESTAZIONE(TIPO  => 1, TESTO  => 'Ordini effetuati');

    
    modGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'ordiniPack.visualizzaOrdini', idSessione);
    modGUI.PassaParametro('id_cliente', id_cliente);

    modGUI.APRIBLOCCO('',center=>false);
        modGUI.paragrafo('<b>VISUALIZZA PER:</b>');
        modGUI.APRIINLINESELECT('flag');
        htp.prn('<option disabled selected value> --- Select an option --- </option>');
        modGUI.AGGIUNGIOPZIONESELECT('dataDesc', 'Data descrescente');
        modGUI.AGGIUNGIOPZIONESELECT('dataAsc', 'Data crescente');
        modGUI.AGGIUNGIOPZIONESELECT('prezzoDesc', 'Prezzo decrescente');
        modGUI.AGGIUNGIOPZIONESELECT('prezzoAsc','Prezzo crescente');
    modGUI.CHIUDIINLINESELECT;

    modGUI.bottone('Applica');
    modGUI.ChiudiBlocco;
    modGUI.ChiudiFormHidden;
    

    modGUi.ritcarrello;

    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Ordine N.');
    modGUI.IntestazioneTabella('Stato ordine');
    modGUI.IntestazioneTabella('Data ordine');
    modGUI.IntestazioneTabella('Prezzo totale');
    modGUI.IntestazioneTabella('Dettagli');
    modGUI.IntestazioneTabella('Cancella ordine');

    case flag 
    when 'prezzoAsc' then open ordini_cur for select * from ORDINICLIENTI where idcliente=id_cliente order by prezzo_totale asc;
    when 'prezzoDesc' then open ordini_cur for select * from ORDINICLIENTI where idcliente=id_cliente order by prezzo_totale desc;
    when 'dataAsc' then open ordini_cur for select * from ORDINICLIENTI where idcliente=id_cliente order by to_date(data_ordine, 'DD-MM-YYYY') asc;
    when 'dataDesc' then open ordini_cur for select * from ORDINICLIENTI where idcliente=id_cliente order by to_date(data_ordine, 'DD-MM-YYYY') desc;
    end case;
    
    --for lordine in (select * from ORDINICLIENTI where idcliente=id_cliente)
    LOOP
        fetch ordini_cur into lordine;
        exit when ordini_cur%notfound;
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(lordine.idordine);
        modGUI.ELEMENTOTABELLA(lordine.stato);
        modGUI.ELEMENTOTABELLA(lordine.data_ordine);
        modGUI.ELEMENTOTABELLA(lordine.prezzo_totale);
        MODGUI.ApriElementoTabella;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'ordiniPack.DettagliOrdine', idSessione);
        MODGUI.bottoneInfo;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('id_ordine', lordine.idordine);
        modGUI.ChiudiFormHidden;

        modGUI.ChiudiElementoTabella;
            MODGUI.ApriElementoTabella;
            if(lordine.stato = 'in preparazione') then
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'ordiniPack.cancellaOrdine', idSessione);
                MODGUI.bottoneDelete;
                /* eventuale parametro da passare */
                modGUI.PassaParametro('id_ordine', lordine.idordine);
                modGUI.ChiudiFormHidden;
            ELSE
                modGUI.paragrafo('Cancellazione scaduta');
            end if;
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
BEGIN
    select * into lordine from ORDINICLIENTI where idordine=id_ordine; 
    modGUI.APRIPAGINA('Ordini effetuati', idSessione);
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
    modGUI.ritCarrello;
    modGUI.ritCarrello;
    modGUI.ritCarrello;
    modGUI.ritCarrello;
    lottiAcquistati(idSessione, lordine.idordine);
    modGUI.CHIUDIPAGINA;
END DettagliOrdine;

procedure lottiAcquistati(
    idSessione number,
    id_ordine ORDINICLIENTI.idordine%type default null
)
is 
    --id_ordine ORDINICLIENTI.IDORDINE%type;
    quantitaLotto number;
    id_cliente number;
    nomelotto LOTTI.NOME%type;
    ordinelotto ORDINICLIENTILOTTI%ROWTYPE;

    ordiniLotti_cur ordinilotti_cursortype;
BEGIN
    if id_ordine is null then 
        modGUI.APRIPAGINA('Lotti acquistati', idSessione);
        modGUi.INTESTAZIONE(TIPO  => 1, TESTO  => 'Lotti acquistati');
        --select IDUTENTE into id_cliente from SESSIONI where SESSIONI.IDSESSIONE = idSessione;
    end if;
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('nome lotto');
    modGUI.IntestazioneTabella('quantita');
    modGUI.IntestazioneTabella('prezzo/litro');
    modGUI.CHIUDIRIGATABELLA;
    id_cliente:=login.GETIDUTENTE(idSessione);

    if id_ordine is null then 
        open ordiniLotti_cur for select * from ORDINICLIENTILOTTI where idordine in (select idordine from ORDINICLIENTI where IDCLIENTE=id_cliente);
    ELSE
        open ordiniLotti_cur for select * from ORDINICLIENTILOTTI where IDORDINE=id_ordine;
    end IF;
    LOOP
        fetch ordiniLotti_cur into ordinelotto;
        exit when ordiniLotti_cur%notfound;
        select nome into nomelotto from lotti where idlotto=ordinelotto.idlotto;
        modGUI.APRIRIGATABELLA;
        modGUI.ELEMENTOTABELLA(nomelotto);
        modGUI.ELEMENTOTABELLA(ordinelotto.numero_litri);
        modGUI.ELEMENTOTABELLA(ordinelotto.prezzo_litro);
        modGUI.CHIUDIRIGATABELLA;
    end LOOP;
    close ordiniLotti_cur;
    modGUI.CHIUDITABELLA;
END lottiAcquistati;

procedure cancellaOrdine(
    idSessione number,
    id_ordine number
)
is
    ordiniclientilotti_cur ORDINICLIENTILOTTI%rowtype;
begin
    for ordiniclientilotti_cur in (select * from ORDINICLIENTILOTTI where idordine = id_ordine)
    loop
        delete from ordiniclientilotti where idlotto = ordiniclientilotti_cur.idlotto and idordine=ordiniclientilotti_cur.idordine;
        update lotti
        set 
            LITRI_RESIDUI = LITRI_RESIDUI + ordiniclientilotti_cur.numero_litri,
            stato = 'vendita'
        where idlotto = ordiniclientilotti_cur.idlotto;
        
    end loop;
    update ordiniclienti
    set PREZZO_TOTALE = null
    where idordine=ordiniclientilotti_cur.idordine;
    modGUI.PaginaFeedback('SUCCESSO', 'Ordine annullato con successo', COSTANTI.root || 'modGUI.PaginaPrincipale', idSessione);

end cancellaOrdine;


end OrdiniPack;

/

CREATE OR REPLACE PACKAGE body RecensioniPack as

procedure visualizzaRecensioni(
    idSessione number,
    id_cliente number default null,
    id_lotto Lotti.IDLOTTO%type default null
)
is
    recensioni_cur rec_cursorType;
    larecensione RECENSIONI%rowtype;
    id_cliente2 CLIENTI.idcliente%type;
    nomeLotto lotti.nome%type;
begin
    modGUI.APRIPAGINA(TITOLO  => 'Recensioni', IDSESSIONE  => IDSESSIONE);
    modGUI.INTESTAZIONE(TIPO  => 1, TESTO  => 'Recensioni');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome lotto');
    modGUI.IntestazioneTabella('Recensione');
    modGUI.IntestazioneTabella('Qualita');

    if login.GETROLEFROMSESSION(idSessione) = 'amministratore' then 
        if id_cliente is null then
            open recensioni_cur for select * from RECENSIONI;
        else 
            open recensioni_cur for select * from RECENSIONI where idcliente=id_cliente;
        end if;
    else
        id_cliente2 := login.GETIDUTENTE(idSessione);

        if id_cliente2 is null then
            open recensioni_cur for select * from RECENSIONI where idlotto=id_lotto;
        else
            if id_lotto is null then
                open recensioni_cur for select * from recensioni where idcliente=id_cliente2;
            else
                open recensioni_cur for select * from RECENSIONI where idlotto=id_lotto and idcliente=id_cliente2;
            end if;
        end if;
    end if;

    LOOP
            fetch RECENSIONI_cur into larecensione;
            exit when recensioni_cur%notfound;
            select nome into nomeLotto from Lotti where idlotto=larecensione.idlotto;
            modGUI.APRIRIGATABELLA;
            modGUI.ELEMENTOTABELLA(nomeLotto);
            modGUI.ELEMENTOTABELLA(larecensione.Recensione);
            modGUI.ELEMENTOTABELLA(larecensione.Qualita);
            modGUI.CHIUDIRIGATABELLA;
        end LOOP;
        modGUI.CHIUDITABELLA;
        modGUI.CHIUDIPAGINA;
end visualizzaRecensioni;

end RecensioniPack;

/

CREATE OR REPLACE package body statisticPack as

--Visualizzare tutti i clienti in base agli ordini fatti.
procedure topClientiOrdini(
    idSessione number,
    flag varchar2 default 'prezzoDesc'
)
is
    clienti_cur cursorType;
    --c_record clienti_cur%rowtype;
    id_cliente number;
    nomeCliente clienti.nome%type;
    cognomeCliente clienti.cognome%type;
    n_ordini number;
    totale number;
BEGIN
        MODGUI.APRIPAGINA('Admin | clienti con piu acquisti', IDSESSIONE);
        modGUI.Intestazione(1, 'Visualizza clienti per numero ordini');

        modGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'statisticPack.topClientiOrdini', idSessione);

        modGUI.APRIBLOCCO('',center=>false);
        modGUI.paragrafo('<b>VISUALIZZA PER:</b>');
        modGUI.APRIINLINESELECT('flag');
        htp.prn('<option disabled selected value> --- Select an option --- </option>');
        modGUI.AGGIUNGIOPZIONESELECT('prezzoAsc', 'Prezzo crescente');
        modGUI.AGGIUNGIOPZIONESELECT('prezzoDesc', 'Prezzo decrescente');
        modGUI.AGGIUNGIOPZIONESELECT('numeroAsc', 'N.ordini crescente');
        modGUI.AGGIUNGIOPZIONESELECT('numeroDesc','N.ordini decrescente');
    modGUI.CHIUDIINLINESELECT;

    modGUI.bottone('Applica');
    modGUI.ChiudiBlocco;
    modGUI.ChiudiFormHidden;

    case flag 
    when 'prezzoAsc' then open clienti_cur for select c.idcliente, nome, cognome, count(IDORDINE) as Nordini, case when count(IDORDINE) = 0 then 0  else  sum(prezzo_totale) end tot
                        /* per visualizzare anche gli gli clienti con 0 ordini */
                        from CLIENTI c left join ORDINICLIENTI o on c.IDCLIENTE=o.IDCLIENTE 
                        group by (c.idcliente, nome, cognome)
                        order by tot asc;
    when 'numeroAsc' then open clienti_cur for select c.idcliente, nome, cognome, count(IDORDINE) as Nordini, case when count(IDORDINE) = 0 then 0  else  sum(prezzo_totale) end tot
                        /* per visualizzare anche gli gli clienti con 0 ordini */
                        from CLIENTI c left join ORDINICLIENTI o on c.IDCLIENTE=o.IDCLIENTE 
                        group by (c.idcliente, nome, cognome)
                        order by Nordini asc;
    when 'prezzoDesc' then open clienti_cur for select c.idcliente, nome, cognome, count(IDORDINE) as Nordini, case when count(IDORDINE) = 0 then 0  else  sum(prezzo_totale) end tot
                        /* per visualizzare anche gli gli clienti con 0 ordini */
                        from CLIENTI c left join ORDINICLIENTI o on c.IDCLIENTE=o.IDCLIENTE 
                        group by (c.idcliente, nome, cognome)
                        order by tot desc;
    when 'numeroDesc' then open clienti_cur for select c.idcliente, nome, cognome, count(IDORDINE) as Nordini, case when count(IDORDINE) = 0 then 0  else  sum(prezzo_totale) end tot
                        /* per visualizzare anche gli gli clienti con 0 ordini */
                        from CLIENTI c left join ORDINICLIENTI o on c.IDCLIENTE=o.IDCLIENTE 
                        group by (c.idcliente, nome, cognome)
                        order by Nordini desc;
    end case;

        MODGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        MODGUI.INTESTAZIONETABELLA('Nome');
        MODGUI.INTESTAZIONETABELLA('Cognome');
        MODGUI.INTESTAZIONETABELLA('Ordini effettuati');
        MODGUI.INTESTAZIONETABELLA('Totale fatturato effettuati');
        MODGUI.CHIUDIRIGATABELLA;
        loop
            fetch clienti_cur into id_cliente, nomeCliente, cognomeCliente, n_ordini, totale;
            exit when clienti_cur%notfound;
            modgui.APRIRIGATABELLA;
            MODGUI.ELEMENTOTABELLA(nomeCliente);
            MODGUI.ELEMENTOTABELLA(cognomeCliente);
            MODGUI.ELEMENTOTABELLA(n_ordini);
            MODGUI.ELEMENTOTABELLA(totale);
            MODGUI.CHIUDIRIGATABELLA;
        end loop;
        close clienti_cur;
        modGUI.ChiudiTabella;
        MODGUI.CHIUDIPAGINA;
END topClientiOrdini;


procedure topClientiRecensioni(
    idSessione number
)
is
    cursor clientiRec_cur is select c.nome, c.cognome, c.idcliente, count(IDRECENSIONE) as nRec, case when count(IDRECENSIONE) = 0 then 0 else avg(r.qualita) end mediaVal
                                from RECENSIONI r right join CLIENTI c on r.idcliente=c.idcliente
                                group by (c.nome, c.cognome, c.idcliente)
                                order by nRec desc;
    cr_record clientiRec_cur%rowtype;
    media number(3,2);
BEGIN
    MODGUI.APRIPAGINA('Admin | clienti con piu recensioni', IDSESSIONE);
    modGUI.Intestazione(1, 'Visualizza clienti per numero recensioni');
    MODGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    MODGUI.INTESTAZIONETABELLA('Nome');
    MODGUI.INTESTAZIONETABELLA('Cognome');
    MODGUI.INTESTAZIONETABELLA('N. Recensioni');
    MODGUI.INTESTAZIONETABELLA('Media valutazione');
    MODGUI.INTESTAZIONETABELLA('Info Cliente');
    MODGUI.INTESTAZIONETABELLA('Info recensioni');
    MODGUI.CHIUDIRIGATABELLA;

    open clientiRec_cur;
    LOOP
        fetch clientiRec_cur into cr_record;
        exit when clientiRec_cur%notfound;
        media:=cr_record.mediaVal;
        modgui.APRIRIGATABELLA;
        MODGUI.ELEMENTOTABELLA(cr_record.nome);
        MODGUI.ELEMENTOTABELLA(cr_record.cognome);
        MODGUI.ELEMENTOTABELLA(cr_record.nRec);
        MODGUI.ELEMENTOTABELLA(media);

        MODGUI.ApriElementoTabella;
        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'Gruppo3.visualizzaCliente', idSessione);
        MODGUI.bottoneInfo;
        modGUI.PassaParametro('id_cliente', cr_record.idcliente);
        modGUI.ChiudiFormHidden;
        modgui.chiudielementotabella;
        MODGUI.ApriElementoTabella;
        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'RecensioniPack.visualizzaRecensioni', idSessione);
        MODGUI.bottoneInfo;
        modGUI.PassaParametro('id_cliente', cr_record.idcliente);
        modGUI.ChiudiFormHidden;
        modgui.chiudielementotabella;

        MODGUI.CHIUDIRIGATABELLA;
    end LOOP;
    close clientiRec_cur;
    MODGUI.ChiudiTabella;
    MODGUI.CHIUDIPAGINA;
END topClientiRecensioni;

procedure bestSellers(
    idSessione number
)
is
    /**
    *fascia 1 è la fascia minore uguale di 5
    *fascia 2 è la fascia compreso tra 5-8(compreso)
    *fascia 3 è la fascia superiore a 8
    */
    soglia1 constant number := 5;
    soglai2 constant number := 8;

    residui1 number;
    residui2 number;
    residui3 number;
    tot1 number;
    tot2 number;
    tot3 number;
    percent1 number(5,2);
    percent2 number(5,2);
    percent3 number(5,2);

    cursor lotti_cur is select  sum(LITRI_PRODOTTI) as tot,
                                sum(LITRI_RESIDUI) as residui,
                                PREZZO_AL_LITRO,
                                case when PREZZO_AL_LITRO <= 5
                                        then 'fascia1'
                                     when PREZZO_AL_LITRO > 5 and PREZZO_AL_LITRO <= 8
                                        then 'fascia2'
                                     else 'fascia3'
                                end fascia
                        from lotti
                        where stato<>'produzione'
                        group by PREZZO_AL_LITRO;
    illotto lotti_cur%rowtype;
BEGIN

    residui1:=0;
    residui2:=0;
    residui3:=0;
    tot1:=0;
    tot2:=0;
    tot3:=0;
    open lotti_cur;
    LOOP
        fetch lotti_cur into illotto;
        exit when lotti_cur%notfound;

        if illotto.fascia = 'fascia1' then
            tot1:= tot1 + illotto.tot;
            residui1:= residui1 + illotto.residui;
        else if illotto.fascia = 'fascia2' THEN
                tot2:=tot2 + illotto.tot;
                residui2:= residui2 + illotto.residui;
            else
                tot3:=tot3 + illotto.tot;
                residui3:= residui3 + illotto.residui;
            end if;
        end if;
    end LOOP;
    close lotti_cur;

    percent1:= (residui1 / tot1) * 100;
    percent2:= (residui2 / tot2) * 100;
    percent3:= (residui3 / tot3) * 100;

    MODGUI.APRIPAGINA('Admin | Statistiche ', IDSESSIONE);
    modGUI.Intestazione(1, 'Visualizza lo stato di vendite dei lotti per fascia di prezzo');
    modGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    MODGUI.INTESTAZIONETABELLA('Fasce');
    MODGUI.INTESTAZIONETABELLA('% venduti');
    MODGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('Fascia 1 (prezzo al litro <= 5euro )');
    modGUI.ELEMENTOTABELLA(100 - percent1);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('Fascia 2 (5euro < prezzo al litro <= 8euro )');
    modGUI.ELEMENTOTABELLA(100 - percent2);
    modGUI.ChiudiRigaTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.ELEMENTOTABELLA('Fascia 3 (prezzo al litro > 8euro )');
    modGUI.ELEMENTOTABELLA(100 - percent3);
    modGUI.ChiudiRigaTabella;
    modGUI.ChiudiTabella;
    MODGUI.CHIUDIPAGINA;
END bestSellers;


procedure nLottiRicetta(
    idSessione number
)
IS
    cursor ricetta_cur is   select count(l.idlotto) as tot, r.idricetta, r.nome, r.utilizzabile 
                        from Ricette r, lotti l 
                        where r.idricetta=l.idricetta   
                        group by (r.idricetta, r.nome, r.utilizzabile)
                        order by tot desc;
    ricetta_rec ricetta_cur%rowtype;
begin
    MODGUI.APRIPAGINA('Admin | numero lotti per ricetta', IDSESSIONE);
    modGUI.Intestazione(1, 'Visualizza il numero dei lotti prodotti per ricetta');
    MODGUI.APRITABELLA;
    modGUI.APRIRIGATABELLA;
    MODGUI.INTESTAZIONETABELLA('Nome ricetta');
    MODGUI.INTESTAZIONETABELLA('Utilizzabile');
    MODGUI.INTESTAZIONETABELLA('N. lotti prodotti');
    MODGUI.INTESTAZIONETABELLA('Visualizza i lotti');
    
    open ricetta_cur;
    loop
        fetch ricetta_cur into ricetta_rec;
        exit when ricetta_cur%notfound;
        modgui.APRIRIGATABELLA;
        MODGUI.ELEMENTOTABELLA(ricetta_rec.nome);
        MODGUI.ELEMENTOTABELLA(ricetta_rec.utilizzabile);
        MODGUI.ELEMENTOTABELLA(ricetta_rec.tot);

        MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'Gruppo3.visualizzaLotti', idSessione);
            MODGUI.bottoneInfo;
            modGUI.PassaParametro('id_ricetta', ricetta_rec.idricetta);
            modGUI.ChiudiFormHidden;
        modgui.ChiudiElementoTabella;

        MODGUI.ChiudiRigaTabella;
    end loop;
    close ricetta_cur;
    MODGUI.ChiudiTabella;
    modGUI.ChiudiPagina;
end nLottiRicetta;

end statisticPack;