create PACKAGE BODY LOGIN AS

    function isLogged(Usrname varchar2) return boolean is
      CURSOR r is SELECT * FROM SESSIONI WHERE UNAME = Usrname;
      v_record r%ROWTYPE;
    begin
      open r;
      fetch r into v_record;
      if r%rowcount = 0 then
        close r;
        return false;
      else 
        close r;
        return true;
      end if;
    end isLogged;
    
    function getIdFromSession(Usrname varchar2) return number is
      CURSOR r is SELECT * FROM SESSIONI WHERE UNAME = Usrname;
      v_record r%ROWTYPE;
    begin
      open r;
      fetch r into v_record;
      if r%rowcount = 0 then
        close r;
        return 0;
      else 
        close r;
        return v_record.IDSESSIONE;
      end if;
    end getIdFromSession;

    procedure login is
begin
	modGUI.ApriPagina('Login', 0);
	modGUI.Intestazione(1, 'Inserire credenziali');
	modGUI.RitCarrello;
  
	modGUI.ApriForm(costanti.root || 'login.checkLogin', 'checklogin' );
	modGUI.CasellaDiTesto('Usr', 'Username','Username','',15,'text',true);
	modGUI.CampoPassword('Pwd', 'Password','Password','',true);
  modgui.apriblocco;
	modGUI.Bottone('Login');
  modGUI.CHIUDIBLOCCO;
	modGUI.ChiudiForm();
	
	modGUI.ChiudiPagina;
  htp.print('<script> document.getElementsByClassName("logButtonsDiv")[0].childNodes[0].remove() </script>');
	
end login;

procedure checkLogin(Usr varchar2 , Pwd varchar2) is
  v_padd   UTENTI.PWD%TYPE;
  CURSOR r is SELECT  IDUTENTE, RUOLO, UNAME, PWD FROM UTENTI WHERE UNAME = Usr and PWD = Pwd;
  v_record r%ROWTYPE;
  id_sess SESSIONI.IDSESSIONE%TYPE;
begin
  --htp.print(Usr);
  open r;
  fetch r into v_record;
  --htp.print(r%rowcount);
  --htp.print(v_record.password);
  /*htp.print(login.getId('teo666'));
  if(login.isLogged('teo666')) then
   htp.print('teo � loggato');
   else 
   htp.print('teo non � loggato');
   end if;*/
  if r%rowcount = 0 then 
    modGUI.PaginaFeedBack('ERRORE','errore login: controlla i tuoi dati inseriti', (costanti.server || costanti.root || 'LOGIN.Login') );
  else
    if not islogged(Usr) then
      id_sess := idSessioni_seq.nextval;
      insert into SESSIONI values (id_sess,v_record.idUtente,SYSTIMESTAMP,Usr);
    else
      id_sess := getIdFromSession(Usr);
    end if;
    modgui.reindirizza(costanti.server || costanti.root || 'modgui.paginaprincipale/?IdSessione='||id_sess);
  end if;
  CLOSE r;
end checkLogin;

procedure logout(idSessione int) is
  id number;
begin
  id := idSessione;
  delete from SESSIONI where IDSESSIONE = id;
  modgui.reindirizza(costanti.server || costanti.root || 'modgui.paginaospiti');
end logout;


END LOGIN;
/

