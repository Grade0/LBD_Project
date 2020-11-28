CREATE OR REPLACE PACKAGE body RecensioniPack as

procedure visualizzaRecensioni(
    idSessione number,
    id_cliente CLIENTI.idcliente%type default -1,
    id_lotto Lotti.IDLOTTO%type default -1
)
is
    larecensione RECENSIONI%rowtype;
    nomeLotto lotti.nome%type;
begin
    modGUI.APRIPAGINA(TITOLO  => 'Recensioni', IDSESSIONE  => IDSESSIONE);
    modGUI.CREAMENUBACKOFFICE(idSessione);

    if id_cliente = -1 and id_lotto = -1 THEN
        modGUI.PaginaFeedback('ERRORE', 'errore nela visualizzazione delle recensioni', COSTANTI.root || 'VisualizzaLotti', IDSESSIONE);
    else
        modGUI.INTESTAZIONE(TIPO  => 1, TESTO  => 'Recensioni');
        modGUI.APRITABELLA;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('nome lotto');
        modGUI.IntestazioneTabella('Recensione');
        modGUI.IntestazioneTabella('Qualita');
        if id_cliente = -1 then
            for larecensione in (select * from RECENSIONI where idlotto=id_lotto)
            loop
                select nome into nomeLotto from LOTTI where idlotto=id_lotto;
                modGUI.APRIRIGATABELLA;
                modGUI.ELEMENTOTABELLA(nomeLotto);
                modGUI.ELEMENTOTABELLA(larecensione.Recensione);
                modGUI.ELEMENTOTABELLA(larecensione.Qualita);
            end loop;
        else
            if id_lotto = -1 then
                for larecensione in (select * from RECENSIONI where idcliente=id_cliente)
                loop
                    select nome into nomeLotto from LOTTI where idlotto=larecensione.idlotto;
                    modGUI.APRIRIGATABELLA;
                    modGUI.ELEMENTOTABELLA(nomeLotto);
                    modGUI.ELEMENTOTABELLA(larecensione.Recensione);
                    modGUI.ELEMENTOTABELLA(larecensione.Qualita);
                end loop;
            else
                for larecensione in (select * from RECENSIONI where idlotto=id_lotto and idcliente=id_cliente)
                LOOP
                    select nome into nomeLotto from Lotti where idlotto=larecensione.idlotto;
                    modGUI.APRIRIGATABELLA;
                    modGUI.ELEMENTOTABELLA(nomeLotto);
                    modGUI.ELEMENTOTABELLA(larecensione.Recensione);
                    modGUI.ELEMENTOTABELLA(larecensione.Qualita);
                end loop;
            end if;
        end if;
    end if;
end visualizzaRecensioni;

end RecensioniPack;
