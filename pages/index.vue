<template>
  <div class="main">
    <img id="background" class="background" src="~assets/img/background.jpeg" alt="background" />
    <div class="flip-container" id="login">
        <div class="flipper">
            <div class="login">
                <p>ANBAUPLANUNG OPTIMIEREN</p>
                <div id="emailFalsch" class="emailFalsch">Die angegebene E-Mail Adresse konnte nicht gefunden werden</div>
                <input id="email" class="email" placeholder="E-Mail" name="email" autofocus="autofocus" />
                <input class="password" onkeypress="return checkEnterLogin(event)" placeholder="Passwort" type="password" name="password" id="password" />
                <input class="checkbox" type="checkbox" />
                <input type="checkbox" id="c1" name="cc" />
                <label for="c1" class="label-login"><span></span>Angemeldet bleiben</label>
                <button type="button" class="login-button" id="login-button">ANMELDEN</button>
                <a class="forgot" href="index.html">Passwort vergessen?</a>
            </div>
            <div class="registrierung">
                <p>JETZT KOSTENLOS ANMELDEN</p>
                <input id='name' class="name" placeholder="Vor- und Nachname" />
                <input id="street" class="street" placeholder="Strasse u. Hausnr." />
                <input id="postcode" class="postcode" placeholder="PLZ" />
                <input id="email2" class="email2" placeholder="E-Mail Adresse" />
                <input id='password2' class="password2" placeholder="Passwort" type="password" />
                <input id="repeatPass" class="repeat-password" placeholder="Passwort wiederholen" type="password" />
                <button type="button" class="register-button" id="signup">REGISTRIEREN</button>
            </div>
        </div>
    </div>
  </div>
</template>

<script>

export default {}
</script>

<style>
.container {
  width: 100%;
  height: 100%;
  overflow-x: hidden;
}

.background {
  position: fixed;
  border: 0px;
  padding: 0px;
  top: 0;
  left: 0;
  /* Preserve aspet ratio */
  min-width: 100%;
  min-height: 100%;
}

.registrieren-oben {
	display: block;
	position: fixed;
	top: 12px;
	right: 35px;
	width: 110px;
	height: 35px;
  z-index: 99;
	border-style: solid;
    border-width: 2px;
    border-color: black;
    background: white;
    font-family: 'Open Sans Condensed', sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 15px;
  	color: black;
  	padding: 5px;
  	border-radius: 0 !important;
}

.registrieren-oben:active {
    vertical-align: top;
    padding-top: 6px;
    background: rgba(0,0,0,0.02);
}

.registrieren-oben:hover {
  background-color: rgba(0,0,0,0.05)
}
div.flip-container {
	position: fixed;
  cursor: default;
	left: 50%;
	margin-left: -150px;
	top: 50%;
	margin-top: -185px;
}
/* entire container, keeps perspective */
.flip-container {
	perspective: 1000px;
}
/* flip the pane when hovered */
.flip-container.flip .flipper {
	transform: rotateY(-180deg);
}

.flip-container, .login {
	width: 300px;
	height: 370px;
}

/* flip speed goes here */
.flipper {
	transition: 0.6s;
	transform-style: preserve-3d;
	position: relative;
}

/* hide back of pane during swap */
.login, .registrierung {
	backface-visibility: hidden;
	-webkit-backface-visibility: hidden;
	position: absolute;
	top: 0;
	left: 0;
}

/* front pane, placed above back */
.login {
	z-index: 2;
	/* for firefox 31 */
	transform: rotateY(0deg);
}

/* back, initially hidden pane */
.registrierung {
  height: 500px;
	transform: rotateY(180deg);
}

.login {
	background: white;
	border-radius: 0 !important;
}

.login p {
	font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.23em;
  	font-size: 29px;
  	text-align: center;
  	color: black;
  	padding-top: 15px;
  	padding-left: 5px;
  	margin: 0px;
  	-webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.registrierung p {
	font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.23em;
  	font-size: 26px;
  	text-align: center;
  	color: black;
  	padding-top: 15px;
  	padding-left: 5px;
  	margin: 0px;
  	-webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.name {
	position: absolute;
	top: 50%;
	margin-top: -134px;
	left: 50%;
	margin-left: -116.5px;
	width: 233px;
	height: 33px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

.street {
  position: absolute;
  top: 50%;
  margin-top: -89px;
  left: 50%;
  margin-left: -116.5px;
  width: 233px;
  height: 33px;
  border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
    letter-spacing: 0.1em;
    font-size: 18px;
    color: grey;
    padding-left: 5px;
    border-radius: 0 !important;
}

.postcode {
  position: absolute;
  top: 50%;
  margin-top: -44px;
  left: 50%;
  margin-left: -116.5px;
  width: 233px;
  height: 33px;
  border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
    letter-spacing: 0.1em;
    font-size: 18px;
    color: grey;
    padding-left: 5px;
    border-radius: 0 !important;
}

.email {
	position: absolute;
	top: 50%;
	margin-top: -48px;
	left: 50%;
	margin-left: -116.5px;
	width: 233px;
	height: 33px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

.emailFalsch {
  position: absolute;
  visibility: hidden;
  top: 38%;
  margin-top: -48px;
  left: 50%;
  margin-left: -120px;
  width: 240px;
  height: 33px;
  border-style: dashed;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: #f5f5f5;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
    text-align: center;
    letter-spacing: 0.1em;
    font-size: 12px;
    color: grey;
    padding-left: 0px;
    border-radius: 0 !important;
}

.email2 {
	position: absolute;
	top: 50%;
	margin-top: -0px;
	left: 50%;
	margin-left: -116.5px;
	width: 233px;
	height: 33px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

.password {
	position: absolute;
	top: 50%;
	margin-top: 0px;
	width: 233px;
	height: 33px;
	left: 50%;
	margin-left: -116.5px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

.password2 {
	position: absolute;
	top: 50%;
	margin-top: 48px;
	width: 233px;
	height: 33px;
	left: 50%;
	margin-left: -116.5px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

.repeat-password {
	position: absolute;
	top: 50%;
	margin-top: 96px;
	width: 233px;
	height: 33px;
	left: 50%;
	margin-left: -116.5px;
	border-style: solid;
    border-width: 1px;
    border-color: #CCCCCC;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 18px;
  	color: grey;
  	padding-left: 5px;
  	border-radius: 0 !important;
}

input[type="checkbox"] {
    display:none;
}
input[type="checkbox"] + label span {
	background: white;
	border: 1px solid #CCCCCC;
	margin:-1px 12px 0 0;
	border-radius: 0 !important;
    display:inline-block;
    width:15px;
    height:15px;
    vertical-align:middle;
    cursor:pointer;
}
input[type="checkbox"]:checked + label span {
    background:grey;
    outline: 2px solid white;
    outline-offset: -3px;
}

.label-login {
	position: absolute;
	top: 50%;
	margin-top: 48px;
	left: 33.5px;
	font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 14px;
  	color: #999999;
  	-webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.login-button {
	position: absolute;
	top: 50%;
	margin-top: 88px;
	width: 233px;
	height: 40px;
	left: 50%;
	margin-left: -116.5px;
	border-style: solid;
    border-width: 2px;
    border-color: black;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.2em;
  	font-size: 18px;
  	color: black;
  	border-radius: 0px !important;
}

.login-button:active {
    vertical-align: top;
    padding-top: 6px;
    background: rgba(0,0,0,0.02);
}

.login-button:hover {
    background: rgba(0,0,0,0.05);
}

.register-button {
	position: absolute;
	top: 50%;
	margin-top: 162px;
	width: 233px;
	height: 40px;
	left: 50%;
	margin-left: -116.5px;
	border-style: solid;
    border-width: 2px;
    border-color: black;
    background-color: transparent;
    font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.2em;
  	font-size: 18px;
  	color: black;
  	border-radius: 0px !important;
}

.register-button:active {
    vertical-align: top;
    padding-top: 6px;
    background: rgba(0,0,0,0.02);
}

.register-button:hover {
    background: rgba(0,0,0,0.05);
}

.forgot {
	position: absolute;
	top: 50%;
	margin-top: 138px;
	right: 33.5px;
	font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  	letter-spacing: 0.1em;
  	font-size: 14px;
  	color: #999999;
  	text-decoration: none;
  	-webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.forgot:active {
	color: black;
}

.registrierung {
	background: white;
}
</style>
