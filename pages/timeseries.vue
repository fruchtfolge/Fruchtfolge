<template>
  <div>
    <addCrop v-if="addCrop" v-on:closeAddCrop="addCrop = false"/>
    <cropsSidebar v-on:showAddCrop="addCrop = true" v-on:changeCrop="changeCrop" :crops="crops" :selectedCrop="selectedCrop"/>
    <div v-for="(crop, i) in crops" :key='i' v-if="isSelected(crop)" >
      <timeSeries :crop="crop"/>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      crops: null,
      selectedCrop: null,
      addCrop: false
    }
  },
  created() {
    this.update()
    this.$bus.$on('changeCurrents', _.debounce(this.update, 200))
  },
  methods: {
    changeCrop(crop) {
      this.selectedCrop = crop
    },
    update() {
      this.$set(this, 'crops', this.$store.curCrops)
      if (!this.selectedCrop && this.$store.curCrops) {
        this.$set(this, 'selectedCrop', this.$store.curCrops[0])
      }
    },
    isSelected(crop) {
      return crop.name === this.selectedCrop.name
    }
  },
  components: {
    timeSeries: () => import('~/components/timeSeries.vue'),
    addCrop: () => import('~/components/add_crop.vue'),
    cropsSidebar: () => import('~/components/crops_sidebar.vue'),
  }
}
</script>
