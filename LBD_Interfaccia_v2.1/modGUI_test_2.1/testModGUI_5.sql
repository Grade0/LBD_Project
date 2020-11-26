create or replace procedure testmodGUI_5 is
begin
    modGUI.PaginaFeedback('ERRORE', 'Errore di modifica del dato', 'www.google.it', 1);

    modGUI.CHIUDIPAGINA;

end testmodGUI_5;