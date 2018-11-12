<template>
  <div class="cropsSidebar">
    <div v-if="crops">
      <div  v-for="(crops, i) in cropGroups" :key='i'>
        <h2 @click="expand($event)" class="cropsExpand groupText"> {{ crops[0].cropGroup.toUpperCase() }} </h2>
        <div class="expand">
          <p v-for="(crop, n) of crops" :key='n' @click="$emit('changeCrop', crop)" class="cropsText"> {{ crop.name }} </p>
        </div>
      </div>
    </div>
    <div v-else class="helpText">
      Klicken Sie auf den Button (+) um neue Kulturen für das aktuelle Planungsjahr hinzuzufügen
    </div>
    <div class="addCrop" @click="addCrop"></div>
  </div>
</template>
<script>
export default {
  data() {
    return {

    }
  },
  created() {
    //console.log(crops);
  },
  props: {
    crops: {
      type: Array,
      required: false
    }
  },
  computed: {
    cropGroups() {
      return _.groupBy(this.crops, 'cropGroup')
    }
  },
  methods: {
    expand: (e) => {
      const event = e.target
      event.__toggle = !event.__toggle
      var target = event.nextSibling

      if (event.__toggle) {
        event.classList.remove('cropsExpand')
        event.classList.add('cropsCollaps')
        target.style.height = target.scrollHeight + 'px'
      } else {
        event.classList.remove('cropsCollaps')
        event.classList.add('cropsExpand')
        target.style.height = 0
      }
    },
    addCrop() {
      this.$emit('showAddCrop')
    }
  }
}
</script>
<style>
.cropsSidebar {
  position: fixed;
  padding-top: 20px;
  overflow-y: scroll;
  top: 60px;
  right: 0px;
  width: 275px;
  cursor: default;
  height: calc(100vh - 70px);
  background: #ececec;
  z-index: 94;
}
.cropCollaps {
  background: url("data:image/svg+xml;utf8,<svg width='24' height='24' xmlns='http://www.w3.org/2000/svg'> <g> <title>background</title> <rect fill='none' id='canvas_background' height='402' width='582' y='-1' x='-1'/> </g> <g> <title>Layer 1</title> <path transform='rotate(-180 12,11.531000137329102) ' id='svg_1' d='m7.406,7.828l4.594,4.594l4.594,-4.594l1.406,1.406l-6,6l-6,-6l1.406,-1.406z' fill='#444'/> </g> </svg>");
    background-position: 100% 50%;
    background-repeat: no-repeat;
}
.cropsExpand:hover {
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
    background-position: 100% 50%;
    background-repeat: no-repeat;
}

.expand{
    height: 0;
    overflow: hidden;
    transition: height 0.8s ease;
}

.geclickt {
  background-color: #E0E0E0;
}

.cropsText {
  font-size: 16px;
  letter-spacing: 0.1em;
  padding-left: 45px;
  padding-top: 5px;
  padding-bottom: 5px;
  margin: 0px;
}

.groupText {
  font-size: 18px;
  letter-spacing: 0.2em;
  margin-bottom: 5px;
  margin-top: 5px;
  margin-left: 30px;
  font-weight: normal;
}

.helpText {
  padding-left: 20px;
  padding-right: 20px;
}

.expand{
    height: 0;
    overflow: hidden;
    transition: height 0.8s ease;
}

.cropsExpand:hover {
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
    background-position: 100% 50%;
    background-repeat: no-repeat;
}

.cropInput {
  font-family: 'open_sanscondensed_light', sans-serif;
  font-size: 16px;
  letter-spacing: 0.1em;
}
.addCrop {
  padding: 0px;
  margin-top: 20px;
  margin-bottom: 20px;
  position: relative;
  left: 50%;
  margin-left: -16.5px;
  margin-bottom: 15px;
  width: 33px;
  height: 33px;
  background: transparent;
  border: none;
  background-color: grey;
  -webkit-mask: url(~assets/img/add.svg), none;
  -webkit-mask-size: cover;
  -webkit-mask-repeat: no-repeat;
  -webkit-mask-position: center center;
}

.addCrop svg {
  width: 33px;
  height: 33px;
}

.addCrop:hover {
  background-color: black;
}
</style>
