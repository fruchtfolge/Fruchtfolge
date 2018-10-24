<template>
  <div style="height: 100%; width: 100%;">
    <plotsSidebar/>
    <maps/>
  </div>
</template>

<script>
export default {
  data: () => ({
    map: null
  }),
  components: {
    maps: () => import('~/components/maps.vue'),
    plotsSidebar: () => import('~/components/plots_sidebar.vue')
  },
  created () {

  }
}
</script>
