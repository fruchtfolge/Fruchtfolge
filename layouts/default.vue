<template>
  <div>
    <div class="header">
      <button @click='toggle' type="button" name="button" class="navIcon"></button>
      <nuxt-link to="/" class="logo">FRUCHTFOLGE</nuxt-link>
      <select v-model="curPlanYear" class="planYear" type="button" value="2019">
        <option disabled value="">Planungsjahr</option>
        <option v-for="(year,i) in years" :key="i" :value="year.single"> {{ year.full }}</option>
      </select>
    </div>
    <!-- this is the navigation bar on the side -->
    <div class="sidenav" v-bind:style="sidenavStyle">
      <ul class="sidenav-container">
        <li v-for="(link, index) in links"
            :key='index' @click="follow(link)">
            <p class="sidenav-links" v-bind:class="{ active: isClicked(link.name)}">
              <!--v-bind:class="{ active: isClicked(link.name)}"-->
              {{ link.name }}
            </p>
          </li>
      </ul>
    </div>
    <!-- this is where the main application lives -->
    <nuxt class="nuxt" v-bind:style="mainStyle"></nuxt>
  </div>
</template>

<script>
import Setting from '~/constructors/settings'

export default {
  data () {
    return {
      curPlanYear: null,
      curPage: 'Home',
      years: [],
      isOpen: false,
      sidenavStyle: {
        width: '0px'
      },
      mainStyle: {
        marginLeft: '0px'
      },
      clickedPage: {
        backgroundColor: 'rgba(0, 0, 0, .05)'
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
  async created() {
    const date = new Date()
    const year = date.getFullYear()
    const month = date.getMonth()
    // construct planning periods for future/past
    for (var i = year - 1; i < year + 6; i++) {
      this.years.push({
        single: i,
        full: `${i - 1}/${i}`
      })
    }
    // switch to new planning period after April
    if (month > 4) {
      this.curPlanYear = year + 1
    } else {
      this.curPlaYear = year
    }
    // construct settings object if it doesn't exist
    try {
      // get settings from db (if available)
      await this.$db.get('settings')
    } catch(e) {
      if (e.status === 404) {
        const settings = new Setting(this.curPlanYear)
        // store in db
        await this.$db.put(settings)
      }
    }
  },
  watch: {
    async curPlanYear() {
      try {
        // get settings from db (if available)
        const settings = await this.$db.get('settings')
        settings.curYear = this.curPlanYear
        await this.$db.put(settings)
      } catch(e) {
        console.log(e)
      }
    }
  },
  methods: {
    open() {
      this.sidenavStyle.width = '250px'
      this.mainStyle.marginLeft = '250px'
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
      this.curPage = link.name
      return $nuxt.$router.replace({path: link.route})
    },
    isClicked(name) {
      return this.curPage === name
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

.planYear {
  width: 125px;
  font-size: 18px;
  border-color: black;
  padding-left: 12px;
  margin-bottom: 15px;
  height: 40px;
  padding-right: 25px;
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
  background-repeat: no-repeat;
  background-position: 100% 50%;
  position: fixed;
  right: 30px;
  top: 10px;
}

.planYear:hover {
  background-color: rgba(0, 0, 0, .05);
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
  background-color: #ececec;
  overflow-x: hidden;
  transition: width .5s;
  padding-top: 60px;
}


.sidenav-container {
  list-style: none;
  padding-left: 0px;
}

.sidenav-links {
  position: relative;
  width: 100%;
  cursor: pointer;
  font-size: 18px;
  letter-spacing: 0.1em;
  padding-left: 40px;
  top: 60px;
  line-height: 40px;
  margin-top: 5px;
  margin-bottom: 5px;
}
.sidenav-links:not(.active):hover {
  background-color: rgba(0, 0, 0, .02);
}
.active {
  background-color: rgba(0, 0, 0, .05);
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
