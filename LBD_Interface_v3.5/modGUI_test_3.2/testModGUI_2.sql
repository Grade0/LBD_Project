CREATE OR REPLACE procedure testModGUI_2 is
begin
  modGUI.APRIPAGINA('test', 5); --idSessione == 0 => sessione ospite
  modGUI.Intestazione(1, 'Esempio di utilizzo di modGUI');


  modGUI.APRITABELLA;
  modGUI.APRIRIGATABELLA;
  FOR h IN 1..3
  LOOP
    modGUI.IntestazioneTabella('Header');
  END LOOP;
  modGUI.IntestazioneTabella('InlineSelect');
  modGUI.IntestazioneTabella('Operazioni');
  modGUI.CHIUDIRIGATABELLA;
  FOR s IN 1..4
  LOOP
    modGUI.APRIRIGATABELLA;
    FOR t IN 1..3
    LOOP
      modGUI.ELEMENTOTABELLA('lorem ipsum dolor sit amet');
    END LOOP;

/* ---------------- Esempio utilizzo InlineSelect ------------------------ */
	MODGUI.ApriElementoTabella;
  modGUI.APRIFORMHIDDEN('ModificaCarrello', 5); 

  modGUI.ApriInlineSelect('quantita');
	modGUI.AGGIUNGIOPZIONESELECT('1','1');
  modGUI.AGGIUNGIOPZIONESELECT('2','2');
  modGUI.AGGIUNGIOPZIONESELECT('3','3',true);
  modGUI.AGGIUNGIOPZIONESELECT('4','4');	
	modGUi.ChiudiInlineSelect;
	MODGUI.bottoneConfirm;
  modgui.ChiudiFormHidden;
  modGUI.ChiudiElementoTabella;


/* ----------------- Esempio utilizzo "BottoniIcone" --------------------- */
	MODGUI.ApriElementoTabella;

    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneDettagli', 1);
    	MODGUI.bottoneInfo;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('IdRecord', 20);
    	modGUI.ChiudiFormHidden;

      MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneConferma', 1);
    	MODGUI.bottoneConfirm;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('IdRecord', 20);
    	modGUI.ChiudiFormHidden;

    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneModifica', 1);
    	MODGUI.bottoneEdit;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('IdRecord', 20);
    	modGUI.ChiudiFormHidden;

    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneElimina', 1);
    	MODGUI.bottoneDelete;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('IdRecord', 20);
   	modGUI.ChiudiFormHidden;

    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'azioneCarrello', 1);
    	MODGUI.bottoneCart;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('IdRecord', 20);
    	modGUI.ChiudiFormHidden;

    	modGUI.ChiudiElementoTabella;
	modGUI.ChiudiRigaTabella;

  END LOOP;
  modGUI.CHIUDITABELLA;

modGUI.APRIDIV(classe=>'centered');
modGUI.PARAGRAFO('Questo è un div centrato');
modGUI.CHIUDIDIV;
modGUI.CHIUDIPAGINA;
end testModGUI_2;