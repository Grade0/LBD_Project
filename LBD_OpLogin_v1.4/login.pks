create or replace PACKAGE LOGIN AS 
    function isLogged(Usrname varchar2) return boolean;
    function getRoleFromSession(idSession number) return varchar2;
    function getUnameFromSession(idSession number) return varchar2;
    function getIdFromSession(Usrname varchar2) return number;
    procedure login;
    procedure checkLogin(Usr varchar2 , v_Pwd varchar2);
    procedure logout(idSessione number);
    function getIdutente(id_Sessione number) return number;
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

END LOGIN;
/

