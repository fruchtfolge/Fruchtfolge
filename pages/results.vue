<template>
  <div class="">
    <button type="button" name="button" @click="solve">Test</button>
  </div>
</template>
<script>
export default {
  data() {
    return {}
  },
  methods: {
    async solve() {
      const { data } = await axios.post('createModel', this.$store)
    }
  }
}
</script>
<style>

</style>
