create or replace procedure testModGUI_2 is
begin
  modGUI.APRIPAGINA('test', 5); --idSessione == 0 => sessione ospite
  modGUI.CREAMENUPRINCIPALE(1);
  modGUI.Intestazione(1, 'Esempio di utilizzo di modGUI');


  modGUI.APRITABELLA;
  modGUI.APRIRIGATABELLA;
  FOR h IN 1..5
  LOOP
    modGUI.IntestazioneTabella('Header');
  END LOOP;
  modGUI.CHIUDIRIGATABELLA;
  FOR s IN 1..4
  LOOP
    modGUI.APRIRIGATABELLA;
    FOR t IN 1..5
    LOOP
      modGUI.ELEMENTOTABELLA('lorem ipsum dolor sit amet');
    END LOOP;
    modGUI.CHIUDIRIGATABELLACONBOTTONI(2, 4, 'procDettagli', 'procModifica', 'procElimina');
  END LOOP;
  modGUI.CHIUDITABELLA;

modGUI.APRIDIV(classe=>'centered');
modGUI.PARAGRAFO('Questo è un div centrato');
modGUI.CHIUDIDIV;
modGUI.CHIUDIPAGINA;
end testModGUI_2;