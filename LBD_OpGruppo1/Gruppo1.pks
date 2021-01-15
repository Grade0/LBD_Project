CREATE OR REPLACE PACKAGE OPERAZIONICATANIASTASULA AS
    procedure inserisciRicetta(idSessione number);
    function getIdFromIngredientName(v_name varchar2) return number;
    procedure procInserisciRicetta (idSessione number, NomeRic varchar2, idRicetta number default null, Istr varchar2, Met varchar2, Ingr varchar2  default null, Quantita number default null, inserted number default 0);
    function getIdUtente (v_idSessione number) return number;
    procedure visualizzaRicette(idSessione number, v_nome IN Ricette.nome%TYPE DEFAULT NULL, idBirraio BIRRAI.IDBIRRAIO%TYPE DEFAULT NULL,
                                              v_mixed IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_wgrain IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_extract IN Ricette.metodologie%TYPE DEFAULT '777',
                                              flag number default 1);
    procedure visualizzaIngredienti(idSessione number,idRicetta number);
    procedure visualizzaRicetta(idSessione number, v_idRicetta number);
    procedure eliminaRicetta (idSessione number, idRicetta number);
    procedure visualizzaMedieBirraiLotti(idSessione number);
    procedure landingVPR(idSessione IN SESSIONI.IDSESSIONE%TYPE);
        --
    procedure landingRCB(idSessione IN SESSIONI.IDSESSIONE%TYPE);
        --
    procedure ricetteCondiviseBirraio(idSessione IN  Sessioni.IDSESSIONE%TYPE,v_nomeRic IN Ricette.nome%TYPE DEFAULT NULL,v_utilizzabile IN Ricette.utilizzabile%TYPE DEFAULT 0);
    procedure ricettaVendutaDa(idSessione IN  Sessioni.IDSESSIONE%TYPE,v_nomeRic IN Ricette.nome%TYPE DEFAULT NULL);
    procedure visualizzaRicetteAdmin(idSessione in Sessioni.IDSESSIONE%type,v_nome in RICETTE.NOME%type default null);
    procedure profiloBirraio(idSessione number, v_idBirraio number default null);
    procedure visualizzaLottiVendutiBirraio (idSessione number, idBirraio number default null);
    procedure inserisciAnnotazione(idSessione number,idLotto number);
    procedure procInserisciAnnotazione(idSessione number,idLotto number,annot varchar2);
    procedure visualizzaLottiBirraio (idSessione number);
    procedure ratingRicetteBirraio(idSessione number);
    procedure modificaRicetta(idSessione number, idRicetta number);
    procedure modificaIstruzioni(idSessione  number, idRicetta number, Istruzioni varchar2);
    procedure modificaIngredienti(idSessione  number, idRicetta number);
    procedure confermaModificaIngrediente(idSessione number,v_idricetta number,v_idingrediente number,v_quantita number);
    procedure statisticaIngredienti(idSessione number);
    procedure ricetteUsanoIngrediente(idSessione number,v_idingrediente number);
    function doppioIngrediente(v_idRicetta number, v_idIngrediente number) return boolean;
    procedure statisticaPrezzoOrdiniAdmin(idSessione number);
    procedure visualizzaRicetteCliente(idSessione number,
                                              v_nome IN Ricette.nome%TYPE DEFAULT NULL,
                                              v_mixed IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_wgrain IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_extract IN Ricette.metodologie%TYPE DEFAULT '777',
                                              flag number default 1);
  /* TODO enter package declarations (types, exceptions, methods etc) here */

END OPERAZIONICATANIASTASULA;