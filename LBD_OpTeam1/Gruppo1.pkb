CREATE OR REPLACE PACKAGE BODY OPERAZIONICATANIASTASULA AS
  procedure statisticaIngredienti(idSessione number) is
    v_idbirraio number;
    begin
    modgui.ApriPagina('Utilizzo ingredienti',idSessione);
    modgui.Intestazione(1,'Utilizzo degli ingredienti nei tuoi lotti');
    modgui.APRITABELLA();
     modGUI.APRIRIGATABELLA;

        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Quantita usata');
        modGUI.IntestazioneTabella('Misura');
        modgui.INTESTAZIONETABELLA('Ricette che lo usano');

     modGUI.ChiudiRigaTabella;
      v_idBirraio := getIdUtente(idSessione);
      for v_record in (
      select ingredienti.nome as nome, sum(ingredientiricette.quantita * lotti.litri_prodotti/10) as v_quantita , tipi.unita_di_misura as misura
      from lotti, ricette, IngredientiRicette,ingredienti, tipi
      where lotti.idbirraio = v_idbirraio
      AND lotti.idricetta = ricette.idricetta
      AND ingredientiricette.idricetta = ricette.idricetta
      AND ingredienti.idingrediente = ingredientiricette.idingrediente
      and tipi.idtipo = ingredienti.idtipo
      GROUP BY ingredienti.nome, tipi.unita_di_misura
      ORDER BY v_quantita)
      loop
          modgui.ApriRigaTabella();
            modgui.ElementoTabella(v_record.nome);
            modgui.ElementoTabella(v_record.v_quantita);
            modgui.ElementoTabella(v_record.misura);
          MODGUI.ApriElementoTabella;

                  MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.ricetteUsanoIngrediente', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_idingrediente',getIdFromIngredientName(v_record.nome));
                    modGUI.ChiudiFormHidden;
                    modGUI.ChiudiElementoTabella;


        modGUI.ChiudiRigaTabella;
          modgui.ChiudiRigaTabella();
      end loop;
          modgui.chiuditabella();
          modgui.ChiudiPagina();
    end;

    procedure inserisciAnnotazione(idSessione number,idLotto number) is

        begin
            modGUI.ApriPagina('Inserimento Annotazione', idSessione);
            modGUI.Intestazione(1, 'Aggiungi una nota al lotto '); -- inserisci nome lotto
            modGUI.RitCarrello;

            modGUI.ApriForm(costanti.root || 'operazionicataniastasula.procInserisciAnnotazione', 'procInserisciRicetta',idSessione );
            MODGUI.PASSAPARAMETRO('idLotto',idLotto);
            modGUI.AreaDiTesto('annot', 'Annotazione',REQUIRE=> true);
            modGUI.ApriBlocco();
            modGUI.BOTTONEFORM(valida=>true,nomeForm=>'procInserisciAnnotazione');
            modGUI.CHIUDIBLOCCO;
            modGUI.ChiudiForm();


            end;
        procedure procInserisciAnnotazione(idSessione number,idLotto number,annot varchar2) is
            v_idBirraio Birrai.idbirraio%TYPE;
        begin
            v_idBirraio := LOGIN.GETIDUTENTE(idSessione);
            INSERT INTO Annotazioni values (IDANNOTAZIONI_SEQ.nextval,annot,CURRENT_DATE,v_idBirraio,idLotto);

            MODGUI.PAGINAFEEDBACK('Successo','Hai inserito correttamente la nota!',Costanti.root || 'operazionicataniastasula.visualizzaLottiBirraio?idSessione=' || idSessione,idSessione);
        end;

        procedure ratingRicetteBirraio(idSessione number) is
            v_idBirraio Birrai.idbirraio%TYPE;
            v_role Utenti.ruolo%TYPE;
        begin
            v_role := login.GETROLEFROMSESSION(idSessione);
            modGUI.APRIPAGINA('Ricette più proficue',idSessione);
            MODGUI.INTESTAZIONE(1,'Le ricette che hanno ricavato di più');
            modgui.APRITABELLA();
             modGUI.APRIRIGATABELLA;

                modGUI.IntestazioneTabella('Nome');
                modGUI.IntestazioneTabella('Ricavo');
                modGUI.IntestazioneTabella('Litri venduti');

            modGUI.ChiudiRigaTabella;

            if(v_role='birraio') then
                v_idBirraio := LOGIN.GETIDUTENTE(idSessione);
                for v_record IN (SELECT RICETTE.nome as nome,sum(ORDINICLIENTILOTTI.NUMERO_LITRI*ORDINICLIENTILOTTI.PREZZO_LITRO) as ricavo, sum(ORDINICLIENTILOTTI.NUMERO_LITRI) as litri
                FROM RICETTE,lotti,ORDINICLIENTILOTTI
                WHERE LOTTI.IDBIRRAIO=v_idBirraio AND RICETTE.IDRICETTA=lotti.IDRICETTA AND lotti.IDLOTTO=ORDINICLIENTILOTTI.IDLOTTO
                GROUP BY RICETTE.NOME
                ORDER BY ricavo desc
                ) LOOP
                    modgui.APRIRIGATABELLA();
                    modGui.ELEMENTOTABELLA(v_record.nome);
                    modgui.ELEMENTOTABELLA(v_record.ricavo);
                    modgui.ELEMENTOTABELLA(v_record.litri);
                    modgui.CHIUDIRIGATABELLA();

                end loop;
                end if;
            if(v_role='amministratore') then
                for v_record IN (SELECT RICETTE.nome as nome,sum(ORDINICLIENTILOTTI.NUMERO_LITRI*ORDINICLIENTILOTTI.PREZZO_LITRO) as ricavo, sum(ORDINICLIENTILOTTI.NUMERO_LITRI) as litri
                FROM RICETTE,lotti,ORDINICLIENTILOTTI
                WHERE RICETTE.IDRICETTA=lotti.IDRICETTA AND lotti.IDLOTTO=ORDINICLIENTILOTTI.IDLOTTO
                GROUP BY RICETTE.NOME
                ORDER BY ricavo desc
                ) LOOP
                    modgui.APRIRIGATABELLA();
                    modGui.ELEMENTOTABELLA(v_record.nome);
                    modgui.ELEMENTOTABELLA(v_record.ricavo);
                    modgui.ELEMENTOTABELLA(v_record.litri);
                    modgui.CHIUDIRIGATABELLA();

                end loop;
            end if;



            modgui.CHIUDITABELLA();
            modgui.CHIUDIPAGINA();
        end;
  procedure inserisciRicetta(idSessione number) is
    begin
          modGUI.ApriPagina('Inserimento Ricette', idSessione);
          modGUI.Intestazione(1, 'Inserire la ricetta');
            modGUI.RitCarrello;
            modGUI.ApriForm(costanti.root || 'operazionicataniastasula.procInserisciRicetta', 'procInserisciRicetta',idSessione );
            modGUI.CasellaDiTesto('NomeRic', 'Nome','Nome','',30,'alfa',true);
            modGUI.AreaDiTesto('Istr', 'Istruzioni',REQUIRE=> true);
            --modGUI.CasellaDiTesto('Met', 'Metodologia','Metodologia','',10,'text',true);
          modgui.APRIBLOCCOSELECT(CENTER => TRUE);
          modgui.APRISELECT(NOME => 'Met',CENTER => TRUE);
            --'whole grain', 'extract', 'mixed'
          modgui.AGGIUNGIOPZIONESELECT('whole grain','whole grain',true);
          modgui.AGGIUNGIOPZIONESELECT('extract','extract',false);
          modgui.AGGIUNGIOPZIONESELECT('mixed','mixed',false);
        modgui.CHIUDISELECT();
          modgui.CHIUDIBLOCCOSELECT();
          modGUI.ApriBlocco();
            modGUI.BOTTONEFORM(valida=>true,nomeForm=>'procInserisciRicetta',TESTO => 'Inserisci');
            modGUI.CHIUDIBLOCCO;
            modGUI.ChiudiForm();

    end inserisciRicetta;

    function getIdFromIngredientName(v_name varchar2) return number is
        v_id number;
        begin
            v_id :=null;
            select INGREDIENTI.IDINGREDIENTE into v_id from INGREDIENTI where INGREDIENTI.nome=v_name;
            return v_id;
            end getIdFromIngredientName;

    procedure procInserisciRicetta (idSessione number, NomeRic varchar2, idRicetta number default null, Istr varchar2, Met varchar2, Ingr varchar2 default null, Quantita number default null, inserted number default 0) is
        --, ingrediente1 varchar2, quantita1 varchar2, ingrediente2 varchar2, quantita2 varchar2
    idUtente NUMBER;
    SeqRic NUMBER (5,0);
    v_idRicetta number;
    v_idingr number;
    CURSOR r is SELECT * FROM RICETTE WHERE RICETTE.Nome = Nomeric;
        v_record r%ROWTYPE;
    begin
      v_idRicetta := idRicetta;
     open r;
        fetch r into v_record;
        modGUI.ApriPagina('Inserimento Ricette',idSessione);
      htp.PRINT('<script>

                      function showMeasure(choice){
                            var str="";
                            if(/malto/i.test(choice)){
                                str="chilogrammi";
                            }
                            else{
                                if(/acqua/i.test(choice)){
                                str="litri";} else{str="grammi"}
                            }
                      
                      document.getElementsByName("Quantita")[0].placeholder=str;
                        }
                    </script>'
                      );
        if Ingr is not null then
            v_idingr := getIdFromIngredientName(Ingr);
            if  r%rowcount = 0 then
                  idUtente := getIdUtente(idSessione);
                  SeqRic := idRicette_seq.NEXTVAL;
                    INSERT INTO RICETTE VALUES (SeqRic, NomeRic, Istr, Met, 1,CURRENT_DATE ,idUtente);
                    INSERT INTO INGREDIENTIRICETTE VALUES (v_idingr,SeqRic,Quantita);
                    modGUI.Intestazione(1, 'Inserimento riuscito !');

                  modGUI.Intestazione(2, 'Vuoi aggiungere un altro ingrediente alla tua ricetta ?');

                   modGUI.ApriForm(costanti.root || 'operazionicataniastasula.procInserisciRicetta', 'procInserisciRicetta',idSessione );
                    modGUI.PassaParametro('NomeRic', to_char(NomeRic));
                   modGUI.PassaParametro('Istr', to_char(Istr));
                   modGUI.PassaParametro('Met', to_char(Met));
                    modGUI.PASSAPARAMETRO('idRicetta', to_char(SeqRic));
                   modgui.APRIBLOCCOSELECT('Ingrediente', true);
                     htp.print('<div class="col-lg-1 col-lg-push-2">
            <select onchange="showMeasure(this.value)" class="form-control" name="Ingr">');
                    for e in (SELECT  IDINGREDIENTE, NOME  FROM INGREDIENTI)
                    loop
                        modgui.AGGIUNGIOPZIONESELECT(to_char(e.NOME), to_char(e.NOME));
                    end loop;
                    modgui.CHIUDISELECT();
                   modgui.CHIUDIBLOCCOSELECT();
                  modgui.CASELLADITESTO('Quantita', '', 'Quantita', '',10, 'alfa', true, true);
                   

                   modGUI.ApriBlocco();
                    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'procInserisciRicetta');
                    modGUI.CHIUDIBLOCCO;
                    modGUI.ChiudiForm();

                    modGUI.ApriForm(costanti.root || 'operazionicataniastasula.inserisciRicetta', 'InserisciRicetta',idSessione );
                    
            modGUI.ApriBlocco();
            modGUI.Bottone('Torna indietro');
            modGUI.CHIUDIBLOCCO;
            modGUI.ChiudiForm();

            end if;
            if v_idRicetta is not null then
                if not doppioIngrediente(v_idRicetta,v_idingr) then
                  INSERT INTO INGREDIENTIRICETTE VALUES (v_idingr,v_idRicetta,Quantita);
                  modGUI.Intestazione(1, 'Ingrediente aggiunto con successo');
                else modGUI.Intestazione(1, 'Ingrediente duplicato');
                end if;
                modGUI.Intestazione(2, 'Vuoi aggiungere un altro ingrediente alla tua ricetta ?');

                   modGUI.ApriForm(costanti.root || 'operazionicataniastasula.procInserisciRicetta', 'procInserisciRicetta',idSessione );
                    modGUI.PassaParametro('NomeRic', to_char(NomeRic));
                   modGUI.PassaParametro('Istr', to_char(Istr));
                   modGUI.PassaParametro('Met', to_char(Met));
                    modGUI.PASSAPARAMETRO('idRicetta', to_char(v_idRicetta));
                   modgui.APRIBLOCCOSELECT('Ingrediente', true);
                     htp.print('<div class="col-lg-1 col-lg-push-2">
            <select onchange="showMeasure(this.value)" class="form-control" name="Ingr">');
                    for e in (SELECT  IDINGREDIENTE, NOME  FROM INGREDIENTI)
                    loop
                        modgui.AGGIUNGIOPZIONESELECT(to_char(e.nome), to_char(e.NOME));
                    end loop;
                    modgui.CHIUDISELECT();
                   modgui.CHIUDIBLOCCOSELECT();
                modgui.CASELLADITESTO('Quantita', '', 'Quantita', '',10, 'alfa', true, true);
                

                   modGUI.ApriBlocco();
                    modGUI.BOTTONEFORM(valida=>true,nomeForm=>'procInserisciRicetta');
                    modGUI.CHIUDIBLOCCO;
                    modGUI.ChiudiForm();

            modGUI.ApriForm(costanti.root || 'operazionicataniastasula.inserisciRicetta', 'InserisciRicetta',idSessione );
            modGUI.ApriBlocco();
            modGUI.Bottone('Torna indietro');
            modGUI.CHIUDIBLOCCO;
            modGUI.ChiudiForm();
                    
            end if;


        end if;
        if r%rowcount = 0 and Ingr is null then

           modGUI.Intestazione(1, 'Inserisci ingredienti');

           modGUI.ApriForm(costanti.root || 'operazionicataniastasula.procInserisciRicetta', 'procInserisciRicetta',idSessione );
            modGUI.PassaParametro('NomeRic', to_char(NomeRic));
           modGUI.PassaParametro('Istr', to_char(Istr));
           modGUI.PassaParametro('Met', to_char(Met));
           modgui.APRIBLOCCOSELECT('Ingrediente', true);
            htp.print('<div class="col-lg-1 col-lg-push-2">
            <select onchange="showMeasure(this.value)" class="form-control" name="Ingr">');
            for e in (SELECT  IDINGREDIENTE, NOME  FROM INGREDIENTI)
            loop 
                modgui.AGGIUNGIOPZIONESELECT(to_char(e.nome), to_char(e.NOME));
            end loop;
           modgui.CHIUDISELECT();
           modgui.CHIUDIBLOCCOSELECT();
            modgui.CASELLADITESTO('Quantita', '', 'Quantita', '',10, 'alfa', true, true);
           

           modGUI.ApriBlocco();--valida=>true,nomeForm=>'procInserisciRicetta','Inserisci
            modGUI.BOTTONEFORM('butt1','Inserisci','Inserisci',true,'procInserisciRicetta');
            modGUI.CHIUDIBLOCCO;
            modGUI.ChiudiForm();

            modGUI.ApriForm(costanti.root || 'operazionicataniastasula.inserisciRicetta', 'InserisciRicetta',idSessione );
        modGUI.ApriBlocco();
        modGUI.Bottone('Torna indietro');
        modGUI.CHIUDIBLOCCO;
        modGUI.ChiudiForm();

        end if;
        if r%rowcount > 0 and Ingr is null then
        MODGUI.INTESTAZIONE(TIPO  => 1 /*IN NUMBER(38)*/,
                            TESTO  => 'Ricetta già presente ! Scegliere un altro nome' );
        modGUI.ApriForm(costanti.root || 'operazionicataniastasula.inserisciRicetta', 'InserisciRicetta',idSessione );
        modGUI.ApriBlocco();
        modGUI.Bottone('Torna indietro');
        modGUI.CHIUDIBLOCCO;
        modGUI.ChiudiForm();
        end if;
      modgui.CHIUDIPAGINA();

    end procInserisciRicetta;

    function getIdUtente (v_idSessione number) return number is
      CURSOR r is SELECT * FROM SESSIONI WHERE v_idSessione = SESSIONI.IDSESSIONE;
        v_record r%ROWTYPE;
    begin
    open r;
      fetch r into v_record;
      if r%rowcount = 0 then
        close r;
        return 0;
      else
        close r;
        return v_record.idUtente;
      end if;
    end getIdUtente;

    procedure visualizzaIngredienti(idSessione number, idRicetta number) is
            v_idSessione number;
            v_idRicetta number;
        begin

        v_idSessione := idSessione;
        v_idRicetta := idRicetta;
                modGUI.ApriPagina('Ingredienti',v_idSessione);
                modGUI.INTESTAZIONE(1,'Ingredienti della ricetta');
                modGUI.ApriTabella;
        modGUI.APRIRIGATABELLA;

        modGUI.IntestazioneTabella('Nome Ingrediente');
        modGUI.IntestazioneTabella('Quantita');
        modGUI.IntestazioneTabella('Ricette condivise che lo usano');

        modGUI.ChiudiRigaTabella;

        for v_record in
        (SELECT INGREDIENTIRICETTE.IDRICETTA,INGREDIENTIRICETTE.IDINGREDIENTE, QUANTITA, INGREDIENTI.UTILIZZABILE, INGREDIENTI.NOME FROM INGREDIENTIRICETTE, INGREDIENTI
        WHERE v_idRicetta = INGREDIENTIRICETTE.IDRICETTA AND INGREDIENTIRICETTE.IDINGREDIENTE = INGREDIENTI.IDINGREDIENTE)

        LOOP

        --Lo facciamo vedere al birraio solo se utilizzabile
        if(v_record.utilizzabile=1) then

        modGUI.ApriRigaTabella;
        
           modGUI.ElementoTabella(to_char(v_record.NOME));

            modGUI.ElementoTabella(to_char(v_record.QUANTITA));

        MODGUI.ApriElementoTabella;

                  MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.ricetteUsanoIngrediente', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_idingrediente',v_record.IDINGREDIENTE);
                    modGUI.ChiudiFormHidden;
                    modGUI.ChiudiElementoTabella;


        modGUI.ChiudiRigaTabella;
        end if;
        end loop;


    modGUI.ChiudiTabella;
    modGUI.ChiudiPagina;

    end visualizzaIngredienti;


      procedure ricetteUsanoIngrediente(idSessione number,v_idingrediente number) is
          v_nome varchar2(50);
              v_idbirraio number;
          begin
              select INGREDIENTI.NOME INTO V_NOME FROM INGREDIENTI WHERE INGREDIENTI.IDINGREDIENTE=v_idingrediente;
              v_idbirraio := login.GETIDUTENTE(idSessione);
              modGUI.ApriPagina('Ricette che lo usano',idSessione);
                modGUI.INTESTAZIONE(1,'Ricette condivise con te che usano ' || v_nome);
                modGUI.ApriTabella;
                modGUI.APRIRIGATABELLA;

                modGUI.IntestazioneTabella('Nome');
                modGUI.IntestazioneTabella('Dettagli');
                modGUI.IntestazioneTabella('Chi la vende');

        modGUI.ChiudiRigaTabella;
              for v_record in (SELECT RICETTE.NOME,ricette.IDRICETTA,RICETTE.UTILIZZABILE FROM Ricette,RICETTECONDIVISE WHERE ricette.UTILIZZABILE=1 and RICETTE.IDRICETTA=RICETTECONDIVISE.IDRICETTA AND RICETTECONDIVISE.IDBIRRAIO=v_idbirraio)
              loop
                    if(v_record.utilizzabile=1) then
                  modGUI.ApriRigaTabella;
                  modGUI.ElementoTabella(v_record.NOME);
                  MODGUI.ApriElementoTabella;

                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.visualizzaRicetta', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_idRicetta',v_record.IDRICETTA);
                    modGUI.ChiudiFormHidden;

                  modGUI.ChiudiElementoTabella;

                  MODGUI.ApriElementoTabella;

                  MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.ricettaVendutaDa', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_nomeRic',v_record.nome);
                    modGUI.ChiudiFormHidden;
                    modGUI.ChiudiElementoTabella;

                modGUI.ChiudiRigaTabella;
                  end if;
              end loop;

              modGUI.CHIUDITABELLA();
              modgui.CHIUDIPAGINA();
              end;

    procedure landingVPR(idSessione IN SESSIONI.IDSESSIONE%TYPE) is
    ruolo UTENTI.ruolo%type;

    begin

        ruolo:=login.GETROLEFROMSESSION(IDSESSIONE);
        if(ruolo='amministratore' ) THEN
        modGUI.ApriPagina('Le ricette', idSessione);

        modGUI.Intestazione(1, 'Cerca tra le ricette');

         modGUI.ApriForm(Costanti.server || Costanti.root || 'OperazioniCataniaStasula.visualizzaRicetteAdmin', 'form0', idSessione);
        else

        if(ruolo='birraio') then
        modGUI.ApriPagina('Le ricette', idSessione);
         modGUI.Intestazione(1, 'Cerca tra le ricette');
        else
            modGUI.ApriPagina('Le ricette disponibili', idSessione);
             modGUI.Intestazione(1, 'Cerca tra ricette disponibili');
            end if;

       
          if ruolo = 'cliente' then
          modGUI.ApriForm(Costanti.server || Costanti.root || 'OperazioniCataniaStasula.visualizzaRicetteCliente', 'form0', idSessione);
          else
         modGUI.ApriForm(Costanti.server || Costanti.root || 'OperazioniCataniaStasula.visualizzaRicette', 'form0', idSessione);
         end if;

        end if;



        -- idsessione passato automaticamente con apriForm
            modGUI.CasellaDiTesto( 'v_nome', 'Nome: ',----
                                  suggerimento=>'Inserisci ricetta da cercare',
                                  require=>false,tipo=>'alfa');
            if(ruolo='birraio') then
            modGUI.PASSAPARAMETRO('idBirraio','');
            end if;

            modGUI.APRIBLOCCO();
            modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form0',TESTO => 'Cerca');
            modGUI.CHIUDIBLOCCO;

            modGUI.ChiudiForm;

      modGUI.ChiudiPagina;

    end;


        procedure visualizzaRicette(idSessione number,
                                              v_nome IN Ricette.nome%TYPE DEFAULT NULL,
                                              idBirraio BIRRAI.IDBIRRAIO%TYPE DEFAULT NULL,
                                              v_mixed IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_wgrain IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_extract IN Ricette.metodologie%TYPE DEFAULT '777',
                                              flag number default 1) is
            v_idBirraio number;
            v_idSessione number;
            v2_nome Ricette.nome%TYPE;
            nomeBirraio Birrai.nome%type;
            cognomeBirraio Birrai.nome%type;
            v1 Ricette.metodologie%TYPE;
            v2 Ricette.metodologie%TYPE;
            v3 Ricette.metodologie%TYPE;
            f number;
                v_role varchar2(30);
        begin
        if flag = 1 then
          v1 := 'mixed';
          v2 := 'whole grain';
          v3 := 'extract';
          f := 0;
        else
          v1 := v_mixed;
          v2 := v_wgrain;
          v3 := v_extract;
        end if;
        v_role := login.GETROLEFROMSESSION(idSessione);
        v_idSessione := idSessione;
        if idBirraio is null then --un birraio (proprietario) ha chiamato la procedura
        modGUI.ApriPagina('Le tue ricette',v_idSessione);
        modGUI.Intestazione(1, 'Guarda le tue ricette');
        v_idBirraio := getIdUtente(v_idSessione);
        ELSE --l'amministratore o un cliente chiama la procedura
        v_idBirraio := idBirraio;
        SELECT nome, cognome into nomeBirraio,cognomeBirraio from birrai where Birrai.idbirraio=v_idBirraio;
        modGUI.ApriPagina('Le ricette di ' || nomeBirraio || ' ' || cognomeBirraio ,v_idSessione);
        modGUI.Intestazione(1, 'Guarda le ricette di ' || nomeBirraio || ' ' || cognomeBirraio);

        end if;

            modgui.APRIBLOCCO(ETICHETTA  => '' /*IN VARCHAR2*/,
                              CENTER  => true /*IN BOOLEAN*/);
            modgui.APRIFORM(AZIONE  => Costanti.server || Costanti.root || 'OperazioniCataniaStasula.visualizzaRicette' /*IN VARCHAR2*/,
                            NOME  => 'checkbox_form' /*IN VARCHAR2*/,
                            IDSESSIONE  => idSessione /*IN NUMBER(38)*/);
            modgui.CHECKBOX(ETICHETTA  => 'mixed' /*IN VARCHAR2*/,
                            NOME  => 'v_mixed' /*IN VARCHAR2*/,
                            VALORE  => 'mixed' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.CHECKBOX(ETICHETTA  => 'whole grain' /*IN VARCHAR2*/,
                            NOME  => 'v_wgrain' /*IN VARCHAR2*/,
                            VALORE  => 'whole grain' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.CHECKBOX(ETICHETTA  => 'extract' /*IN VARCHAR2*/,
                            NOME  => 'v_extract' /*IN VARCHAR2*/,
                            VALORE  => 'extract' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.PASSAPARAMETRO(NOME  => 'flag' /*IN VARCHAR2*/,
                                  VALORE  => to_char(f) /*IN VARCHAR2*/);
            modgui.BOTTONE(TESTO  => 'Filtra' /*IN VARCHAR2*/,
                           NOME  => 'bottone' /*IN VARCHAR2*/);
            modgui.ChiudiForm();
            modgui.CHIUDIBLOCCO();



            modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;

            modGUI.IntestazioneTabella('Nome Ricetta');
            modGUI.IntestazioneTabella('Utilizzabile');
            if( not v_role='cliente') then
            modGUI.IntestazioneTabella('Dettagli');
            end if;

            modGUI.ChiudiRigaTabella;
            if v_nome is null THEN
              v2_nome := '';
            else
              v2_nome := v_nome;
            end if;
            for v_record in
                (SELECT * FROM RICETTE
                WHERE v_idBirraio = RICETTE.IDBIRRAIO AND LOWER(RICETTE.NOME) LIKE LOWER('%' || v2_nome || '%')
                AND (RICETTE.METODOLOGIE = v1
                    OR RICETTE.METODOLOGIE = v2
                    OR RICETTE.METODOLOGIE = v3))
                -- v1 v2 v3
                -- default = ' '

                  loop
                    modGUI.ApriRigaTabella;
                    if(v_role<>'cliente' or (v_role='cliente' and v_record.utilizzabile=1)) then
                      modGUI.ElementoTabella(v_record.NOME);

                           if(v_record.utilizzabile=1) then
                                modGUI.ElementoTabella('Si');
                           else
                                modGUI.ElementoTabella('No');
                            end if;
                        if(v_role<>'cliente') then
                      MODGUI.ApriElementoTabella;

                        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.visualizzaRicetta', v_idSessione);
                        MODGUI.bottoneInfo;
                        /* eventuale parametro da passare */
                        modGUI.PassaParametro('v_idRicetta',v_record.IDRICETTA);
                        modGUI.ChiudiFormHidden;
                         --è il birraio che sta chiamando la procedura
                        if(v_role='birraio') then
                        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.eliminaRicetta', v_idSessione);
                        MODGUI.bottoneDelete;
                        /* eventuale parametro da passare */
                        modGUI.PassaParametro('idRicetta', v_record.IDRICETTA);
                       modGUI.ChiudiFormHidden;


                        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.modificaRicetta', v_idSessione);
                        MODGUI.BOTTONEEDIT();
                        /* eventuale parametro da passare */
                        modGUI.PassaParametro('idRicetta', v_record.IDRICETTA);
                       modGUI.ChiudiFormHidden;
                        end if;
                        end if;
                      modGUI.ChiudiElementoTabella;


                    modGUI.ChiudiRigaTabella;
                      end if;

                end loop;
                modgui.CHIUDITABELLA();
                modGUI.ChiudiPagina;
        end;

        procedure visualizzaRicetta(idSessione number,v_idRicetta number) is
            CURSOR r is SELECT * FROM RICETTE WHERE v_idRicetta = RICETTE.IDRICETTA;
            v_record r%ROWTYPE;
            v_idSessione number;
            ruolo Utenti.RUOLO%type;
                popolarita float;
                birraicondivisi number;
                totbirrai number;
            begin
                select count(*) into totbirrai from BIRRAI;
                v_idSessione := idSessione;
                modgui.APRIPAGINA('Dettagli ricetta', v_idSessione);
                open r;
                fetch r into v_record;
                birraicondivisi := 0;
                select count(*) into birraicondivisi from RICETTECONDIVISE where RICETTECONDIVISE.IDRICETTA=v_record.IDRICETTA;
                popolarita :=ROUND(birraicondivisi*100/totbirrai,2);
                modgui.INTESTAZIONE(1,'Ricetta');
                modGUI.ApriTabella;
                modGUI.APRIRIGATABELLA;
                modGUI.ElementoTabella('Nome');
                modGUI.ElementoTabella(v_record.NOME);
                modGUI.ChiudiRigaTabella;

                modGUI.APRIRIGATABELLA;
                modGUI.ElementoTabella('Metodologia');
                modGUI.ElementoTabella(v_record.METODOLOGIE);
                modGUI.ChiudiRigaTabella;

                modGUI.APRIRIGATABELLA;
                modGUI.ElementoTabella('Istruzioni');
                modGUI.ElementoTabella(v_record.ISTRUZIONI);
                modGUI.ChiudiRigaTabella;

                modGUI.APRIRIGATABELLA;
                modGUI.ElementoTabella('Popolarità');
                modGUI.ElementoTabella(popolarita || '%');
                modGUI.ChiudiRigaTabella;

                modgui.chiuditabella;
                 modGUI.ApriForm(costanti.root || 'operazionicataniastasula.visualizzaIngredienti', 'visualizzaIngredienti',idSessione );
                 modgui.PASSAPARAMETRO(NOME  => 'idRicetta' /*IN VARCHAR2*/,
                                       VALORE  => to_char(v_idRicetta) /*IN VARCHAR2*/);
                modGUI.ApriBlocco();
                modGUI.Bottone('Visualizza Ingredienti');
                modGUI.CHIUDIBLOCCO;
                modGUI.ChiudiForm();

                ruolo:=login.GETROLEFROMSESSION(IDSESSION  => idSessione);

                if(ruolo='amministratore') THEN
                modGUI.ApriForm(costanti.root || 'operazionicataniastasula.ricettaVendutaDa', 'ricettaVendutaDa',idSessione );
                 modgui.PASSAPARAMETRO(NOME  => 'v_nomeRic' /*IN VARCHAR2*/,
                                       VALORE  => to_char(v_record.Nome) /*IN VARCHAR2*/);
                modGUI.ApriBlocco();
                modGUI.Bottone('Chi l''ha venduta');
                modGUI.CHIUDIBLOCCO;
                modGUI.ChiudiForm();
                end if;


        end;

        procedure eliminaRicetta(idSessione number, idRicetta number) IS
        v_idRicetta number;
        v_ruolo varchar2(40);
        BEGIN
          v_idRicetta :=idRicetta;
          UPDATE RICETTE
          SET UTILIZZABILE=0
          WHERE v_idRicetta = RICETTE.IDRICETTA;
          
          v_ruolo := login.GETROLEFROMSESSION(idSessione);
          if v_ruolo = 'amministratore' THEN
          modgui.reindirizza(costanti.server || costanti.root || 'operazionicataniastasula.visualizzaRicetteAdmin?idSessione=' || idSessione);
          end if;
          if v_ruolo = 'birraio' then
          modgui.reindirizza(costanti.server || costanti.root || 'operazionicataniastasula.visualizzaRicette?idSessione=' || idSessione);
          end if;
        END;

        procedure modificaRicetta(idSessione number, idRicetta number) is
            begin

            modgui.APRIPAGINA('Modifica la ricetta',idSessione);
            modgui.INTESTAZIONE(1,'Modifica le istruzioni');


            modgui.APRIFORM(costanti.root ||'operazionicataniastasula.modificaIstruzioni','form1',idSessione);
            modgui.PASSAPARAMETRO('idRicetta',to_char(idRicetta));
            modgui.CASELLADITESTO('Istruzioni','','Istruzioni',TIPO => 'alfa',REQUIRE => true);
            modgui.APRIBLOCCO(CENTER => true);
            modgui.BOTTONEFORM(valida=>true,nomeForm=>'form1',TESTO => 'Modifica');
            modgui.CHIUDIFORM();
            modgui.CHIUDIBLOCCO();


            modgui.APRIFORM(costanti.root ||'operazionicataniastasula.modificaIngredienti','form2',idSessione);
            MODGUI.PASSAPARAMETRO('idRicetta',to_char(idRicetta));
            --modgui.BOTTONEEDIT();
            modgui.APRIBLOCCO(CENTER => true);
            modgui.BOTTONEFORM(valida=>true,nomeForm=>'',TESTO => 'Modifica dosaggi');
            modgui.CHIUDIFORM();
            modgui.CHIUDIBLOCCO();



            modgui.CHIUDIPAGINA();

        end;

        procedure modificaIstruzioni(idSessione  number, idRicetta number, Istruzioni varchar2) is
            v_idricetta Ricette.idricetta%TYPE;
            v_istruzioni Ricette.istruzioni%TYPE;
            v_path varchar2(500);
                riga modgui.stringDict;
            begin
                --modgui.APRIPAGINA('Istruzioni modificate',idSessione);
                --modgui.INTESTAZIONE(1,'Modifica le istruzioni');
                v_istruzioni := Istruzioni;
                v_idricetta := idRicetta;

                UPDATE Ricette SET Ricette.ISTRUZIONI=v_istruzioni, RICETTE.ULTIMA_MODIFICA=CURRENT_DATE WHERE Ricette.IDRICETTA=v_idricetta;
                 v_path := Costanti.root || 'operazionicataniastasula.visualizzaRicetta';
                riga('v_idricetta') := idRicetta;
                 MODGUI.PAGINAFEEDBACK('Successo','Hai modificato correttamente la ricetta!',v_path,idSessione,riga);



            end;
        procedure modificaIngredienti(idSessione  number, idRicetta number) is
            v_idricetta number;
            begin
                v_idricetta := idRicetta;
                modgui.APRIPAGINA('Modifica gli ingredienti',idSessione);
                modgui.INTESTAZIONE(1,'Modifica gli ingredienti');


                modGui.APRIFORM(COSTANTI.root || 'operazionicataniastasula.confermaModificaIngrediente','form1',idSessione);
                modgui.PASSAPARAMETRO('v_idricetta',idRicetta);
                modgui.APRIBLOCCOSELECT('',true);
                modgui.APRISELECT('v_idingrediente',true);
                for v_record IN (SELECT INGREDIENTI.IDINGREDIENTE,INGREDIENTI.nome
                    FROM INGREDIENTIRICETTE, INGREDIENTI
                    WHERE INGREDIENTIRICETTE.IDRICETTA=v_idricetta AND INGREDIENTIRICETTE.IDINGREDIENTE = INGREDIENTI.IDINGREDIENTE
                    ) loop

                    modgui.AGGIUNGIOPZIONESELECT(v_record.IDINGREDIENTE,v_record.NOME);

                    end loop;
                    --TODO: check require
                modgui.CHIUDISELECT();
                modgui.CHIUDIBLOCCOSELECT();
                modgui.CASELLADITESTO('v_quantita','','Inserisci quantita',REQUIRE => TRUE,TIPO => 'number');
                modgui.APRIBLOCCO('',CENTER => TRUE);
                modgui.BOTTONEFORM('bott','Modifica','Modifica',true,'form1');
                modgui.CHIUDIBLOCCO();
                modgui.CHIUDIFORM();
                modgui.CHIUDIPAGINA();
            end;

        procedure confermaModificaIngrediente(idSessione number,v_idricetta number,v_idingrediente number,v_quantita number) is
            v_path varchar2(500);
                riga modgui.stringDict;
            begin
                    UPDATE INGREDIENTIRICETTE
                    SET QUANTITA=v_quantita
                    WHERE v_idRicetta = INGREDIENTIRICETTE.IDRICETTA
                    AND v_idingrediente = INGREDIENTIRICETTE.IDINGREDIENTE;

                    UPDATE RICETTE
                    SET ricette.ULTIMA_MODIFICA=current_date
                WHERE RICETTE.IDRICETTA=v_idricetta;

                    v_path := Costanti.root || 'operazionicataniastasula.modificaIngredienti';
                riga('idRicetta') := v_idricetta;
                 MODGUI.PAGINAFEEDBACK('Successo','Hai modificato correttamente gli ingredienti della ricetta!',v_path,idSessione,riga);

                end;



         procedure visualizzaMedieBirraiLotti(idSessione number) is
          v_litriTotali number;
          v_qualita number;
          v_prezzoMedio number;
          v_lottiInconclusi number;
          v_lottiEsauriti number;
          p_istruzioni varchar2(500);

         BEGIN

         -- test
        -- v_litriTotali :=1;
        -- v_qualita :=2;
        -- v_prezzoMedio :=3;
        -- v_lottiInconclusi := 4;
        -- v_lottiEsauriti := 5;
         -- end test

         -- UNCOMMENT =============================================
           modgui.APRIPAGINA('Classifica birrai', idSessione);
           modgui.INTESTAZIONE(TIPO  => 1 /*IN NUMBER(38)*/,
                               TESTO  => 'Rating birrai' /*IN VARCHAR2*/);

          modGUI.ApriTabella;
          modGUI.APRIRIGATABELLA;


          modGUI.IntestazioneTabella('Nome');
          modGUI.IntestazioneTabella('Cognome');
          modGUI.IntestazioneTabella('Litri venduti');
          modGUI.IntestazioneTabella('Qualita media');
          modGUI.IntestazioneTabella('Prezzo/litro medio');
          modGUI.IntestazioneTabella('Lotti inconclusi');
          modGUI.IntestazioneTabella('Lotti esauriti');
          modGUI.IntestazioneTabella('Profilo');


            modGUI.ChiudiRigaTabella;
           for v_record in (
              SELECT BIRRAI.IDBIRRAIO, BIRRAI.NOME,BIRRAI.COGNOME, ROUND(avg(prezzo_litro),2) as mediaPrezzo ,sum(NUMERO_LITRI) as totLitri, QL.QUALITA AS qualitaProduzione--, LA.NUMLOTTI as lottiAnnullati, LE.NUMLOTTI as lottiEsauriti
              FROM BIRRAI,ORDINICLIENTILOTTI, LOTTI, QUALITABIRRAI QL--, LOTTIANNULLATIBIRRAIO LA, LOTTIESAURITIBIRRAIO LE
              WHERE LOTTI.IDLOTTO = ORDINICLIENTILOTTI.idLOTTO
                  and BIRRAI.IDBIRRAIO = LOTTI.idbirraio AND QL.IDBIRRAIO = BIRRAI.IDBIRRAIO
                  --AND BIRRAI.IDBIRRAIO = LE.IDBIRRAIO AND BIRRAI.IDBIRRAIO = LA.IDBIRRAIO
              -- WHERE IDLOTTO=ANY(select idlotto from lotti where LOTTI.idbirraio=BIRRAI.idbirraio)
              GROUP BY BIRRAI.IDBIRRAIO,BIRRAI.NOME,BIRRAI.COGNOME, QL.QUALITA--, LA.NUMLOTTI,LE.NUMLOTTI
              ORDER BY totLitri DESC)
            LOOP

                SELECT COUNT(*) INTO v_lottiInconclusi FROM LOTTI
                WHERE v_record.IDBIRRAIO = LOTTI.IDBIRRAIO AND
                LOTTI.LITRI_RESIDUI > 0 AND LOTTI.STATO = 'archiviato';

                SELECT COUNT(*) INTO v_lottiEsauriti FROM LOTTI
                WHERE v_record.IDBIRRAIO = LOTTI.IDBIRRAIO AND
                LOTTI.LITRI_RESIDUI = 0 AND LOTTI.STATO = 'archiviato';

                modgui.APRIRIGATABELLA;
                -- SE A ESEGUIRLA E' ADMIN -> NOME E COGNOME DIVENTANO LINK AL PROFILO DEL BIRRAIO
                -- IN OGNI CASO IL TASTO INFO PORTA ALLA PAGINA CHE VISUALIZZA I LOTTI ATTUALMENTE IN VENDITA

                modGUI.ElementoTabella(v_record.NOME);
                modGUI.ElementoTabella(v_record.COGNOME);

                p_istruzioni := Costanti.server || Costanti.root || 'OPERAZIONICATANIASTASULA.visualizzaLottiVendutiBirraio?idSessione=' || idSessione || '&idBirraio=' || v_record.IDBIRRAIO;

                modGUI.APRIELEMENTOTABELLA();
                modGUI.COLLEGAMENTO(v_record.totLitri,p_istruzioni);
                modGUI.CHIUDIELEMENTOTABELLA();

                --modGUI.ElementoTabella(v_record.totLitri);
                modGUI.ElementoTabella(v_record.qualitaProduzione);
                modGUI.ElementoTabella(v_record.mediaPrezzo);
                modGUI.ElementoTabella(v_lottiInconclusi);
                modGUI.ElementoTabella(v_lottiEsauriti);

                modGUI.ApriElementoTabella;
                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.profiloBirraio', idSessione);
                      modgui.PassaParametro('v_idBirraio',v_record.IDBIRRAIO);
                      MODGUI.bottoneInfo;
                      /* eventuale parametro da passare */
                      --modGUI.PassaParametro('v_idBirraio',v_record.IDBIRRAIO);
                      modGUI.ChiudiFormHidden;
                modGUI.ChiudiElementoTabella;

                modgui.ChiudiRigaTabella;

            END LOOP;

            modGUI.ChiudiTabella;
            modGUI.ChiudiPagina;
            END;
        procedure landingRCB(
idSessione IN SESSIONI.IDSESSIONE%TYPE
)
is
begin
    modGUI.ApriPagina('Ricette condivise', idSessione);

    modGUI.Intestazione(1, 'Cerca tra le ricette condivise con te');

        modGUI.ApriForm(Costanti.server || Costanti.root || 'OperazioniCataniaStasula.ricetteCondiviseBirraio', 'form1', idSessione);

        modGUI.CasellaDiTesto( 'v_nomeRic', 'Nome: ',
                                  suggerimento=>'Inserisci ricetta da cercare ',
                                  require=>false,tipo=>'alfa');
        modGUI.APRIBLOCCO();
        modGUI.CHECKBOX('Quelle utilizzabili?','v_utilizzabile','1',true);
        modGUI.CHIUDIBLOCCO;

        modGUI.APRIBLOCCO();
        modGUI.BOTTONEFORM(valida=>true,nomeForm=>'form1');
        modGUI.CHIUDIBLOCCO;

        modGUI.CHIUDIFORM();

	modGUI.ChiudiPagina;

end ;
        procedure ricetteCondiviseBirraio(
   idSessione IN  Sessioni.IDSESSIONE%TYPE,
   v_nomeRic IN Ricette.nome%TYPE DEFAULT NULL,
   v_utilizzabile IN Ricette.utilizzabile%TYPE DEFAULT 0)
is
    v_idbirraio Birrai.idbirraio%TYPE;
    CURSOR r(v_nidbirraio Birrai.idbirraio%TYPE, nomeRic Ricette.nome%TYPE) is
        SELECT r.idricetta,nome,utilizzabile,metodologie,istruzioni
        FROM RicetteCondivise rc, Ricette r
        WHERE rc.IDRICETTA = r.IDRICETTA AND rc.idbirraio=v_nidbirraio AND r.utilizzabile>=v_utilizzabile AND r.nome LIKE '%' || nomeRic || '%'
        ORDER BY r.utilizzabile DESC, r.nome;
    v_record r%ROWTYPE;
    v1_nomeRic Ricette.nome%TYPE;
    v_tmp number;
begin

modGUI.APRIPAGINA('Ricette condivise',idSessione);

modGUI.INTESTAZIONE(1,'Ricette condivise con te');

modGUI.ApriTabella;
modGUI.APRIRIGATABELLA;

        modGUI.IntestazioneTabella('Nome Ricetta');
        modGUI.IntestazioneTabella('Utilizzabile');
        modGUI.INTESTAZIONETABELLA('Dettagli');

modGUI.ChiudiRigaTabella;

v_idbirraio := getIdUtente(idSessione);
if (v_nomeRic is null) then
    v1_nomeRic:=''; --so the wildcard %v_nomeRic% satisfies every name
else
    v1_nomeRic:=v_nomeRic;
end if;

for v_record in r(v_idbirraio,v1_nomeRic)
  loop
      modGUI.ElementoTabella(v_record.NOME);

      if(v_record.utilizzabile=1) then
          modGUI.ElementoTabella('Si');
      else
          modGUI.ElementoTabella('No');
      end if;
      v_tmp := 0;
        select count(*) into v_tmp from RICETTE where ricette.IDRICETTA=v_record.IDRICETTA and RICETTE.IDBIRRAIO=v_idbirraio;

      MODGUI.ApriElementoTabella;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.visualizzaRicetta', idSessione);
        MODGUI.bottoneInfo;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('v_idRicetta',v_record.IDRICETTA);
        modGUI.ChiudiFormHidden;
        if(v_tmp>0) then
         MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.modificaRicetta', idSessione);
        MODGUI.BOTTONEEDIT();
        /* eventuale parametro da passare */
        modGUI.PassaParametro('idRicetta', v_record.IDRICETTA);
        modGUI.ChiudiFormHidden;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.eliminaRicetta', idSessione);
        MODGUI.bottoneDelete;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('idRicetta', v_record.IDRICETTA);
        modGUI.ChiudiFormHidden;
        end if;
      modGUI.ChiudiElementoTabella;


    modGUI.ChiudiRigaTabella;
 end loop;

 modGUI.ChiudiTabella;
 modGUI.CHIUDIPAGINA;

end RicetteCondiviseBirraio;
        procedure ricettaVendutaDa(
    idSessione IN  Sessioni.IDSESSIONE%TYPE,
    v_nomeRic IN Ricette.nome%TYPE DEFAULT NULL
    ) is
    CURSOR r1(nomeRic Ricette.nome%TYPE) is (
                SELECT DISTINCT b.idbirraio, b.NOME,b.COGNOME,r.IDRICETTA
                FROM Birrai b , Lotti l, Ricette r
                WHERE r.IDRICETTA=l.IDRICETTA AND l.IDBIRRAIO=b.IDBIRRAIO
                AND l.STATO = 'vendita' AND r.NOME=nomeRic
            );
     v_birraio r1%ROWTYPE;
        p_ricetteBirraio varchar2(500);
    stars NUMBER(2);
begin
modGUI.APRIPAGINA(v_nomeRic,idSessione);

modGUI.INTESTAZIONE(1,'Birrai che stanno vendendo '|| v_nomeRic);

modGUI.ApriTabella;
modGUI.APRIRIGATABELLA;

        modGUI.IntestazioneTabella('Nome');
        modGUI.IntestazioneTabella('Valutazione');
        modGUI.IntestazioneTabella('Le sue ricette');

modGUI.ChiudiRigaTabella;


for v_birraio in r1(v_nomeRic)
  loop
      modGUI.ApriRigaTabella;

    select avg(qualita)
    into stars
    from recensioni re, ricette ri, lotti l, birrai b
    where ri.idricetta=v_birraio.IDRICETTA and l.idricetta=ri.idricetta
      and l.idlotto=re.idlotto and b.idbirraio=l.idbirraio
        and b.IDBIRRAIO=v_birraio.IDBIRRAIO
    group by b.nome;

      p_ricetteBirraio := Costanti.server || Costanti.root || 'OPERAZIONICATANIASTASULA.visualizzaRicette?idSessione=' || to_char(idSessione) ||'=' || ''|| '=' || to_char(v_birraio.idbirraio);

        modGUI.ELEMENTOTABELLA(TESTO  =>v_birraio.nome || ' ' || v_birraio.COGNOME);

        modGUI.ElementoTabella(TO_CHAR(stars));

        MODGUI.ApriElementoTabella;

        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.visualizzaRicette', idSessione);
        MODGUI.bottoneInfo;
        /* eventuale parametro da passare */
        modGUI.PassaParametro('v_nome','');
        modGUI.PASSAPARAMETRO(NOME  => 'idBirraio',
                              VALORE  => to_char(v_birraio.idbirraio));
        modGUI.ChiudiFormHidden;
        modGUI.ChiudiElementoTabella;
      modGUI.ChiudiRigaTabella;
 end loop;

 modGUI.ChiudiTabella;
 modGUI.CHIUDIPAGINA;
end;
        procedure visualizzaRicetteAdmin(idSessione in Sessioni.IDSESSIONE%type,v_nome in RICETTE.NOME%type default null) IS
v2_nome RICETTE.NOME%type;
BEGIN
modGUI.APRIPAGINA(TITOLO  => 'Tutte le ricette',
                  IDSESSIONE  => IDSESSIONE);
modGUI.INTESTAZIONE(1,'Visualizza tutte le ricette');
modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;

            modGUI.IntestazioneTabella('Nome Ricetta');
            modGUI.IntestazioneTabella('Utilizzabile');
            modGUI.IntestazioneTabella('Dettagli');
            modGUI.IntestazioneTabella('Venditori');

            modGUI.ChiudiRigaTabella;
            if v_nome is null THEN
              v2_nome := '';
            else
              v2_nome := v_nome;
            end if;
            for v_record in
                (SELECT * FROM RICETTE WHERE LOWER(RICETTE.NOME) LIKE LOWER('%' || v2_nome || '%'))
                  loop
                    modGUI.ApriRigaTabella;
                  modGUI.ElementoTabella(v_record.NOME);

                       if(v_record.utilizzabile=1) then
                            modGUI.ElementoTabella('Si');
                       else
                            modGUI.ElementoTabella('No');
                        end if;

                  MODGUI.ApriElementoTabella;

                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.visualizzaRicetta', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_idRicetta',v_record.IDRICETTA);
                    modGUI.ChiudiFormHidden;

                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.eliminaRicetta', idSessione);
                    MODGUI.bottoneDelete;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('idRicetta', v_record.IDRICETTA);
                   modGUI.ChiudiFormHidden;

                  modGUI.ChiudiElementoTabella;

                  MODGUI.ApriElementoTabella;

                  MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.ricettaVendutaDa', idSessione);
                    MODGUI.bottoneInfo;
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('v_nomeRic',v_record.nome);
                    modGUI.ChiudiFormHidden;
                    modGUI.ChiudiElementoTabella;

                modGUI.ChiudiRigaTabella;

                end loop;
                modGUI.chiuditabella;

                modGUI.ChiudiPagina;

END;
procedure profiloBirraio(idSessione number, v_idBirraio number default null) IS

cursor r(idbirr number) is (SELECT * FROM BIRRAI WHERE idbirr = IDBIRRAIO );
v_record r%ROWTYPE;
v_idbir number;
BEGIN
    if v_idBirraio is null then
    v_idbir :=login.GETIDUTENTE(idSessione);
    else v_idbir := v_idBirraio;
    end if;

  open r(v_idbir);
  fetch r into v_record;

  modGUI.APRIPAGINA(TITOLO  => 'Profilo birraio',
                    IDSESSIONE  => IDSESSIONE);
  modGUI.INTESTAZIONE(1,'Profilo di ' || v_record.NOME || ' ' || v_record.COGNOME);
  modGUI.ApriTabella;

        modGUI.APRIRIGATABELLA;

        modGUI.ELEMENTOTABELLA(TESTO  => 'Nome' /*IN VARCHAR2*/);
        modGUI.ELEMENTOTABELLA(TESTO  => v_record.NOME /*IN VARCHAR2*/);
        modGUI.ChiudiRigaTabella;
        modGUI.ELEMENTOTABELLA(TESTO  => 'Cognome' /*IN VARCHAR2*/);
        modGUI.ELEMENTOTABELLA(TESTO  => v_record.Cognome /*IN VARCHAR2*/);
        modGUI.ChiudiRigaTabella;
        modGUI.ELEMENTOTABELLA(TESTO  => 'Telefono' /*IN VARCHAR2*/);
        modGUI.ELEMENTOTABELLA(TESTO  => v_record.TELEFONO /*IN VARCHAR2*/);
        modGUI.ChiudiRigaTabella;
        modGUI.ELEMENTOTABELLA(TESTO  => 'Indirizzo' /*IN VARCHAR2*/);
        modGUI.ELEMENTOTABELLA(TESTO  => v_record.INDIRIZZO /*IN VARCHAR2*/);
        modGUI.ChiudiRigaTabella;
        modGUI.ELEMENTOTABELLA(TESTO  => 'Ragione sociale' /*IN VARCHAR2*/);
        modGUI.ELEMENTOTABELLA(TESTO  => v_record.RAGIONE_SOCIALE /*IN VARCHAR2*/);
        modGUI.ChiudiRigaTabella;
  modGUI.ChiudiTabella;

END;

procedure visualizzaLottiVendutiBirraio (idSessione number, idBirraio number default null) IS
v_idBirraio number;
NomeBirraio varchar2(50);
CognomeBirraio varchar2(50);
BEGIN
  if idBirraio is null THEN
    v_idBirraio := getIdUtente(idSessione);
  ELSE
    v_idBirraio := idBirraio;
  end if;

  SELECT B.NOME, B.COGNOME INTO NomeBirraio, CognomeBirraio
  FROM BIRRAI B
  WHERE B.IDBIRRAIO = v_idBirraio;
  modgui.APRIPAGINA(TITOLO  => 'Lotti prodotti' /*IN VARCHAR2*/,
                    IDSESSIONE  => idSessione /*IN NUMBER(38)*/);
  modgui.INTESTAZIONE(TIPO  => 1 /*IN NUMBER(38)*/,
                      TESTO  => 'Lotti prodotti da ' || NomeBirraio || ' ' || CognomeBirraio/*IN VARCH2*/);

  modgui.ApriTabella;
  modgui.ApriRigaTabella;
    modGUI.INTESTAZIONETABELLA(TESTO  => 'Nome' /*IN VARCHAR2*/);
    modgui.INTESTAZIONETABELLA(TESTO  => 'Inizio produzione' /*IN VARCHAR2*/);
    modgui.INTESTAZIONETABELLA(TESTO  => 'Scadenza' /*IN VARCHAR2*/);
    modgui.INTESTAZIONETABELLA(TESTO  => 'Stato' /*IN VARCHAR2*/);
  modgui.ChiudiRigaTabella;

  for v_record in (
    SELECT B.IDBIRRAIO, B.NOME, COGNOME, L.NOME as nomeLotto, INIZIO_PRODUZIONE as initProd, SCADENZA as scad, STATO as stato
    FROM BIRRAI B,LOTTI L
    WHERE v_idBirraio = B.IDBIRRAIO and L.IDBIRRAIO = v_idBirraio
  )
  LOOP
    modgui.ApriRigaTabella;
    modgui.ELEMENTOTABELLA(TESTO  => v_record.nomeLotto /*IN VARCHAR2*/);
    modgui.ELEMENTOTABELLA(TESTO  => v_record.initProd /*IN VARCHAR2*/);
    modgui.ELEMENTOTABELLA(TESTO  => v_record.scad /*IN VARCHAR2*/);
    modgui.ELEMENTOTABELLA(TESTO  => v_record.stato /*IN VARCHAR2*/);
    modgui.ChiudiRigaTabella;

  end loop;
  modgui.ChiudiTabella;

END;
    procedure visualizzaLottiBirraio(idSessione number) is
            v_idbirraio number;
                v_nome varchar2(64);
                    v_cognome varchar2(64);
    begin

        v_idbirraio := login.GETIDUTENTE(idSessione);
        SELECT BIRRAI.nome,Birrai.cognome
        into v_nome,v_cognome
            FROM BIRRAI
            WHERE birrai.IDBIRRAIO=v_idbirraio;


        modgui.APRIPAGINA(TITOLO  => 'Visualizza i tuoi lotti' /*IN VARCHAR2*/,
                    IDSESSIONE  => idSessione /*IN NUMBER(38)*/);
        modgui.INTESTAZIONE(TIPO  => 1 /*IN NUMBER(38)*/,
                      TESTO  => 'Lotti prodotti da ' || v_nome || ' ' || v_cognome/*IN VARCH2*/);

        modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;

            modGUI.IntestazioneTabella('Nome');
            modgui.INTESTAZIONETABELLA('Stato');
            modGUI.IntestazioneTabella('Dettagli');
            modGUI.IntestazioneTabella('Annota');
            modgui.INTESTAZIONETABELLA('Annotazioni');

            modGUI.ChiudiRigaTabella;

            for v_record in
                (SELECT * FROM LOTTI WHERE LOTTI.IDBIRRAIO=v_idbirraio)
                  loop
                    modGUI.ApriRigaTabella;
                  modGUI.ElementoTabella(v_record.NOME);

                  MODGUI.ApriElementoTabella;
                    modgui.paragrafo(v_record.STATO);
                    if v_record.STATO = 'produzione' or v_record.STATO = 'vendita' then
                        MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'opBirrai.modificaStatoLotto', idSessione);
                        MODGUI.BOTTONEEDIT();
                        /* eventuale parametro da passare */
                        modGUI.PassaParametro('id_lotto',v_record.IDLOTTO);
                        modGUI.ChiudiFormHidden;
                    end if;
                  modGUI.ChiudiElementoTabella;

                  MODGUI.ApriElementoTabella;
                    --TODO: CHECK CON GRUPPO 3
                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'gruppo3.dettaglilotti', idSessione);
                    MODGUI.BOTTONEINFO();
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('id_lotto',v_record.IDLOTTO);
                    modGUI.ChiudiFormHidden;
                    modGUI.ChiudiElementoTabella;

                    MODGUI.APRIELEMENTOTABELLA();
                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'operazionicataniastasula.inserisciannotazione', idSessione);
                    MODGUI.BOTTONEEDIT();
                    /* eventuale parametro da passare */
                    modGUI.PassaParametro('idLotto', v_record.IDLOTTO);
                   modGUI.ChiudiFormHidden;

                  modGUI.ChiudiElementoTabella;

                    MODGUI.APRIELEMENTOTABELLA();--todo:check nome e funzionamento
                    MODGUI.APRIFORMHIDDEN(Costanti.server || Costanti.root || 'opBirrai.visualizzaAnnotazioni', idSessione);
                    modGUI.PassaParametro('id_lotto', v_record.IDLOTTO);
                    MODGUI.BOTTONEINFO();
                   modGUI.ChiudiFormHidden;

                  modGUI.ChiudiElementoTabella;

                    modgui.CHIUDIRIGATABELLA();

                end loop;
                modGUI.chiuditabella;

                modGUI.ChiudiPagina;

        end;

        function doppioIngrediente(v_idRicetta number, v_idIngrediente number) return boolean IS
        v_numero NUMBER;
        BEGIN
          SELECT COUNT(*) into v_numero
          FROM INGREDIENTIRICETTE
          WHERE v_idRicetta = IDRICETTA
          AND v_idIngrediente = IDINGREDIENTE;
          if(v_numero > 0) then return true;
          else return false;
          end if;
        END;
        -- TODO : SUL TOTALE ORDINI BIRRAI FORNITORI -> DIVISIONE IN FASCE SUL PREZZO TOTALE DEGLI ORDINI

    procedure statisticaPrezzoOrdiniAdmin(idSessione number) is

        -- CURSOR r(fromvalue number,tovalue number, totordini number) is
        -- select count(*)/totordini
        --     from ORDINIBIRRAI
        --         where ORDINIBIRRAI.PREZZO_TOTALE BETWEEN fromvalue AND tovalue;

        v_totordini number;
            soglia1 number;
            soglia2 number;
            soglia3 number;
            fascia1 number;
            fascia2 number;
            fascia3 number;
            fascia4 number;
    begin
        soglia1 := 50;
        soglia2 := 100;
        soglia3 := 150;

        v_totordini :=0;
        fascia1 := 0;
        fascia2 := 0;
        fascia3 := 0;
        fascia4 := 0;


        for v_record in (select * from ORDINIBIRRAI) loop
            v_totordini := v_totordini + 1;
            if(v_record.PREZZO_TOTALE <= soglia1) then
                fascia1 := fascia1 + 1;
                else if(v_record.PREZZO_TOTALE <= soglia2 AND v_record.PREZZO_TOTALE > soglia1) then
                    fascia2 := fascia2 + 1;
                    else if(v_record.PREZZO_TOTALE <= soglia3 AND v_record.PREZZO_TOTALE > soglia2) then
                        fascia3 := fascia3 + 1;
                        else
                        fascia4 := fascia4 + 1;
                    end if;
                end if;
            end if;
            end loop;
        modgui.APRIPAGINA(TITOLO  => 'Statistica ordini birrai' /*IN VARCHAR2*/,
                          IDSESSIONE  => idSessione /*IN NUMBER(38)*/);

        modgui.INTESTAZIONE(TIPO  => 1/*IN NUMBER(38)*/,
                            TESTO  => 'Statistica degli ordini dei birrai per fasce di prezzo' /*IN VARCHAR2*/);
        modgui.ApriTabella();
        modgui.ApriRigaTabella();
          modgui.INTESTAZIONETABELLA(TESTO  => 'Fascia di prezzo' /*IN VARCHAR2*/);
          modgui.INTESTAZIONETABELLA(TESTO  => 'Percentuale ordini' /*IN VARCHAR2*/);
        modgui.ChiudiRigaTabella();

        modgui.ApriRigaTabella();
          modgui.ELEMENTOTABELLA(TESTO  => '< € 50' /*IN VARCHAR2*/);
          modgui.ELEMENTOTABELLA(TESTO  => to_char(ROUND(fascia1/v_totordini*100,2)) || ' %');
        modgui.ChiudiRigaTabella();

        modgui.ApriRigaTabella();
          modgui.ELEMENTOTABELLA(TESTO  => '€ 50 - € 100' /*IN VARCHAR2*/);
          modgui.ELEMENTOTABELLA(TESTO  => to_char(ROUND(fascia2/v_totordini*100,2)) || ' %');
        modgui.ChiudiRigaTabella();

        modgui.ApriRigaTabella();
          modgui.ELEMENTOTABELLA(TESTO  => '€ 100 - € 150' /*IN VARCHAR2*/);
          modgui.ELEMENTOTABELLA(TESTO  => to_char(ROUND(fascia3/v_totordini*100,2)) || ' %');
        modgui.ChiudiRigaTabella();

        modgui.ApriRigaTabella();
          modgui.ELEMENTOTABELLA(TESTO  => '> € 150' /*IN VARCHAR2*/);
          modgui.ELEMENTOTABELLA(TESTO  => to_char(ROUND(fascia4/v_totordini*100,2)) || ' %');
        modgui.ChiudiRigaTabella();

        modgui.chiuditabella();
        modgui.ChiudiPagina();
        -- modgui.PARAGRAFO(to_char(fascia1/v_totordini*100));
        -- modgui.PARAGRAFO(to_char(fascia1/v_totordini*100));
        -- modgui.PARAGRAFO(to_char(fascia1/v_totordini*100));
        -- modgui.PARAGRAFO(to_char(fascia1/v_totordini*100));


        end;

      procedure visualizzaRicetteCliente(idSessione number,
                                              v_nome IN Ricette.nome%TYPE DEFAULT NULL,
                                              v_mixed IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_wgrain IN Ricette.metodologie%TYPE DEFAULT '777',
                                              v_extract IN Ricette.metodologie%TYPE DEFAULT '777',
                                              flag number default 1) is
            v2_nome Ricette.nome%TYPE;
            v1 Ricette.metodologie%TYPE;
            v2 Ricette.metodologie%TYPE;
            v3 Ricette.metodologie%TYPE;
            f number;
        begin
        if flag = 1 then
          v1 := 'mixed';
          v2 := 'whole grain';
          v3 := 'extract';
          f := 0;
        else
          v1 := v_mixed;
          v2 := v_wgrain;
          v3 := v_extract;
        end if;
       
      
        modGUI.ApriPagina('Le ricette disponibili ',idSessione);
        modGUI.Intestazione(1, 'Ricette disponibili');


            modgui.APRIBLOCCO(ETICHETTA  => '' /*IN VARCHAR2*/,
                              CENTER  => true /*IN BOOLEAN*/);
            modgui.APRIFORM(AZIONE  => Costanti.server || Costanti.root || 'OperazioniCataniaStasula.visualizzaRicette' /*IN VARCHAR2*/,
                            NOME  => 'checkbox_form' /*IN VARCHAR2*/,
                            IDSESSIONE  => idSessione /*IN NUMBER(38)*/);
            modgui.CHECKBOX(ETICHETTA  => 'mixed' /*IN VARCHAR2*/,
                            NOME  => 'v_mixed' /*IN VARCHAR2*/,
                            VALORE  => 'mixed' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.CHECKBOX(ETICHETTA  => 'whole grain' /*IN VARCHAR2*/,
                            NOME  => 'v_wgrain' /*IN VARCHAR2*/,
                            VALORE  => 'whole grain' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.CHECKBOX(ETICHETTA  => 'extract' /*IN VARCHAR2*/,
                            NOME  => 'v_extract' /*IN VARCHAR2*/,
                            VALORE  => 'extract' /*IN VARCHAR2*/,
                            SELEZIONATO  => false /*IN BOOLEAN*/);
            modgui.PASSAPARAMETRO(NOME  => 'flag' /*IN VARCHAR2*/,
                                  VALORE  => to_char(f) /*IN VARCHAR2*/);
            modgui.BOTTONE(TESTO  => 'Filtra' /*IN VARCHAR2*/,
                           NOME  => 'bottone' /*IN VARCHAR2*/);
            modgui.ChiudiForm();
            modgui.CHIUDIBLOCCO();



            modGUI.ApriTabella;
            modGUI.APRIRIGATABELLA;

            modGUI.IntestazioneTabella('Nome Ricetta');
            modGUI.IntestazioneTabella('Utilizzabile');

            modGUI.ChiudiRigaTabella;
            if v_nome is null THEN
              v2_nome := '';
            else
              v2_nome := v_nome;
            end if;
            for v_record in
                (SELECT * FROM RICETTE
                WHERE LOWER(RICETTE.NOME) LIKE LOWER('%' || v2_nome || '%')
                AND (RICETTE.METODOLOGIE = v1
                    OR RICETTE.METODOLOGIE = v2
                    OR RICETTE.METODOLOGIE = v3)AND RICETTE.UTILIZZABILE = 1)
                -- v1 v2 v3
                -- default = ' '

                  loop
                    modGUI.ApriRigaTabella;
                      modgui.elementotabella(v_record.NOME);
                      modgui.elementotabella('Si');
                    modGUI.ChiudiRigaTabella;
                   

                end loop;
                modgui.CHIUDITABELLA();
                modGUI.ChiudiPagina;
        end;

end;