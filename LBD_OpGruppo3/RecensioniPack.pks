CREATE OR REPLACE PACKAGE RecensioniPack AS

procedure visualizzaRecensioni(
    idSessione number,
    id_cliente CLIENTI.idcliente%type default -1,
    id_lotto Lotti.IDLOTTO%type default -1
);

END RecensioniPack;