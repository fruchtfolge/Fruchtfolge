<template>
  <div>
    <div class="header">
      <button @click='toggle' type="button" name="button" class="navIcon"></button>
      <nuxt-link to="/" class="logo">FRUCHTFOLGE</nuxt-link>
    </div>
    <!-- this is the navigation bar on the side -->
    <div class="sidenav" v-bind:style="sidenavStyle">
      <ul class="sidenav-container">
        <li v-for="(link, index) in links" class="sidenav-links"
            :key='index' @click="follow(link.route)">{{ link.name }}</li>
      </ul>
    </div>
    <!-- this is where the main application lives -->
    <nuxt class="nuxt" v-bind:style="mainStyle"></nuxt>
  </div>
</template>

<script>
export default {
  data () {
    return {
      isOpen: false,
      sidenavStyle: {
        width: '0px'
      },
      mainStyle: {
        marginLeft: '0px'
      },
      links: [{
        route: '/',
        name: 'Home',
        icon: 'static/home.png'
      },
      {
        route: 'settings',
        name: 'Einstellungen',
        icon: 'static/settings.png'
      },{
        route: 'maps',
        name: 'Felder',
        icon: 'static/plots.png'
      },
      {
        route: 'crops',
        name: 'Kulturen',
        icon: 'static/crops.png'
      },
      {
        route: 'constraints',
        name: 'Nebenbedigungen',
        icon: 'static/constraints.png'
      },
      {
        route: 'results',
        name: 'Ergebnisse',
        icon: 'static/results.png'
      }]
    }
  },
  methods: {
    open() {
      this.sidenavStyle.width = '275px'
      this.mainStyle.marginLeft = '275px'
      this.isOpen = true
    },
    close() {
      this.sidenavStyle.width = '0px'
      this.mainStyle.marginLeft = '0px'
      this.isOpen = false
    },
    toggle() {
      if (this.isOpen) {
        this.close();
      } else {
        this.open();
      }
    },
    follow(link) {
      return $nuxt.$router.replace({path: link})
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
  overflow-x: hidden;
  background-color: #F5F5F5;
  font-family: 'Open Sans Condensed', sans-serif;
}

.header {
  position: fixed;
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
  padding-left: 80px;
  margin: 0px;
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  text-decoration: none;
}

.nuxt {
  position: relative;
  top: 60px;
  transition: margin-left .5s;
  padding-bottom: 50px;
}

.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: rgb(210, 210, 210);
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav-container {
  list-style: none;
}

.sidenav-links {
  position: relative;
  width: 200px;
  cursor: pointer;
  font-size: 18px;
  letter-spacing: 0.1em;
  padding-top: 10px;
  padding-bottom: 10px;
  top: 60px;
}

.navIcon {
	position: fixed;
	left: 22px;
	top: 19px;
	z-index: 120;
	width: 33px;
	height: 27px;
  cursor: pointer;
	background: url("data:image/svg+xml;utf8,<svg version='1.1' id='Ebene_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' width='33px' height='27px' viewBox='0 0 33 27' enable-background='new 0 0 33 27' xml:space='preserve'> <g> <rect width='33' height='2'/> </g> <g> <rect y='25' width='33' height='2'/> </g> <g> <rect y='12' width='33' height='2'/> </g> </svg>")  no-repeat;
	background-size: 23px 25px;
	background-repeat: no-repeat;
	border-radius: 0 !important;
	border-style: solid;
	border-width: 0px;
  -moz-user-select: -moz-none;
}

button:focus {outline:0;}

</style>
