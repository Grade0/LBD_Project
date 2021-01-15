create or replace package body GruppoIngredienti as

--Inserimento di un ingrediente, effettuato dall'admin
procedure immettiIngrediente (idsessione in sessioni.idsessione%type) is
v_ruolo Utenti.ruolo%type;
v_id Utenti.idutente%type;
v_fornitore Fornitori.ragione_sociale%type;
begin
  modGUI.APRIPAGINA('Inserimento ingrediente',idsessione);
  --modGUI.CREAMENUBACKOFFICE(1);
  modGUI.INTESTAZIONE(1,'Inserimento ingrediente');
  --APRE UNA FORM VISUALE
  modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.checkIngrediente','form',idsessione);
  ---AGGIUNGE UNA TEXBOX DI TIPO 'CF'
  modGUI.CASELLADITESTO('pnome','Nome',suggerimento=>'Inserisci il nome', lunghezzaMAx=>'30', tipo=>'alfa', require=>true);
  
  modGUI.CASELLADITESTO('pprezzo_unitario','Prezzo unitario €',suggerimento=>'Inserisci prezzo unitario', lunghezzaMAx=>'5', tipo=>'number', require=>true);
  
  modGUI.AREADITESTO('pdescrizione','Descrizione', center=>true, lunghezzaMax=>'100', require=>true);
  
  modGUI.APRIBLOCCOSELECT('Utilizzabile',center=>true);
  modGUI.APRISELECT('putilizzabile',center=>true);
  modGUI.AGGIUNGIOPZIONESELECT('No', 'No');
  modGUI.AGGIUNGIOPZIONESELECT('Si', 'Si', true);
  modGUI.CHIUDISELECT;
  modGUI.CHIUDIBLOCCOSELECT;

  modGUI.APRIBLOCCOSELECT('Tipo',center=>true);
  modGUI.APRISELECT('ptipo',center=>true);
  modGUI.AGGIUNGIOPZIONESELECT('malto','Malto', true);
  modGUI.AGGIUNGIOPZIONESELECT('luppolo','Luppolo');
  modGUI.AGGIUNGIOPZIONESELECT('varie_kg','Varie kili');
  modGUI.AGGIUNGIOPZIONESELECT('varie_l','Varie litri');
  modGUI.AGGIUNGIOPZIONESELECT('varie_mg','Varie milligrammi');
  modGUI.CHIUDISELECT;
  modGUI.CHIUDIBLOCCOSELECT;
  
  v_ruolo := LOGIN.getRoleFromSession(idsessione);
  if (v_ruolo = 'fornitore') then
      v_id := LOGIN.getIdUtente(idsessione);
      select ragione_sociale into v_fornitore from Fornitori where idfornitore = v_id;
      modGUI.passaParametro('pfornitore', v_fornitore);
        
      modGUI.CHIUDISELECT;
      modGUI.CHIUDIBLOCCOSELECT;
    
  else 
      modGUI.APRIBLOCCOSELECT('Fornitore',center=>true);
      modGUI.APRISELECT('pfornitore',center=>true);
      
      for v_record in (select ragione_sociale from Fornitori) LOOP  
      modGUI.AGGIUNGIOPZIONESELECT(v_record.ragione_sociale, v_record.ragione_sociale);
      end loop;
        
      modGUI.CHIUDISELECT;
      modGUI.CHIUDIBLOCCOSELECT;
  
  end if;
  
 --VA A CAPO
  modGUI.RITCARRELLO;
  ---APRE UN BLOCCO ANONIMO PER ALLINEARE IL BOTTONE CON GLI ALTRI CAMPI
  modGUI.APRIBLOCCO; 
  modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'immettiIngredienti');
  modGUI.CHIUDIBLOCCO;
  modGUI.CHIUDIFORM;
  modGUI.CHIUDIPAGINA;
end immettiIngrediente;


procedure checkIngrediente
(
    idsessione in sessioni.idsessione%type,
    pnome in Ingredienti.nome%type,
    pdescrizione in Ingredienti.descrizione%type,
    pprezzo_unitario in Ingredienti.prezzo_unitario%type,
    putilizzabile varchar2,
    ptipo in tipi.nome%type,
    pfornitore in Fornitori.ragione_sociale%type
) 
is 
    exist number;
    pidtipo Tipi.idtipo%type;
    putil Ingredienti.utilizzabile%type;
    pfor Fornitori.ragione_sociale%type;
begin

    if (putilizzabile = 'No') then putil := 0;
    else putil := 1;
    end if;
    
    select idfornitore into pfor from Fornitori where upper(pfornitore) = upper(Fornitori.ragione_sociale);
    if (ptipo = 'varie_kg') then
        select idtipo into pidtipo from Tipi where nome = 'varie' AND unita_di_misura = 'kg';
    elsif (ptipo = 'varie_mg') then
        select idtipo into pidtipo from Tipi where nome = 'varie' AND unita_di_misura = 'mg';
    elsif (ptipo = 'varie_l') then
        select idtipo into pidtipo from Tipi where nome = 'varie' AND unita_di_misura = 'l';
    else 
        select idtipo into pidtipo from Tipi where upper(ptipo) = upper(tipi.nome);
    end if;
    
    select count(*) into exist from Ingredienti where upper(pnome) = upper(Ingredienti.nome);
    
    if(exist >= 1) then modGUI.PaginaFeedback('ERRORE', 'Ingrediente già esistente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.immettiIngrediente', idsessione);
    else
        INSERT INTO Ingredienti (idingrediente, nome, descrizione, prezzo_unitario, utilizzabile, idtipo, idfornitore)
        VALUES(IDINGREDIENTI_SEQ.nextval, pnome, pdescrizione, pprezzo_unitario, putil, pidtipo, pfor);
        modGUI.PaginaFeedback('SUCCESSO', 'Ingrediente inserito', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.immettiIngrediente', idsessione);
        modGUI.CHIUDIPAGINA;
        
    end if;
end checkIngrediente;

procedure visualizzaIngredienti(idSessione in sessioni.idsessione%type, v_idRicetta ricette.idricetta%type) is
            p_istruzioni varchar2(500);
            trovato int;
            v_nome Ricette.nome%type;
        begin
        select nome into v_nome from Ricette where idricetta = v_idricetta;
        modGUI.APRIPAGINA('Visualizza ricetta',idSessione);
        modGUI.INTESTAZIONE(1,'Visualizza ricetta: ' || v_nome);
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome Ingrediente');
        modGUI.IntestazioneTabella('Disponibile');
        modGUI.IntestazioneTabella('Quantita');
        modGUI.IntestazioneTabella('Dettagli');
        modGUI.ChiudiRigaTabella;
        trovato := 0;
        for v_record in
        (SELECT INGREDIENTIRICETTE.IDRICETTA,INGREDIENTIRICETTE.IDINGREDIENTE, QUANTITA, INGREDIENTI.UTILIZZABILE, INGREDIENTI.NOME FROM INGREDIENTIRICETTE, INGREDIENTI
        WHERE v_idRicetta = INGREDIENTIRICETTE.IDRICETTA AND INGREDIENTIRICETTE.IDINGREDIENTE = INGREDIENTI.IDINGREDIENTE)
        LOOP
        trovato :=1;
        modGUI.ApriRigaTabella;
            modGUI.ElementoTabella(v_record.nome);
            if(v_record.utilizzabile=1) then
                modGUI.ElementoTabella('Si');
            else
                modGUI.ElementoTabella('No');
            end if;
            modGUI.ElementoTabella(to_char(v_record.QUANTITA));
            MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.infoIngrediente?idSessione=' || to_char(idsessione) || '&v_nome=' || to_char(v_record.nome), idsessione);
            MODGUI.bottoneInfo;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('v_nome', to_char(v_record.nome));
            modGUI.ChiudiFormHidden;
        modGUI.ChiudiRigaTabella;
        end loop;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end visualizzaIngredienti;




procedure infoIngrediente(idSessione sessioni.idsessione%type, v_nome Ingredienti.nome%type) is 
    v_record Ingredienti%rowtype;
    v_fornitore Fornitori.ragione_sociale%type;
    v_tipo Tipi.nome%type;
    v_unita_di_misura Tipi.unita_di_misura%type;
begin
    modGUI.APRIPAGINA('Informazioni ingrediente',idSessione);
    modGUI.INTESTAZIONE(1,'Informazioni ingrediente');          
    select * into v_record from Ingredienti where Ingredienti.nome = v_nome;
    
    select ragione_sociale into v_fornitore from Fornitori, Ingredienti 
    where Ingredienti.nome = v_nome AND Ingredienti.idfornitore = Fornitori.idfornitore;
    
    select Tipi.nome, Tipi.unita_di_misura into v_tipo, v_unita_di_misura from Tipi, Ingredienti
    where Tipi.idtipo = Ingredienti.idtipo AND Ingredienti.nome = v_nome;
    
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome Ingrediente');
    modGUI.IntestazioneTabella('Prezzo unitario');
    modGUI.IntestazioneTabella('Utilizzabile');
    modGUI.IntestazioneTabella('Tipo');
    modGUI.IntestazioneTabella('Unità di misura');
    modGUI.IntestazioneTabella('Fornitore');
    if (v_record.utilizzabile = 1) then
        modGUI.IntestazioneTabella('Carrello');
    end if;
    modGUI.IntestazioneTabella('Dettagli Fornitore');
    modGUI.ChiudiRigaTabella;
    
    modGUI.ApriRigaTabella;
    modGUI.ElementoTabella(v_record.Nome);
    modGUI.ElementoTabella(v_record.Prezzo_unitario || '€');
    if(v_record.utilizzabile=1) then
        modGUI.ElementoTabella('Si');
    else
        modGUI.ElementoTabella('No');
    end if;
    modGUI.ElementoTabella(v_tipo);
    if (v_unita_di_misura = 'kg') then
        modGUI.ElementoTabella('Kilogrammi');
    elsif (v_unita_di_misura = 'l') then
        modGUI.ElementoTabella('Litri');
    else
        modGUI.ElementoTabella('Milligrammi');
    end if;
    modGUI.ElementoTabella(v_fornitore);
    if (v_record.utilizzabile = 1) then
        modGUI.ApriElementoTabella;

        htp.print('<form name="info"  action="'|| Costanti.server || Costanti.root || 
        'GruppoIngredienti.acquistoIngredienti" method="GET" >');  
        modGUI.PassaParametro('idSessione', to_char(idSessione));

        --modGUI.apriForm(Costanti.server || Costanti.root || 'GruppoIngredienti.acquistoIngredienti', 'acquistoIngrediente', idSessione);
        --modGUI.CASELLADITESTO('v_quantita', '', suggerimento=>'Quantità', tipo=>'number', LunghezzaMax=>3, require=>true);
        htp.print('<input style="width: 100px" class="number required form-control" name="v_quantita" placeholder="Quantità"  maxlength="3">');
        modGUI.PassaParametro('v_idingrediente', v_record.idingrediente);
        modGUI.bottoneform(valida => true, nomeForm => 'info', testo => '', classe => 'cart');
        htp.formClose;

        /*MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
        'GruppoIngredienti.acquistoIngredienti?idSessione=' || to_char(idsessione) ||
        '&v_idingrediente=' || to_char(v_record.idingrediente), idsessione); 
        MODGUI.bottoneCart;
        modGUI.CASELLADITESTO('v_quantita', '', suggerimento=>'Quantità', tipo=>'number', LunghezzaMax=>3,require=>true);
        modGUI.PassaParametro('v_idingrediente', v_record.idingrediente);
        modgui.ChiudiFormHidden;*/
        modGUI.ChiudiElementoTabella;
    end if;
    MODGUI.ApriElementoTabella;
    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.visualizzaFornitore?idSessione=' || to_char(idsessione) || '&v_ragione_sociale=' || v_fornitore, idsessione);
    MODGUI.bottoneInfo;
    modGUI.PassaParametro('v_ragione_sociale', v_fornitore);
    modGUI.ChiudiFormHidden;
    modGUI.ChiudiElementoTabella;
    modGUI.ChiudiTabella;
    modGUI.INTESTAZIONE(2,'Descrizione'); 
    modGUI.ApriTabella;
    modGUI.ElementoTabella(v_record.Descrizione);
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end infoIngrediente;


procedure visualizzaCostoLotti (
idsessione in sessioni.idsessione%type
) is
    somma1 number;
    somma2 number;
    quantita number;
    v_idbirraio birrai.idbirraio%type;
    i number;
    media number;
    esiste number;
begin
    --v_uname := LOGIN.getUnameFromSession(idSessione);
    v_idbirraio := LOGIN.getIdutente(idsessione);
    --modgui.StringaDiTesto(v_Uname || to_char(v_idbirraio));
    modGUI.APRIPAGINA('Visualizza costo lotti',idSessione);
    i := 0;
    somma2 := 0;
    select count(*) into esiste from Birrai, Lotti where Birrai.idbirraio = v_idbirraio;
    if (esiste >= 1) then
        modGUI.INTESTAZIONE(1,'Visualizza costo lotti');
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Codice');
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Costo');
        modGUI.ChiudiRigaTabella;
    
        for v_record in
        (select L.idlotto as Codice, L.nome as Nome, sum(I.prezzo_unitario*IR.quantita) as Costo
        from Lotti L, Ricette R, IngredientiRicette IR, Ingredienti I 
        where L.idricetta = R.idricetta AND R.idricetta = IR.idricetta AND IR.idingrediente = I.idingrediente 
        AND L.stato = 'archiviato' AND L.idbirraio = v_idbirraio
        group by L.idlotto, L.nome
        order by L.idlotto)
        LOOP
            modGUI.ApriRigaTabella;
            modGUI.ElementoTabella(v_record.Codice);
            modGUI.ElementoTabella(v_record.Nome);
            modGUI.ElementoTabella(v_record.Costo || '€');
            modGUI.ChiudiRigaTabella;
            somma2 := somma2+v_record.costo;
            i := i+1;
        end loop;
        modGUI.ChiudiTabella;
        if (i > 0) then media := somma2/i;
        else media := 0;
        end if;
        modGUI.RITCARRELLO;
        modGUI.INTESTAZIONE(2,'La media è: ' || media || '€');
    else 
        modGUI.INTESTAZIONE(2,'Non hai lotti archiviati');
    end if;
    modGUI.CHIUDIPAGINA;
end visualizzaCostoLotti;

procedure ricercaIngredienti (idsessione in sessioni.idsessione%type) 
is
begin
 modGUI.APRIPAGINA('Ricerca ingrediente',idsessione);
  --modGUI.CREAMENUBACKOFFICE(1);
  modGUI.INTESTAZIONE(1,'Ricerca ingrediente');
  --APRE UNA FORM VISUALE
  modGUI.APRIFORM(Costanti.root || 'GruppoIngredienti.checkRicercaIngredienti','form',idsessione);
  ---AGGIUNGE UNA TEXBOX DI TIPO 'CF'
  modGUI.CASELLADITESTO('pnome','Nome',suggerimento=>'Inserisci il nome', lunghezzaMAx=>'30', tipo=>'Alfa', require=>false);

  
  modGUI.CASELLADITESTO('prezzo_minimo','Prezzo minimo €',suggerimento=>'Inserisci il prezzo minimo', lunghezzaMAx=>'5', tipo=>'number', require=>true, testo=>0);
  modGUI.CASELLADITESTO('prezzo_massimo','Prezzo massimo €',suggerimento=>'Inserisci il prezzo massimo', lunghezzaMAx=>'5', tipo=>'number', require=>true, testo=>10000);
  
  modGUI.APRIBLOCCOSELECT('Utilizzabile',center=>true);
  modGUI.APRISELECT('putilizzabile',center=>true);
  modGUI.AGGIUNGIOPZIONESELECT('Null','Null', true);
  modGUI.AGGIUNGIOPZIONESELECT('Si','Si');
  modGUI.AGGIUNGIOPZIONESELECT('No','No');
  modGUI.CHIUDISELECT;
  modGUI.CHIUDIBLOCCOSELECT;
  
    modGUI.APRIBLOCCO('Seleziona il tipo');
    htp.formSelectOpen('vetTipo',
    cattributes => 'multiple');
    htp.formSelectOption('malto');
    htp.formSelectOption('luppolo');
    htp.formSelectOption('varie');
    --htp.formSelectOption('Varie_kg');
    --htp.formSelectOption('Varie_l');
    --htp.formSelectOption('Varie_mg');
    htp.formSelectClose;
    modGUI.CHIUDIBLOCCO;
  
    modGUI.RITCARRELLO;
  	
    modGUI.APRIBLOCCO ('Seleziona il fornitore');
    htp.formSelectOpen('vetFornitore',
    cattributes => 'multiple');
    for v_record in (select ragione_sociale from Fornitori) LOOP  
        modGUI.AGGIUNGIOPZIONESELECT(v_record.ragione_sociale, v_record.ragione_sociale);
    end loop;
    htp.formSelectClose;
    modGUI.CHIUDIBLOCCO;

  modGUI.APRIBLOCCO; 
  modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'ricercaIngredienti');
  modGUI.CHIUDIBLOCCO;
  modGUI.CHIUDIFORM;
  modGUI.CHIUDIPAGINA;
end ricercaIngredienti;

procedure checkRicercaIngredienti (
idsessione in sessioni.idsessione%type,
pnome in Ingredienti.nome%type,
prezzo_minimo in number,
prezzo_massimo in number,
putilizzabile in varchar2,
vetFornitore in tabellaFornitore DEFAULT tabellaFornitoreVuota,
vetTipo in tabellaTipo DEFAULT tabellaTipoVuota
) is
    putil Ingredienti.utilizzabile%type;
    i Fornitori.ragione_sociale%type;
    j Tipi.nome%type;
    trovato number;
    k number;
    pippo number;
    var number;
begin 
  k:=0;
  pippo:=0;
  trovato:=1;
  var := 0;
  if (prezzo_minimo > prezzo_massimo) then 
    pippo:= 1; 
    modGUI.PaginaFeedback('ERRORE', 'Immettere parametri corretti', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.ricercaIngredienti', idsessione);
  else 
      if (putilizzabile = 'Si') then putil :=1;
      elsif (putilizzabile = 'No') then putil :=0;
      end if;
      
      modGUI.APRIPAGINA('Ingredienti dei fornitori',idsessione); 
      modGUI.INTESTAZIONE(1,'Ingredienti dei fornitori:');
      i:=vetFornitore.first;
      j:=vetTipo.first;
      
      if (j is null) then trovato := 0; end if;
      while (j is not null)
      loop
          insert into tipi_temp values(vetTipo(j));
          j:=vetTipo.next(j);
      end loop;
      
      
      --Caso in cui nessun fornitore è stato selezionato
      if (i is null) then
        for record_f in (select ragione_sociale from Fornitori) 
        LOOP
        --Caso in cui nessun fornitore è stato selezionato e utilizzabile segnato a 'null'
        if (putilizzabile = 'Null') then
            --Caso in cui nessun fornitore è stato selezionato e utilizzabile segnato a 'null' e nessun tipo è stato selezionato
            if (trovato = 0) then
                   for v_record in 
                   (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile, 
                   T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                   from Ingredienti, Tipi T, Fornitori F
                   where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                   AND F.ragione_sociale = record_f.ragione_sociale AND 
                   Ingredienti.idfornitore = F.idfornitore AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                   order by Ingredienti.utilizzabile desc)
                   LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, record_f.ragione_sociale, k, pippo);
                   end loop;
                   k:=0;
             --Caso in cui nessun fornitore è stato selezionato e utilizzabile segnato a 'null' e qualche tipo è stato selezionato
            else
                for v_record in 
                   (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile, 
                   T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                   from Ingredienti, Tipi T, Fornitori F
                   where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                   AND F.ragione_sociale = record_f.ragione_sociale AND Ingredienti.idfornitore = F.idfornitore AND 
                   (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                   AND upper(T.nome) IN (select upper(nome) from Tipi_temp)
                   order by Ingredienti.utilizzabile desc)
                   LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, record_f.ragione_sociale, k, pippo);
                   end loop;
               k:=0;
            end if;
            --tutto ok
        else 
            --Caso in cui nessun fornitore è stato selezionato e utilizzabile segnato a qualcosa e nessun tipo è stato selezionato
            if (trovato = 0) then
                for v_record in 
                       (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile,
                       T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo
                       from Ingredienti, Tipi T, Fornitori F
                       where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                       AND F.ragione_sociale = record_f.ragione_sociale AND 
                       Ingredienti.idfornitore = F.idfornitore AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                       AND Ingredienti.utilizzabile = putil
                       order by Ingredienti.utilizzabile desc)
                       LOOP
                            GruppoIngredienti.appoggio(idsessione, v_record, record_f.ragione_sociale, k, pippo);
                       end loop;
                       k:=0;
            --Caso in cui nessun fornitore è stato selezionato e utilizzabile segnato a qualcosa e qualche tipo è stato selezionato
            else 
                for v_record in 
                    (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile,
                    T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo
                    from Ingredienti, Tipi T, Fornitori F
                    where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                    AND F.ragione_sociale = record_f.ragione_sociale AND Ingredienti.idfornitore = F.idfornitore AND 
                    Ingredienti.utilizzabile = putil AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                    AND upper(T.nome) IN (select upper(nome) from Tipi_temp)
                    AND Ingredienti.utilizzabile = putil
                    order by Ingredienti.utilizzabile desc)
                    LOOP
                        GruppoIngredienti.appoggio(idsessione, v_record, record_f.ragione_sociale, k, pippo);
                   end loop;
                   k:=0;
            end if;
        end if;
        modGUI.ChiudiTabella;
        end loop;
      end if;
      --tutto ok
      --Caso in cui qualche fornitore è stato selezionato
      while (i is not null)
      loop
       --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a 'null'
       if (putilizzabile = 'Null') then
            --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a 'null' e nessun tipo è stato selezionato
            if (trovato = 0) then
                for v_record in 
                    (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile, 
                    T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                    from Ingredienti, Tipi T, Fornitori F
                    where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                    AND F.ragione_sociale = vetFornitore(i) AND Ingredienti.idfornitore = F.idfornitore AND 
                    (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                    order by Ingredienti.utilizzabile desc)
                    LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, vetFornitore(i), k, pippo);
                   end loop;
                   k:=0;
            --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a 'null' e qualche tipo è stato selezionato
            else
                for v_record in 
                    (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile, 
                    T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                    from Ingredienti, Tipi T, Fornitori F
                    where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                    AND F.ragione_sociale = vetFornitore(i) AND Ingredienti.idfornitore = F.idfornitore
                    AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                    AND upper(T.nome) IN (select upper(nome) from Tipi_temp)
                    order by Ingredienti.utilizzabile desc)
                    LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, vetFornitore(i), k, pippo);
                   end loop;
                   k:=0;
           end if;
        --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a qualcosa 
        else 
            --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a qualcosa e nessun tipo è stato selezionato
            if (trovato = 0) then
                for v_record in 
                    (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile,
                    T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                    from Ingredienti, Tipi T, Fornitori F
                    where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                    AND F.ragione_sociale = vetFornitore(i) AND Ingredienti.idfornitore = F.idfornitore AND 
                    Ingredienti.utilizzabile = putil AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                    order by Ingredienti.utilizzabile desc)
                    LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, vetFornitore(i), k, pippo);
                   end loop;
                   k:=0;
            --Caso in cui qualche fornitore è stato selezionato ed utilizzabile è segnato a qualcosa e qualche tipo è stato selezionato
            else
                for v_record in 
                    (select Ingredienti.idingrediente as idin, Ingredienti.nome as Nome, Ingredienti.utilizzabile as Utilizzabile,
                    T.nome as Tipo, Ingredienti.prezzo_unitario as Prezzo 
                    from Ingredienti, Tipi T, Fornitori F
                    where Ingredienti.idtipo = T.idtipo AND (Ingredienti.prezzo_unitario between prezzo_minimo and prezzo_massimo)
                    AND F.ragione_sociale = vetFornitore(i) AND Ingredienti.idfornitore = F.idfornitore AND 
                    Ingredienti.utilizzabile = putil AND (upper(ingredienti.nome) LIKE '%'||upper(pnome)||'%')
                    AND upper(T.nome) IN (select upper(nome) from Tipi_temp)
                    order by Ingredienti.utilizzabile desc)
                    LOOP
                       GruppoIngredienti.appoggio(idsessione, v_record, vetFornitore(i), k, pippo);
                   end loop;
                   k:=0;
           end if;
        end if;
        modGUI.ChiudiTabella;
        i:=vetFornitore.next(i);
    end loop;
    end if;
    delete from tipi_temp;
    if (pippo = 0) then
        modGUI.INTESTAZIONE(2, 'non ci sono ingredienti con le caratteristiche specificate');
    end if;
    modGUI.CHIUDIPAGINA; 
end checkRicercaIngredienti;

procedure varietaFornitori (
    idsessione in sessioni.idsessione%type) is
    begin
    modGUI.APRIPAGINA('Fornitori con maggior varietà di ingredienti',idsessione); 
    modGUI.INTESTAZIONE(1,'Fornitori con maggior varietà di ingredienti:');
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Ragione sociale');
    modGUI.IntestazioneTabella('Quantità ingredienti distinti');
    modGUI.IntestazioneTabella('Dettagli fornitore');
    modGUI.ChiudiRigaTabella;
    for v_record in 
    (select Fornitori.ragione_sociale as ragione_sociale, count(*) as quantita
    from Fornitori, Ingredienti 
    where Fornitori.idfornitore = Ingredienti.idfornitore 
    group by Fornitori.idfornitore, Fornitori.nome, Fornitori.cognome, Fornitori.telefono, Fornitori.indirizzo, Fornitori.ragione_sociale
    order by count(*) desc)
    LOOP
        modGUI.ApriRigaTabella;
        modGUI.ElementoTabella(v_record.ragione_sociale);
        modGUI.ElementoTabella(v_record.quantita);
        MODGUI.ApriElementoTabella;
    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.visualizzaFornitore?idsessione=' || to_char(idsessione) || 'v_ragione_sociale=' || to_char(v_record.ragione_sociale), idsessione);
    	MODGUI.bottoneInfo;
    	modGUI.PassaParametro('v_ragione_sociale', to_char(v_record.ragione_sociale));
    	modGUI.ChiudiFormHidden;
        modGUI.ChiudiRigaTabella;
    end loop;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end varietaFornitori;

procedure visualizzaIngredientiFornitore (
idsessione in sessioni.idsessione%type,
v_ragione_sociale in Fornitori.ragione_sociale%type) is
    esiste number;
begin

    modGUI.APRIPAGINA('Ingredienti fornitore',idsessione); 
    modGUI.INTESTAZIONE(1,'Ingredienti fornitore: ' || to_char(v_ragione_sociale));
    select count(*) into esiste from Fornitori F, Ingredienti ING 
    where ING.idfornitore = F.idfornitore AND F.ragione_sociale = v_ragione_sociale;
    if (esiste >= 1) then
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Prezzo');
        modGUI.IntestazioneTabella('Tipo');
        modGUI.IntestazioneTabella('Carrello');
        modGUI.IntestazioneTabella('Dettagli');
        modGUI.ChiudiRigaTabella;
        for v_record in 
        (select Ingredienti.nome as Nome, Ingredienti.idingrediente as idin,
        Ingredienti.prezzo_unitario as Prezzo, Tipi.nome as Tipo, Ingredienti.utilizzabile as utilizzabile
        From Ingredienti, Fornitori, Tipi
        where Fornitori.idfornitore = Ingredienti.idfornitore AND Ingredienti.idtipo = Tipi.idtipo AND Fornitori.ragione_sociale = v_ragione_sociale
        Order by Ingredienti.utilizzabile desc, Ingredienti.Prezzo_unitario desc)
        LOOP
            modGUI.ApriRigaTabella;
            modGUI.ElementoTabella(v_record.Nome);
            modGUI.ElementoTabella(v_record.Prezzo || '€');
            modGUI.ElementoTabella(v_record.Tipo);
            if (v_record.utilizzabile = 1) then
                modGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
                'GruppoIngredienti.acquistoIngredienti?idSessione=' || to_char(idsessione) ||
                '&v_idingrediente=' || to_char(v_record.idin), idsessione); 
                MODGUI.bottoneCart;
                modGUI.CASELLADITESTO('v_quantita', '', suggerimento=>'Quantità', tipo=>'number', LunghezzaMax=>3,require=>true);
                modGUI.PassaParametro('v_idingrediente', v_record.idin);
                modgui.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
            else 
                modGUI.ElementoTabella('');
            end if;
            MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.infoIngrediente?idsessione=' || to_char(idsessione) || 'v_nome=' || to_char(v_record.Nome), idsessione);
            MODGUI.bottoneInfo;
            /* eventuale parametro da passare */
            modGUI.PassaParametro('v_nome', to_char(v_record.Nome));
            modGUI.ChiudiFormHidden;
            modGUI.ChiudiElementoTabella;
            modGUI.ChiudiRigaTabella;
        end loop;
    else
        modGUI.INTESTAZIONE(2,'Il fornitore ' || v_ragione_sociale || ' non ha ingredienti esposti');
    end if;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end visualizzaIngredientiFornitore;

procedure IngredientiPiuVenduti (idsessione in Sessioni.idsessione%type) is
begin
    modGUI.APRIPAGINA('Ingredienti più venduti',idsessione); 
    modGUI.INTESTAZIONE(1,'Ingredienti più venduti: ');
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Tipo');
    modGUI.IntestazioneTabella('Fornitore');
    modGUI.IntestazioneTabella('Vendite');
    modGUI.IntestazioneTabella('Dettagli Ingrediente');
    modGUI.IntestazioneTabella('Dettagli Fornitore');
    modGUI.ChiudiRigaTabella;
    for v_record in 
    (select Ingredienti.Nome as Nome, 
    Tipi.nome as Tipo, Fornitori.ragione_sociale as Fornitore, sum(rifornimenti.quantita) as Vendite
    from Ingredienti, Rifornimenti, Tipi, Fornitori
    where Ingredienti.idingrediente = Rifornimenti.idingrediente AND Ingredienti.idtipo = Tipi.idtipo
    AND Ingredienti.idfornitore = Fornitori.idfornitore
    group by Ingredienti.Nome, Ingredienti.Utilizzabile, Tipi.nome, Fornitori.ragione_sociale
    order by sum(Rifornimenti.quantita) desc, Ingredienti.nome asc)
    LOOP
        modGUI.ApriRigaTabella;
        modGUI.ElementoTabella(v_record.Nome);
        modGUI.ElementoTabella(v_record.Tipo);
        modGUI.ElementoTabella(v_record.Fornitore);
        modGUI.ElementoTabella(v_record.Vendite);
        MODGUI.ApriElementoTabella;
    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.infoIngrediente?idsessione=' || to_char(idsessione) || 'v_nome=' || to_char(v_record.Nome), idsessione);
    	MODGUI.bottoneInfo;
    	modGUI.PassaParametro('v_nome', to_char(v_record.Nome));
    	modGUI.ChiudiFormHidden;
        MODGUI.ApriElementoTabella;
    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.visualizzaFornitore?idsessione=' || to_char(idsessione) || 'v_nome=' || to_char(v_record.Fornitore), idsessione);
    	MODGUI.bottoneInfo;
    	modGUI.PassaParametro('v_ragione_sociale', to_char(v_record.Fornitore));
    	modGUI.ChiudiFormHidden;
        modGUI.ChiudiRigaTabella;
    end loop;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end IngredientiPiuVenduti;

procedure visualizzaFornitore (idsessione in Sessioni.idsessione%type, 
v_ragione_sociale in Fornitori.ragione_sociale%type) is
begin
    modGUI.APRIPAGINA('Dati Fornitore',idsessione); 
    modGUI.INTESTAZIONE(1,'Dati Fornitore: ' || v_ragione_sociale);
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Cognome');
    modGUI.IntestazioneTabella('Telefono');
    modGUI.IntestazioneTabella('Indirizzo');
    modGUI.IntestazioneTabella('Ingredienti esposti');
    modGUI.ChiudiRigaTabella;
    for v_record in (select Fornitori.nome, Fornitori.cognome, Fornitori.Telefono, Fornitori.Indirizzo
    from Fornitori
    where Fornitori.ragione_sociale = v_ragione_sociale)
    LOOP
        modGUI.ElementoTabella(v_record.Nome);
        modGUI.ElementoTabella(v_record.Cognome);
        modGUI.ElementoTabella(v_record.Telefono);
        modGUI.ElementoTabella(v_record.Indirizzo);
        MODGUI.ApriElementoTabella;
    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.visualizzaIngredientiFornitore?idsessione=' || to_char(idsessione) || 'v_ragione_sociale=' || to_char(v_ragione_sociale), idsessione);
    	MODGUI.bottoneInfo;
    	modGUI.PassaParametro('v_ragione_sociale', v_ragione_sociale);
    	modGUI.ChiudiFormHidden;
    end loop;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end visualizzaFornitore;

procedure visualizzaDatiAnagrafici (idsessione in Sessioni.idsessione%type)
is
    v_idfornitore Fornitori.idfornitore%type;
    v_ragione_sociale Fornitori.ragione_sociale%type;
    v_record Fornitori%rowtype;
begin
    v_idfornitore := LOGIN.getIdUtente(idsessione);
    select ragione_sociale into v_ragione_sociale from Fornitori where idfornitore = v_idfornitore;
    modGUI.APRIPAGINA('Dati Fornitore',idsessione); 
    modGUI.INTESTAZIONE(1,'I tuoi dati');
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Cognome');
    modGUI.IntestazioneTabella('Telefono');
    modGUI.IntestazioneTabella('Indirizzo');
    modGUI.IntestazioneTabella('Ingredienti esposti');
    modGUI.IntestazioneTabella('Modifica dati profilo');
    modGUI.ChiudiRigaTabella;
    select * into v_record from Fornitori where Fornitori.ragione_sociale = v_ragione_sociale;
    modGUI.ElementoTabella(v_record.Nome);
    modGUI.ElementoTabella(v_record.Cognome);
    modGUI.ElementoTabella(v_record.Telefono);
    modGUI.ElementoTabella(v_record.Indirizzo);
    MODGUI.ApriElementoTabella;
    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.visualizzaIngredientiEsposti?idsessione=' || to_char(idsessione), idsessione);
    MODGUI.bottoneInfo;
    modGUI.ChiudiFormHidden;
    MODGUI.ChiudiElementoTabella;
    MODGUI.ApriElementoTabella;
    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.modificaDatiFornitore?idsessione=' || to_char(idsessione), idsessione);
    MODGUI.bottoneEdit;
    modGUI.ChiudiFormHidden;
    MODGUI.ChiudiElementoTabella;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end visualizzaDatiAnagrafici;

procedure visualizzaLotti (idsessione in Sessioni.idsessione%type) is
begin
    modGUI.APRIPAGINA('Visualizza Lotti',1); 
    modGUI.INTESTAZIONE(1,'Visualizza Lotti');
    modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.checkVisualizzaLotti','form',idsessione);
  	modGUI.apriblocco('Seleziona gli ingredienti');
      htp.formSelectOpen('vetingredienti', cattributes => 'multiple');
      for v_record in (select Ingredienti.nome from Ingredienti) LOOP  
      modGUI.AGGIUNGIOPZIONESELECT(v_record.nome, v_record.nome);
      end loop;
      htp.formSelectClose;
    modGUI.chiudiblocco;
    modGUI.RITCARRELLO;
     modGUI.APRIBLOCCO; 
      modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'VisualizzaLotti');
      modGUI.CHIUDIBLOCCO;
      modGUI.CHIUDIFORM;
    modGUI.CHIUDIPAGINA; 
end visualizzaLotti;

procedure checkVisualizzaLotti (idsessione in sessioni.idsessione%type, vetingredienti tabellaIngrediente default tabellaIngredienteVuota)is
    i Ingredienti.nome%type;
    k number;
    var number;
begin
    k:=0;
    var := 0;
    modGUI.APRIPAGINA('Lotti con ingredienti specificati',idsessione); 
    modGUI.INTESTAZIONE(1,'Lotti con ingredienti specificati'); 
    i := vetingredienti.first;
    if (i is null)then
    for v_ingredienti in (select nome from Ingredienti)
    loop
        for v_record in 
           (select Lotti.Nome, Lotti.Descrizione, Lotti.Inizio_produzione, Lotti.fine_produzione, 
           Lotti.Scadenza, Lotti.Pubblicazione, 
           Lotti.Prezzo_al_litro, Lotti.Litri_residui, Lotti.Stato, Lotti.litri_prodotti
           from Lotti, Ingredienti, Ricette, IngredientiRicette
           where Lotti.idricetta = Ricette.idricetta AND 
           Ricette.idricetta = IngredientiRicette.idricetta AND 
           IngredientiRicette.idingrediente = Ingredienti.idingrediente AND Ingredienti.nome = v_ingredienti.nome)
           LOOP
               if (k = 0) then 
                    modGUI.INTESTAZIONE(2, v_ingredienti.nome); 
                    modGUI.ApriTabella;
                    modGUI.APRIRIGATABELLA;
                    modGUI.IntestazioneTabella('Nome');
                    modGUI.IntestazioneTabella('Descrizione');
                    modGUI.IntestazioneTabella('Inizio produzione');
                    modGUI.IntestazioneTabella('Fine produzione');
                    modGUI.IntestazioneTabella('Scadenza');
                    modGUI.IntestazioneTabella('Pubblicazione');
                    modGUI.IntestazioneTabella('Litri Prodotti');
                    modGUI.IntestazioneTabella('Prezzo al litro');
                    modGUI.IntestazioneTabella('Litri residui');
                    modGUI.IntestazioneTabella('Stato');
                    modGUI.ChiudiRigaTabella;
                    k:=1;
                    var := 1;
                end if;
               modGUI.ApriRigaTabella;
               modGUI.ElementoTabella(v_record.Nome);
               modGUI.ElementoTabella(v_record.descrizione);
               modGUI.ElementoTabella(v_record.Inizio_produzione);
               modGUI.ElementoTabella(v_record.Fine_produzione);
               modGUI.ElementoTabella(v_record.Scadenza);
               modGUI.ElementoTabella(v_record.Pubblicazione);
               modGUI.ElementoTabella(v_record.Litri_prodotti);
               modGUI.ElementoTabella(v_record.Prezzo_al_litro || '€');
               modGUI.ElementoTabella(v_record.Litri_residui);
               modGUI.ElementoTabella(v_record.Stato);
               modGUI.ChiudiRigaTabella;
           end loop;
           k:=0;
           modGUI.chiudiTabella();
        end loop;
    end if;
    while (i is not null) loop
        for v_record in 
           (select Lotti.Nome, Lotti.Descrizione, Lotti.Inizio_produzione, Lotti.fine_produzione, 
           Lotti.Scadenza, Lotti.Pubblicazione, Lotti.Litri_prodotti,
           Lotti.Prezzo_al_litro, Lotti.Litri_residui, Lotti.Stato
           from Lotti, Ingredienti, Ricette, IngredientiRicette
           where Lotti.idricetta = Ricette.idricetta AND 
           Ricette.idricetta = IngredientiRicette.idricetta AND 
           IngredientiRicette.idingrediente = Ingredienti.idingrediente AND 
           Ingredienti.nome = vetingredienti(i))
           LOOP
                if (k = 0) then
                    modGUI.INTESTAZIONE(2, vetingredienti(i)); 
                    modGUI.ApriTabella;
                    modGUI.APRIRIGATABELLA;
                    modGUI.IntestazioneTabella('Nome');
                    modGUI.IntestazioneTabella('Descrizione');
                    modGUI.IntestazioneTabella('Inizio produzione');
                    modGUI.IntestazioneTabella('Fine produzione');
                    modGUI.IntestazioneTabella('Scadenza');
                    modGUI.IntestazioneTabella('Pubblicazione');
                    modGUI.IntestazioneTabella('Litri Prodotti');
                    modGUI.IntestazioneTabella('Prezzo al litro');
                    modGUI.IntestazioneTabella('Litri residui');
                    modGUI.IntestazioneTabella('Stato');
                    modGUI.ChiudiRigaTabella;
                    k := 1;
                    var := 1;
                end if;
               modGUI.ApriRigaTabella;
               modGUI.ElementoTabella(v_record.Nome);
               modGUI.ElementoTabella(v_record.descrizione);
               modGUI.ElementoTabella(v_record.Inizio_produzione);
               modGUI.ElementoTabella(v_record.Fine_produzione);
               modGUI.ElementoTabella(v_record.Scadenza);
               modGUI.ElementoTabella(v_record.Pubblicazione);
               modGUI.ElementoTabella(v_record.litri_prodotti);
               modGUI.ElementoTabella(v_record.Prezzo_al_litro || '€');
               modGUI.ElementoTabella(v_record.Litri_residui);
               modGUI.ElementoTabella(v_record.Stato);
               modGUI.ChiudiRigaTabella;
           end loop;
           modgui.chiuditabella;
           k := 0;
           i := vetingredienti.next(i);
    end loop;
    if (var = 0) then
        modGUI.INTESTAZIONE(2, 'Non ci sono lotti che utilizzano gli ingredienti selezionati');
    end if;
    modGUI.CHIUDIPAGINA; 
end checkVisualizzaLotti;


procedure modificaDatiFornitore (idsessione in sessioni.idsessione%type) is
v_idfornitore Fornitori.idfornitore%type;
v_record Fornitori%rowtype;
begin
  modGUI.APRIPAGINA('Modifica dati',idsessione);
  modGUI.INTESTAZIONE(1,'Modifica dati');
  v_idfornitore := LOGIN.getIdUtente (idsessione);
  select idfornitore, nome, cognome, telefono, indirizzo, ragione_sociale  into v_record from Fornitori where idfornitore = v_idfornitore;
  modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.checkModificaDati','form',idsessione);
  modGUI.CASELLADITESTO('pnome','Nome',suggerimento=>'Inserisci il nome', lunghezzaMAx=>'30', tipo=>'alfa', require=>true, testo=>v_record.nome);
  modGUI.CASELLADITESTO('pcognome','Cognome',suggerimento=>'Inserisci il cognome', lunghezzaMAx=>'30', tipo=>'alfa', require=>true, testo=>v_record.cognome);
  modGUI.CASELLADITESTO('ptelefono','Telefono',suggerimento=>'Inserisci il numero di telefono', lunghezzaMAx=>'30', tipo=>'number', require=>true, testo=>v_record.telefono);
  modGUI.CASELLADITESTO('pindirizzo','Indirizzo',suggerimento=>'Inserisci indirizzo', lunghezzaMAx=>'45', tipo=>'alfa', require=>true, testo=>v_record.indirizzo);
  modGUI.CASELLADITESTO('pragione_sociale','Ragione sociale',suggerimento=>'Inserisci ragione sociale', lunghezzaMAx=>'45', tipo=>'alfa', require=>true, testo=>v_record.ragione_sociale);
  modGUI.passaParametro('v_idfornitore', v_idfornitore);
  modGUI.APRIBLOCCO; 
  modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'modifiacDatiFornitore');
  modGUI.CHIUDIBLOCCO;
  modGUI.CHIUDIFORM;
  modGUI.CHIUDIPAGINA;
end modificaDatiFornitore;

procedure checkModificaDati (idsessione in sessioni.idsessione%type,
    pnome in Fornitori.nome%type,
    pcognome in Fornitori.cognome%type,
    ptelefono in Fornitori.telefono%type,
    pindirizzo in Fornitori.indirizzo%type,
    pragione_sociale in Fornitori.ragione_sociale%type,
    v_idfornitore in Fornitori.idfornitore%type) is
esiste number;
begin
    select count(*) into esiste from Fornitori where telefono = ptelefono AND idfornitore != v_idfornitore;
    if (esiste >= 1) then 
        modGUI.PaginaFeedback('ERRORE', 'Numero di telefono già esistente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.modificaDatiFornitore', idsessione);
    end if;
    select count(*) into esiste from Fornitori where indirizzo = pindirizzo AND idfornitore != v_idfornitore;
    if (esiste >= 1) then
        modGUI.PaginaFeedback('ERRORE', 'Indirizzo già esistente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.modificaDatiFornitore', idsessione);
    end if;
    select count(*) into esiste from Fornitori where ragione_sociale = pragione_sociale AND idfornitore != v_idfornitore;
    if (esiste >= 1) then
        modGUI.PaginaFeedback('ERRORE', 'Ragione sociale già esistente', 'http://131.114.73.203:8080/apex/gianmarco.GruppoIngredienti.modificaDatiFornitore', idsessione);
    end if;
    update Fornitori set nome = pnome, cognome = pcognome, telefono = ptelefono, indirizzo = pindirizzo, ragione_sociale = pragione_sociale where idfornitore = v_idfornitore;
    modGUI.PaginaFeedback('SUCCESSO', 'Dati aggiornati correttamente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.modificaDatiFornitore', idsessione);
end checkModificaDati;

procedure infoBirraio (idsessione in sessioni.idsessione%type, v_idbirraio in Birrai.idbirraio%type) is
    v_record Birrai%rowtype;
begin
    modGUI.APRIPAGINA('Dettagli birraio',idsessione);
    modGUI.INTESTAZIONE(1, 'Dettagli birraio');
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Cognome');
    modGUI.IntestazioneTabella('Telefono');
    modGUI.IntestazioneTabella('Indirizzo');
    modGUI.IntestazioneTabella('Ragione sociale');
    modGUI.ChiudiRigaTabella;
    select * into v_record from Birrai B where  B.idbirraio = v_idbirraio;
    modGUI.ApriRigaTabella;
    modGUI.ElementoTabella(v_record.Nome);
    modGUI.ElementoTabella(v_record.Cognome);
    modGUI.ElementoTabella(v_record.Telefono);
    modGUI.ElementoTabella(v_record.Indirizzo);
    modGUI.ElementoTabella(v_record.Ragione_sociale); 
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end infoBirraio;

procedure visualizzaMagazzino (idsessione in sessioni.idsessione%type) is
    v_idbirraio Birrai.idbirraio%type;
    esiste number;
begin
    v_idbirraio := LOGIN.getIdUtente(idsessione);
    modGUI.APRIPAGINA('Magazzino',idsessione);
    modGUI.INTESTAZIONE(1, 'Magazzino');
    select count(*) into esiste from IngredientiBirrai IB where IB.idbirraio = v_idbirraio; 
    if (esiste >= 1) then
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Ingrediente');
        modGUI.IntestazioneTabella('Tipo');
        modGUI.IntestazioneTabella('Unità di misura');
        modGUI.IntestazioneTabella('Quantità');
        modGUI.IntestazioneTabella('Utilizzabile');
        modGUI.IntestazioneTabella('Dettagli');
        for v_record in
        (select ING.nome as Ingrediente, T.nome as Tipo, T.unita_di_misura as Unita,
        IB.quantita as quantita, ING.utilizzabile as utilizzabile
        from Ingredienti ING, Tipi T, Birrai B, IngredientiBirrai IB
        where ING.idtipo = T.idtipo AND B.idbirraio = IB.idbirraio
        AND IB.idingrediente = ING.idingrediente AND B.idbirraio = v_idbirraio)
        loop
            modGUI.ApriRigaTabella;
            modGUI.ElementoTabella(v_record.Ingrediente);
            modGUI.ElementoTabella(v_record.Tipo);
            if (v_record.Unita = 'kg') then
                modGUI.ElementoTabella('Kilogrammi');
            elsif (v_record.Unita = 'l') then
                modGUI.ElementoTabella('Litri');
            else 
                modGUI.ElementoTabella('Milligrammi');
            end if;
            modGUI.ElementoTabella(v_record.Quantita);
            if (v_record.Utilizzabile = 1) then
                modGUI.ElementoTabella('Si');
            else 
                modGUI.ElementoTabella('No');
            end if;
            MODGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.infoIngrediente?idSessione=' || to_char(idsessione) || '&v_nome=' || to_char(v_record.Ingrediente), idsessione);
            MODGUI.bottoneInfo;
            modGUI.PassaParametro('v_nome', to_char(v_record.Ingrediente));
            modGUI.ChiudiFormHidden;
        end loop;
    else 
        modGUI.INTESTAZIONE(1, 'Non possiedi ingredienti in magazzino');
    end if;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end visualizzaMagazzino;

procedure appoggio (idsessione in sessioni.idsessione%type, v_record in precord, 
v_fornitore in Fornitori.ragione_sociale%type, k in out number, pippo in out number) is
begin
    if (k = 0) then
        modGUI.INTESTAZIONE(2,v_fornitore);
        modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.visualizzaFornitore?idsessione=' || idsessione ||
        '&v_ragione_sociale=' || v_fornitore,'form',idsessione);
        modGUI.passaParametro('v_ragione_sociale', v_fornitore);
        modGUI.APRIBLOCCO;
        modGUI.BottoneForm('Dettagli Fornitore', 'Dettagli fornitore', 'Dettagli fornitore',
        true, 'visualizzaRifornimenti');
        modGUI.CHIUDIBLOCCO;
        modGUI.CHIUDIFORM;
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Tipo');
        modGUI.IntestazioneTabella('Prezzo');
        modGUI.IntestazioneTabella('Utilizzabile');
        modGUI.IntestazioneTabella('Carrello');
        modGUI.IntestazioneTabella('Dettagli');
        modGUI.ChiudiRigaTabella;
        k:=1;
        pippo:=1;
    end if;        
    modGUI.ApriRigaTabella;
    modGUI.ElementoTabella(v_record.Nome);
    modGUI.ElementoTabella(v_record.Tipo);
    modGUI.ElementoTabella(v_record.Prezzo || '€');
    if (v_record.Utilizzabile = 1) then
        modGUI.ElementoTabella('Si');
        modGUI.ApriElementoTabella;
        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.acquistoIngredienti', idsessione); 
        modGUI.BOTTONECART;
        modGUI.CASELLADITESTO('v_quantita', '', suggerimento=>'Quantità', tipo=>'number', LunghezzaMax=>3,require=>true);
        modGUI.PassaParametro('v_idingrediente', v_record.idin);
        
        modgui.ChiudiFormHidden;
        modGUI.ChiudiElementoTabella;
    else 
        modGUI.ElementoTabella('No');
        modGUI.ElementoTabella('');
    end if;
    modGUI.ApriElementoTabella;
    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
    'GruppoIngredienti.infoIngrediente?idSessione=' || to_char(idsessione) ||
    '&v_nome=' || to_char(v_record.Nome), idsessione); 
    MODGUI.bottoneinfo;
    modGUI.PassaParametro('v_nome', v_record.Nome);
    modgui.ChiudiFormHidden;
    modGUI.ChiudiElementoTabella;
    modGUI.ChiudiRigaTabella;
end appoggio;

procedure visualizzaOrdini (idsessione in sessioni.idsessione%type) is
    v_idbirraio Birrai.idbirraio%type;
    esiste number;
begin
    modGUI.APRIPAGINA('Ordini effettuati',idsessione);
    modGUI.INTESTAZIONE(1, 'Ordini effettuati');
    v_idbirraio := LOGIN.getIdUtente(idsessione);
    select count(*) into esiste from OrdiniBirrai OB where OB.id_birraio = v_idbirraio;
    if (esiste >= 1) then
        for v_ordine in 
        (select OB.numero_fattura, OB.prezzo_totale, OB.data_ordine from OrdiniBirrai OB where OB.id_birraio = v_idbirraio 
        order by OB.data_ordine desc)
        loop
            modGUI.INTESTAZIONE(2, 'Ordine numero:' || v_ordine.numero_fattura || ' data: ' || v_ordine.data_ordine
            || ' prezzo totale: ' || v_ordine.prezzo_totale);
            modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;
            modGUI.IntestazioneTabella('Nome');
            modGUI.IntestazioneTabella('Tipo');
            modGUI.IntestazioneTabella('Prezzo');
            modGUI.IntestazioneTabella('Quantita');
            modGUI.IntestazioneTabella('Fornitore');
            modGUI.IntestazioneTabella('Dettagli fornitore');
            modGUI.IntestazioneTabella('Dettagli ingrediente');
            modGUI.ChiudiRigaTabella;
            for v_record in 
            (select ING.nome as nome, T.nome as Tipo, R.quantita as quantita, F.ragione_sociale as fornitore, 
            R.prezzo_ingrediente as prezzo
            from Ingredienti ING, Tipi T, Rifornimenti R, Fornitori F, OrdiniBirrai OB
            where F.idfornitore = ING.idfornitore AND ING.idtipo = T.idtipo AND ING.idingrediente = R.idingrediente AND
            R.idordine = OB.idordine AND OB.id_birraio = v_idbirraio AND OB.numero_fattura = v_ordine.numero_fattura)
            loop
                modGUI.ElementoTabella(v_record.Nome);
                modGUI.ElementoTabella(v_record.Tipo);
                modGUI.ElementoTabella(v_record.prezzo || '€');
                modGUI.ElementoTabella(v_record.quantita);
                modGUI.ElementoTabella(v_record.fornitore);
                modGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
                'GruppoIngredienti.visualizzaFornitore?idSessione=' || to_char(idsessione) ||
                '&v_ragione_sociale=' || to_char(v_record.fornitore), idsessione); 
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('v_ragione_sociale', v_record.fornitore);
                modgui.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
                modGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
                'GruppoIngredienti.infoIngrediente?idSessione=' || to_char(idsessione) ||
                '&v_nome=' || to_char(v_record.nome), idsessione); 
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('v_nome', v_record.nome);
                modgui.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
                modGUI.ChiudiRigaTabella;
            end loop;
            modGUI.ChiudiTabella;
        end loop;
        modGUI.CHIUDIPAGINA;
    else
        modGUI.INTESTAZIONE(2, 'Non hai effettuato ordini');
    end if;
end visualizzaOrdini;

procedure visualizzaRifornimenti (idsessione in sessioni.idsessione%type) is
    v_idfornitore Fornitori.idfornitore%type;
    esiste1 number;
    k number;
begin
    k:=0;
    modGUI.APRIPAGINA('Ordini effettuati',idsessione);
    modGUI.INTESTAZIONE(1, 'Rifornimenti effettuati');
    v_idfornitore := LOGIN.getIdUtente(idsessione);
    select count(*) into esiste1 from Fornitori F, Ingredienti ING, Rifornimenti R
    where F.idfornitore = ING.idfornitore AND ING.idingrediente = R.idingrediente;
    if (esiste1 >= 1) then
        for v_birraio in 
        (select DISTINCT idbirraio, nome, cognome from Birrai, OrdiniBirrai where Birrai.idbirraio = OrdiniBirrai.id_birraio)
        loop
            for v_record in 
            (select ING.nome as ingrediente, T.nome as tipo, R.prezzo_ingrediente as prezzo,
            R.quantita as quantita, OB.data_ordine as giorno
            from Ingredienti ING, Tipi T, Rifornimenti R, OrdiniBirrai OB, Birrai B, Fornitori F
            where ING.idtipo = T.idtipo AND ING.idingrediente = R.idingrediente AND R.idordine = OB.idordine
            AND OB.id_birraio = B.idbirraio AND B.idbirraio = v_birraio.idbirraio AND
            F.idfornitore = ING.idfornitore AND F.idfornitore = v_idfornitore
            order by OB.data_ordine desc)
            loop
                if (k = 0) then
                    modGUI.INTESTAZIONE(2, 'Birraio: ' || v_birraio.nome || ' ' || v_birraio.cognome);
                    modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.infoBirraio?idsessione=' || idsessione ||
                    '&v_idbirraio=' || v_birraio.idbirraio,'form',idsessione);
                    modGUI.passaParametro('v_idbirraio', v_birraio.idbirraio);
                    modGUI.APRIBLOCCO;
                    modGUI.BottoneForm('Dettagli Birraio', 'Dettagli Birraio', 'Dettagli Birraio',
                    true, 'visualizzaRifornimenti');
                    modGUI.CHIUDIBLOCCO;
                    modGUI.CHIUDIFORM;
                    modGUI.ApriTabella;
                    modGUI.APRIRIGATABELLA;
                    modGUI.IntestazioneTabella('Nome');
                    modGUI.IntestazioneTabella('Tipo');
                    modGUI.IntestazioneTabella('Prezzo');
                    modGUI.IntestazioneTabella('Quantità');
                    modGUI.IntestazioneTabella('Totale');
                    modGUI.IntestazioneTabella('Data rifornimento');
                    modGUI.IntestazioneTabella('Dettagli ingrediente');
                    modGUI.ChiudiRigaTabella;
                    k:=1;
                end if;
                modGUI.ElementoTabella(v_record.ingrediente);
                modGUI.ElementoTabella(v_record.Tipo);
                modGUI.ElementoTabella(v_record.prezzo || '€');
                modGUI.ElementoTabella(v_record.quantita);
                modGUI.ElementoTabella(v_record.quantita * v_record.prezzo || '€');
                modGUI.ElementoTabella(v_record.giorno);
                modGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
                'GruppoIngredienti.infoIngredienteFornitore?idSessione=' || to_char(idsessione) ||
                '&v_nome=' || to_char(v_record.ingrediente), idsessione); 
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('v_nome', v_record.ingrediente);
                modgui.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
                modGUI.ChiudiRigaTabella;
            end loop;
            modGUI.ChiudiTabella;
            k:=0;
        end loop;
    else
        modGUI.INTESTAZIONE(1, 'Non hai effettuato rifornimenti');
    end if;
    modGUI.ChiudiTabella;
    modGUI.RITCARRELLO;
end visualizzaRifornimenti;


procedure modificaIngrediente (idsessione in sessioni.idsessione%type, v_nome in Ingredienti.nome%type) is
    v_prezzo Ingredienti.prezzo_unitario%type;
    v_descrizione Ingredienti.descrizione%type;
begin
    modGUI.APRIPAGINA('Modifica Ingrediente',idsessione);
    modGUI.INTESTAZIONE(1, 'Modifica Ingrediente');
    select prezzo_unitario, descrizione into v_prezzo, v_descrizione from Ingredienti where nome = v_nome;
    modGUI.APRIFORM(Costanti.root || 'GruppoIngredienti.checkModificaIngrediente','form',idSessione);
    modGUI.CASELLADITESTO('pnome','Nome',suggerimento=>'Inserisci il nome', lunghezzaMAx=>'30', tipo=>'alfa', require=>true, testo=>v_nome);
    modGUI.CASELLADITESTO('pprezzo','Prezzo €',suggerimento=>'Inserisci il Prezzo', lunghezzaMAx=>'5', tipo=>'number', require=>true, testo=>v_prezzo);
    modGUI.AREADITESTO('pdescrizione','Descrizione', center=>true, lunghezzaMax=>'100', require=>true, valore=>v_descrizione);
    modGUI.APRIBLOCCOSELECT('Utilizzabile',center=>true);
    modGUI.APRISELECT('putilizzabile',center=>true);
    modGUI.AGGIUNGIOPZIONESELECT('No', 'No');
    modGUI.AGGIUNGIOPZIONESELECT('Si', 'Si', true);
    modGUI.CHIUDISELECT;
    modGUI.CHIUDIBLOCCOSELECT;
    modGUI.passaParametro('v_nome', v_nome);
    modGUI.APRIBLOCCO; 
    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'Modifica Ingrediente');
    modGUI.CHIUDIBLOCCO;
    modGUI.CHIUDIPAGINA; 
end modificaIngrediente;

procedure checkModificaIngrediente (idsessione in sessioni.idsessione%type,
    pnome in Ingredienti.nome%type,
    pprezzo in Ingredienti.prezzo_unitario%type,
    putilizzabile in varchar2,
    pdescrizione in Ingredienti.descrizione%type,
    v_nome in Ingredienti.nome%type) is
    
    esiste number;
    v_id Ingredienti.idingrediente%type;
    putil Ingredienti.utilizzabile%type;
begin
    if (putilizzabile = 'Si') then
        putil := 1;
    else
        putil := 0;
    end if;
    select idingrediente into v_id from Ingredienti where nome = v_nome;
    select count(*) into esiste from Ingredienti where nome = pnome AND idingrediente != v_id;
    if (esiste >= 1) then
        modGUI.PaginaFeedback('ERRORE', 'Nome ingrediente già esistente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.visualizzaIngredientiEsposti?idsessione='
        || idsessione, idsessione);
    else 
        update Ingredienti set nome = pnome, utilizzabile = putil, prezzo_unitario = pprezzo, descrizione = pdescrizione
        where idingrediente = v_id;
        modGUI.PaginaFeedback('SUCCESSO', 'Ingrediente aggiornato correttamente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.visualizzaIngredientiEsposti?idsessione='
        || idsessione, idsessione);
    end if;
end checkModificaIngrediente;

procedure visualizzaIngredientiEsposti (idsessione in sessioni.idsessione%type) is 
    v_idfornitore Fornitori.idfornitore%type;
begin
    v_idfornitore := LOGIN.getIdUtente(idsessione);
    modGUI.APRIPAGINA('I tuoi ingredienti',idsessione); 
    modGUI.INTESTAZIONE(1,'I tuoi ingredienti');
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome');
    modGUI.IntestazioneTabella('Prezzo');
    modGUI.IntestazioneTabella('Tipo');
    modGUI.IntestazioneTabella('Dettagli');
    modGUI.ChiudiRigaTabella;
    for v_record in 
    (select Ingredienti.nome as Nome,
    Ingredienti.prezzo_unitario as Prezzo, Tipi.nome as Tipo
    From Ingredienti, Fornitori, Tipi
    where Fornitori.idfornitore = Ingredienti.idfornitore AND Ingredienti.idtipo = Tipi.idtipo AND Fornitori.idfornitore = v_idfornitore
    Order by Ingredienti.utilizzabile desc, Ingredienti.Prezzo_unitario desc)
    LOOP
        modGUI.ApriRigaTabella;
        modGUI.ElementoTabella(v_record.Nome);
        modGUI.ElementoTabella(v_record.Prezzo  || '€');
        modGUI.ElementoTabella(v_record.Tipo);
        MODGUI.ApriElementoTabella;
    	MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'GruppoIngredienti.infoIngredienteFornitore?idsessione=' || to_char(idsessione) || 'v_nome=' || to_char(v_record.Nome), idsessione);
    	MODGUI.bottoneInfo;
    	/* eventuale parametro da passare */
    	modGUI.PassaParametro('v_nome', to_char(v_record.Nome));
    	modGUI.ChiudiFormHidden;
        modGUI.ChiudiElementoTabella;
        modGUI.ChiudiRigaTabella;
    end loop;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end visualizzaIngredientiEsposti;

procedure infoIngredienteFornitore (idsessione in sessioni.idsessione%type, v_nome in Ingredienti.nome%type) is
    v_record Ingredienti%rowtype;
    v_tipo Tipi.nome%type;
    v_unita_di_misura Tipi.unita_di_misura%type;
begin
    modGUI.APRIPAGINA('Informazioni ingrediente',idSessione);
    modGUI.INTESTAZIONE(1,'Informazioni ingrediente');          
    modGUI.ApriTabella;
    modGUI.APRIRIGATABELLA;
    modGUI.IntestazioneTabella('Nome Ingrediente');
    modGUI.IntestazioneTabella('Prezzo unitario');
    modGUI.IntestazioneTabella('Utilizzabile');
    modGUI.IntestazioneTabella('Tipo');
    modGUI.IntestazioneTabella('Unità di misura');
    modGUI.IntestazioneTabella('Modifica Ingrediente');
    modGUI.ChiudiRigaTabella;
    select * into v_record from Ingredienti where Ingredienti.nome = v_nome;
    
    select Tipi.nome, Tipi.unita_di_misura into v_tipo, v_unita_di_misura from Tipi, Ingredienti
    where Tipi.idtipo = Ingredienti.idtipo AND Ingredienti.nome = v_nome;
    
    modGUI.ApriRigaTabella;
    modGUI.ElementoTabella(v_record.Nome);
    modGUI.ElementoTabella(v_record.Prezzo_unitario || '€');
    if(v_record.utilizzabile=1) then
        modGUI.ElementoTabella('Si');
    else
        modGUI.ElementoTabella('No');
    end if;
    modGUI.ElementoTabella(v_tipo);
    if (v_unita_di_misura = 'kg') then
        modGUI.ElementoTabella('Kilogrammi');
    elsif (v_unita_di_misura = 'l') then
        modGUI.ElementoTabella('Litri');
    else
        modGUI.ElementoTabella('Milligrammi');
    end if;
    modGUI.ApriElementoTabella;
    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
    'GruppoIngredienti.modificaIngrediente?idSessione=' || to_char(idsessione) ||
    '&v_nome=' || v_nome, idsessione); 
    MODGUI.bottoneEdit;
    modGUI.PassaParametro('v_nome', v_nome);
    modgui.ChiudiFormHidden;
    modGUI.ChiudiElementoTabella;
    modGUI.ChiudiTabella;
    modGUI.INTESTAZIONE(2,'Descrizione'); 
    modGUI.ApriTabella;
    modGUI.ElementoTabella(v_record.Descrizione);
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end infoIngredienteFornitore;

procedure datiDiVendita (idsessione in sessioni.idsessione%type) is
    v_idfornitore Fornitori.idfornitore%type;
    esiste number;
    numero number;
    costo number;
begin
    modGUI.APRIPAGINA('Dati di vendita',idSessione);
    modGUI.INTESTAZIONE(1,'Dati di vendite');
    v_idfornitore := LOGIN.getIdUtente(idsessione);
    
    select count(*) into esiste from Fornitori F, Ingredienti ING, Rifornimenti R 
    where F.idfornitore = ING.idfornitore AND ING.idingrediente = R.idingrediente AND F.idfornitore = v_idfornitore;
    if (esiste >= 1) then
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Cognome');
        modGUI.IntestazioneTabella('Numero rifornimenti');
        modGUI.IntestazioneTabella('Prezzo rifornimenti');
        modGUI.IntestazioneTabella('Dettagli birraio');
        modGUI.ChiudiRigaTabella;
        for v_birraio in
        (select DISTINCT B.idbirraio from Birrai B, OrdiniBirrai OB where B.idbirraio = OB.id_birraio)
        loop
            
            select count(*), sum(R.quantita*R.prezzo_ingrediente) into numero, costo from Ingredienti ING, Rifornimenti R, OrdiniBirrai OB, Fornitori F, Birrai B
            where ING.idingrediente = R.idingrediente AND R.idordine = OB.idordine AND ING.idfornitore = F.idfornitore
            AND OB.id_birraio = B.idbirraio AND F.idfornitore = v_idfornitore AND B.idbirraio = v_birraio.idbirraio;
            
            
            
            for v_record in 
            (select  DISTINCT B.nome, B.cognome
            from Birrai B, Rifornimenti R, Fornitori F, Ingredienti ING, OrdiniBirrai OB
            where B.idbirraio = OB.id_birraio AND OB.idordine = R.idordine AND R.idingrediente = ING.idingrediente AND
            ING.idfornitore = F.idfornitore AND F.idfornitore = v_idfornitore AND B.idbirraio = v_birraio.idbirraio)
            loop
                modGUI.ApriRigaTabella;
                modGUI.ElementoTabella(v_record.Nome);
                modGUI.ElementoTabella(v_record.Cognome);
                modGUI.ElementoTabella(numero);
                modGUI.ElementoTabella(costo || '€');
                modGUI.ApriElementoTabella;
                MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
                'GruppoIngredienti.infoBirraio?idSessione=' || to_char(idsessione) ||
                '&v_idbirraio=' || v_birraio.idbirraio, idsessione); 
                MODGUI.bottoneInfo;
                modGUI.PassaParametro('v_idbirraio', v_birraio.idbirraio);
                modgui.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;
                modGUI.ChiudiRigaTabella;
            end loop;
        end loop;
    else
        modGUI.INTESTAZIONE(2,'Non hai effettuato rifornimenti a nessun birraio');
    end if;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA;
end datiDiVendita;

procedure ricercaFornitori (idsessione in sessioni.idsessione%type) 
is
begin
 modGUI.APRIPAGINA('Ricerca Fornitori',idsessione);
  
  --modGUI.CREAMENUBACKOFFICE(1);
  modGUI.INTESTAZIONE(1,'Ricerca Fornitori');
  
  --APRE UNA FORM VISUALE
  modGUI.APRIFORM(Costanti.root || 'GruppoIngredienti.checkRicercaFornitori','form',idsessione);
  
  ---AGGIUNGE UNA TEXBOX DI TIPO 'CF'
  modGUI.CASELLADITESTO('pragione_sociale','Ragione sociale',suggerimento=>'Inserisci la ragione sociale', lunghezzaMAx=>'30', tipo=>'alfa', require=>false);

  modGUI.RITCARRELLO;
  modGUI.APRIBLOCCO; 
  modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form', valore=>'ricercaFornitori');
  modGUI.CHIUDIBLOCCO;
  modGUI.CHIUDIFORM;
  modGUI.CHIUDIPAGINA;
end ricercaFornitori;



procedure checkRicercaFornitori (
idsessione in sessioni.idsessione%type,
pragione_sociale in Fornitori.ragione_sociale%type
)
is
    k number;
begin 
    k := 0;
    modGUI.APRIPAGINA('Fornitori con il nome specificato',idsessione); 
    modGUI.INTESTAZIONE(1,'Fornitori');
    for v_record in 
    (select F.Nome as nome, F.cognome as cognome, F.telefono as telefono, 
    F.indirizzo as indirizzo, F.ragione_sociale as ragione_sociale
    from Fornitori F
    where (upper(F.ragione_sociale) LIKE '%'||upper(pragione_sociale)||'%'))
    LOOP
        if (k = 0) then
            modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;
            modGUI.IntestazioneTabella('Nome');
            modGUI.IntestazioneTabella('Cognome');
            modGUI.IntestazioneTabella('Telefono');
            modGUI.IntestazioneTabella('Indirizzo');
            modGUI.IntestazioneTabella('Ragione sociale');
            modGUI.IntestazioneTabella('Ingredienti esposti');
            modGUI.ChiudiRigaTabella;
            k:=1;
        end if;
        modGUI.ApriRigaTabella;
        modGUI.ElementoTabella(v_record.nome);
        modGUI.ElementoTabella(v_record.cognome);
        modGUI.ElementoTabella(v_record.telefono);
        modGUI.ElementoTabella(v_record.indirizzo);
        modGUI.ElementoTabella(v_record.ragione_sociale);
        modGUI.ApriElementoTabella;
        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
        'GruppoIngredienti.visualizzaIngredientiFornitore?idSessione=' || to_char(idsessione) ||
        '&v_ragione_sociale=' || v_record.ragione_sociale, idsessione); 
        MODGUI.bottoneInfo;
        modGUI.PassaParametro('v_ragione_sociale', v_record.ragione_sociale);
        modgui.ChiudiFormHidden;
        modGUI.ChiudiElementoTabella;
        modGUI.ChiudiRigaTabella;
    end loop;
    if ( k = 0) then
        modGUI.INTESTAZIONE(2,'Non ci sono fornitori con la ragione sociale specificata');
    end if;
    modGUI.ChiudiTabella;
    modGUI.CHIUDIPAGINA; 
end checkRicercaFornitori;

procedure acquistoingredienti (idsessione in sessioni.idsessione%type,
v_quantita in number, v_idingrediente in ingredienti.idingrediente%type) is
    v_idbirraio Birrai.idbirraio%type;
    esiste number;
    v_prezzo number;
    v_quant number;
begin
    if (v_quantita is null) then
	v_quant := 1;
    else
	v_quant := v_quantita;
    end if;
    v_idbirraio := LOGIN.getIdUtente(idsessione);
    select prezzo_unitario into v_prezzo from Ingredienti where idingrediente = v_idingrediente;
    select count(*) into esiste from carrello_for where idingrediente = v_idingrediente AND idbirraio = v_idbirraio;
    if (esiste >= 1) then
        update carrello_for set quantita = quantita + v_quant where idingrediente = v_idingrediente AND idbirraio = v_idbirraio;
    else 
        insert into carrello_for values (idcarrello_seq.nextval, v_idingrediente, v_quant, v_prezzo,v_idbirraio);
    end if;
    modGUI.PaginaFeedback('SUCCESSO', 'Ingrediente aggiunto al carrello', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.ricercaIngredienti?idsessione='
    || idsessione, idsessione);
    
end acquistoingredienti;

procedure visualizzaCarrello (idsessione in sessioni.idsessione%type) is
    esiste number;
    v_idbirraio Birrai.idbirraio%type;
    v_par_tot number;
    v_tot number;
    v_ingrediente Ingredienti.nome%type;
    v_quan number;
begin
    modGUI.APRIPAGINA('Il tuo carrello',idsessione);
    modGUI.INTESTAZIONE(1,'Il tuo carrello');
    v_quan := 0;
    v_tot := 0;
    v_idbirraio := LOGIN.getIdUtente(idsessione);
    select count(*) into esiste from carrello_for where idbirraio = v_idbirraio;
    if (esiste >= 1) then
        
        --Apro la tabella ed imposto la intestazione
        modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;
        modGUI.IntestazioneTabella('Ingrediente');
        modGUI.IntestazioneTabella('Prezzo');
        modGUI.IntestazioneTabella('Quantità');
        modGUI.IntestazioneTabella('Totale parziale');
        modGUI.IntestazioneTabella('Elimina ingrediente');
        modGUI.ChiudiRigaTabella;
        
        --Prendo ogni riga del carrello.
        for v_record in 
        (select idcarrello, idingrediente, quantita, prezzo
        from carrello_for
        where idbirraio = v_idbirraio)
        loop
            --Prendo il nome dell'ingrediente
            select ING.nome into v_ingrediente from Ingredienti ING, carrello_for C
            where C.idingrediente = ING.idingrediente AND ING.idingrediente = v_record.idingrediente;
            
            --Calcolo il totale parziale per ogni ingrediente ed lo sommo al prezzo totale del carrello
            v_par_tot := v_record.quantita * v_record.prezzo;
            v_tot := v_tot + v_par_tot;
            v_quan := v_quan + v_record.quantita;
            
            modGUI.ApriRigaTabella;
            modGUI.ElementoTabella(v_ingrediente);
            modGUI.ElementoTabella(v_record.prezzo || '€');
            modGUI.ElementoTabella(v_record.quantita);
            modGUI.ElementoTabella(v_par_tot || '€');
            modGUI.ApriElementoTabella;
            MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 
            'GruppoIngredienti.modificaCarrello?idSessione=' || to_char(idsessione) ||
            '&v_idcarrello=' || v_record.idcarrello, idsessione); 
            MODGUI.bottoneDelete;
            modGUI.PassaParametro('v_idcarrello', v_record.idcarrello);
            modgui.ChiudiFormHidden;
            modGUI.ChiudiElementoTabella;
            modGUI.ChiudiRigaTabella;
        end loop;
        modGUI.ChiudiTabella;
        modGUI.INTESTAZIONE(2,'Prezzo totale: ' || v_tot || '€');
        modGUI.INTESTAZIONE(2,'Totale prodotti: ' || v_quan);
        modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.confermaCarrello','form',idsessione);
        modGUI.passaParametro('v_tot', v_tot);
        modGUI.APRIBLOCCO; 
        modGUI.BottoneForm('Conferma carrello', 'Conferma carrello', 'Conferma carrello',
        true, 'Conferma carrello');
        modGUI.CHIUDIBLOCCO;
        modGUI.CHIUDIFORM;
        modGUI.APRIFORM(Costanti.root || 'gruppoingredienti.eliminaCarrello','form',idsessione);
        modGUI.APRIBLOCCO; 
        modGUI.BottoneForm('Elimina carrello', 'Elimina carrello', 'Elimina carrello',
        true, 'Elimina carrello');
        modGUI.CHIUDIBLOCCO;
        modGUI.CHIUDIFORM;
    else 
        modGUI.INTESTAZIONE(2,'Il tuo carrello è vuoto');
    end if;
    modGUI.CHIUDIPAGINA; 
end visualizzaCarrello;

procedure modificaCarrello (idsessione in sessioni.idsessione%type,
v_idcarrello in carrello_for.idcarrello%type) is
begin
    delete from carrello_for where idcarrello = v_idcarrello;
    modGUI.PaginaFeedback('SUCCESSO', 'Ingrediente correttamente eliminato dal carrello', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.visualizzaCarrello?idsessione='
    || idsessione, idsessione);
end modificaCarrello;

procedure eliminaCarrello (idsessione in sessioni.idsessione%type) is
begin
    delete from carrello_for;
    modGUI.PaginaFeedback('SUCCESSO', 'Carrello svuotato correttamente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.visualizzaCarrello?idsessione='
    || idsessione, idsessione);
end eliminaCarrello;

procedure ConfermaCarrello (idsessione in sessioni.idsessione%type, v_tot in number) is
    numero number;
    v_idbirraio Birrai.idbirraio%type;
    esiste number;
begin
    numero := idOrdiniBirrai_seq.nextval;
    v_idbirraio := LOGIN.getIdUtente(idsessione);
    insert into ordiniBirrai values (numero, numero+1, CURRENT_DATE, v_tot, v_idbirraio);
    for v_record in 
    (select idingrediente, quantita, prezzo from carrello_for where idbirraio = v_idbirraio)
    loop
        insert into rifornimenti values (idrifornimenti_seq.nextval, v_record.prezzo, v_record.quantita, v_record.idingrediente, numero);
    end loop;
    delete from carrello_for;
    modGUI.PaginaFeedback('SUCCESSO', 'Ordine effettuato correttamente', 'http://131.114.73.203:8080/apex/utentefinale.GruppoIngredienti.visualizzaCarrello?idsessione='
    || idsessione, idsessione);
end ConfermaCarrello;

procedure tuttiRifornimenti (idsessione in sessioni.idsessione%type) is
    esiste number;
begin
    modGUI.APRIPAGINA('Ordini effettuati',idsessione);
    modGUI.INTESTAZIONE(1, 'Tutti i rifornimenti');
    for v_fornitore in
    (select ragione_sociale from fornitori)
    loop
        select count(*) into esiste from Fornitori F, Ingredienti ING, Rifornimenti R
        where F.idfornitore = ING.idfornitore AND ING.idingrediente = R.idingrediente AND F.ragione_sociale = v_fornitore.ragione_sociale;
        if (esiste >= 1) then
            modGUI.INTESTAZIONE(2, 'Fornitore: ' || v_fornitore.ragione_sociale);
            modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;
            modGUI.IntestazioneTabella('Nome');
            modGUI.IntestazioneTabella('Tipo');
            modGUI.IntestazioneTabella('Prezzo');
            modGUI.IntestazioneTabella('Quantità');
            modGUI.IntestazioneTabella('Totale');
            modGUI.IntestazioneTabella('Nome birraio');
            modGUI.IntestazioneTabella('Cognome birraio');
            modGUI.IntestazioneTabella('Data rifornimento');
            modGUI.ChiudiRigaTabella;
        end if;
        for v_record in 
        (select ING.nome as ingrediente, T.nome as tipo, R.prezzo_ingrediente as prezzo,
        R.quantita as quantita, OB.data_ordine as giorno, B.nome as b_nome, B.cognome as b_cognome
        from Ingredienti ING, Tipi T, Rifornimenti R, OrdiniBirrai OB, Birrai B, Fornitori F
        where ING.idtipo = T.idtipo AND ING.idingrediente = R.idingrediente AND R.idordine = OB.idordine
        AND OB.id_birraio = B.idbirraio  AND F.idfornitore = ING.idfornitore AND F.ragione_sociale = v_fornitore.ragione_sociale
        order by OB.data_ordine desc)
        loop
            modGUI.APRIRIGATABELLA;
            modGUI.ElementoTabella(v_record.ingrediente);
            modGUI.ElementoTabella(v_record.Tipo);
            modGUI.ElementoTabella(v_record.prezzo);
            modGUI.ElementoTabella(v_record.quantita);
            modGUI.ElementoTabella(v_record.quantita * v_record.prezzo || '€');
            modGUI.ElementoTabella(v_record.b_nome);
            modGUI.ElementoTabella(v_record.b_cognome);
            modGUI.ElementoTabella(v_record.giorno);
            modGUI.ChiudiRigaTabella;
        end loop;
        modGUI.chiudiTabella;
    end loop;
    modGUI.chiudiPagina;
end tuttiRifornimenti;



end GruppoIngredienti;