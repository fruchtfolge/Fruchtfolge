<template>
  <div>
    <div class="menu">
        <!--<nuxt-link to="/" class="logo">FRUCHTFOLGE</nuxt-link>-->
        <p @click='toggle' to="/" class="logo">FRUCHTFOLGE</p>
    </div>
    <div class="sidenav" v-bind:style="sidenavStyle"></div>
    <nuxt class="nuxt" v-bind:style="main"></nuxt>
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
      main: {
        marginLeft: '0px'
      }
    }
  },
  methods: {
    open() {
      this.sidenavStyle.width = '250px'
      this.main.marginLeft = '250px'
      this.isOpen = true
    },
    close() {
      this.sidenavStyle.width = '0px'
      this.main.marginLeft = '0px'
      this.isOpen = false
    },
    toggle() {
      if (this.isOpen) {
        this.close();
      } else {
        this.open();
      }
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
    padding-left: 60px;
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
  overflow-x: hidden;
}

.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

</style>
