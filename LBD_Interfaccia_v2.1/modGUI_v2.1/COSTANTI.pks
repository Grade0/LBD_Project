CREATE OR REPLACE PACKAGE COSTANTI as

stile constant VARCHAR2(32767) := '

/* !!!!! CAMBIARE NOME UTENTE !!!!! */
:root {
  --url-bg-image: url(http://131.114.73.203:8080/apex/davide.files_orcl2021_api.GetImage?p_name=bgbeer2.jpg);
}

* {
  margin: 0;
  padding: 0;
  font-family: sans-serif;
}

html {
  overflow-x:hidden
}

body {
  color: #232a30;
}

.centered {
  text-align: center;
}

h1, h2, h3, h4, h5, h6 {
  text-align: center;
}

h1 {
    color: #FFBF00;
}

h2.right {
  text-align: right;
  padding-right: 200px;
}

form {
 width:100%;
}

/* Paste this css to your style sheet file or under head tag */
/* This only works with JavaScript, 
if its not present, dont show loader */
.no-js #loader { display: none;  }
.js #loader { display: block; position: absolute; left: 100px; top: 0; }
.se-pre-con {
  position: fixed;
  left: 0px;
  top: 0px;
  width: 100%;
  height: 100%;
  z-index: 10;
  background: url(https://smallenvelop.com/wp-content/uploads/2014/08/Preloader_11.gif) center no-repeat #fff;
}


/* ----- Guest Page ----- */

#bgimg {
  background-image: var(--url-bg-image);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  height: 100vh;
  overflow: hidden;
  /*background-color: linear-gradient(to bottom, #232a30, rgba(255,191,0,0.3));*/
}

.logo0 {
  display: inline-block;
}
.imglogo0 {
  height: 50px;
  margin-right: 10px;
}

.navbar {
  color: #FFBF00;
  margin-top: 25px;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.form-box {
  right: 38px;
  width: 420px;
  height: 300px;
  background: #fff;
  margin-top: 10%;
  margin-right: 15%;
  padding: 10px 0;
  color: #fff;
  box-shadow: 0 0 20px 2px linea(250,250,250,0.5);
  border-radius: 15px;
  position: absolute;
  text-align: center;
  /*overflow: hidden;*/
  transition: .5s;
}


.button-box {
  display: inline-block;

}

.button-box span {
  font-weight: bold;
  padding: 10px;
  color: rgba(250, 191, 0, 0.8);
  cursor: pointer;
  width: 100px;
  display: inline-block;
}

#indicator {
  width: 80%;
  border: none;
  background: #232a30;
  height: 2px;
  margin-top: 0;
  left: 32px;
  position: absolute;
  font-size: 30px;
}


.login-btn {
  margin: 50px auto 20px;
  width: 85%;
  display: block;
  outline: none;
  padding: 10px 0;
  border: 1px solid #FFBF00;
  cursor: pointer;
  background: transparent;
  color: #fff;
  font-size: 16px;
}



/* ------ Main Page ------ */

.imglogo {
  height: 50px;
  margin-right: 10px;
  margin-left: 30px;
}

.logo {
  color: #FFBF00;
}

nav {
  flex: 1;
  text-align: right;
  margin-right: 30px;
}

nav ul li {
  list-style: none;
  display: inline-block;
  margin-left: 50px;
}

nav ul li a {
  text-decoration: none;
  color: #232a30;
  padding: 5px 2px;
}

nav ul li a:hover {
  color: #FFBF00;
}

/* hide sub-menu-1 */
.sub-menu-1 {
  display:  none; 
}

/* hide sub-menu-2 */
.sub-menu-2 {
  display:  none;
}

/* subnavs cells layout */
.sub-menu-1 ul li {
  display: block;
  margin: 0;
  padding:  10px 0px 10px 20px; /* padding around links*/
  min-width:  135px;
  text-align: left;
  /*for debuging purpose*/
  /*outline: 1px solid #000;*/
}
/*
.sub-menu-1>ul>li>a {
    margin: 0 25px;
    outline: 1px solid #ccc;
}*/

/* display sub-menu-1 on hover */
nav ul li:hover .sub-menu-1 {
  display:  block;
  -webkit-animation: slide-down .8s ease-out;
  -moz-animation: slide-down .8s ease-out;
  position:  absolute;  
  margin-top:   5px;
  margin-left:  -15px;
   
}

/* display sub-menu-2 on hover */
.sub-menu-1 ul li:hover .sub-menu-2 {
  display:  block;
  -webkit-animation: slide-down .8s ease-out;
  -moz-animation: slide-down .8s ease-out;
  position:  absolute;  
  margin-top:   -40px;
  margin-left:  130px;
}

.sub-menu-1 ul li:hover .sub-menu-2 ul li {
    margin: 0;
    padding: 10px 25px;
    /*outline: 1px solid #ccc;*/
}

/* subnavs layout */
.sub-menu-1 ul {
  margin: 10px; /*margin around subnavs*/
  padding: 8px 0; /*padding above and below links */
  background-color: rgba(250,250,250,1);
  box-shadow: 0 0 20px -5px rgba(35,42,48,0.3);
  border-radius:  10px;
}

@-webkit-keyframes slide-down {
      0% { opacity: 0; /*-webkit-transform: translateY(-100%); */}   
    100% { opacity: 1; /*-webkit-transform: translateY(0); */}
}

@-moz-keyframes slide-down {
      0% { opacity: 0; /*-moz-transform: translateY(-100%); */}   
    100% { opacity: 1; /*-moz-transform: translateY(0); */}
}

.dropbtn {
  position: relative;
  background: none;
  color: #232a30;
  padding: 16px;
  font-size: 16px;
  border: 1px solid #232a30;
  border-radius: 25px;
  /*text-shadow: 0px 0px 6px rgba(255, 255, 255, 1);
  -webkit-box-shadow: 0px 5px 40px -10px rgba(255,255,255,0.57);
  -moz-box-shadow: 0px 5px 40px -10px rgba(255,255,255,0.57);
  /*transition: all 0.4s ease 0s;*/
  outline: none;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
  position: relative;
  display: inline-block;

}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  max-height: 0;
  overflow: hidden;
  -webkit-transition: max-height 0.2s ease-in;
  transition: max-height 0.2s ease-in;
  position: absolute;
  background-color: rgba(35,42,48,0.8);
  min-width: 155px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  border-radius: 15px;
  margin-top: 2px; 
  margin-left: 18px;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: #fff;
  padding: 12px 0;
  text-decoration: none;
  display: block;
  text-align: left;
  margin-left: 28px; 
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {max-height: 200px;}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
  border: 1px solid #FFBF00;
}


@media (max-width:1250px) {
    .hide1 {
        display: none;
    }
}

@media (max-width:700px) {
    .hide3 {
        display: none;
    }
    
    .dropbtn {
        font-size: 10px;
    }
}

/* The side navigation menu */
.sidenav {
  height: 100%; /* 100% Full-height */
  position: fixed; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0; /* Stay at the top */
  right: 0;
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.8s; /* 0.8 second transition effect to slide in the sidenav */
  background: #fff;
  box-shadow: -10px 0px 20px -5px rgba(0,0,0, 0.1);
}

/* The navigation menu links */
.sidenav a {
  padding: 12px 8px 8px 40px;
  text-decoration: none;
  font-size: 24px;
  color: #232a30;
  display: block;
  transition: 0.3s;
  overflow: hidden;
  
}

.nav-title-box {
  margin: 10px 0;
  width: 300px;
}

.nav-list-title {
  padding-left: 20px;
  color: #FFBF00;
  font-size: 1.5em; 
  font-weight: bolder
}

.nav-list {
  margin-top: 15px;
  width: 300px;
}

/* When you mouse over the navigation links, change their color */
.sidenav a:hover {
  color: #FFBF00;
  transition: 0.5s;
}

.subnav:hover {
    padding-left: 48px;
}

/* Position and style the close button (top right corner) */
.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}

@media screen and (min-width: 1249px) {
  .hide2 {
    display: none;
  }
}

#hamb-icon {
  font-size: 30px;
  transition: .5;
}

#hamb-icon:hover {
  color: #FFBF00;
}

table tr:nth-child(first) {
  border-top: none;
}

table tr:nth-child(odd) {
  /*background-color: rgba(240, 240, 240, 0.5);*/
}

th {
  background-color: rgba(35,42,48, 0.9);
  color: #FFBF00;
  font-size: large;
  
}

td, th {
  padding: 15px;
  height: 80px;
}

td {
  color: #232a30;
  text-align: center;
  border-top: 1px solid rgba(35,42,48,0.5);
}
table {
  cell-padding: 10px;
  border: 1px solid rgba(35,42,48,0.5);
  border-radius: 10px;
  border-spacing: 0px;
  margin-left: auto;
  margin-right: auto;
  min-width: 90%;
  overflow: hidden;
}
td button {
  background-size: 24px 24px;
  background-position: center;
  background-repeat: no-repeat;
  height: 32px;
  background-clip:padding-box;
  width: 32px;
  border: none;
  cursor: pointer;
  background-color: transparent;
}
td button:hover {
    color: #FFBF00;
}

td button.info {
  background-image: url(https://img.icons8.com/pastel-glyph/64/000000/info--v4.png);
}
td button.edit {
  background-image: url(https://img.icons8.com/pastel-glyph/64/000000/edit--v1.png);
}

td button.Confirm {
  background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHg9IjBweCIgeT0iMHB4Igp3aWR0aD0iNjQiIGhlaWdodD0iNjQiCnZpZXdCb3g9IjAgMCAxNzIgMTcyIgpzdHlsZT0iIGZpbGw6IzAwMDAwMDsiPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0ibm9uemVybyIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtbGluZWpvaW49Im1pdGVyIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHN0cm9rZS1kYXNoYXJyYXk9IiIgc3Ryb2tlLWRhc2hvZmZzZXQ9IjAiIGZvbnQtZmFtaWx5PSJub25lIiBmb250LXdlaWdodD0ibm9uZSIgZm9udC1zaXplPSJub25lIiB0ZXh0LWFuY2hvcj0ibm9uZSIgc3R5bGU9Im1peC1ibGVuZC1tb2RlOiBub3JtYWwiPjxwYXRoIGQ9Ik0wLDE3MnYtMTcyaDE3MnYxNzJ6IiBmaWxsPSJub25lIj48L3BhdGg+PGcgZmlsbD0iIzJlY2M3MSI+PHBhdGggZD0iTTg2LDguMDYyNWMtNDMsMCAtNzcuOTM3NSwzNC45Mzc1IC03Ny45Mzc1LDc3LjkzNzVjMCw0MyAzNC45Mzc1LDc3LjkzNzUgNzcuOTM3NSw3Ny45Mzc1YzQzLDAgNzcuOTM3NSwtMzQuOTM3NSA3Ny45Mzc1LC03Ny45Mzc1YzAsLTQzIC0zNC45Mzc1LC03Ny45Mzc1IC03Ny45Mzc1LC03Ny45Mzc1ek04NiwxNi4xMjVjMzguNTY1NjIsMCA2OS44NzUsMzEuMzA5MzcgNjkuODc1LDY5Ljg3NWMwLDM4LjU2NTYyIC0zMS4zMDkzOCw2OS44NzUgLTY5Ljg3NSw2OS44NzVjLTM4LjU2NTYzLDAgLTY5Ljg3NSwtMzEuMzA5MzggLTY5Ljg3NSwtNjkuODc1YzAsLTM4LjU2NTYzIDMxLjMwOTM3LC02OS44NzUgNjkuODc1LC02OS44NzV6TTExNC4yNjg2Miw2NS43NzU1MWMtMS4wMjQ2MSwwLjAzMzU5IC0yLjA2NDk2LDAuNDcxODkgLTIuODcxMjEsMS4yNzgxNGwtMjguMDg0OSwyOS4xNTgzMmwtMTQuNjQ3NCwtMTUuNzIwODJjLTEuNDc4MTMsLTEuNjEyNSAtNC4wMzAyLC0xLjc0ODQ1IC01LjY0MjcsLTAuMjcwMzJjLTEuNjEyNSwxLjQ3ODEzIC0xLjc0ODQ1LDQuMDMyODIgLTAuMjcwMzIsNS42NDUzMmwxNy42MDUyMiwxOC45NDYzNWMwLjgwNjI1LDAuODA2MjUgMS43NDU4MywxLjM0Mzc1IDIuOTU1MiwxLjM0Mzc1YzEuMDc1LDAgMi4xNDg5NSwtMC40MDM2NSAyLjk1NTIsLTEuMjA5OWwzMC45MDYyNSwtMzIuMzgzODVjMS40NzgxMiwtMS42MTI1IDEuNDc4NjUsLTQuMTY0NTggLTAuMTMzODUsLTUuNjQyN2MtMC43MzkwNiwtMC44MDYyNSAtMS43NDY4NywtMS4xNzc4OCAtMi43NzE0OCwtMS4xNDQyOXoiPjwvcGF0aD48L2c+PC9nPjwvc3ZnPg==);
}

td button.delete {
  background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHg9IjBweCIgeT0iMHB4Igp3aWR0aD0iNjQiIGhlaWdodD0iNjQiCnZpZXdCb3g9IjAgMCAxNzIgMTcyIgpzdHlsZT0iIGZpbGw6IzAwMDAwMDsiPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0ibm9uemVybyIgc3Ryb2tlPSJub25lIiBzdHJva2Utd2lkdGg9IjEiIHN0cm9rZS1saW5lY2FwPSJidXR0IiBzdHJva2UtbGluZWpvaW49Im1pdGVyIiBzdHJva2UtbWl0ZXJsaW1pdD0iMTAiIHN0cm9rZS1kYXNoYXJyYXk9IiIgc3Ryb2tlLWRhc2hvZmZzZXQ9IjAiIGZvbnQtZmFtaWx5PSJub25lIiBmb250LXdlaWdodD0ibm9uZSIgZm9udC1zaXplPSJub25lIiB0ZXh0LWFuY2hvcj0ibm9uZSIgc3R5bGU9Im1peC1ibGVuZC1tb2RlOiBub3JtYWwiPjxwYXRoIGQ9Ik0wLDE3MnYtMTcyaDE3MnYxNzJ6IiBmaWxsPSJub25lIj48L3BhdGg+PGcgZmlsbD0iI2U3NGMzYyI+PHBhdGggZD0iTTg2LDguMDYyNWMtMjAuODI4MTIsMCAtNDAuNDQ2ODcsOC4wNjI1IC01NS4wOTM3NSwyMi44NDM3NWMtMTQuNzgxMjUsMTQuNjQ2ODggLTIyLjg0Mzc1LDM0LjI2NTYzIC0yMi44NDM3NSw1NS4wOTM3NWMwLDIwLjgyODEzIDguMDYyNSw0MC40NDY4NyAyMi44NDM3NSw1NS4wOTM3NWMxNC43ODEyNSwxNC43ODEyNSAzNC4yNjU2MywyMi44NDM3NSA1NS4wOTM3NSwyMi44NDM3NWMyMC44MjgxMywwIDQwLjQ0Njg3LC04LjA2MjUgNTUuMDkzNzUsLTIyLjg0Mzc1YzE0Ljc4MTI1LC0xNC43ODEyNSAyMi44NDM3NSwtMzQuMjY1NjIgMjIuODQzNzUsLTU1LjA5Mzc1YzAsLTIwLjgyODEyIC04LjA2MjUsLTQwLjQ0Njg3IC0yMi44NDM3NSwtNTUuMDkzNzVjLTE0LjY0Njg4LC0xNC43ODEyNSAtMzQuMjY1NjIsLTIyLjg0Mzc1IC01NS4wOTM3NSwtMjIuODQzNzV6TTg2LDE2LjEyNWMxOC42NzgxMywwIDM2LjE0NzkyLDcuMjU1MiA0OS40NTEwNSwyMC40MjM5NWMxMy4zMDMxMiwxMy4xNjg3NSAyMC40MjM5NSwzMC43NzI5MiAyMC40MjM5NSw0OS40NTEwNWMwLDE4LjY3ODEzIC03LjI1NTIsMzYuMTQ3OTIgLTIwLjQyMzk1LDQ5LjQ1MTA1Yy0xMy4zMDMxMiwxMy4xNjg3NSAtMzAuNzcyOTIsMjAuNDIzOTUgLTQ5LjQ1MTA1LDIwLjQyMzk1Yy0xOC42NzgxMiwwIC0zNi4xNDc5MiwtNy4yNTUyIC00OS40NTEwNSwtMjAuNDIzOTVjLTEzLjMwMzEyLC0xMy4xNjg3NSAtMjAuNDIzOTUsLTMwLjc3MjkyIC0yMC40MjM5NSwtNDkuNDUxMDVjMCwtMTguNjc4MTIgNy4yNTUyLC0zNi4xNDc5MiAyMC40MjM5NSwtNDkuNDUxMDVjMTMuMTY4NzUsLTEzLjMwMzEyIDMwLjc3MjkyLC0yMC40MjM5NSA0OS40NTEwNSwtMjAuNDIzOTV6TTY3Ljk0MzM2LDYzLjgyODEzYy0xLjAyNDYxLDAgLTIuMDMyNDIsMC40MDM2NSAtMi43NzE0OCwxLjIwOTljLTEuNjEyNSwxLjYxMjUgLTEuNjEyNSw0LjE2NDU3IDAsNS42NDI3bDE1LjE4NTQyLDE1LjMxOTI4bC0xNS4zMTkyNywxNS4xODU0MmMtMS42MTI1LDEuNjEyNSAtMS42MTI1LDQuMTY0NTggMCw1LjY0MjdjMC44MDYyNSwwLjgwNjI1IDEuODgwNzIsMS4yMDk5IDIuODIxMzUsMS4yMDk5YzAuOTQwNjIsMCAyLjAxNTEsLTAuNDAzNjUgMi44MjEzNSwtMS4yMDk5bDE1LjMxOTI4LC0xNS4xODU0MmwxNS4xODU0MiwxNS4xODU0MmMwLjgwNjI1LDAuODA2MjUgMS44ODA3MywxLjIwOTkgMi44MjEzNSwxLjIwOTljMC45NDA2MiwwIDIuMDE1MSwtMC40MDM2NSAyLjgyMTM1LC0xLjIwOTljMS42MTI1LC0xLjYxMjUgMS42MTI1LC00LjE2NDU4IDAsLTUuNjQyN2wtMTUuMTg1NDIsLTE1LjE4NTQybDE1LjE4NTQyLC0xNS4xODU0MmMxLjYxMjUsLTEuNjEyNSAxLjYxMTk3LC00LjE2NDA1IDAuMTMzODUsLTUuNzc2NTVjLTEuNjEyNSwtMS42MTI1IC00LjE2NDU3LC0xLjYxMjUgLTUuNjQyNywwbC0xNS4zMTkyOCwxNS4zMTkyN2wtMTUuMTg1NDIsLTE1LjMxOTI3Yy0wLjgwNjI1LC0wLjgwNjI1IC0xLjg0NjYxLC0xLjIwOTkgLTIuODcxMjIsLTEuMjA5OXoiPjwvcGF0aD48L2c+PC9nPjwvc3ZnPg==);
}

td button.cart {
  background-image: url(https://img.icons8.com/pastel-glyph/64/000000/shopping-cart--v2.png);
}

table form {
	display: inline;
}

button {
  background: none;
  color: #232a30;
  border: 1px solid #232a30;
  border-radius: 25px;
  font-variant: inherit;
  display: inline-block;
  cursor: pointer;
  font-size: 16px;
  padding: 16px;
  outline: none;
}

form .verde {
  border: 1px solid #2ECC71;
}

form .rosso {
  border: 1px solid #E74C3C;
}

form button {
    margin-top: 20px;
    min-width: 120px;
}

button:not(.edit):not(.delete):not(.info):not(.cart):not(.confirm):hover {
    border: 1px solid #FFBF00;
}

p.message {
  font: 14pt/22pt "Segoe UI Light";
  padding: 5px 300px;
  text-align: center;
}


div.menuDiv {
  width: 100%;
  height: 15vh;
  margin: auto;
  display: flex;
  align-items: center;
  box-shadow: 0 4px 4px -4px rgba(0,0,0,.2);
}



div.menuDiv a:hover {
  color: #FFBF00;
}

div.logButtonsDiv {
  position: absolute;
  display: flex;
  top: 10px;
  right: 10px;
}

div.logButtonsDiv button {
  float: left;
  margin-left: 5px;
}

span.textlabel {
  font-weight: bold;
}


label{
  text-align:center;
  word-wrap:break-word
}

.label-login {
  position: relative;
  left: 0;
}

.container{
  margin-top:40px;
}

.form-group button{
margin-top:10px;
margin-right:10px;
margin-bottom:10px;
width:150px;

}


.row select{
  /*width:130px;*/
}

.feedback-neg {
    color: #ff0000;
}

.feedback-pos {
    color: #149414;
}

.centrato {
    text-align: center;
    margin-top: 8%;
}

/* verificare che la div non dia problemi al form */
.back {
  margin-left: 45px;
  display: inline-block;
}
';


boot constant varchar2(32767) :=
'
.form-group{
  margin-bottom:15px
  
}
  
.row{
  margin-right:-140px;
  margin-left:0px
  display: inline-block;
}

.form-group-login {
  margin-bottom: 15px;
  position: relative;
  display: inline-block;
  right: 50px;
  width: 280px;
  text-align: center;
  outline: 1px solid #fff;
  height: 150px;
  vertical-align:middle
}

 .row:after,.row:before{
    display:table;content:" "
}

.control-label{
  margin-bottom:0;
  vertical-align:middle
}



.col-lg-1,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9{
   position:relative;
   min-height:1px;
   padding-right:15px;
   padding-left:15px;
}

.col-lg-1,.col-lg-10,.col-lg-11,.col-lg-12,.col-lg-2,.col-lg-3,.col-lg-4,.col-lg-5,.col-lg-6,.col-lg-7,.col-lg-8,.col-lg-9{float:left}

.col-lg-12{width:100%}.col-lg-11{width:91.66666667%}.col-lg-10{width:83.33333333%}.col-lg-9{width:75%}.col-lg-8{width:66.66666667%}.col-lg-7{width:58.33333333%}
.col-lg-6{width:50%}.col-lg-5{width:41.66666667%}.col-lg-4{width:33.33333333%}.col-lg-3{width:25%}.col-lg-2{width:16.66666667%}.col-lg-1{width:8.33333333%}

.col-lg-push-12{left:100%}.col-lg-push-11{left:91.66666667%}.col-lg-push-10{left:83.33333333%}.col-lg-push-9{left:75%}.col-lg-push-8{left:66.66666667%}
.col-lg-push-7{left:58.33333333%}.col-lg-push-6{left:50%}.col-lg-push-5{left:41.66666667%}.col-lg-push-4{left:33.33333333%}.col-lg-push-3{left:25%}
.col-lg-push-2{left:16.66666667%}.col-lg-push-1{left:8.33333333%}.col-lg-push-0{left:auto}


.container{
  padding-right:15px;
  padding-left:15px;
  margin-right:auto;
  margin-left:auto;
  width:1170px;
}

.container:after,.row:after{clear:both}

.form-control{
  height: 50px;
  display:block;
  width:100%;
  padding:6px 20px;
  color:#232a30;
  background-color:trasparent;
  background-image:none;
  border:1px solid rgba(35,42,48,0.8);
  border-radius:25px;
}

.inline-select{
  height: 40px;
  width: 80px;
  padding:6px 20px;
  margin: 6px 0;
  color:#232a30;
  background-color:trasparent;
  background-image:none;
  border:1px solid rgba(35,42,48,0.8);
  border-radius:25px;
}



.form-login {
  height: 50px;
  padding:20px;
  display:block;
  width:20%;
  padding:6px 20px;
  color:#232a30;
  background-color:#fff;
  background-image:none;
  border:1px solid rgba(35,42,48,0.8);
  border-radius:25px;
  outline: none;
  left: 50px;
}


.form-control:focus{
    border-color:#FFBF00;
    outline:none;
}

textarea.form-control{height:auto}

.checkbox-inline, .radio-inline{
  position:relative;
  display:inline-block;
  padding-left:20px;
  margin-bottom:0px;
  margin-right:20px;
  vertical-align:middle;
  cursor:pointer;
}

.checkbox-inline input[type="checkbox"]{
  position:absolute;
  margin-left:-20px;
}

input[type="checkbox"], input[type="radio"]{
  margin: 4px 0 0;
  line-height:normal;
  box-sizing:border-box;
  padding:0;
}

.radio-inline input[type="radio"]{
  position:absolute;
  margin-left:-20px;
}
';


script constant varchar2(32767) :=
'
        /* Set the width of the side navigation to 300px */
        function openNav(id_var) {
            document.getElementById(id_var).style.width = "300px";
        }

        /* Set the width of the side navigation to 0 */
        function closeNav(elem) {
            elem.style.width = "0";
        }

        function checkText(value) {
            if (value.length == 0)
                return true;
            var regexp = /^[a-z]+$/i;
            return regexp.test(value);
        }


        function checkNumber(value) {
            if (value.length == 0)
                return true;
            var regexp = /^[0-9]+$/;
            return regexp.test(value);
        }

        function checkMail(value) {
            if (value.length == 0)
                return true;
            var regexp = /^[-a-z0-9~!$%^&*_=+}{\''?]+(\.[-a-z0-9~!$%^&*_=+}{\''?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
            return regexp.test(value);
        }

        
        function checkCF(value){
            if(value.length == 0)
              return true;
            var regexp = /^[a-z0-9]+$/i;
            return regexp.test(value);
            }
        function resetStyle(idForm)
        {

            var input = document.forms[idForm].getElementsByTagName("input");
            var N = input.length;
            for(var i=0;i<N;i++)
                input[i].style.borderColor = "#CCC";
            
        }

        function validateForm(idForm) {

            console.log("Validation..");
            var correct = true;


            var fields = document.forms[idForm].getElementsByTagName("input");

            var N = fields.length;

            for(var i=0;i<N;i++) {
                
                var input = fields[i];
                var classes = input.className.split(" ");

                var type = classes[0].trim().toLowerCase();
                var check= classes[1];
                var required = (check == ''required'');

                console.log(required);
                switch (type) {
                   
                    case ("text"):
                        console.log(input.value);
                     
                        if ( (required && input.value.length == 0) || (!checkText(input.value))) {
                            input.style.border="2px solid #ff0000 ";
                            correct = false;
                        }

                        else {
                            input.style.borderColor = "#232a30";
                        }

                        break;
                    case ("number"):
                        console.log(input.value);
                        if ( (required && input.value.length == 0) || (!checkNumber(input.value))) {

                            input.style.border = "2px solid #ff0000 ";
                            
                            correct = false;
                        }

                        else {
                            input.style.borderColor = "#232a30";
                        }
                        break;

                    case ("mail"):
                        if ( (required  && input.value.length == 0) || (!checkMail(input.value))) {

                            input.style.border = "2px solid #ff0000";

                            correct = false;
                        }

                        else {
                            input.style.borderColor = "#232a30";
                        }
                        break;
                        
                    
                    case("password"):
                      if ( (required  && input.value.length == 0)) {

                            input.style.border = "2px solid #ff0000 ";
                            
                            correct = false;
                        }

                        else {
                            input.style.borderColor = "#232a30";
                        }
                        break;
                      
                    case ("alfa"):
                        console.log(input.value);
                        if ( (required  && input.value.length == 0) || (!checkCF(input.value))) {

                            input.style.border = "2px solid #ff0000 ";
                            
                            correct = false;
                        }

                        else {
                            input.style.borderColor = "#232a30";
                        }
                        break;

                }

            }

            return correct;
        }';


root constant VARCHAR2(20) := '/apex/davide.'; -- DA SOSTITUIRE (N.B. INCLUDERE IL PUNTO FINALE!!!)
server constant VARCHAR2(50) := 'http://131.114.73.203:8080';
interfaccia constant VARCHAR2(50) := '/apex/davide.'; -- DA SOSTITUIRE (N.B. INCLUDERE IL PUNTO FINALE!!!)

--SOSTITUIRE la costante nel seguente modo q'['CostanteDaSostituire']'
-- IMPORTANTE NON INSERIRE SPAZI E LASCIARE INALTERATO IL PATTERN q'['']'
mySidenav constant VARCHAR(20) := q'['dav-mySidenav']'; 

/* Operazioni menù principale */
/* NOTA: si tratta delle operazioni da invocare a seguito del click sulle voci del menù principale */
home constant VARCHAR2(500) := 'nomeOperazione';
pacchetti constant VARCHAR2(500) := 'nomeOperazione';
servGenerali constant VARCHAR2(500) := 'nomeOperazione';
prenotazioni constant VARCHAR2(500) := 'nomeOperazione';
carrello constant VARCHAR2(500) := 'nomeOperazione';

/* Operazioni menù backoffice */
/* NOTA: si tratta delle pagine principali di ciascun gruppo del 3° raggruppamento */
gruppo1 constant VARCHAR2(500) := 'nomeOperazione';
gruppo2 constant VARCHAR2(500) := 'nomeOperazione';
gruppo3 constant VARCHAR2(500) := 'nomeOperazione';

titoloApplicazione constant VARCHAR2(100) := 'Laboratorio di Basi di Dati 2020';

END COSTANTI;