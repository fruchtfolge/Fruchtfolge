<template>
  <div>
    <cropsSidebar v-on:showAddCrop="addCrop = true"/>
    <addCrop v-if="addCrop" v-on:closeAddCrop="addCrop = false"/>
    <div v-for="(crop, i) in crops" :key='i' v-if="crop === clickedCrop" >
      <cropTable/>
      <cropSettings/>
      <cropRevYields/>
    </div>
  </div>
</template>

<script>
export default {
  data: () => {
    return {
      crops: null,
      addCrop: true
    }
  },
  components: {
    // cropTable: () => import('~/components/cropTable.vue'),
    addCrop: () => import('~/components/add_crop.vue'),
    cropsSidebar: () => import('~/components/crops_sidebar.vue'),
    // cropSettings: () => import('~/components/cropSettings.vue'),
    // cropRevYields: () => import('~/components/cropRevYields.vue')
  }
}
</script>
