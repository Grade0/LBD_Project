/**
*setta pronto=1 nel Ordininiclientilotti 
*quando viene aggiornato lo stato del lotto in vendita  
*/
CREATE OR REPLACE trigger updataLotto
after update on Lotti
for each row
begin
    if :new.stato = 'vendita' and to_date(:new.FINE_PRODUZIONE, 'dd/mm/yyyy') < to_date(SYSDATE, 'dd/mm/yyyy') then 
        update OrdiniClientiLotti
        set
            pronto=1
        where idlotto=:new.idlotto;
    else if :old.stato = 'produzione' and :new.stato = 'archiviato' then
            delete ordiniclientilotti where pronto=0 and idlotto=:new.idlotto;
        end if;
    end if;
end;

/

/**
*setta lo stato='spedito' del Ordiniclienti
*quando dopo un aggiornamento tutti i lotti di un ordine sono pronti
*/
create or replace trigger OrdineLottoPronto
after update on OrdiniClientiLotti
BEGIN
    for cur in (select idordine 
                from ordiniclienti oc 
                where stato='in preparazione' 
                and not exists (select * 
                                from ORDINICLIENTILOTTI ocl 
                                where oc.idordine=ocl.idordine and pronto=0))
    loop
        update OrdiniClienti
        set 
            stato='spedito'
        where idordine=cur.idordine;
    end loop;
END;
/
/**
*annulla o spedisce un ordinecliente
*quando un lotto viene cancellato
*se l'ordine non contiene piu' lotti allora e' annullato
*altrimenti verifica se altri lotti sono tutti pronti 
*    se lo sono allora stato='spedito'
*/
create or replace TRIGGER ORDINICLIENTILOTTI_ON_DELETE 
after DELETE ON ordiniclientilotti
declare
    lottiNum number;
    notProntiNum number;
    id_cur OrdiniClienti.idordine%type;
BEGIN
    for id_cur in (select idordine from Ordiniclienti where stato <> 'spedito')
    loop
        select count(*) into lottiNum from OrdiniClientiLotti where idordine=id_cur.idordine;
        if lottiNum < 1 then 
            update OrdiniClienti
            set stato = 'annullato'
            where idordine= id_cur.idordine;
        else 
            select count(*) into notProntiNum from OrdiniClientiLotti where idordine=id_cur.idordine and pronto=0;
            if notProntiNum < 1 then
                update OrdiniClienti
                set stato='spedito'
                where idordine = id_cur.idordine;
            end if;
        end if;
    end loop;
END;

/
/*
*se una ricetta viene cancellata
*elimina dalle ricettecondivise tutte le tuple interessate
*/
create or replace trigger cancellazioneRicette
before update on RICETTE
for each ROW
declare
BEGIN
    if :new.utilizzabile = 0 THEN
        delete from RICETTECONDIVISE where IDRICETTA=:new.IDRICETTA;
    end if;
END;
/

/*
*Verifica se gli ingredienti nel magazzino del birraio sono sufficienti per produrre un lotti id una certa quantita
*altrimenti lancia la eccezione 20001
*/
create or replace TRIGGER checkIngredienti
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
    /*
    EXCEPTION
    when IngredienteNonSufficienteExp then
        modGUI.INTESTAZIONE(TIPO  => 1, TESTO  => 'quantita ingredienti non sufficente in magazzino, impossibile procedere per la creazione del lotto. Per favore procedere per acquisto degli ingredienti necessari.');
    */
END;
/

/*
*se in ingrediente diventa inutilizzabile
*diventano inutilizzabili tutte le ricette che la contengono
*diventano archiviati tutti i lotti che la contengono
*cancellati dagli ordini che hanno i lotti che la contengono
*/
create or replace trigger ingredienteInutilizzabile
after update on Ingredienti
for each row
declare
    laricetta IngredientiRicette%Rowtype;
    lotto_cur lotti.idlotto%type;
    stato_cur OrdiniClienti.stato%type;
begin
    if :new.utilizzabile=0 then
        for laricetta in (
            select * from IngredientiRicette where idingrediente = :new.idingrediente
        )
        loop
            update Ricette
            set
                utilizzabile = 0
            where idricetta = laricetta.idricetta;

            update Lotti
            set 
                stato='archiviato'
            where idricetta = laricetta.idricetta;

            for lotto_cur in (select idlotto from lotti where idricetta=laricetta.idricetta)
            loop
                for stato_cur in (select oc.stato from OrdiniClienti oc, OrdiniClientiLotti ocl where oc.idordine=ocl.idordine and ocl.idlotto=lotto_cur.idlotto)
                loop
                    if stato_cur.stato <> 'spedito' then
                        delete from OrdiniClientiLotti where idlotto=lotto_cur.idlotto;
                    end if;
                end loop;
            end loop;
        end loop;
    end if;
end;
/
/*
*aggiorna il magazzino del birraio
*quando effettua un ordine di  ingredienti
*/
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
/

--diminuire i lotti in caso di ordine nuovo
create or replace trigger diminuisciLitriLotti
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
    /*
    Exception
    when LottoNonSufficenteExp then modGUI.INTESTAZIONE(TIPO  => 1, TESTO  => 'Ops, il lotto che hai selezionato lo hanno gia comprato altri, seleziona un altro!');
    */
end;