create or replace PACKAGE BODY modGUI as

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
  
  htp.print(' <link rel="shortcut icon" href="' || Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png">');
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
        htp.img(Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo0"');
        htp.print('<h1 class="logo0">Una Cervecita Fresca</h1>');
    modGUI.ChiudiDiv;
    modGUI.ApriDiv(ident => 'b1' ,classe => 'form-box');
        modGUI.ApriDiv(classe => 'button-box');
            htp.print('<span> Benvenuto </span>
                       <hr id="indicator">');
        modGUI.ChiudiDiv;
        modGUI.InserisciLoginERegistrati;
    modGUI.chiudiDiv;
    modGUI.chiudiDiv;    

  modGUI.ChiudiDiv;
  else
	-- Fare una query alla tabella Sessioni per aggiungere l'username dell'utente in alto a destra
	--modGUI.InserisciLogout(idSessione);--
	modGUI.ChiudiDiv;

  end if;

end ApriBody;

procedure ApriMenuNav(idSessione int, indirizzo varchar2) is
begin
    modGUI.ApriDiv(classe => 'menuDiv');
    htp.img(Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo"');
    htp.print('<h1 class="hide3">Una Cervecita Fresca</h1>');

    htp.print('<nav><ul>');
end ApriMenuNav;

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

procedure ChiudiMenuNav(idSessione int) is
begin
    htp.print('<li class="dropdown">
        <button class="dropbtn"><i class="fa fa-user"></i>&nbsp; Mario R. | &nbsp;Birraio </a></button>');
        modGUI.ApriDiv(classe => 'dropdown-content');
            modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fas fa-coins"></i>&nbsp; Vendite',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-shopping-bag"></i>&nbsp; Acquisti',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-sign-out"></i>&nbsp; Logout',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
        modGUI.ChiudiDiv;
    htp.print('</li><li class="hide2">');
        htp.print('<i id="hamb-icon" class="fas fa-bars" onclick="openNav('|| Costanti.mySidenav ||')"></i>');

    htp.print('</li></ul></nav>');

	modGUI.ChiudiDiv;
end ChiudiMenuNav;


procedure CreaMenuPrincipale(idSessione int) is
begin
	 modGUI.ApriDiv(ident => 'mySidenav',classe => 'sidenav hide2');
        htp.print('<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>');
        modGUI.ApriDiv(classe => 'nav-list');
            modGUI.Collegamento('Lotti',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Ricette',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Ingredienti',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Acquista',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            -- if (utente backoffice)
            if (true) then
                modGUI.Collegamento('Area Backoffice', Costanti.server || Costanti.root || Costanti.areaBackoffice || '?idSessione=' || idSessione);
            end if;
        modGUI.ChiudiDiv;
    modGUI.ChiudiDiv;

	modGUI.ApriDiv(classe => 'menuDiv');

    htp.img(Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo"');
    htp.print('<h1 class="hide3">Una Cervecita Fresca</h1>');
    

    htp.print('<nav><ul>');
    htp.print('<li class="hide1">');
	modGUI.Collegamento('Lotti',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
    htp.print('</li><li class="hide1">');
	modGUI.Collegamento('Ricette',  Costanti.server || Costanti.root || Costanti.gruppo1 || '?idSessione=' || idSessione);
    htp.print('</li><li class="hide1">');
    modGUI.Collegamento('Ingredienti',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
	htp.print('</li><li class="hide1">');
    modGUI.Collegamento('Acquista',  Costanti.server || Costanti.root || Costanti.gruppo3 || '?idSessione=' || idSessione);
    -- if (utente backoffice)
	if (true) then
        htp.print('</li><li class="hide1">');
		modGUI.Collegamento('Area Backoffice', Costanti.server || Costanti.root || Costanti.areaBackoffice || '?idSessione=' || idSessione);
	end if;
    htp.print('</li><li class="dropdown">
        <button class="dropbtn"><i class="fa fa-user"></i>&nbsp; Mario R. | &nbsp;Birraio </a></button>');
        modGUI.ApriDiv(classe => 'dropdown-content');
            modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fas fa-coins"></i>&nbsp; Vendite',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-shopping-bag"></i>&nbsp; Acquisti',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-sign-out"></i>&nbsp; Logout',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
        modGUI.ChiudiDiv;
    htp.print('</li><li class="hide2">');
        htp.print('<i id="hamb-icon" class="fas fa-bars" onclick="openNav()"></i>');

    htp.print('</li></ul></nav>');

	modGUI.ChiudiDiv;

    htp.print('<script>
                /* Set the width of the side navigation to 300px */
                function openNav(id_var) {
                    document.getElementById(id_var).style.width = "300px";
                }

                 /* Set the width of the side navigation to 0 */
                 function closeNav(id_var) {
                     document.getElementById(id_var).style.width = "0";
                }
             </script>');

	--modGUI.ChiudiDiv;

end CreaMenuPrincipale;


procedure CreaMenuBackOffice(idSessione int) is
begin
    modGUI.ApriDiv(ident => 'mySidenav',classe => 'sidenav hide2');
        htp.print('<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>');
        modGUI.ApriDiv(classe => 'nav-list');
            modGUI.Collegamento('Home',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Gruppo 1',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Gruppo 2',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
            modGUI.Collegamento('Gruppo 3',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
        modGUI.ChiudiDiv;
    modGUI.ChiudiDiv;

	modGUI.ApriDiv(classe => 'menuDiv');
    htp.img(Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png',cattributes => 'class="imglogo"');
    htp.print('<h1 class="hide3">Una Cervecita Fresca</h1>');

    htp.print('<nav><ul>');
    htp.print('<li class="hide1">');
	modGUI.Collegamento('Home',  Costanti.server || Costanti.root || Costanti.home || '?idSessione=' || idSessione);
    htp.print('</li><li class="hide1">');
	modGUI.Collegamento('Gruppo1',  Costanti.server || Costanti.root || Costanti.gruppo1 || '?idSessione=' || idSessione);
    htp.print('</li><li class="hide1">');
    modGUI.Collegamento('Gruppo2',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
	htp.print('</li><li class="hide1">');
    modGUI.Collegamento('Gruppo3',  Costanti.server || Costanti.root || Costanti.gruppo3 || '?idSessione=' || idSessione);		
    htp.print('</li><li class="dropdown">
        <button class="dropbtn"><i class="fa fa-user"></i>&nbsp; Mario R. | &nbsp;Admin </a></button>');
        modGUI.ApriDiv(classe => 'dropdown-content');
            modGUI.Collegamento('<i class="fas fa-user-circle"></i>&nbsp; Profilo',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fas fa-coins"></i>&nbsp; Vendite',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-shopping-bag"></i>&nbsp; Acquisti',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
            modGUI.Collegamento('<i class="fa fa-sign-out"></i>&nbsp; Logout',  Costanti.server || Costanti.root || Costanti.gruppo2 || '?idSessione=' || idSessione);
        modGUI.ChiudiDiv;
    htp.print('</li><li class="hide2">');
        htp.print('<i id="hamb-icon" class="fas fa-bars" onclick="openNav(' || Costanti.mySidenav ||')"></i>');

    htp.print('</li></ul></nav>');

	modGUI.ChiudiDiv;

    htp.print('<script>
                /* Set the width of the side navigation to 250px */
                function openNav() {
                    document.getElementById("mySidenav").style.width = "250px";
                }

                 /* Set the width of the side navigation to 0 */
                 function closeNav() {
                     document.getElementById("mySidenav").style.width = "0";
                }
             </script>');


end CreaMenuBackOffice;


procedure InserisciLoginERegistrati is
begin
	modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'pksys.login');
	modGUI.Bottone('Login', classe=> 'login');
	modGUI.ChiudiFormHidden;
	modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'pksys.registrazione');
	modGUI.Bottone('Registrati', classe => 'register');
	modGUI.ChiudiFormHidden;
end InserisciLoginERegistrati;


procedure InserisciLogout(idSessione int) is
begin
	modGUI.ApriFormHidden(Costanti.server || Costanti.root || 'pksys.logout', idSessione);
	modGUI.Bottone('Logout');
	modGUI.ChiudiFormHidden;
end InserisciLogout;


procedure Intestazione(tipo int, testo varchar2, ident varchar2 default '', classe varchar2 default '') is
begin
	htp.prn('<h' || tipo || ' id="' || ident || '" class="' || classe || '" style="margin: 50px;">');
	htp.prn(testo);
	htp.prn('</h' || tipo || '>');

end Intestazione;


procedure ChiudiPagina is
begin
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

procedure ApriFormHidden(azione varchar2, idSessione int default -1) is
begin
  htp.formOpen(azione, 'GET');
  
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

procedure ChiudiRigaTabellaConBottoni(
	IdSessione integer,
	IdRecord integer,
	azioneDettagli varchar2 default null, 
	azioneModifica varchar2 default null, 
	azioneElimina varchar2 default null) is
begin
	modGUI.ApriElementoTabella;

	if (azioneDettagli is not null) then
		modGUI.ApriFormHidden(Costanti.server || Costanti.root || azioneDettagli, IdSessione);
		htp.prn('
			<button type="submit" class="view"></button>
		');
		modGUI.PassaParametro('IdRecord', IdRecord);
		modGUI.ChiudiFormHidden;
	end if;
	if (azioneModifica is not null) then
		modGUI.ApriFormHidden(Costanti.server || Costanti.root || azioneModifica, IdSessione);
		htp.prn('
			<button type="submit" class="edit"></button>
		');
		modGUI.PassaParametro('IdRecord', IdRecord);
		modGUI.ChiudiFormHidden;
	end if;
	if (azioneElimina is not null) then
		modGUI.ApriFormHidden(Costanti.server || Costanti.root || azioneElimina, IdSessione);
		htp.prn('
			<button type="submit" class="delete"></button>
		');
		modGUI.PassaParametro('IdRecord', IdRecord);
		modGUI.ChiudiFormHidden;
	end if;
	modGUI.ChiudiElementoTabella;
	modGUI.ChiudiRigaTabella;

end ChiudiRigaTabellaConBottoni;

procedure  PaginaFeedback(
    tipoMessaggio varchar2, descrizioneMessaggio varchar2, 
    indirizzoRitorno varchar2, idSessione int default -1, 
    parametriProcedura modGUI.stringDict default modGUI.emptyDict
) 
    is
param varchar2(500);
begin
  modGUI.ApriPagina(tipoMessaggio, idSessione);
  modGUI.ApriDiv(classe => 'menuDiv');
    htp.img(Costanti.server || Costanti.interfaccia || 'files_orcl2021_api.GetImage?p_name=beerlogo.png', cattributes => 'class="imglogo"');
    htp.print('<h1 class="hide3">Una Cervecita Fresca</h1>');
  modGUI.ChiudiDiv;
  
  modGUI.ApriDiv(classe => 'form-group row back');
  
    modGUI.ApriFormHidden(Costanti.server || Costanti.root || Costanti.home, idSessione);
            modGUI.Bottone(testo => '<i class="fas fa-home"></i>&nbsp; Home');
    modGUI.ChiudiFormHidden;
  
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
	modGUI.ApriPagina('Una Cervecita Fresca', 0);
	modGUI.ChiudiPagina;

end PaginaOspiti;

procedure PaginaPrincipale(idSessione int) is
begin
	modGUI.ApriPagina('Home', idSessione);
	modGUI.CreaMenuPrincipale(idSessione);
	modGUI.Intestazione(1, 'Benvenuto sul sito di Una Cervecita Fresca');
	modGUI.ChiudiPagina;

end PaginaPrincipale;

procedure PaginaPrincipaleBackoffice(idSessione int) is
begin
	modGUI.ApriPagina('Area backoffice', idSessione);
	modGUI.CreaMenuBackOffice(idSessione);	
	modGUI.Intestazione(1, 'Benvenuto nell''area backoffice di Una Cervecita Fresca');

	modGUI.ChiudiPagina;

end PaginaPrincipaleBackoffice;

procedure StringaDiTesto(testo varchar2) is
begin
  htp.print(testo);
end StringaDiTesto;

end modGUI;