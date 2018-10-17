<template>
  <div style="height: 100%; width: 100%;">
    <maps/>
  </div>
</template>

<script>
export default {
  data: () => ({
    map: null
  }),
  components: {
    maps: () => import('~/components/maps.vue')
  },
  created () {

  }
}
</script>
