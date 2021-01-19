CREATE OR REPLACE PACKAGE gruppo3 AS 
    
TYPE metodoTab IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
EmptyMetodoTab metodoTab;

type birraiTab is table of birrai%ROWTYPE index by BINARY_INTEGER;
EmptyBirraiTab birraiTab;

TYPE birrai_cursorType is ref CURSOR;
    
procedure stampaBirrai(  
    idSessione number,
    metodi in metodoTab default EmptyMetodoTab,
    nomeRicetta varchar default null
);

procedure cercaBirrai(
    idSessione number
);

procedure visualizzaCliente(
    IDSESSIONE NUMBER,
    id_cliente number default null
);

procedure aggiornamentoCliente(
    idSessione number,
    id_cliente number default null
);

procedure checkDatiClienti(
    idSessione number,
    id_cliente number,
    ilnome VARCHAR2,
    ilcognome VARCHAR2,
    iltelefono VARCHAR2,
    lindirizzo VARCHAR2,
    laragioneSociale VARCHAR2
);

TYPE lotti_cursorType is ref CURSOR;

procedure visualizzaLotti(
    idSessione NUMBER,
    /*Da modificare dopo aggiornamento modGUI*/
    id_birraio lotti.IDBIRRAIO%type default null,
    id_ricetta ricette.idricetta%type default null
);

type lottiTab is table of lotti%ROWTYPE index by BINARY_INTEGER;
EmptylottiTab lottiTab;

procedure inserisciCarrello(
    idSessione number,
    id_lotto lotti.IDLOTTO%type,
    laquantita lotti.LITRI_PRODOTTI%type
);

procedure DettagliLotti(
    idSessione number,
    id_lotto lotti.IDLOTTO%type
);

procedure eliminaDaCarrello(
    idSessione number,
    id_lotto number default null,
    flag number default null
);

procedure confermaCarrello(
    idSessione number
    --iLotti in lottiTab default EmptylottiTab
);

procedure modificaCarrello(
    idSessione number,
    id_lotto number,
    laquantita lotti.LITRI_PRODOTTI%type
);

procedure visualizzaCarrello(
    idSessione number
);

END GRUPPO3;

/

CREATE OR REPLACE package opBirrai as

type annotazioni_cursorType is ref cursor;

procedure visualizzaAnnotazioni(
    idSessione number,
    id_lotto lotti.idlotto%type default null
);

procedure modificaStatoLotto(
    idSessione number,
    id_lotto lotti.idlotto%type
);

procedure aggiungiDatiLotto(
    idSessione number,
    id_lotto number,
    new_stato varchar2,
    data_fine_produzione varchar2 default null,
    data_scadenza varchar2 default null,
    data_pubblicazione varchar2 default null
);


procedure produciLotto(
    idSessione number
);

procedure inserisciLotto(
    idSessione number,
    nomeLotto varchar2,
    descrizioneLotto varchar2 default null,
    id_ricetta ricette.idricetta%type,
    litri number,
    prezzoVendita number
);

end opBirrai;

/

CREATE OR REPLACE package OrdiniPack AS

TYPE ordiniclienti_cursorType is ref CURSOR;

procedure visualizzaOrdini(
    idSessione number,
    id_cliente number default null,
    flag varchar2 default 'dataDesc'
    /*
    numOrdineFlag number default 0,
    dataFlag number default 0,
    prezzoFlag number default 0,
    quantitaFlag number default 0
    */
);

procedure DettagliOrdine(
    idSessione number,
    id_ordine ORDINICLIENTI.IDORDINE%type
);


type ordiniLotti_cursorType is ref cursor;
procedure lottiAcquistati(
    idSessione number,
    id_ordine ORDINICLIENTI.idordine%type default null
);

procedure cancellaOrdine(
    idSessione number,
    id_ordine number
);
end OrdiniPack;

/

CREATE OR REPLACE PACKAGE RecensioniPack AS

type rec_cursorType is ref cursor;
procedure visualizzaRecensioni(
    idSessione number,
    id_cliente number default null,
    id_lotto Lotti.IDLOTTO%type default null
);

END RecensioniPack;

/

CREATE OR REPLACE package statisticPack as
--Visualizzare tutti i clienti in base agli ordini fatti.

TYPE cursorType is ref CURSOR;

procedure topClientiOrdini(
    idSessione number,
    flag varchar2 default 'prezzoDesc'
);

--visualizza tutti i clienti in base al numero di recensioni
procedure topClientiRecensioni(
    idSessione number
);


--visualizzare i best sellers per fascia di prezzo
procedure bestSellers(
    idSessione number
);

procedure nLottiRicetta(
    idSessione number
);

end statisticPack;