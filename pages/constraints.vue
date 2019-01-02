<template>
  <div>
    <addConstraint v-if="addConstraint" v-on:closeAddConstraint="addConstraint = false"/>
    <div style="width: 100%;">
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Maximal/mindestens</th>
            <th>Menge</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>test</td>
          </tr>
        </tbody>
      </table>
    </div>
    <div style="text-align: center; margin-top: 40px;">
      <button class="addConstraint" style="font-family: 'Open Sans Condensed';" @click="addConstraint = true">HINZUFÜGEN</button>
    </div>
  </div>
</template>
<script>

export default {
  data() {
    return {
      addConstraint: false
    }
  },
  mounted() {

  },
  methods: {

  },
  components: {
    addConstraint: () => import('~/components/add_constraint.vue'),
  }
}
</script>
<style>

</style>
