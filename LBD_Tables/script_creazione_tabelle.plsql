BEGIN
 FOR i IN (SELECT us.sequence_name
 FROM USER_SEQUENCES us) LOOP
 EXECUTE IMMEDIATE 'drop sequence '|| i.sequence_name ||'';
 END LOOP;
 FOR i IN (SELECT ut.table_name
 FROM USER_TABLES ut
 WHERE ut.table_name!='FILES_ORCL2021') LOOP
 EXECUTE IMMEDIATE 'drop table '|| i.table_name ||' CASCADE CONSTRAINTS ';
 END LOOP;
 FOR i IN (SELECT uv.view_name
 FROM USER_VIEWS uv) LOOP
 EXECUTE IMMEDIATE 'drop view' || i.view_name || '';
 END LOOP;
END;
/
create table Utenti (
 idutente number (10,0) NOT NULL,
 uname varchar2 (45) NOT NULL UNIQUE,
 pwd varchar2 (45) NOT NULL,
 ruolo VARCHAR2(20) CHECK(ruolo IN ('fornitore', 'birraio', 'cliente','amministratore')) NOT NULL,
 PRIMARY KEY ( idutente , ruolo )
);

create table Sessioni (
 idsessione NUMBER(10,0) PRIMARY KEY,
 idutente NUMBER(10,0) NOT NULL,
 tempo TIMESTAMP (6)NOT NULL,
 uname varchar2 (45) NOT NULL UNIQUE 
);

CREATE TABLE Fornitori (
 idfornitore NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL,
 cognome VARCHAR2(45) NOT NULL,
 telefono VARCHAR2(13) NOT NULL,
 indirizzo VARCHAR2(45) NOT NULL,
 ragione_sociale VARCHAR2(45)
);

CREATE TABLE Clienti (
 idcliente NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL,
 cognome VARCHAR2(45) NOT NULL,
 telefono VARCHAR2(13) NOT NULL,
 indirizzo VARCHAR2(45) NOT NULL,
 ragione_sociale VARCHAR2(45)
);

CREATE TABLE Birrai (
 idbirraio NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL,
 cognome VARCHAR2(45) NOT NULL,
 telefono VARCHAR2(13) NOT NULL,
 indirizzo VARCHAR2(45) NOT NULL,
 ragione_sociale VARCHAR2(45)
);

CREATE TABLE Tipi (
 idtipo NUMBER(2) PRIMARY KEY, 
 nome VARCHAR2(10) CHECK(nome IN('malto', 'luppolo', 'varie')),
 unita_di_misura VARCHAR2(3) CHECK(unita_di_misura IN ('g', 'mg', 'kg', 'l')) NOT NULL
);

CREATE TABLE Ingredienti (
 idingrediente NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL,
 descrizione VARCHAR2(100) NOT NULL,
 prezzo_unitario NUMBER(5) NOT NULL CHECK(prezzo_unitario>0),
 utilizzabile NUMBER(1) CHECK(utilizzabile IN (0,1)) NOT NULL,
 idtipo NUMBER(2) NOT NULL
 REFERENCES Tipi(idtipo),
 idfornitore NUMBER(5)
 REFERENCES Fornitori(idfornitore)
 ON DELETE SET NULL
);

CREATE TABLE OrdiniBirrai (
 idordine NUMBER(5) PRIMARY KEY,
 numero_fattura VARCHAR2(9) UNIQUE,
 data_ordine DATE NOT NULL,
 prezzo_totale FLOAT CHECK(prezzo_totale>0),
 id_birraio NUMBER(5)
 REFERENCES Birrai(idbirraio)
 ON DELETE SET NULL
);

CREATE TABLE IngredientiBirrai (
 idingrediente NUMBER(5) NOT NULL
 REFERENCES Ingredienti(idingrediente),
 idbirraio NUMBER(5) NOT NULL 
 REFERENCES Birrai(idbirraio),
quantita NUMBER(5) NOT NULL CHECK(quantita>0)
);

CREATE TABLE Rifornimenti (
 idrifornimento NUMBER(5) PRIMARY KEY,
 prezzo_ingrediente NUMBER(5) NOT NULL CHECK(prezzo_ingrediente>0),
 quantita NUMBER(5) NOT NULL CHECK(quantita>0),
 idingrediente NUMBER(5) NOT NULL
 REFERENCES Ingredienti(idingrediente),
 idordine NUMBER(5) NOT NULL
 REFERENCES OrdiniBirrai(idordine)
);

CREATE TABLE OrdiniClienti (
 idordine NUMBER(5) PRIMARY KEY,
 data_ordine DATE NOT NULL,
 prezzo_totale NUMBER(5) CHECK(prezzo_totale>0),
 stato VARCHAR2(20) CHECK(stato IN ('in preparazione', 'spedito', 'annullato')) NOT NULL,
 idcliente NUMBER(5)
 REFERENCES Clienti(idcliente)
 ON DELETE SET NULL
);

CREATE TABLE Ricette (
 idricetta NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL UNIQUE,
 istruzioni VARCHAR2(500) NOT NULL,
 metodologie VARCHAR2(20) CHECK(metodologie IN ('whole grain', 'extract', 'mixed')) NOT NULL,
 utilizzabile NUMBER(1) CHECK(utilizzabile IN(0,1)) NOT NULL, 
 ultima_modifica DATE NOT NULL,
 idbirraio NUMBER(5)
 REFERENCES Birrai(idbirraio)
 ON DELETE SET NULL
);

CREATE TABLE Lotti (
 idlotto NUMBER(5) PRIMARY KEY,
 nome VARCHAR2(45) NOT NULL,
 descrizione VARCHAR2(45),
 inizio_produzione DATE NOT NULL,
 fine_produzione DATE,
 scadenza DATE,
 litri_prodotti NUMBER(10) CHECK(litri_prodotti>0),
 stato VARCHAR2(20) CHECK(stato IN ('produzione', 'vendita', 'archiviato')) NOT NULL,
 pubblicazione DATE,
 litri_residui NUMBER(10) NOT NULL CHECK(litri_residui>=0),
 prezzo_al_litro NUMBER(5) CHECK(prezzo_al_litro>0),
 idricetta NUMBER(5) NOT NULL
 REFERENCES Ricette(idricetta),
 idbirraio NUMBER(5)
 REFERENCES Birrai(idbirraio)
 ON DELETE SET NULL
);

CREATE TABLE Recensioni (
 idrecensione NUMBER(5) PRIMARY KEY,
 recensione VARCHAR2(500) NOT NULL,
 qualita NUMBER(1) NOT NULL CHECK(qualita>=1 AND qualita<=5),
 idcliente NUMBER(5)
 REFERENCES Clienti(idcliente)
 ON DELETE SET NULL, 
 idlotto NUMBER(5) NOT NULL
 REFERENCES Lotti(idlotto)
);

CREATE TABLE Annotazioni (
 idannotazione NUMBER(5) PRIMARY KEY,
 annotazione VARCHAR2(500) NOT NULL,
 rilascio DATE NOT NULL,
 idbirraio NUMBER(5)
 REFERENCES Birrai(idbirraio)
 ON DELETE SET NULL,
 idlotto NUMBER(5) NOT NULL
 REFERENCES Lotti(idlotto)
);

CREATE TABLE IngredientiRicette (
 idingrediente NUMBER(5) NOT NULL
 REFERENCES Ingredienti(idingrediente),
 idricetta NUMBER(5) NOT NULL
 REFERENCES Ricette(idricetta),
 quantita FLOAT NOT NULL CHECK(quantita>0),
 PRIMARY KEY ( idingrediente , idricetta )
);

CREATE TABLE RicetteCondivise (
 idricetta NUMBER(5) NOT NULL
 REFERENCES Ricette(idricetta),
 idbirraio NUMBER(5) NOT NULL
 REFERENCES Birrai(idbirraio),
 PRIMARY KEY ( idricetta , idbirraio )
);

CREATE TABLE OrdiniClientiLotti ( 
 idordine NUMBER(5) NOT NULL
 REFERENCES OrdiniClienti(idordine),
 idlotto NUMBER(5) NOT NULL
 REFERENCES Lotti(idlotto),
 numero_litri NUMBER(10) CHECK(numero_litri>0),
 prezzo_litro NUMBER(5) NOT NULL CHECK(prezzo_litro>0),
 pronto NUMBER(1) CHECK(pronto IN (0,1)) NOT NULL,
 PRIMARY KEY ( idordine , idlotto )
);

CREATE OR REPLACE VIEW LitriVendutiBirraio (idbirraio, nlitri) AS
SELECT b.idbirraio, SUM(oc.NUMERO_LITRI)
FROM Birrai b, Lotti l,OrdiniClientiLotti oc
WHERE b.idbirraio=l.idbirraio AND oc.idlotto=l.idlotto
GROUP BY b.idbirraio;

CREATE OR REPLACE VIEW qualitamedialotti (idbirraio,qualitamedia) AS
SELECT b.idbirraio, avg(r.qualita)
FROM birrai b,lotti l,recensioni r
WHERE b.idbirraio=l.idbirraio and r.idlotto=l.idlotto
GROUP BY b.idbirraio;

CREATE OR REPLACE VIEW PrezzoMedioBirraio (idbirraio, avgprezzo) AS
SELECT b.idbirraio, AVG(oc.prezzo_litro)
FROM Birrai b, Lotti l,OrdiniClientiLotti oc
WHERE b.idbirraio=l.idbirraio AND oc.idlotto=l.idlotto
GROUP BY b.idbirraio;

CREATE OR REPLACE VIEW LottiInconclusiBirraio (idbirraio,nlottibad) AS
SELECT b.idbirraio,COUNT(
 case l.idlotto
 when is null then 0 
 else 1
 end)
FROM BIRRAI b LEFT OUTER JOIN LOTTI l
l.LITRI_RESIDUI > 0 AND l.STATO = 'archiviato'
GROUP BY b.idbirraio;

CREATE OR REPLACE VIEW LottiConclusiBirraio (idbirraio,nlottiright) AS
SELECT b.idbirraio,COUNT(*)
FROM BIRRAI b,LOTTI l
WHERE b.idbirraio=l.idbirraio AND
l.LITRI_RESIDUI = 0 AND l.STATO = 'archiviato'
GROUP BY b.idbirraio; 

create or replace table tipi_temp (nome varchar2(45));

create or replace table carrello(
 id_Sessione number,
 idlotto number,
 quantita number,
 primary key(id_Sessione, idlotto)
);

create or replace table carrello_for (idcarrello number PRIMARY KEY,
 idingrediente number,
 quantita number,
 prezzo number,
 idbirraio number);

CREATE OR REPLACE VIEW QUALITABIRRAI (qualita, idbirraio) AS
SELECT CAST(ROUND(avg(qualita), 2) AS NUMERIC(12,2)), B.IDBIRRAIO
FROM BIRRAI B, QUALITALOTTI QL, LOTTI L
WHERE B.IDBIRRAIO = L.IDBIRRAIO
AND L.IDLOTTO = QL.IDLOTTO
GROUP BY B.IDBIRRAIO;

CREATE OR REPLACE VIEW QUALITALOTTI (qualita, idlotto) AS
SELECT CAST(ROUND(avg(qualita), 2) AS NUMERIC(12,2)), L.IDLOTTO 
FROM RECENSIONI RE, LOTTI L 
WHERE L.IDLOTTO = RE.IDLOTTO
GROUP BY L.IDLOTTO;
/
CREATE SEQUENCE idSessioni_seq START WITH 1 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE; 
CREATE SEQUENCE idFornitori_seq START WITH 9 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE;
CREATE SEQUENCE idClienti_seq START WITH 10 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE;
CREATE SEQUENCE idBirrai_seq START WITH 8 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE;
CREATE SEQUENCE idTipi_seq START WITH 6 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295 CYCLE
NOCACHE;
CREATE SEQUENCE idIngredienti_seq START WITH 9 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idRifornimenti_seq START WITH 16 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idRicette_seq START WITH 5 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE;
CREATE SEQUENCE idLotti_seq START WITH 21 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE;
CREATE SEQUENCE idRecensioni_seq START WITH 19 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idAnnotazioni_seq START WITH 17 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idOrdiniClienti_seq START WITH 13 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idOrdiniBirrai_seq START WITH 10 MINVALUE 0 INCREMENT BY 1 MAXVALUE
4294967295 CYCLE NOCACHE;
CREATE SEQUENCE idcarrello_seq START WITH 1 MINVALUE 0 INCREMENT BY 1 MAXVALUE 4294967295
CYCLE NOCACHE; 