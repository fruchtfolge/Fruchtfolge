<template>
  <div>
    <cropsSidebar/>
    <addCrop/>
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
      crops: null
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
