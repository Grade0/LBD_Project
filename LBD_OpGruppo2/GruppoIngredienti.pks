create or replace package GruppoIngredienti as

TYPE tabellaFornitore IS TABLE OF varchar2(45) INDEX BY BINARY_INTEGER;
TYPE tabellaIngrediente IS TABLE OF Ingredienti.nome%type INDEX BY BINARY_INTEGER;
TYPE tabellaTipo IS TABLE OF varchar2(10) INDEX BY BINARY_INTEGER;
tabellaFornitoreVuota tabellaFornitore;
tabellaTipoVuota tabellaTipo;
tabellaIngredienteVuota tabellaIngrediente;

TYPE precord is record (idin Ingredienti.idingrediente%type, Nome Ingredienti.nome%type, Utilizzabile Ingredienti.utilizzabile%type,
Tipo Tipi.nome%type, Prezzo Ingredienti.prezzo_unitario%type);

procedure immettiIngrediente (idsessione in sessioni.idsessione%type);

procedure checkIngrediente
(
    idsessione in sessioni.idsessione%type,
    pnome in Ingredienti.nome%type,
    pdescrizione in Ingredienti.descrizione%type,
    pprezzo_unitario in Ingredienti.prezzo_unitario%type,
    putilizzabile varchar2,
    ptipo in tipi.nome%type,
    pfornitore in Fornitori.ragione_sociale%type
);

--Visualizza gli ingredienti i cui è composta una ricetta
procedure visualizzaIngredienti(idSessione in sessioni.idsessione%type, v_idRicetta ricette.idricetta%type);

--Visualizza tutti i dti del singolo ingrediente
procedure infoIngrediente(idSessione sessioni.idsessione%type, v_nome Ingredienti.nome%type);

--visualizza il costo di tutti i lotti fatti dal birraio, più informazione sulla media totale
procedure visualizzaCostoLotti (idsessione in sessioni.idsessione%type);

/*procedure acquistoIngredienti (
    v_idsessione in sessioni.idsessione%type,
    v_idbirraio in birrai.idbirraio%type,
    v_quantita in ingredientibirrai.quantita%type,
    v_ingrediente in Ingredienti.nome%type,
    v_tipo in tipi.nome%type
);*/

--ricerca sugli ingredienti basata su tutti i parametri
procedure ricercaIngredienti (idsessione in sessioni.idsessione%type);

procedure checkRicercaIngredienti (
idsessione in sessioni.idsessione%type,
pnome in Ingredienti.nome%type,
--pfornitore in fornitori.ragione_sociale%type,
prezzo_minimo in number DEFAULT 0.00,
prezzo_massimo in number DEFAULT  10000.00,
--ptipo in tipi.nome%type,
putilizzabile varchar2,
vetFornitore tabellaFornitore DEFAULT tabellaFornitoreVuota,
vetTipo tabellaTipo DEFAULT tabellaTipoVuota
);

--visualizza i fornitori che espongono più ingredienti diversi 
procedure varietaFornitori (idsessione in sessioni.idsessione%type);
    
--visualizza ingredienti esposti dal fornitore
procedure visualizzaIngredientiFornitore (idsessione in sessioni.idsessione%type, v_ragione_sociale in Fornitori.ragione_sociale%type);

--visualizza gli ingredienti più venduti
procedure IngredientiPiuVenduti (idsessione in Sessioni.idsessione%type);

--visualizza i propri dati come fornitore
procedure visualizzaFornitore (idsessione in Sessioni.idsessione%type, v_ragione_sociale in Fornitori.ragione_sociale%type);

--visualizza i dati di un fornitore
procedure visualizzaDatiAnagrafici (idsessione in Sessioni.idsessione%type);

--visualizza i lotti con determinati ingredienti
procedure visualizzaLotti (idsessione in Sessioni.idsessione%type);

procedure checkVisualizzaLotti (idsessione in sessioni.idsessione%type, vetingredienti tabellaIngrediente default tabellaIngredienteVuota);

--procedure acquistoIngredienti (idsessione in sessioni.idsessione%type, v_quantita number, v_idingrediente Ingredienti.idingrediente%type);

--procedure visualizzaRifornimenti (idsessione in sessioni.idsessione%type);

--procedure infoRifornimento (idsessione in sessioni.idsessione%type, v_idrifornimento in rifornimenti.idrifornimento%type);

--modifica i propri dati come fornitore
procedure modificaDatiFornitore (idsessione in sessioni.idsessione%type);

procedure checkModificaDati (idsessione in sessioni.idsessione%type,
    pnome in Fornitori.nome%type,
    pcognome in Fornitori.cognome%type,
    ptelefono in Fornitori.telefono%type,
    pindirizzo in Fornitori.indirizzo%type,
    pragione_sociale in Fornitori.ragione_sociale%type,
    v_idfornitore in Fornitori.idfornitore%type);
    
--visualizza tutti le informazioni di un birraio
procedure infoBirraio (idsessione in sessioni.idsessione%type, v_idbirraio in Birrai.idbirraio%type);

--visualizza il proprio magazzino come birraio
procedure visualizzaMagazzino (idsessione in sessioni.idsessione%type);

--procedura di supporto per un'altra 
procedure appoggio (idsessione in sessioni.idsessione%type, v_record in precord, 
v_fornitore in Fornitori.ragione_sociale%type, k in out number, pippo in out number);

--visualizza tutti gli ordini come birraio
procedure visualizzaOrdini (idsessione in sessioni.idsessione%type);

--visualizza tutti i rifornimenti effettuatui come fornitore
procedure visualizzaRifornimenti (idsessione in sessioni.idsessione%type);

procedure visualizzaIngredientiEsposti (idsessione in sessioni.idsessione%type);

procedure infoIngredienteFornitore (idsessione in sessioni.idsessione%type, v_nome in Ingredienti.nome%type);

procedure modificaIngrediente (idsessione in sessioni.idsessione%type, v_nome in Ingredienti.nome%type);

procedure checkModificaIngrediente (idsessione in sessioni.idsessione%type,
pnome in Ingredienti.nome%type, 
pprezzo in Ingredienti.prezzo_unitario%type,
putilizzabile in varchar2,
pdescrizione in Ingredienti.descrizione%type,
v_nome in Ingredienti.nome%type);

procedure datiDiVendita (idsessione in sessioni.idsessione%type);

procedure ricercaFornitori (idsessione in sessioni.idsessione%type);

procedure checkRicercaFornitori (
idsessione in sessioni.idsessione%type,
pragione_sociale in Fornitori.ragione_sociale%type
);

procedure acquistoingredienti (idsessione in sessioni.idsessione%type,
v_quantita in number, v_idingrediente in ingredienti.idingrediente%type);

procedure visualizzaCarrello (idsessione in sessioni.idsessione%type);

procedure modificaCarrello (idsessione in sessioni.idsessione%type, 
v_idcarrello in carrello_for.idcarrello%type);

procedure eliminaCarrello (idsessione in sessioni.idsessione%type);

procedure ConfermaCarrello (idsessione in sessioni.idsessione%type, v_tot in number);

procedure tuttiRifornimenti (idsessione in sessioni.idsessione%type);

end GruppoIngredienti;