declare 
    utenteFornitore FORNITORI%rowtype;
    utenteBirraio BIRRAI%ROWTYPE;
    utenteCliente Clienti%rowtype;

begin
    for utenteFornitore in (select * from FORNITORI)
    LOOP
        insert into utenti(idutente, uname, pwd, ruolo)
        values(utenteFornitore.idfornitore, utenteFornitore.nome || utenteFornitore.cognome, utenteFornitore.nome || utenteFornitore.cognome, 'fornitore');
    end LOOP;

    for utenteBirraio in (select * from BIRRAI)
    LOOP
        insert into utenti(idutente, uname, pwd, ruolo)
        values(utenteBirraio.idbirraio, utenteBirraio.nome || utenteBirraio.cognome, utenteBirraio.nome || utenteBirraio.cognome, 'birraio');
    end LOOP;

    for utenteCliente in (select * from CLIENTI)
    LOOP
        insert into utenti(idutente, uname, pwd, ruolo)
        values(utenteCliente.idcliente, utenteCliente.nome || utenteCliente.cognome, utenteCliente.nome || utenteCliente.cognome, 'cliente');
    end LOOP;
end;