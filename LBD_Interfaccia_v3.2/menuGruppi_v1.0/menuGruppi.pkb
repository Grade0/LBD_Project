CREATE OR REPLACE package body menuGruppi AS

-------------------------------------- GRUPPO 1 ----------------------------------------

procedure navGruppo1(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.CollegamentoNav('Esempio',  Costanti.root || 'nomeProcedura?idSessione=' || idSessione);

    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('procedureAdmin', Costanti.root || 'nomeProcedura?idSessione=' || idSessione);
    end if;
END navGruppo1;

procedure navLatGruppo1(idSessione int) is
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.Collegamento('Esempio',  Costanti.root || 'nomeProcedura' || idSessione);

    if(ruolo = 'amministratore') then
        modGUI.Collegamento('procedureAdmin', Costanti.root || 'nomeProcedura?idSessione=' || idSessione);
    end if;
END navLatGruppo1;


--------------------------------------- GRUPPO 2 -----------------------------------------
procedure navGruppo2(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.CollegamentoNav('Esempio',  Costanti.root || 'nomeProcedura?idSessione=' || idSessione);

    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('procedureAdmin', Costanti.root || 'nomeProcedura?idSessione=' || idSessione);
    end if;
END navGruppo2;

procedure navLatGruppo2(idSessione int) is
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.Collegamento('Esempio',  Costanti.root || 'nomeProcedura' || idSessione);

    if(ruolo = 'amministratore') then
        modGUI.Collegamento('procedureAdmin', Costanti.root || 'nomeProcedura?idSessione=' || idSessione);
    end if;
END navLatGruppo2;


--------------------------------------- GRUPPO 3 -----------------------------------------
procedure navGruppo3(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.CollegamentoNav('Visualizza dati cliente',  Costanti.root || 'gruppo3.visualizzaCliente?idSessione=' || idSessione);
    modGUI.CollegamentoNav('Cerca birrai',  Costanti.root || 'gruppo3.cercaBirrai?idSessione=' || idSessione);
    modGUI.CollegamentoNav('Visualizza lotti',  Costanti.root || 'gruppo3.visualizzaLotti?idSessione=' || idSessione);
    modGUI.CollegamentoNav('Carrello',  Costanti.root || 'gruppo3.visualizzaCarrello?idSessione=' || idSessione); 
    modGUI.CollegamentoNav('Ordini effettuati',  Costanti.root || 'ordinipack.visualizzaOrdini?idSessione=' || idSessione); 
    
    if(ruolo = 'amministratore') then
        modGUI.CollegamentoNav('Visualizza clienti per numero ordini', Costanti.root || 'statisticpack.topClientiOrdini?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza clienti per numero recensioni', Costanti.root || 'statisticpack.topClientiRecensioni?idSessione=' || idSessione);
        modGUI.CollegamentoNav('Visualizza le statistiche dei lotti venduti per fascia prezzi', Costanti.root || 'statisticpack.bestSellers?idSessione=' || idSessione);
    end if;
END navGruppo3;

procedure navLatGruppo3(idSessione int) IS
    ruolo varchar2(45);
BEGIN
    ruolo := login.GETROLEFROMSESSION(idSessione);
    modGUI.Collegamento('Visualizza dati cliente',  Costanti.root || 'gruppo3.visualizzaCliente?idSessione=' || idSessione);
    modGUI.Collegamento('Cerca birrai',  Costanti.root || 'gruppo3.cercaBirrai?idSessione=' || idSessione);
    modGUI.Collegamento('Visualizza lotti',  Costanti.root || 'gruppo3.visualizzaLotti?idSessione=' || idSessione);
    modGUI.Collegamento('Carrello',  Costanti.root || 'gruppo3.visualizzaCarrello?idSessione=' || idSessione);
    modGUI.Collegamento('Ordini effettuati',  Costanti.root || 'ordinipack.visualizzaOrdini?idSessione=' || idSessione); 

    if(ruolo = 'amministratore') then
        modGUI.Collegamento('Visualizza clienti per numero ordini', Costanti.root || 'statisticpack.topClientiOrdini?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza clienti per numero recensioni', Costanti.root || 'statisticpack.topClientiRecensioni?idSessione=' || idSessione);
        modGUI.Collegamento('Visualizza le statistiche dei lotti venduti per fascia prezzi', Costanti.root || 'statisticpack.bestSellers?idSessione=' || idSessione);
    end if;
END navLatGruppo3;

end menuGruppi;