<template>
  <section class="container">
    <div class="main">
      <img id="background" class="background" src="~assets/img/background.jpeg" alt="background" />
    </div>
  </section>
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
  padding: 0px;
  border: 0px;
  width: 100%;
  min-height: 100vh;
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
</style>
