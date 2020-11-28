CREATE OR REPLACE PACKAGE BODY homepageClienti AS 

procedure homePage(
    idSessione number
    )
IS
begin
    modGUI.APRIPAGINA('home page gruppo 3', idSessione);
    modGUI.CreaMenuBackOffice(idSessione);
    modGUI.INTESTAZIONE(idSessione,'HOME PAGE');
    
    modGUI.APRIDIV(classe=>'centered');
    --Visualizza i tuoi dati
    modGUI.APRIFORMHidden(Costanti.root || 'gruppo3.visualizzaDati',idSessione);
    modgui.passaparametro('valore', 'cliente');
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', testo=>'Visualizza i tuoi dati');
    modGUI.ChiudiForm();
    modGUI.CHIUDIDIV();
    
    --Visualizza i  birrai
    modGUI.APRIDIV(classe=>'centered');
    modGUI.APRIFORMHidden(Costanti.root || 'gruppo3.visualizzaDati', idSessione);
    modgui.passaparametro('valore', 'birrai');
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', testo=>'Cerca i Birrai');
    modGUI.ChiudiForm();
    modGUI.CHIUDIDIV();
    
    --Visualizza i lotti
    modGUI.APRIDIV(classe=>'centered');
    modGUI.APRIFORMHidden(Costanti.root || 'gruppo3.visualizzaDati', idSessione);
    modgui.passaparametro('valore', 'lotti');
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', testo=>'Visualizza i lotti');
    modGUI.ChiudiForm();
    modGUI.CHIUDIDIV();
    
    
    modGUI.ChiudiPagina();
end homePage;

END homepageClienti;