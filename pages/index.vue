<template>
  <section class="container">
    <button @click="toggle" class="registrieren-oben">DRUCKEN</button>
    <div class="main">
      <img id="background" class="background" src="background.jpeg" alt="background" />
    </div>
    <navSidebar></navSidebar>
  </section>
</template>

<script>
import navSidebar from '~/components/navbar.vue' 

export default {
  methods: {
    toggle() {
      return navSidebar.methods.toggle()
    }
  },
  components: {
    navSidebar
  }
}
</script>

<style>
.container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.background {
  position: fixed;
  top: 0;
  left: 0;
  /* Preserve aspect ratio */
  min-width: 100%;
  min-height: 100%;
}

.main {
  transition: margin-left .5s;
}

.registrieren-oben {
	display: block;
	position: absolute;
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
