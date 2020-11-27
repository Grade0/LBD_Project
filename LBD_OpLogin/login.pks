create PACKAGE LOGIN AS 
    function isLogged(Usrname varchar2) return boolean;
    function getIdFromSession(Usrname varchar2) return number;
    procedure login;
    procedure checkLogin(Usr varchar2 , Pwd varchar2);
    procedure logout(idSessione int);
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

END LOGIN;
/

