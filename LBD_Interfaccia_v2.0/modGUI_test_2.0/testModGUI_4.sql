create or replace procedure testmodGUI_4 is
begin
    modGUI.PaginaFeedback('SUCCESSO', 'Modifica avvenuta con successo', 'www.google.it', 1);

    modGUI.CHIUDIPAGINA;

end testmodGUI_4;