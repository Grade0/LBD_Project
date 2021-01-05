CREATE OR REPLACE PACKAGE modGUI as

-- Tabella con elementi di tipo varchar2 e indici di tipo varchar2
type stringDict is table of varchar2(500) index by varchar2(500);

-- Rappresenta la tabella vuota di tipo stringDict
emptyDict stringDict;

procedure Reindirizza(indirizzo varchar2);

procedure ApriPagina(titolo varchar2 default 'Senza titolo', idSessione int default 0);

procedure ApriBody(idSessione int default 0);

procedure ApriMenuLat(idSessione int, ident varchar2 default '', subMenu boolean default false, parentName varchar2 default '');

procedure ChiudiMenuLat;

procedure CreaMenuPrincipale(idSessione int);

procedure Intestazione(tipo int, testo varchar2, ident varchar2 default '', classe varchar2 default '');

procedure ChiudiPagina; 

procedure RitCarrello;

procedure ApriForm(azione varchar2, nome varchar2, idSessione int default -1);

procedure ChiudiForm;

procedure ApriFormHidden(azione varchar2, idSessione int default -1, ident varchar2 default '', classe varchar2 default '');

procedure ChiudiFormHidden;

procedure ApriDiv(ident varchar2 default '', classe varchar2 default '');

procedure ChiudiDiv;

procedure Paragrafo(testo varchar2, ident varchar2 default '', classe varchar2 default '');

procedure Collegamento(testo varchar2, indirizzo varchar2, hasSub boolean default false);

procedure CollegamentoNav(testo varchar2, indirizzo varchar2, hasSub boolean default false, tipoSub varchar2 default '');

procedure ChiudiCollegamentoSubNav;

procedure Bottone(testo varchar2 default '', nome varchar2 default '', valore varchar2 default '', ident varchar2 default '', classe varchar2 default '');

procedure AreaDiTesto(nome varchar2, etichetta varchar2,valore varchar2 default '',center boolean default true);

procedure BottoneForm(nome varchar2 default 'Submit',valore varchar2 default 'Submit', testo varchar2 default 'Submit',
                      valida boolean default true, nomeForm varchar2 default '', classe varchar2 default '');

procedure CasellaDiTesto( nome varchar2, etichetta varchar2,
                          suggerimento varchar2 default '',
                          testo varchar2 default '',
                          lunghezzaMax varchar2 default '',
                          tipo varchar2 default '',
                          require boolean default false,
                          center boolean default true);

procedure CampoPassword(nome varchar2, etichetta varchar2 default 'Password', suggerimento varchar2 default '',  valore varchar2 default '', require boolean default false,center boolean default true);

procedure ApriBlocco(etichetta varchar2 default '',center boolean default true);

procedure ChiudiBlocco;

procedure ApriBloccoSelect(etichetta varchar2 default '',center boolean default true);

procedure ChiudiBloccoSelect;

procedure CheckBox(etichetta varchar2, nome varchar2,valore varchar2 , selezionato boolean default false);

procedure RadioButton(etichetta varchar2, nome varchar2,valore varchar2, selezionato boolean default false);

procedure ApriSelect(nome varchar2,center boolean default true);

procedure ChiudiSelect;

procedure ApriInlineSelect(nome varchar2);

------- MODIFICATO -----------
procedure ChiudiInlineSelect;

procedure AggiungiOpzioneSelect(Valore varchar2, Etichetta varchar2, Selezionato boolean default false);

procedure SelettoreData(
	idCampoGiorno VARCHAR2 default 'giorno',
	idCampoMese VARCHAR2 default 'mese',
	idCampoAnno VARCHAR2 default 'anno',
	dataDefault date, 
	etichetta varchar2, 
	center boolean default true
);

procedure PassaParametro(nome varchar2, valore varchar2 default null);

procedure StringaDiTesto(testo varchar2);

procedure ApriTabella;

procedure ChiudiTabella;

procedure ApriRigaTabella;

procedure ChiudiRigaTabella;

procedure ApriElementoTabella;

procedure ChiudiElementoTabella;

procedure ElementoTabella(testo varchar2);

procedure IntestazioneTabella(testo varchar2);

procedure bottoneInfo;

procedure bottoneEdit;

procedure bottoneConfirm;

procedure bottoneDelete;

procedure bottoneCart;

procedure PaginaFeedback(
	tipoMessaggio varchar2, 
	descrizioneMessaggio varchar2, 
	indirizzoRitorno varchar2, 
	idSessione int default -1, 
	parametriProcedura modGUI.stringDict default modGUI.emptyDict
);

procedure PaginaOspiti;

procedure PaginaPrincipale(idSessione int);

end modGUI;