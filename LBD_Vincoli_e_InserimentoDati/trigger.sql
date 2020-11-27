--rimozione ingredienti in caso di produzione birra
CREATE OR REPLACE TRIGGER checkIngredienti
BEFORE INSERT ON Lotti
FOR EACH ROW
DECLARE 
    lingrediente ingredienti%Rowtype;
    quantitaInMagazzino IngredientiBirrai.quantita%type;
    quantitaRichiesto IngredientiRicette.quantita%type;
    litriDaProdurre Lotti.litri_prodotti%type;
    IngredienteNonSufficienteExp Exception;
BEGIN 
    litriDaProdurre := :new.litri_prodotti;
    
    for lingrediente in (
        select i.* from Ingredienti i, IngredientiRicette ir 
        where idricetta=:new.idricetta and i.idingrediente = ir.idingrediente
    )
    loop
            select quantita into quantitaRichiesto
            from IngredientiRicette
            where idingrediente = lingrediente.idingrediente and idricetta=:new.idricetta;

            quantitaRichiesto := (quantitaRichiesto * litriDaProdurre) / 10;

            select quantita into quantitaInMagazzino
            from IngredientiBirrai
            where idingrediente = lingrediente.idingrediente and idbirraio=:new.idbirraio;

            if quantitaRichiesto > quantitaInMagazzino then 
                Raise IngredienteNonSufficienteExp;
            else 
                update IngredientiBirrai
                set quantita = quantitaInMagazzino - quantitaRichiesto
                where
                    idbirraio = :new.idbirraio and
                    idingrediente = lingrediente.idingrediente;
            end if;
    end loop;

    EXCEPTION
    when IngredienteNonSufficienteExp then Raise_application_error 
    (-10001, 'quantita ingredienti non sufficente in magazzino, impossibile procedere per la creazione del lotto. Per favore procedere per acquisto degli ingredienti necessari.');
END;
    
    
--diminuire i lotti in caso di ordine nuovo
CREATE OR REPLACE trigger diminuisciLitriLotti
before insert on OrdiniClientiLotti
for each row
declare
    litriVenduti number;
    litriRimanenti number;
    LottoNonSufficenteExp Exception;
begin
    litriVenduti := :new.numero_litri;

    select litri_residui into litriRimanenti
    from Lotti
    where idlotto = :new.idlotto;

    if litriRimanenti < litriVenduti then
        Raise LottoNonSufficenteExp;
    else if litriRimanenti = litriVenduti then
        update Lotti
        set
            litri_residui = litriRimanenti - litriVenduti,
            stato = 'archiviato'
        where idlotto = :new.idlotto;
    else    
        update Lotti
        set
            litri_residui = litriRimanenti - litriVenduti
        where idlotto = :new.idlotto;
    end if;
    end if;
    Exception
    when LottoNonSufficenteExp then Raise_application_error
    (-10002, 'quantita indicata superiore alla quantita disponibile. Per favore indicare una quantita inferiore.');
end;



--se lo stato del lotto �� pronto allora settare OrdiniClientiLotti pronto=1
CREATE OR REPLACE trigger lottoPronto
after update on Lotti
for each row
declare statoLotto varchar(10);
begin
    if :new.stato = 'vendita' then
        update OrdiniClientiLotti
        set 
            pronto=1
        where idlotto=:new.idlotto;
    end if;
end;


--ingrediente inutilizzabiile => ricetta inutilizzabile
CREATE OR REPLACE trigger ingredienteInutilizzabile
after update on Ingredienti
for each row
declare

    laricetta IngredientiRicette%Rowtype;
begin
    for laricetta in (
        select * from IngredientiRicette where idingrediente = :new.idingrediente
    )
    loop
        update Ricette
        set
            utilizzabile = 0
        where idricetta = laricetta.idricetta;
    end loop;
end;


--aggiornamento quantita ingredienti dopo un ordine
create or replace trigger updateIngredienti
after insert on Rifornimenti
for each row
declare 
    id_birraio birrai.idbirraio%type;
    exist number;
begin
    select ordinibirrai.id_birraio into id_birraio from ordinibirrai where idordine=:new.idordine;

    select count(*) into exist from ingredientibirrai where idingrediente=:new.idingrediente and idbirraio=id_birraio;
    if exist > 0 then 
        update IngredientiBirrai
        set
            quantita = quantita + :new.quantita
        where 
            idingrediente = :new.idingrediente and 
            idbirraio=id_birraio;
    else 
        INSERT INTO IngredientiBirrai (idbirraio, idingrediente, quantita)
        VALUES (id_birraio, :new.idingrediente, :new.quantita);
    end if;
end;

--cancellazione birraio
create or replace trigger cancellazionebirraio
before delete on BIRRAI
for each ROW
declare
BEGIN
    delete from RICETTECONDIVISE where idbirraio=:new.idbirraio;
    update RICETTE
        set utilizzabile = 0
    where idbirraio=:new.idbirraio;
    update LOTTI
        set stato = 'archiviato'
    where IDBIRRAIO = :new.idbirraio;
    delete from INGREDIENTIBIRRAI where IDBIRRAIO=:new.idbirraio;
END;


--cancellazione ricette
create or replace trigger cancellazioneRicette
before update on RICETTE
for each ROW
declare
BEGIN
    if :new.utilizzabile = 0 THEN
        delete from RICETTECONDIVISE where IDRICETTA=:new.IDRICETTA;
    end if;
END;