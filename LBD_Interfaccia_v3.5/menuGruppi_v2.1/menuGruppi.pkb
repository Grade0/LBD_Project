CREATE OR REPLACE package body menuGruppi AS

-------------------------------------- GRUPPO 1 ----------------------------------------

procedure navGruppo1(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if (ruolo='birraio' ) then
        modGUI.CollegamentoNav('Cerca le tue ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Inserisci una ricetta',  Costanti.root || 'operazionicataniastasula.inserisciRicetta?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('I tuoi lotti',  Costanti.root || 'operazionicataniastasula.visualizzaLottiBirraio?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Le tue ricette più proficue',  Costanti.root || 'operazionicataniastasula.ratingRicetteBirraio?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Utilizzo degli ingredienti',  Costanti.root || 'operazionicataniastasula.statisticaIngredienti?idSessione=' || idSessione);

    end if;
    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('Cerca ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        --modGUI.CollegamentoNav('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Statistica ordini birrai',  Costanti.root || 'operazionicataniastasula.statisticaPrezzoOrdiniAdmin?idSessione=' || idSessione);
    end if;
    if(ruolo = 'cliente') then
        modGUI.CollegamentoNav('Cerca ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        --modGUI.CollegamentoNav('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
    end if;
    
END navGruppo1;

procedure navLatGruppo1(idSessione int) is
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if (ruolo='birraio' ) then
        modGUI.Collegamento('Cerca le tue ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        modGUI.Collegamento('Inserisci una ricetta',  Costanti.root || 'operazionicataniastasula.inserisciRicetta?idSessione=' || idSessione);
        modGUI.Collegamento('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.Collegamento('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
        modGUI.Collegamento('I tuoi lotti',  Costanti.root || 'operazionicataniastasula.visualizzaLottiBirraio?idSessione=' || idSessione);
        modGUI.Collegamento('Le tue ricette più proficue',  Costanti.root || 'operazionicataniastasula.ratingRicetteBirraio?idSessione=' || idSessione);
        modGUI.Collegamento('Utilizzo degli ingredienti',  Costanti.root || 'operazionicataniastasula.statisticaIngredienti?idSessione=' || idSessione);

    end if;
    if(ruolo = 'amministratore') then
        modGUI.Collegamento('Cerca ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        --modGUI.CollegamentoNav('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.Collegamento('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
        modGUI.Collegamento('Statistica ordini birrai',  Costanti.root || 'operazionicataniastasula.statisticaPrezzoOrdiniAdmin?idSessione=' || idSessione);
    end if;
    if(ruolo = 'cliente') then
        modGUI.Collegamento('Cerca ricette',  Costanti.root || 'operazionicataniastasula.landingVPR?idSessione=' || idSessione);
        --modGUI.CollegamentoNav('Ricette condivise con te',  Costanti.root || 'operazionicataniastasula.landingRCB?idSessione=' || idSessione);
        modGUI.Collegamento('Rating birrai',  Costanti.root || 'operazionicataniastasula.visualizzaMedieBirraiLotti?idSessione=' || idSessione);
    end if;
END navLatGruppo1;


--------------------------------------- GRUPPO 2 -----------------------------------------
procedure navGruppo2(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if(ruolo='fornitore') then
        modGUI.CollegamentoNav('Immetti ingrediente', Costanti.root || 'GruppoIngredienti.immettiIngrediente?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza rifornimenti', Costanti.root || 'GruppoIngredienti.visualizzaRifornimenti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza ingredienti esposti', Costanti.root || 'GruppoIngredienti.visualizzaIngredientiEsposti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza clienti più proficui', Costanti.root || 'GruppoIngredienti.datiDiVendita?idSessione=' || idSessione);
    end if;
    
    if(ruolo='birraio') then
        modGUI.CollegamentoNav('Visualizza costi di produzione dei lotti venduti', Costanti.root || 'GruppoIngredienti.visualizzaCostoLotti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Ricerca ingredienti', Costanti.root || 'GruppoIngredienti.ricercaIngredienti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza fornitori con più varietà di ingredienti', Costanti.root || 'GruppoIngredienti.varietaFornitori?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza ingredienti più venduti', Costanti.root || 'GruppoIngredienti.IngredientiPiuVenduti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza magazzino', Costanti.root || 'GruppoIngredienti.visualizzaMagazzino?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza ordini', Costanti.root || 'GruppoIngredienti.visualizzaOrdini?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Ricerca fornitori', Costanti.root || 'GruppoIngredienti.ricercaFornitori?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Carrello', Costanti.root || 'GruppoIngredienti.visualizzaCarrello?idSessione=' || idSessione);
    end if;
    
    if(ruolo='cliente') then
        modGUI.CollegamentoNav('Visualizza i lotti con ingredienti specifici', Costanti.root || 'GruppoIngredienti.visualizzaLotti?idSessione=' || idSessione);
    end if;
    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('Immetti ingrediente', Costanti.root || 'GruppoIngredienti.immettiIngrediente?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza tutti i rifornimenti', Costanti.root || 'GruppoIngredienti.tuttiRifornimenti?idSessione=' || idSessione);
    end if;
END navGruppo2;

procedure navLatGruppo2(idSessione int) is
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if(ruolo='fornitore') then
        modGUI.Collegamento('Immetti ingrediente', Costanti.root || 'GruppoIngredienti.immettiIngrediente?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza rifornimenti', Costanti.root || 'GruppoIngredienti.visualizzaRifornimenti?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza ingredienti esposti', Costanti.root || 'GruppoIngredienti.visualizzaIngredientiEsposti?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza clienti più proficui', Costanti.root || 'GruppoIngredienti.datiDiVendita?idSessione=' || idSessione);
    end if;
    
    if(ruolo='birraio') then
        modGUI.Collegamento('Visualizza costi di produzione dei lotti venduti', Costanti.root || 'GruppoIngredienti.visualizzaCostoLotti?idSessione=' || idSessione);
        modGUI.Collegamento('Ricerca ingredienti', Costanti.root || 'GruppoIngredienti.ricercaIngredienti?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza fornitori con più varietà di ingredienti', Costanti.root || 'GruppoIngredienti.varietaFornitori?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza ingredienti più venduti', Costanti.root || 'GruppoIngredienti.IngredientiPiuVenduti?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza magazzino', Costanti.root || 'GruppoIngredienti.visualizzaMagazzino?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza ordini', Costanti.root || 'GruppoIngredienti.visualizzaOrdini?idSessione=' || idSessione);
        modGUI.Collegamento('Ricerca fornitori', Costanti.root || 'GruppoIngredienti.ricercaFornitori?idSessione=' || idSessione);
        modGUI.Collegamento('Carrello', Costanti.root || 'GruppoIngredienti.visualizzaCarrello?idSessione=' || idSessione);
    end if;
    
    if(ruolo='cliente') then
        modGUI.Collegamento('Visualizza i lotti con ingredienti specifici', Costanti.root || 'GruppoIngredienti.visualizzaLotti?idSessione=' || idSessione);
    end if;
    if(ruolo = 'amministratore') then
        modGUI.Collegamento('Immetti ingrediente', Costanti.root || 'GruppoIngredienti.immettiIngrediente?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza tutti i rifornimenti', Costanti.root || 'GruppoIngredienti.tuttiRifornimenti?idSessione=' || idSessione);
    end if;
END navLatGruppo2;


--------------------------------------- GRUPPO 3 -----------------------------------------
procedure navGruppo3(idSessione number) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if(ruolo = 'cliente') then
        modGUI.CollegamentoNav('Visualizza dati cliente',  Costanti.root || 'gruppo3.visualizzaCliente?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Cerca birrai',  Costanti.root || 'gruppo3.cercaBirrai?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza lotti',  Costanti.root || 'gruppo3.visualizzaLotti?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Carrello',  Costanti.root || 'gruppo3.visualizzaCarrello?idSessione=' || idSessione); 
        modGUI.CollegamentoNav('Ordini effettuati',  Costanti.root || 'ordinipack.visualizzaOrdini?idSessione=' || idSessione || '&id_cliente=' || login.GETIDUTENTE(idSessione)); 
        modGUI.CollegamentoNav('Recensioni',  Costanti.server || Costanti.root || 'RecensioniPack.visualizzarecensioni?idSessione=' || idSessione); 
    end if;

    if(ruolo = 'birraio') then
        modGUI.CollegamentoNav('Visualizza annotazioni',  Costanti.root || 'opBirrai.visualizzaAnnotazioni?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Inserisci un nuovo lotto',  Costanti.root || 'opBirrai.produciLotto?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Modifica stato lotto',  Costanti.root || 'operazioniCataniaStasula.visualizzaLottiBirraio?idSessione=' || idSessione);
    end if;

    
    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('Visualizza clienti per numero ordini', Costanti.root || 'statisticpack.topClientiOrdini?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza clienti per numero recensioni', Costanti.root || 'statisticpack.topClientiRecensioni?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza lo stato di vendite dei lotti per fascia di prezzo', Costanti.root || 'statisticpack.bestSellers?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza numero lotti per ricetta', Costanti.root || 'statisticpack.nLottiRicetta?idSessione=' || idSessione);
    end if;
END navGruppo3;

procedure navLatGruppo3(idSessione number) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    if(ruolo = 'cliente') then
        modGUI.Collegamento('Visualizza dati cliente',  Costanti.root || 'gruppo3.visualizzaCliente?idSessione=' || idSessione);
        modGUI.Collegamento('Cerca birrai',  Costanti.root || 'gruppo3.cercaBirrai?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza lotti',  Costanti.root || 'gruppo3.visualizzaLotti?idSessione=' || idSessione);
        modGUI.Collegamento('Carrello',  Costanti.root || 'gruppo3.visualizzaCarrello?idSessione=' || idSessione); 
        modGUI.Collegamento('Ordini effettuati',  Costanti.root || 'ordinipack.visualizzaOrdini?idSessione=' || idSessione || '&id_cliente=' || login.GETIDUTENTE(idSessione)); 
        modGUI.Collegamento('Recensioni',  Costanti.server || Costanti.root || 'RecensioniPack.visualizzarecensioni?idSessione=' || idSessione); 
    end if;

    if(ruolo = 'birraio') then
        modGUI.Collegamento('Visualizza annotazioni',  Costanti.root || 'opBirrai.visualizzaAnnotazioni?idSessione=' || idSessione);
        modGUI.Collegamento('Inserisci un nuovo lotto',  Costanti.root || 'opBirrai.produciLotto?idSessione=' || idSessione);
	modGUI.Collegamento('Modifica stato lotto',  Costanti.root || 'operazioniCataniaStasula.visualizzaLottiBirraio?idSessione=' || idSessione);
    end if;

    if(ruolo = 'amministratore') then
        modGUI.Collegamento('Visualizza clienti per numero ordini', Costanti.root || 'statisticpack.topClientiOrdini?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza clienti per numero recensioni', Costanti.root || 'statisticpack.topClientiRecensioni?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza lo stato di vendite dei lotti per fascia di prezzo', Costanti.root || 'statisticpack.bestSellers?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza il numero dei lotti per ricetta', Costanti.root || 'statisticpack.nLottiRicetta?idSessione=' || idSessione);
    end if;
END navLatGruppo3;


end menuGruppi;