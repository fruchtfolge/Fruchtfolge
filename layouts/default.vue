<template>
  <div>
    <div class="menu">
        <nuxt-link to="/" class="logo">FRUCHTFOLGE</nuxt-link>
        <button v-if="$nuxt.$route.path !== '/'" @click="btnFn" id="proceed" class="proceed" type="button">{{ btnText }}</button>
    		<div v-if="$nuxt.$route.path !== '/'" @click="isOpen =! isOpen" id="menuNav" class="menuNav">
    			<div v-show="isOpen" class="dropdown-content">
    				<a>DATENEINGABE</a>
    				<a>KARTENDARSTELLUNG</a>
    				<a>DECKUNGSBEITRÄGE</a>
    				<a>ANBAUMÖGLICHKEITEN</a>
    				<a>NEBENBEDINGUNGEN</a>
    				<a>ERGEBNIS</a>
    				<a @click="logout">LOGOUT</a>
    			</div>
    		</div>
    </div>
    <nuxt/>
  </div>
</template>

<script>
export default {
  data () {
    return {
      isOpen: false,
      btnText: '',
      btnFn: ''
    }
  }
}
</script>

<style>

body,html {
  margin: 0px;
  padding: 0px;
  height: 100%;
  width: 100%;
  background-color: #F5F5F5;
  font-family: 'Open Sans Condensed', sans-serif;
}

.menu {
  position: absolute;
  cursor: default;
  top: 0px;
  left: 0px;
  height: 60px;
  width: 100%;
  background: white;
    z-index: 97;
    line-height: 60px;
}

.logo {
  color: black;
  font-family: 'Open Sans Condensed', sans-serif;
    letter-spacing: 0.3em;
    font-size: 28px;
    padding-left: 30px;
    margin: 0px;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    text-decoration: none;
}
.proceed {
	display: block;
	position: fixed;
	top: 10px;
	right: 77px;
	width: 130px;
	height: 40px;
	z-index: 99;
	border-style: solid;
		border-width: 2px;
		border-color: black;
		background: white;
		font-family: 'Open Sans Condensed', sans-serif;
		letter-spacing: 0.1em;
		font-size: 18px;
		color: black;
		padding: 5px;
		border-radius: 0 !important;
}
.proceed:hover {
	background-color: rgba(0,0,0,0.05)
}
.proceed:active {
		vertical-align: top;
		padding-top: 6px;
		background-color: rgba(0,0,0,0.2)
}
.menuNav {
	position: fixed;
	right: 22px;
	top: 19px;
	z-index: 120;
	width: 33px;
	height: 27px;
	background: url("data:image/svg+xml;utf8,<svg version='1.1' id='Ebene_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' width='33px' height='27px' viewBox='0 0 33 27' enable-background='new 0 0 33 27' xml:space='preserve'> <g> <rect width='33' height='2'/> </g> <g> <rect y='25' width='33' height='2'/> </g> <g> <rect y='12' width='33' height='2'/> </g> </svg>")  no-repeat;
	background-size: 33px 25px;
	background-repeat: no-repeat;
	border-radius: 0 !important;
	border-style: solid;
		border-width: 0px;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  right: 0;
  top: 30px;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 5px 5px;
  text-decoration: none;
  font-size: 12px;
  letter-spacing: 0.1em;
  line-height: 20px;
  display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}
</style>
