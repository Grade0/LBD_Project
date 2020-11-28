CREATE OR REPLACE PACKAGE gruppo3 AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
procedure visualizzaDati(
    idSessione number,
    valore varchar
    )
    ;
    
TYPE metodoTab IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
EmptyMetodoTab metodoTab;

type birraiTab is table of birrai%ROWTYPE index by BINARY_INTEGER;
EmptyBirraiTab birraiTab;
    
procedure stampaBirrai(  
    idSessione number,
    metodi in metodoTab default EmptyMetodoTab
);

procedure cercaBirrai(
    idSessione number
);

procedure visualizzaClienti(
    IDSESSIONE NUMBER
);
/*
procedure immettiParametri (
    nome in Clienti.nome%type,
    cognome in Clienti.cognome%type,
    ragione_sociale in Clienti.ragione_sociale%type
);
*/
/*
procedure cercaCliente(
    nome in Clienti.nome%type,
    cognome in Clienti.cognome%type,
    ragione_sociale in Clienti.ragione_sociale%type
);
*/
procedure visualizzaLotti(
    idSessione NUMBER,
    /*Da modificare dopo aggiornamento modGUI*/
    id_birraio lotti.IDBIRRAIO%type default -1
);
/*
procedure visualizzaRecensioni(
    idSessione number
);
*/

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
    id_sessione number,
    id_lotto lotti.IDLOTTO%type
);

procedure confermaCarrello(
    idSessione number,
    id_cliente number default 1, --DA SOSTITUIRE CON IDCLIENTE NELLA TABELLA SESSIONI
    iLotti in lottiTab default EmptylottiTab
);

procedure modificaCarrello(
    id_sessione number,
    iLotti in lottiTab default EmptylottiTab,
    laquantita lotti.LITRI_PRODOTTI%type
);

procedure visualizzaCarrello(
    idSessione number
);

END GRUPPO3;