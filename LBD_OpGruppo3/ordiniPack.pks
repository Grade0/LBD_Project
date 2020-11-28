CREATE OR REPLACE package OrdiniPack AS

procedure visualizzaOrdini(
    idSessione number,
    numOrdineFlag number default 0,
    dataFlag number default 0,
    prezzoFlag number default 0,
    quantitaFlag number default 0
);

procedure DettagliOrdine(
    idSessione number,
    id_ordine ORDINICLIENTI.IDORDINE%type
);

procedure lottiAcquistati(
    idSessione number,
    id_ordine ORDINICLIENTI.idordine%type default -1  
);
end OrdiniPack;