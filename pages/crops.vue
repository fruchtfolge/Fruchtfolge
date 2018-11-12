<template>
  <div>
    <cropsSidebar v-on:showAddCrop="addCrop = true" v-on:changeCrop="changeCrop" :crops="crops"/>
    <addCrop v-if="addCrop" v-on:closeAddCrop="addCrop = false"/>
    <div v-for="(crop, i) in crops" :key='i' v-if="crop === selectedCrop" >
      <cropTable :crop="crop"/>
      <!--<cropSettings/>
      <cropRevYields/>-->
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      crops: null,
      selectedCrop: null,
      addCrop: true
    }
  },
  created() {
    this.update()
    this.$bus.$on('changeCurrents', this.update)
  },
  methods: {
    changeCrop(crop) {
      this.selectedCrop = crop
    },
    update() {
      if (this.$store.curCrops) {
        this.crops = this.$store.curCrops
        this.selectedCrop = this.$store.curCrops[0]
      }
    }
  },
  components: {
    cropTable: () => import('~/components/crop_table.vue'),
    addCrop: () => import('~/components/add_crop.vue'),
    cropsSidebar: () => import('~/components/crops_sidebar.vue'),
    // cropSettings: () => import('~/components/cropSettings.vue'),
    // cropRevYields: () => import('~/components/cropRevYields.vue')
  }
}
</script>
