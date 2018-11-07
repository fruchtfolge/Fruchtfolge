<template lang="html">
  <div class="blur">
    <div class="box">
      <div class="inputs">
        <h2 class="infoText">NEUE KULTUR HINZUFÜGEN</h2>
        <label for="add.crop.farmingType">Anbauverfahren</label>
        <select class="dropdown" id="add.crop.farmingType" v-model="farmingType">
          <option v-for="(farmingType, i) in farmingTypes" :key="i" :value="farmingType">{{ farmingType }}</option>
        </select>
        <label for="add.crop.crop">Kultur</label>
        <select class="dropdown" id="add.crop.crop" v-model="crop">
          <option v-for="(crop, i) in crops" :key="i" :value="crop">{{ crop }}</option>
        </select>
        <label for="add.crop.system">System</label>
        <select class="dropdown" id="add.crop.system" v-model="system">
          <option v-for="(system, i) in systems" :key="i" :value="system">{{ system }}</option>
        </select>
        <label for="add.crop.variety">Sorte</label>
        <input type="text" id="add.crop.variety" placeholder="Optional" class="input" v-model="variety">
      </div>
      <button class="buttonOk" @click="addCrop">ÜBERNEHMEN</button>
      <button class="buttonCancel" @click="cancel">ABBRECHEN</button>
    </div>
  </div>
</template>

<script>
import ktblCrops from '~/assets/js/crops.js'
import Crop from '~/constructors/Crop'

export default {
  data() {
    return {
      farmingType: 'konventionell/integriert',
      crop: 'Ackergras - Anwelksilage',
      system: 'Ballen',
      variety: '',
      farmingTypes: ['konventionell/integriert', 'ökologisch']
    }
  },
  computed: {
    crops() {
      const data = _.filter(ktblCrops, {farmingType: this.farmingType})
      let unique = _.uniqBy(data, 'crop')
      if (data) {
        unique = unique.map(o => {return o.crop})
        return unique
      }
    },
    systems() {
      let data = _.filter(ktblCrops, {farmingType: this.farmingType, crop: this.crop})
      if (data) {
        data = data.map(o => {return o.system})
        return data
      }
    }
  },
  methods: {
    async addCrop() {
      //const settings = await this.$db.get('settings')
      this.$emit('closeAddCrop')
    },
    cancel() {
      this.$emit('closeAddCrop')
    }
  }
}
</script>

<style>
.blur {
  background: #F5F5F5;
  position: fixed;
  width: 100%;
  height: 100%;
  z-index: 95;
  transition: all 0.8s ease-in-out;
  opacity: 0.95;
  visibility: visible;
}

.box {
  position: relative;
  width: 400px;
  height: 500px;
  top: 40%;
  margin-top: -250px;
  left: 50%;
  margin-left: -200px;
  background-color: white;
  border: 1px solid;
  border-color: #CCCCCC;
  z-index: 99;
}

.inputs {
  width: 320px;
  position: relative;
  left: 50%;
  top: 30px;
  margin-left: -160px;
}

.label {
  position: relative;
  left: 0px;
  margin-left: 0px;
  display: inline-block;
  margin-top: 0px;
  top: 0px;
  margin-bottom: 5px;
}
.infoText {
  text-align: center;
  font-size: 18px;
  padding-bottom: 15px;
  letter-spacing: 0.2em;
  font-weight: normal;
  font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
}

.dropdown {
  margin-bottom: 15px;
  width: 320px;
  height: 33px;
  background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
  background-position: 100% 50%;
  background-repeat: no-repeat;
  padding-right: 25px;
}

.input {
  margin-bottom: 15px;
  width: 312px;
  height: 33px;
  padding-right: 0px;
}

.buttonOk {
    position: absolute;
    bottom: 35px;
    left: 45px;
    height: 40px;
    width: 130px;
    border-style: solid;
    border-width: 1px;
    border-color: black;
    background-color: transparent;
    padding: 5px;
}

.buttonOk:hover {
    background-color: #79ae98;
    color: white;
}

.buttonCancel {
    position: absolute;
    bottom: 35px;
    right: 45px;
    height: 40px;
    width: 130px;
    border-style: solid;
    border-width: 1px;
    border-color: black;
    background-color: transparent;
    padding: 5px;
}
.buttonCancel:hover {
    background-color: rgba(0,0,0,0.05);
}
</style>
