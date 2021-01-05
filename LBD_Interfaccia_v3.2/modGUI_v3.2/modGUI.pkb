CREATE OR REPLACE PACKAGE BODY modGUI as

procedure Reindirizza(indirizzo varchar2) is
begin
	htp.prn('<head><meta http-equiv="refresh" content="0;url=' || indirizzo || '"></head>');

end Reindirizza;


procedure ApriPagina(titolo varchar2 default 'Senza titolo', idSessione int default 0) is
begin
	htp.htmlOpen;
	htp.headOpen;
	htp.title(titolo);
	htp.print('
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  '); 
  
  htp.print(' <link rel="shortcut icon" href="' || Costanti.server || Costanti.root || 'files_orcl2021_api.GetImage?p_name=beerlogo.png">');
  htp.print(' <style> ' || Costanti.stile || Costanti.boot || '</style>
              <script>' || Costanti.script || '</script>');
  htp.print(' <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">');
  htp.print(' <script src="https://kit.fontawesome.com/8d046e8a1e.js" crossorigin="anonymous"></script>
               <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
               <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>
               <script>
                    // Wait for window load
                    $(window).load(function() {
                    // Animate loader off screen
                    $(".se-pre-con").fadeOut("slow");;
                    });
               </script>');
 	htp.headClose; 
	modGUI.ApriBody(idSessione);
    modGUI.ApriDiv(classe => 'se-pre-con');
    modGUI.ChiudiDiv;
end ApriPagina;


procedure ApriBody(idSessione int default 0) is
begin
  htp.print('<body>');

  modGUI.ApriDiv(classe => '');
  if (idSessione = 0) then /* Sessione di tipo 'Ospite' */
  modGUI.ApriDiv(ident => 'bgimg');
	modGUI.ApriDiv(classe => 'navbar');
        htp.img(Costanti.server || Costanti.root || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo0"');
        htp.print('<h1 class="logo0">'|| Costanti.titoloApplicazione ||'</h1>');
    modGUI.ChiudiDiv;
    modGUI.ApriDiv(ident => 'b1' ,classe => 'form-box');
        modGUI.ApriDiv(classe => 'button-box');
            htp.print('<span> Benvenuto </span>
                       <hr id="indicator">');
        modGUI.ChiudiDiv;

        modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'login.checkLogin');
        modGUI.ApriDiv(classe => 'form-group-login');
        
        htp.prn(' <div class="form-g">
                  <input type="text" required class="form-control" name="Usr" placeholder="Inserire username..." maxlength="45">
                  </div>');
        htp.prn(' <div class="form-g">
                  <input type="password" class="password form-control" required name="Pwd" placeholder="Inserire password...">
                  </div>');
        modGUI.BOTTONEFORM(testo => 'Accedi');
        modGUI.ChiudiDiv;
        modGUI.chiudiFormHidden;
    modGUI.chiudiDiv;
    modGUI.chiudiDiv;    

  modGUI.ChiudiDiv;
  elsif (idSessione = -1) then /* Sessione non correttamente loggata (es. credenziali errate)*/
    modGUI.ChiudiDiv;
  else
	modGUI.ChiudiDiv;
  CreaMenuPrincipale(idSessione);
  end if;

end ApriBody;

procedure ApriMenuLat(idSessione int, ident varchar2 default '', subMenu boolean default false, parentName varchar2 default '') is
begin
    htp.prn('<div id="' || ident || '" class="sidenav hide2" style="width: 0">');
    if(subMenu) then
        htp.prn('<a href="javascript:void(0)" class="closebtn" onclick="closeNav(this.parentElement)">&rarr;</a>');
        modGUI.ApriDiv(classe => 'nav-title-box');
            htp.prn('<span class="nav-list-title">'|| parentName ||'</span>');
        modGUI.ChiudiDiv;
    else
        htp.prn('<a href="javascript:void(0)" class="closebtn" onclick="closeNav(this.parentElement)">&times;</a>');
        modGUI.ApriDiv(classe => 'nav-title-box');
            htp.prn('<span class="nav-list-title">Main Menu</span>');
        modGUI.ChiudiDiv;
    end if;
    modGUI.ApriDiv(classe => 'nav-list');
end ApriMenuLat;

procedure ChiudiMenuLat is
begin
    modGUI.ChiudiDiv;
    modGUI.ChiudiDiv;
end ChiudiMenuLat;


procedure CreaMenuPrincipale(idSessione int) is
  ruolo varchar2(45);
begin
    ruolo := login.getRoleFromSession(idSessione);
    modGUI.ApriDiv(classe => 'menuDiv');
    htp.img(Costanti.server || Costanti.root || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo"');
    htp.print('<h1 class="hide3">'|| Costanti.titoloApplicazione ||'</h1>');

    htp.print('<nav><ul>');
    modGUI.CollegamentoNav('Home',  Costanti.root || 'modGUI.PaginaPrincipale?idSessione=' || idSessione);
    modGUI.CollegamentoNav('Gruppo 1',  'javascript:void(0)', true, 'primo');
      menuGruppi.navGruppo1(idSessione);
    modGUI.ChiudiCollegamentoSubNav;

    modGUI.CollegamentoNav('Gruppo 2',  'javascript:void(0)', true, 'primo');
      menuGruppi.navGruppo2(idSessione);
    modGUI.ChiudiCollegamentoSubNav;

    modGUI.CollegamentoNav('Gruppo 3',  'javascript:void(0)', true, 'primo');
      menuGruppi.navGruppo3(idSessione);
    modGUI.ChiudiCollegamentoSubNav;

    htp.print('<li class="dropdown">
        <button class="dropbtn"><i class="fa fa-user"></i>&nbsp; '|| login.getUnameFromSession(idSessione) ||' | ' || ruolo || ' </a></button>');
        modGUI.ApriDiv(classe => 'dropdown-content');
            IF ruolo = 'birraio' THEN modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.profilo1 || '?idSessione=' || idSessione);
            ELSIF ruolo = 'fornitore' THEN modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.profilo2 || '?idSessione=' || idSessione);
            ELSIF ruolo = 'cliente' THEN modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.profilo3 || '?idSessione=' || idSessione);
            END IF;
            modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'login.logout', IDSESSIONE, ident => 'esci');
            htp.prn('<a href="javascript:void(0)" onclick="sbmt()"><i class="fa fa-sign-out"></i>&nbsp; Logout</i></a>');
            modGUI.ChiudiFormHidden;
        modGUI.ChiudiDiv;
    htp.print('</li><li class="hide2">');
        htp.print('<i id="hamb-icon" class="fas fa-bars" onclick="openNav('|| Costanti.mySidenav ||')"></i>');

    htp.print('</li></ul></nav>');

	modGUI.ChiudiDiv;

  htp.prn('<div id="' || 'mySidenav' || '" class="sidenav hide2" style="width: 0">');
      htp.prn('<a href="javascript:void(0)" class="closebtn" onclick="closeNav(this.parentElement)">&times;</a>');
      modGUI.ApriDiv(classe => 'nav-title-box');
        htp.prn('<span class="nav-list-title">Main Menu</span>');
      modGUI.ChiudiDiv;

      modGUI.ApriDiv(classe => 'nav-list');
        modGUI.CollegamentoNav('Home',  Costanti.root || 'modGUI.PaginaPrincipale?idSessione=' || idSessione);
        modGUI.Collegamento('Gruppo 1', 'subMenuGruppo1', true);
        modGUI.Collegamento('Gruppo 2', 'subMenuGruppo2', true);
        modGUI.Collegamento('Gruppo 3', 'subMenuGruppo3', true);
      modGUI.ChiudiDiv;
      modGUI.ChiudiDiv;

      modGUI.ApriMenuLat(idSessione, 'subMenuGruppo1', true, 'Gruppo 1');
        menuGruppi.navLatGruppo1(idSessione);
      modGUI.ChiudiMenuLat;

      modGUI.ApriMenuLat(idSessione, 'subMenuGruppo2', true, 'Gruppo 2');
        menuGruppi.navLatGruppo2(idSessione);
      modGUI.ChiudiMenuLat;

      modGUI.ApriMenuLat(idSessione, 'subMenuGruppo3', true, 'Gruppo 3');
        menuGruppi.navLatGruppo3(idSessione);
      modGUI.ChiudiMenuLat;
end CreaMenuPrincipale;


procedure Intestazione(tipo int, testo varchar2, ident varchar2 default '', classe varchar2 default '') is
begin
	htp.prn('<h' || tipo || ' id="' || ident || '" class="' || classe || '" style="margin: 50px;">');
	htp.prn(testo);
	htp.prn('</h' || tipo || '>');

end Intestazione;


procedure ChiudiPagina is
begin
  modGUI.ApriDiv(classe => 'footer');
  modGUI.ChiudiDiv;
	htp.bodyClose;
 	htp.htmlClose; 

end ChiudiPagina; 

procedure RitCarrello is
begin
	htp.br;

end RitCarrello;


procedure ApriForm(azione varchar2, nome varchar2, idSessione int default -1) is 
begin

  htp.print('<div class="container">');
  htp.print('<form name="' ||nome ||'"  action="' || azione || '" method="GET" >');  
	if (idSessione <> -1) then
		modGUI.PassaParametro('idSessione', to_char(idSessione)); -- -> ?idSessione=value
	end if;

end ApriForm;


procedure ChiudiForm is
begin	
	htp.formClose;
  htp.print('</div>');
end ChiudiForm;


procedure ApriDiv(ident varchar2 default '', classe varchar2 default '') is
begin
	htp.prn('<div id="' || ident || '" class="' || classe || '">');

end ApriDiv;


procedure ChiudiDiv is
begin
	htp.prn('</div>');

end ChiudiDiv;

procedure Paragrafo(testo varchar2, ident varchar2 default '', classe varchar2 default '') is
begin
	htp.prn('<p id="' || ident || '" class="' || classe || '">' || testo || '</p>');

end Paragrafo;


procedure Collegamento(testo varchar2, indirizzo varchar2, hasSub boolean default false) is
begin
    if(hasSub) then
        htp.prn('<a href="javascript:void(0)" onclick="openNav('|| q'[']' || indirizzo || q'[']' ||')" class="subnav">' || testo || ' <i class="fas fa-angle-right"></i></a>');
    
    else
        htp.prn('<a href="' || indirizzo || '">' || testo || '</a>');
    
    end if;
end Collegamento;

procedure CollegamentoNav(testo varchar2, indirizzo varchar2, hasSub boolean default false, tipoSub varchar2 default '') is
begin
    if(hasSub) then
        htp.print('<li class="hide1">');
        if(tipoSub = 'primo') then
            htp.print('<a href="' || indirizzo || '">' || testo || ' <i class="fas fa-angle-down"></i></a>');
            modGUI.ApriDiv(classe => 'sub-menu-1');
        else if(tipoSub = 'secondo') then
            htp.print('<a href="' || indirizzo || '">' || testo || ' <i class="fas fa-angle-right"></i></a>');
            modGUI.ApriDiv(classe => 'sub-menu-2');
        end if;
        end if;
        htp.print('<ul>');
    else 
        htp.print('<li class="hide1">');
        htp.print('<a href="' || indirizzo || '">' || testo || '</a>'); 
        htp.print('</li>');
    end if;
end CollegamentoNav;

procedure ChiudiCollegamentoSubNav is
begin
    htp.print('</ul></div></li>');
end ChiudiCollegamentoSubNav;

procedure Bottone(testo varchar2 default '', nome varchar2 default '', valore varchar2 default '', ident varchar2 default '', classe varchar2 default '') is
begin
	htp.prn('<button type="submit" ');

	if ((nome != '' and nome is not null) and (valore != '' and valore is not null)) then
		htp.prn('name="' || nome || '"  value="' || valore || '" ');
	end if;

	htp.prn('id="' || ident || '" class=" btn' || classe || '">');
	htp.prn(testo);
	htp.prn('</button>');

end Bottone;

procedure ApriFormHidden(azione varchar2, idSessione int default -1, ident varchar2 default '', classe varchar2 default '') is
begin
  htp.prn('<form action="'|| azione ||'" method="get" id="'|| ident ||'" classe="'|| classe ||'">');
  
  if (idSessione <> -1) then
	modGUI.PassaParametro('idSessione', to_char(idSessione)); -- -> ?idSessione=value
  end if;
end ApriFormHidden;

procedure ChiudiFormHidden is
begin	
	htp.formClose;

end ChiudiFormHidden;

procedure AreaDiTesto(nome varchar2, etichetta varchar2,valore varchar2 default '',center boolean default true) is
begin
  if(center)then
    htp.print('
    <div class="form-group row">
      <label class="col-lg-2 col-lg-push-2 control-label">' || etichetta ||'</label>
      <div class="col-lg-push-2 col-lg-3">
        <textarea class="form-control" rows="3" name="'||nome||'">' || valore||'</textarea>
      </div>
    </div>');


  else
      htp.print('
        <div class="form-group row">
          <label class="col-lg-2 control-label">' || etichetta ||'</label>
          <div class="col-lg-3">
            <textarea class="form-control" rows="3" name="'||nome||'">' || valore||'</textarea>
           </div>
        </div>');
  end if;

end AreaDiTesto;

procedure BottoneForm(
nome varchar2 default 'Submit',
valore varchar2 default 'Submit', 
testo varchar2 default 'Submit',
valida boolean default true,
nomeForm varchar2 default '',
classe varchar2 default ''
)is
begin

	htp.prn('<button type="submit" class="' || classe || '"');

	if ((nome != '' and nome is not null) and (valore != '' and valore is not null)) then
		htp.prn('name="' || nome || '"  value="' || valore || '" ');
	end if;

    if (valida) then
      htp.print('onclick="return validateForm('''||nomeForm|| ''')"');

    end if;
    htp.print('>' || testo || '</button>');

end BottoneForm;


procedure CasellaDiTesto(
	nome varchar2, 
	etichetta varchar2, 
	suggerimento varchar2 default '',
  testo varchar2 default '',
  lunghezzaMax varchar2 default '',
  tipo varchar2 default '',
  require boolean default false,
  center boolean default true
	) is

begin

  if(center) then
   htp.print('
    <div class="form-group row">
      <label for="' || nome ||'" class="col-lg-2 col-lg-push-2 control-label">'
      || etichetta ||'</label>
      <div class="col-lg-3 col-lg-push-2">');


        if(require) then
          htp.print(' <input class="' ||tipo ||' required form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||testo||'" maxlength="'||lunghezzaMax||'">');

        else
          htp.print('  <input class="' ||tipo || ' free form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||testo||'" maxlength="'||lunghezzaMax||'">');
        end if;

       htp.print(' </div> </div>');

  ----FORM NON CENTRATA
  else
    htp.print('
    <div class="form-group row">
      <label for="' || nome ||'" class="col-lg-2 control-label">'
      || etichetta ||'</label>

      <div class="col-lg-3">');

     if(require) then
          htp.print(' <input class="' ||tipo ||' required form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'|| testo||'" maxlength="'||lunghezzaMax||'">');

        else
          htp.print('  <input class="' ||tipo || ' free form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||testo||'" maxlength="'||lunghezzaMax||'">');
        end if;

       htp.print(' </div> </div>');

  end if;
end CasellaDiTesto;

procedure CampoPassword(
   nome varchar2,
   etichetta varchar2 default 'Password', 
   suggerimento varchar2 default '',
   valore varchar2 default '',
   require boolean default false,
   center boolean default true
    ) is

begin

  if(center) then
   htp.print('
    <div class="form-group row">
      <label for="' || nome ||'" class="col-lg-2 col-lg-push-2 control-label">'
      || etichetta ||'</label>
      <div class="col-lg-3 col-lg-push-2">');

      if(require) then
        htp.print('<input type="password" class="password required form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||valore||'">');
      else
        htp.print('<input type="password" class="password free form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||valore||'">');
      end if;
      htp.print('</div></div>');

  else
    htp.print('
    <div class="form-group row">
      <label for="' || nome ||'" class="col-lg-2 control-label">'
      || etichetta ||'</label>
      <div class="col-lg-3">');

       if(require) then
        htp.print('<input type="password" class="password required form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||valore||'">');
      else
        htp.print('<input type="password" class="password free form-control" name="'||nome||'"
            placeholder="' || suggerimento ||'" value="'||valore||'">');
      end if;
      htp.print('</div></div>');
  end if;

end CampoPassword;

/*APRE UN BLOCCO INLINE ALL'INTERNO DELLA FORM.
  DA USARE SEMPRE ALL'INTERNO DI UNA FORM QUANDO
  SI AGGIUNGONO CHECKBOX,RADIO-BUTTON O BOTTONI...
  USARE RITCARRELLO PER INIZIARE UNA NUOVA RIGA ALLINEATA CON LA PRECEDENTE.
  DA NON USARE CON LE TEXTBOX O TEXTAREA O SELECT!!!
*/

procedure ApriBlocco(etichetta varchar2 default '',center boolean default true) is

begin
  if(center) then
    htp.print('
      <div class="form-group row">
        <label class="col-lg-2 col-lg-push-2 control-label">' || etichetta || '</label>
        <div class="col-lg-8 col-lg-push-2">'
    );
  else
    htp.print('<div class="form-group row">
    <label class="col-lg-2 control-label">' || etichetta || '</label>
    <div class="col-lg-8">');

  end if;

end ApriBlocco;

--CHIUDE IL BLOCCO INLINE
procedure ChiudiBlocco is
begin
  htp.print('</div></div>');
end ChiudiBlocco;



procedure ApriBloccoSelect(
  etichetta varchar2 default '',
  center boolean default true
  ) is
begin

if(center) then
    htp.print('
    <div class="form-group row">
      <label class="col-lg-2 col-lg-push-2 control-label">' || etichetta || '</label>
      ');
else
  htp.print('
    <div class="form-group row">
      <label class="col-lg-2 control-label">' || etichetta || '</label>
      ');
end if;
end ApriBloccoSelect;


procedure ChiudiBloccoSelect is
begin
  htp.print('</div>');
end ChiudiBloccoSelect;


/*
  INSERISCE UNA CHECKBOX INLINE.
  PRIMA DEVE ESSERE STATA CHIAMATA LA PROCEDURA "APRIBLOCCO"
*/

procedure CheckBox(
  etichetta varchar2, 
  nome varchar2,
  valore varchar2,
  selezionato boolean default false
  ) is

begin  
  htp.print('
    <label class="checkbox-inline">
      <input type="checkbox" name="'|| nome ||'" value="' || valore || '"');

  if selezionato then
    htp.print('checked');
  end if;

  htp.print('>' || etichetta || '</label>');

end CheckBox;


procedure RadioButton(
  etichetta varchar2, 
  nome varchar2, 
  valore varchar2,
  selezionato boolean default false
  ) is

begin

   htp.print('
    <label class="radio-inline">
      <input type="radio" name="'|| nome ||'" value="'||valore||'"');

  if selezionato then
    htp.print('checked');
  end if;

  htp.print('><span>' || etichetta || '</span></label>');

end RadioButton;

procedure ApriSelect(nome varchar2,center boolean default true) is
begin

  if(center) then
    htp.print('<div class="col-lg-1 col-lg-push-2">');

  else
    htp.print('<div class="col-lg-1">');
  end if;

  htp.print('<select class="form-control" name="' || nome||'">');
end ApriSelect;

procedure ChiudiSelect is
begin
  htp.print('</select> </div>');
end ChiudiSelect;

procedure ApriInlineSelect(nome varchar2) IS
BEGIN
  htp.print('<select class="inline-select" name="' || nome ||'">');
END ApriInlineSelect;

procedure ChiudiInlineSelect IS
BEGIN
  htp.print('</select>');
END ChiudiInlineSelect;

procedure AggiungiOpzioneSelect(
  valore varchar2, 
  etichetta varchar2, 
  selezionato boolean default false
  ) is
begin

  if(selezionato) then
       htp.print('<option value="' ||valore || '" selected ');
  else
       htp.print('<option value="' ||valore || '"');
  end if;

  htp.print('>' || etichetta ||' </option>');
end AggiungiOpzioneSelect;

procedure SelettoreData(
	idCampoGiorno VARCHAR2 default 'giorno',
	idCampoMese VARCHAR2 default 'mese',
	idCampoAnno VARCHAR2 default 'anno',
	dataDefault date, 
	etichetta varchar2, 
	center boolean default true
) is

	--dichiarazioni
	giornoDefault number default null;
    meseDefault number default null;
    annoDefault number default null;
begin

	giornoDefault := TO_NUMBER(TO_CHAR(dataDefault, 'DD'));
    meseDefault := TO_NUMBER(TO_CHAR(dataDefault, 'MM'));
    annoDefault := TO_NUMBER(TO_CHAR(dataDefault, 'YYYY'));

  modGUI.APRIBLOCCOSELECT(etichetta,center);
	modGUI.ApriSelect(idCampoGiorno, center);	
	for DAY in 1..31
    loop
        -- se il giorno è minore di 10 devo aggiungere uno 0 in cima per il formato
        if DAY < 10 then --valore, etichetta, selezionato
            modGUI.AggiungiOpzioneSelect(to_char(DAY), '0' || to_char(DAY), DAY = giornoDefault);
          else --giorno > 9
            modGUI.AggiungiOpzioneSelect(to_char(DAY), to_char(DAY), DAY = giornoDefault);
        end if;
    end loop;
  modGUI.ChiudiSelect;

	modGUI.ApriSelect(idCampoMese, center);	
	for MONTH in 1..12
    loop
      if MONTH < 10 then
          modGUI.AggiungiOpzioneSelect('0'||to_char(MONTH), to_char(to_date(MONTH,'MM'), 'Month', 'NLS_DATE_LANGUAGE=Italian'), MONTH = meseDefault);
      else
          modGUI.AggiungiOpzioneSelect(to_char(MONTH), to_char(to_date(MONTH,'MM'), 'Month', 'NLS_DATE_LANGUAGE=Italian'), MONTH = meseDefault);
      end if;
    end loop;
	modGUI.ChiudiSelect;

	modGUI.ApriSelect(idCampoAnno, center);	
	for YEAR in 1950..2050
    loop
        modGUI.AggiungiOpzioneSelect(to_char(YEAR), to_char(YEAR), YEAR = annoDefault);
    end loop;
	modGUI.ChiudiSelect;

modGUI.ChiudiBloccoSelect;

end SelettoreData;

procedure PassaParametro(nome varchar2, valore varchar2 default null) is
begin		
	htp.formHidden(nome, valore);

end PassaParametro;

procedure ApriTabella is
begin	
	htp.tableOpen;

end ApriTabella;

procedure ChiudiTabella is
begin       
	htp.tableClose;

end ChiudiTabella;

procedure ApriRigaTabella is
begin		
	htp.tableRowOpen;

end ApriRigaTabella;

procedure ChiudiRigaTabella is
begin	
	htp.tableRowClose;

end ChiudiRigaTabella;

procedure ApriElementoTabella is
begin	
	htp.prn('<td>');

end ApriElementoTabella;

procedure ChiudiElementoTabella is
begin	
	htp.prn('</td>');

end ChiudiElementoTabella;

procedure ElementoTabella(testo varchar2) is
begin
	htp.tableData(testo);
end ElementoTabella;

procedure IntestazioneTabella(testo varchar2) is
begin
	htp.prn('<th>' || testo || '</th>');
end IntestazioneTabella;


procedure bottoneInfo IS
BEGIN
  htp.prn('<button type="submit" class="info"></button>');
end bottoneInfo;

procedure bottoneEdit IS
BEGIN
  htp.prn('<button type="submit" class="edit"></button>');
end bottoneEdit;

procedure bottoneConfirm IS
BEGIN
  htp.prn('<button type="submit" class="confirm"></button>');
end bottoneConfirm;

procedure bottoneDelete IS
BEGIN
  htp.prn('<button type="submit" class="delete"></button>');
end bottoneDelete;

procedure bottoneCart IS
BEGIN
  htp.prn('<button type="submit" class="cart"></button>');
end bottoneCart;

procedure  PaginaFeedback(
    tipoMessaggio varchar2, descrizioneMessaggio varchar2, 
    indirizzoRitorno varchar2, idSessione int default -1, 
    parametriProcedura modGUI.stringDict default modGUI.emptyDict
) 
    is
param varchar2(500);
begin
  modGUI.ApriPagina(tipoMessaggio, idSessione);
  
  modGUI.ApriDiv(classe => 'form-group row back');
  if(idSessione != -1) then
    modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'modGUI.PaginaPrincipale', idSessione);
            modGUI.Bottone(testo => '<i class="fas fa-home"></i>&nbsp; Home');
    modGUI.ChiudiFormHidden;
  end if;
    modGUI.ApriFormHidden(indirizzoRitorno, idSessione);
        param := parametriProcedura.FIRST;
        -- Passo - uno per uno - tutti i parametri alla procedura di ritorno		
        while param is not null 
        loop
        modGUI.PassaParametro(param, parametriProcedura(param));
        param := parametriProcedura.next(param);
        end loop;
            modGUI.Bottone(testo => '&#8592;&nbsp; Indietro');
    modGUI.ChiudiFormHidden;

  modGUI.ChiudiDiv;
  
  modGUI.ApriDIV(classe => 'centrato');
  if upper(trim(tipoMessaggio)) = 'ERRORE' then
    htp.print('<i class="fas fa-times fa-10x feedback-neg"></i>');
  else
    htp.print('<i class="fas fa-check fa-10x feedback-pos"></i>');
  end if;

  modGUI.Paragrafo(testo => descrizioneMessaggio, classe => 'message');
  modGUI.ChiudiDiv;

  

  modGUI.ChiudiPagina;

end PaginaFeedback;

procedure PaginaOspiti is
begin
	modGUI.ApriPagina(Costanti.titoloApplicazione, 0);
	modGUI.ChiudiPagina;

end PaginaOspiti;

procedure PaginaPrincipale(idSessione int) is
begin
	modGUI.ApriPagina('Home', idSessione);
	modGUI.Intestazione(1, 'Benvenuto sul sito di ' || Costanti.titoloApplicazione);
  modGUI.ApriDiv(classe => 'centered');
  modGUI.RitCarrello;
  modGUI.RitCarrello;
  modGUI.RitCarrello;
  modGUI.RitCarrello;
  htp.prn('<img src="https://i2.wp.com/www.foodmakers.it/wp-content/uploads/2020/04/birre_ritual_lab.jpg?resize=960%2C385&ssl=1"');
  modGUI.ChiudiDiv;
	modGUI.ChiudiPagina;

end PaginaPrincipale;

procedure StringaDiTesto(testo varchar2) is
begin
  htp.print(testo);
end StringaDiTesto;

end modGUI;