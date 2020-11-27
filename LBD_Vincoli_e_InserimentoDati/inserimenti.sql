----------------------------------BIRRAI--------------------------------
INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo, ragione_sociale)
VALUES(1, 'Saverio','Catania','0987654321','via Pisanelli, 1','Catania srl');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(2, 'Ruslan','Stasula','0367 8935211','Via Rosmini, 27','Stasula srl');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(3, 'Umberto','Trentini','0334 4666353','Piazzetta Scalette Rubiani, 150', 'privato');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(4, 'Concetta','Toscano','0390 7725197','Via Francesco Del Giudice, 88', 'privato');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(5, 'Speranza','Napolitani','0315 3370835','Via Longhena, 136', 'privato');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(6, 'Brunilde','DeRose','0317 7937377','Via Alfredo Fusco, 93', 'privato');

INSERT INTO Birrai (idbirraio, nome, cognome,  telefono, indirizzo,  ragione_sociale) 
VALUES(7, 'Giacobbe','Davide','0377 3253162','Piazza della Repubblica, 137', 'privato');

---------------------------------- CLIENTI --------------------------------
INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo, ragione_sociale)
VALUES(1, 'Davide','Chen','0350 7294685','Via Duomo, 26', 'Chen srl');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo, ragione_sociale)
VALUES(2, 'Malio','Li','0321 8300195','Via Francesco Girardi, 116', 'Li srl');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(3, 'Elisa','Loggia','0397 3863485','Corso Alcide De Gasperi, 2');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(4, 'Gaspare','Rossi','0387 5284999','Via Alfredo Fusco, 21');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(5, 'Eliano','Romani','0359 3369906','Discesa Gaiola, 12');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo, ragione_sociale)
VALUES(6, 'Libero','Padovesi','0370 4929533','Via Colonnello Galliano, 139', 'Padovesi srl');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(7, 'Gildo','Marino','0359 5304508','Vicolo Calcirelli, 56');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(8, 'Adone','Bergamaschi','0397 5873222','Via Castelfidardo, 134');

INSERT INTO Clienti (idcliente, nome, cognome,  telefono, indirizzo)
VALUES(9, 'Ambrosino','Trevisani','0325 1043072','Via del Piave, 59');

---------------------------------- FORNITORI--------------------------------
INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES (1, 'Gianmarco','Bertola',  '0123456789', 'viale Italia 1', 'Bertola srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(2, 'Luca','Pardini', '1123456789', 'via Milano 1', 'Pardini srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(3, 'Adelinda','Ferrari', '2123456789', 'via Roma 1', 'Ferrari srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale) 
VALUES(4, 'Amedeo','Romani', '3123456789', 'via Napoli  1', 'Romani srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(5, 'Isotta','Fallaci', '4123456789', 'viale Torino 1', 'Fallaci srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(6, 'Sergio','Sal', '5123456789', 'via Venezia 1', 'Val srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale) 
VALUES(7, 'Rosina','Rossi', '6123456789', 'via Sicilia 1', 'Rosina srl');

INSERT INTO Fornitori (idfornitore, nome, cognome,  telefono, indirizzo,  ragione_sociale)
VALUES(8, 'Rachele','Verdi', '7123456789', 'via Sardegna 1', 'Rachele srl');

---------------------------------- TIPI --------------------------------
INSERT INTO Tipi (idtipo, nome , unita_di_misura)
VALUES (1,'malto', 'kg');

INSERT INTO Tipi (idtipo, nome , unita_di_misura)
VALUES (2, 'luppolo','kg');

INSERT INTO Tipi (idtipo, nome , unita_di_misura)
VALUES (3,'varie','kg');

INSERT INTO Tipi (idtipo, nome , unita_di_misura)
VALUES (4,'varie','l');

INSERT INTO Tipi (idtipo, nome , unita_di_misura)
VALUES (5,'varie','mg');

---------------------------------- INGREDIENTI --------------------------------
INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (1, 4, 1,  'Acqua','Acqua di montagna.', 1, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (2, 1, 2,  'Malto A','Malto di qualita A.', 5, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (3, 1, 3, 'Malto B','Malto di qualita B.', 7, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (4, 2, 4,  'Luppolo A','Luppolo di qualita A.', 3, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (5,2, 5, 'Luppolo B','Luppolo di qualita B.', 5, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (6, 5, 6,  'Lievito','Lievito per birra', 3, 1);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (7, 3, 1,  'Finocchi','Frutta', 6, 0);

INSERT INTO Ingredienti (idingrediente, idtipo, idfornitore, nome, descrizione, prezzo_unitario, utilizzabile)
VALUES (8, 5, 2, 'Lattosio','lattosio per birra', 8, 0);

---------------------------------- RICETTE--------------------------------
INSERT INTO Ricette (idricetta, idbirraio, nome, istruzioni, metodologie, utilizzabile)
VALUES (1, 1, 'Ginger Rye Ale', 'istruzione della ricetta Ginger Rye Ale', 'whole grain', 1);

INSERT INTO Ricette (idricetta, idbirraio, nome, istruzioni, metodologie, utilizzabile)
VALUES (2, 1, 'Pumpking beer', 'istruzione della ricetta Pumpking beer', 'whole grain', 0);

INSERT INTO Ricette (idricetta, idbirraio, nome, istruzioni, metodologie, utilizzabile)
VALUES (3, 2, 'Birra al mango','istruzione della ricetta Birra al mango','extract', 1);

INSERT INTO Ricette (idricetta, idbirraio, nome, istruzioni, metodologie, utilizzabile)
VALUES (4, 3, 'Birra al pepe di Cubebe','istruzione della ricetta Birra al pepe di Cubebe','mixed', 1);

---------------------------------- INGREDIENTIRICETTE--------------------------------
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(1, 1, 10);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(1, 2, 5);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(1, 4, 3);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(1,6, 100);

INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(2, 1, 10);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(2, 3, 5);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(2, 5, 4);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(2, 6, 150);

INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(3, 1, 15);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(3, 2, 5);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(3, 5, 3);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(3, 6, 180);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(3, 7, 1);

INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(4, 1, 20);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(4, 3, 10);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(4, 4, 5);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(4, 6, 200);
INSERT INTO IngredientiRicette (idricetta, idingrediente , quantita)
VALUES(4, 8, 200);


---------------------------------- INGREDIENTIBIRRAI --------------------------------
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (1, 1, 50);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (1, 2, 20);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (1, 4, 30);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (1, 6, 2000);

INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (2, 1, 80);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (2, 3, 30);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (2, 5, 20);

INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (3, 1, 30);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (3, 3, 20);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (3, 4, 30);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (3, 7, 10);

INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 1, 50);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 2, 20);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 3, 10);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 4, 30);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 5, 15);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 6, 500);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 7, 3);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (4, 8, 250);

INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (5, 5, 20);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (5, 6, 500);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (5, 8, 180);


INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (6, 1, 100);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (6, 2, 50);

INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (7, 4, 20);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (7, 6, 2000);
INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
VALUES (7, 8, 500);
---------------------------------- ORDINIBIRRAI--------------------------------
INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(1, 1, 1, to_date('15/10/2020','dd/mm/yyyy'), 109);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(2, 1, 2, to_date('16/10/2020','dd/mm/yyyy'), 150);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(3, 2, 3, to_date('17/10/2020','dd/mm/yyyy'), 23);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(4, 3, 4, to_date('17/10/2020','dd/mm/yyyy'), 20);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(5, 4, 5, to_date('18/10/2020','dd/mm/yyyy'), 155);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(6, 5, 6, to_date('19/10/2020','dd/mm/yyyy'), 15);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(7, 6, 7, to_date('20/10/2020','dd/mm/yyyy'), 70);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(8, 6, 8, to_date('21/10/2020','dd/mm/yyyy'), 100);

INSERT INTO OrdiniBirrai (idordine, id_birraio, numero_fattura, data_ordine, prezzo_totale)
VALUES(9, 6, 9, to_date('25/10/2020','dd/mm/yyyy'), 30);


---------------------------------- RICETTECONDIVISE--------------------------------
INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 2);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 3);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 4);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 5);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 6);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (1, 7);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (2, 7);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (2, 6);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (2, 3);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (2, 2);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (2, 4);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 1);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 3);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 4);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 5);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 6);

INSERT INTO RICETTECONDIVISE (idricetta, idbirraio)
VALUES (3, 7);
---------------------------------- LOTTI--------------------------------
insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(1, 1, 1, 'lotto 1', 'descrizione lotto 1', to_date('14/08/2011', 'dd/mm/yyyy'), to_date('14/09/2011', 'dd/mm/yyyy'), to_date('14/09/2016', 'dd/mm/yyyy'), 40, 'archiviato', to_date('15/09/2011', 'dd/mm/yyyy'), 0, 5);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(2, 1, 1, 'lotto2', 'descrizione lotto 2', to_date('12/09/2011', 'dd/mm/yyyy'), to_date('12/10/2011', 'dd/mm/yyyy'), to_date('12/09/2016', 'dd/mm/yyyy'), 50, 'archiviato', to_date('13/10/2011', 'dd/mm/yyyy'), 0, 6);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(3, 2, 1, 'lotto3', 'descrizione lotto 3', to_date('07/07/2012', 'dd/mm/yyyy'), to_date('07/08/2012', 'dd/mm/yyyy'), to_date('07/08/2018', 'dd/mm/yyyy'), 45, 'archiviato', to_date('10/08/2012', 'dd/mm/yyyy'), 0, 5);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(4, 2, 1, 'lotto4', 'descrizione lotto 4', to_date('22/04/2014', 'dd/mm/yyyy'), to_date('22/06/2014', 'dd/mm/yyyy'), to_date('22/04/2019','dd/mm/yyyy'),60, 'archiviato', to_date('22/06/2014','dd/mm/yyyy'), 0, 7);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(5, 3, 2, 'lotto5', 'descrizione lotto 5', to_date('08/07/2014','dd/mm/yyyy'), to_date('08/08/2014','dd/mm/yyyy'), to_date('08/07/2019','dd/mm/yyyy'), 50, 'archiviato', to_date('09/07/2014','dd/mm/yyyy'), 0, 6);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(6, 1, 2, 'lotto6', 'descrizione lotto 6', to_date('22/05/2015','dd/mm/yyyy'), to_date('22/07/2015','dd/mm/yyyy'), to_date('22/07/2019','dd/mm/yyyy'), 30, 'archiviato', to_date('30/05/2015','dd/mm/yyyy'), 0, 6);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(7, 4, 3, 'lotto7', 'descrizione lotto 7', to_date('03/10/2016', 'dd/mm/yyyy'), to_date('03/11/2016','dd/mm/yyyy'), to_date('03/10/2021','dd/mm/yyyy'), 50, 'vendita', to_date('05/10/2016', 'dd/mm/yyyy'), 10, 8);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(8, 1, 3, 'lotto8', 'descrizione lotto 8', to_date('21/03/2017','dd/mm/yyyy'), to_date('21/04/2017','dd/mm/yyyy'), to_date('21/03/2022','dd/mm/yyyy'), 50, 'archiviato', to_date('21/03/2017','dd/mm/yyyy'), 0, 6);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(9, 2, 3, 'lotto9', 'descrizione lotto 9', to_date('05/04/2017','dd/mm/yyyy'), to_date('05/05/2017','dd/mm/yyyy'), to_date('05/04/2022','dd/mm/yyyy'), 60, 'vendita', to_date('06/04/2017','dd/mm/yyyy'), 20, 7);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(10, 3, 3, 'lotto10', 'descrizione lotto 10', to_date('28/07/2017','dd/mm/yyyy'), to_date('15/09/2017','dd/mm/yyyy'), to_date('15/09/2022','dd/mm/yyyy'), 50, 'archiviato', to_date('15/08/2017','dd/mm/yyyy'), 0, 9);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(11, 4, 3, 'lotto11', 'descrizione lotto11', to_date('05/09/2017','dd/mm/yyyy'), to_date('05/10/2017','dd/mm/yyyy'), to_date('05/09/2022','dd/mm/yyyy'), 100, 'vendita', to_date('05/09/2017','dd/mm/yyyy'), 50, 8);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(12, 2, 4, 'lotto12', 'descrizione lotto12', to_date('19/09/2017','dd/mm/yyyy'), to_date('19/10/2017','dd/mm/yyyy'), to_date('19/10/2022','dd/mm/yyyy'), 70, 'vendita', to_date('19/09/2017','dd/mm/yyyy'), 5, 7);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(13, 3, 4, 'lotto13', 'descrizione lotto 13', to_date('25/10/2017','dd/mm/yyyy'), to_date('25/12/2017','dd/mm/yyyy'), to_date('25/10/2023','dd/mm/yyyy'), 50, 'archiviato', to_date('25/10/2017','dd/mm/yyyy'), 0, 5);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(14, 1, 1, 'lotto14', 'descrizione lotto 14', to_date('11/10/2018','dd/mm/yyyy'), to_date('11/11/2018','dd/mm/yyyy'), to_date('11/11/2023','dd/mm/yyyy'), 70, 'archiviato', to_date('11/11/2018','dd/mm/yyyy'), 0, 3);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(15, 1, 2, 'lotto15', 'descrizione lotto 15', to_date('05/05/2019','dd/mm/yyyy'), to_date('05/07/2019','dd/mm/yyyy'), to_date('05/06/2025','dd/mm/yyyy'), 30, 'archiviato', to_date('05/05/2019','dd/mm/yyyy'), 0, 6);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(16, 3, 5, 'lotto16', 'descrizione lotto 16', to_date('12/11/2019','dd/mm/yyyy'), to_date('12/12/2019','dd/mm/yyyy'), to_date('12/11/2025','dd/mm/yyyy'), 45, 'vendita', to_date('12/12/2019','dd/mm/yyyy'), 30, 7);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(17, 3, 5, 'lotto17', 'descrizione lotto 17', to_date('26/12/2019','dd/mm/yyyy'), to_date('26/2/2020','dd/mm/yyyy'), to_date('26/12/2025','dd/mm/yyyy'), 50, 'vendita', to_date('7/1/2020','dd/mm/yyyy'), 45, 9);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, fine_produzione, scadenza, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(18, 3, 5, 'lotto18', 'descrizione lotto 18', to_date('30/03/2020','dd/mm/yyyy'), to_date('30/05/2020','dd/mm/yyyy'), to_date('30/05/2026','dd/mm/yyyy'), 70, 'vendita', to_date('30/05/2020','dd/mm/yyyy'), 60, 7);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, litri_prodotti, stato,litri_residui, prezzo_al_litro)
values(19, 1, 6, 'lotto19', 'descrizione lotto 19', to_date('12/10/2020','dd/mm/yyyy'), 60, 'produzione', 60, 8);

insert into lotti (idlotto, idricetta, idbirraio, nome, descrizione, inizio_produzione, litri_prodotti, stato, pubblicazione, litri_residui, prezzo_al_litro)
values(20, 4, 3, 'lotto20', 'descrizione lotto 20', to_date('12/11/2020','dd/mm/yyyy'), 70,  'produzione', to_date('12/11/2020','dd/mm/yyyy'), 50, 9);


---------------------------------- ORDINICLIENTI--------------------------------
INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(1, 1, to_date('28/07/2014','dd/mm/yyyy'), 265, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(2, 1, to_date('01/11/2016','dd/mm/yyyy') , 280, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(3, 2, to_date('06/11/2016','dd/mm/yyyy'), 50, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(4, 3, to_date('15/11/2016','dd/mm/yyyy') ,170, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(5, 3, to_date('16/11/2016','dd/mm/yyyy'), 120, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(6, 3, to_date('21/05/2017','dd/mm/yyyy'), 530, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(7, 4, to_date('22/05/2017','dd/mm/yyyy'), 550, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(8, 4, to_date('22/06/2017','dd/mm/yyyy'), 150, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(9, 4, to_date('27/06/2017','dd/mm/yyyy'), 70, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(10, 5, to_date('20/12/2017','dd/mm/yyyy'), 850, 'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(11, 6, to_date('20/12/2019','dd/mm/yyyy') ,285 ,'spedito');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(12, 6, to_date('13/11/2020','dd/mm/yyyy') ,1190, 'in preparazione');

INSERT INTO ORDINICLIENTI(idordine, idcliente, data_ordine, prezzo_totale, stato)
VALUES(13, 9, to_date('25/11/2020','dd/mm/yyyy'), 420, 'spedito');

---------------------------------- RECENSIONI--------------------------------
INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (1, 1, 1, 'recensione cliente 1 sul lotto 1', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (2, 1, 3, 'recensione cliente 1 sul lotto 3', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (3, 2, 1, 'recensione cliente 2 sul lotto 1', 3);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (4, 3, 3, 'recensione cliente 3 sul lotto 1', 4 );

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (5, 1, 5, 'recensione cliente 1 sul lotto 5', 2);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (6, 3, 5, 'recensione cliente 3 sul lotto 5', 1);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (7, 3, 2, 'recensione cliente 3 sul lotto 2', 3);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (8, 4, 2, 'recensione cliente 4 sul lotto 2', 4);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (9, 4, 3, 'recensione cliente 1 sul lotto 1', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (10, 5, 10, 'recensione cliente 5 sul lotto 10', 4);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (11, 6, 8, 'recensione cliente 6 sul lotto 8', 4);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (12, 9, 9, 'recensione cliente 9 sul lotto 9', 3);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (13, 9, 12, 'recensione cliente 9 sul lotto 12', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (14, 6, 16, 'recensione cliente 6 sul lotto 16', 1);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (15, 5, 11, 'recensione cliente 5 sul lotto 11', 3);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (16, 4, 6, 'recensione cliente 4 sul lotto 6', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (17, 4, 9, 'recensione cliente 4 sul lotto 9', 5);

INSERT INTO RECENSIONI(idrecensione, idcliente, idlotto, recensione, qualita)
VALUES (18, 9, 17, 'recensione cliente 9 sul lotto 17', 4);

---------------------------------- ORDINISCLIENTILOTTI--------------------------------
INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(1, 1, 10, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(1, 2, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(1, 3, 5, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(1, 4, 10, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(2, 1, 20, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(2, 5, 10, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(2, 7, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(3, 1, 10, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(4, 3, 10, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(4, 5, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(5, 6, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(6, 2, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(6, 4, 30, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(6, 8, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(6, 7, 10, 8, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(7, 2, 10, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(7, 3, 30, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(7, 4, 20, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(7, 5, 20, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(7, 6, 10, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(8, 7, 10, 8, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(8, 9, 10, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(9, 9, 10, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(10, 10, 50, 9, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(10, 11, 50, 8, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(11, 8, 30, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(11, 16, 15, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(12, 12, 40, 7, 1 );

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(12, 13, 50, 5, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(12, 14, 70, 3, 1 );

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(12, 15, 30, 6, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(12, 20, 30, 9, 0);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(13, 9, 20, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(13, 12, 25, 7, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(13, 17, 5, 9, 1);

INSERT INTO ORDINICLIENTILOTTI (idordine, idlotto, numero_litri, prezzo_litro, pronto)
VALUES(13, 18, 10, 6, 1);

---------------------------------- ANNOTAZIONI--------------------------------
INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(1, 1, 1, 'annotazione del lotto 1', to_date('17/08/2011','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(2, 1, 2, 'annotazione del lotto 2', to_date('17/09/2011','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(3, 1, 3, 'annotazione del lotto 3', to_date('15/07/2012','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(4, 1, 3, 'annotazione del lotto 3 BIS', to_date('1/08/2012','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(5, 1, 4, 'annotazione del lotto 4', to_date('30/04/2014','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(6, 1, 14, 'annotazione del lotto 14', to_date('11/11/2018','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(7, 2, 5, 'annotazione del lotto 5', to_date('01/08/2014','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(8, 2, 6, 'annotazione del lotto 6', to_date('23/05/2015','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(9, 2, 15, 'annotazione del lotto 15', to_date('06/05/2019','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(10, 3, 8, 'annotazione del lotto 8', to_date('25/03/2017','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(11, 3, 10, 'annotazione del lotto 10', to_date('15/08/2017','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(12, 3, 11, 'annotazione del lotto 11', to_date('15/09/2017','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(13, 3, 20, 'annotazione del lotto 20', to_date('13/11/2020','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(15, 5, 18, 'annotazione del lotto 18', to_date('07/01/2020','dd/mm/yyyy'));

INSERT INTO Annotazioni (idannotazione, idbirraio, idlotto, annotazione, rilascio)
VALUES(16, 6, 19, 'annotazione del lotto 19', to_date('12/11/2020','dd/mm/yyyy'));


---------------------------------- RIFORNIMENTI --------------------------------
INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(1, 1, 1, 1, 10);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(2, 2, 1, 5, 5);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(3, 4, 1, 3, 20);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(4, 6, 1, 3, 2);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(5, 8, 1, 8, 1);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(6, 3, 2, 7, 15);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(7, 4, 2, 3, 15);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(8, 6, 3, 3, 5);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(9, 8, 3, 8, 1);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(10, 1, 4, 1, 20);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(11, 2, 5, 5, 10);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(12, 3, 5, 7, 15);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(13, 4, 6, 3, 5);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(14, 3, 7, 7, 10);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(15, 5, 8, 5, 20);

INSERT INTO Rifornimenti (idrifornimento, idingrediente, idordine, prezzo_ingrediente, quantita)
VALUES(16, 6, 9, 3, 10);
