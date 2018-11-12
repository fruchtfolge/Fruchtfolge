<template lang="html">
  <div class="cropsTable">
    <table >
      <thead>
        <tr>
          <th>Leistungs-/Kostenart</th>
          <th colspan="2">Menge</th>
          <th colspan="2">Preis</th>
          <th colspan="2">Betrag</th>
        </tr>
      </thead>
      <tbody>
        <!-- Revenues-->
        <tr v-for="(source, i) in cm.revenues" :key="revenues + i">
          <td>{{ source.name }}</td>
          <td contenteditable="true" @blur="update">{{ source.amount.value }}</td>
          <td>{{ source.amount.unit }}</td>
          <td contenteditable="true" @input="update">{{ source.price.value }}</td>
          <td>{{ source.price.unit }}</td>
          <td>{{ source.total.value }}</td>
          <td>{{ source.total.unit }}</td>
        </tr>
        <tr class="highlightRow">
          <td colspan="5">Summe Leistung</td>
          <td>{{ revenues }}</td>
          <td>€/ha</td>
        </tr>
        <!-- Direct Costs-->
        <tr v-for="(source, i) in cm.directCosts" :key="directCosts + i">
          <td>{{ source.name }}</td>
          <td contenteditable="true">{{ source.amount.value }}</td>
          <td>{{ source.amount.unit }}</td>
          <td contenteditable="true">{{ source.price.value }}</td>
          <td>{{ source.price.unit }}</td>
          <td>{{ source.amount.value * source.price.value}}</td>
          <td>{{ source.total.unit }}</td>
        </tr>
        <tr class="highlightRow">
          <td colspan="5">Summe Direktkosten</td>
          <td>{{ directCosts }}</td>
          <td>€/ha</td>
        </tr>
        <!-- Other Variable Costs-->
        <tr v-for="(source, i) in cm.variableCosts" :key="variableCosts + i">
          <td>{{ source.name }}</td>
          <td contenteditable="true">{{ source.amount.value }}</td>
          <td>{{ source.amount.unit }}</td>
          <td contenteditable="true">{{ source.price.value }}</td>
          <td>{{ source.price.unit }}</td>
          <td>{{ source.total.value }}</td>
          <td>{{ source.total.unit }}</td>
        </tr>
        <tr class="highlightRow">
          <td colspan="5">Summe variable Kosten</td>
          <td>{{ variableCosts }}</td>
          <td>€/ha</td>
        </tr>
        <!-- Contribution Margin-->
        <tr class="highlightRow">
          <td colspan="5">Deckungsbeitrag</td>
          <td>{{ contributionMargin }}</td>
          <td>€/ha</td>
        </tr>
        <!-- Fix Costs-->
        <tr v-for="(source, i) in cm.fixCosts" :key="fixCosts + i">
          <td>{{ source.name }}</td>
          <td contenteditable="true">{{ source.amount.value }}</td>
          <td>{{ source.amount.unit }}</td>
          <td contenteditable="true">{{ source.price.value }}</td>
          <td>{{ source.price.unit }}</td>
          <td>{{ source.total.value }}</td>
          <td>{{ source.total.unit }}</td>
        </tr>
        <tr class="highlightRow">
          <td colspan="5">Summe Direkt- und Arbeitserledigungskosten</td>
          <td>{{ fixCosts }}</td>
          <td>€/ha</td>
        </tr>
        <!-- Contribution Margin 2-->
        <tr class="highlightRow">
          <td colspan="5">Direkt- und arbeitserledigungskostenfreie Leistung</td>
          <td>{{ contributionMargin2 }}</td>
          <td>€/ha</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  data() {
    return {
      //selectedCrop: null
    }
  },
  computed: {
    cm() {
      return this.crop.contributionMargin
    },
    revenues() {
      return _.sumBy(this.cm.revenues, o => { return o.total.value })
    },
    directCosts() {
      const costs = _.sumBy(this.cm.directCosts, o => { return o.total.value })
      return _.round(costs, 2)
    },
    variableCosts() {
      const costs = _.sumBy(this.cm.variableCosts, o => { return o.total.value }) + this.directCosts
      return _.round(costs, 2)
    },
    fixCosts() {
      return _.sumBy(this.cm.fixCosts, o => { return o.total.value })
    },
    contributionMargin() {
      return _.round(this.revenues - this.variableCosts, 2)
    },
    contributionMargin2() {
      return _.round(this.contributionMargin - this.fixCosts, 2)
    }

  },
  props: {
    crop: {
      type: Object,
      required: true
    }
  },
  created() {
    console.log(this.cm);
    this.$bus.$on('selectedCrop', selectedCrop => {
      //this.selectedCrop = selectedCrop
      //console.log(this.selectedCrop)
    })
  },
  methods: {
    update(e) {
      console.log(e.target.innerText);
    }
  }
}
</script>
<style>
.cropsTable table {
  width: calc(100% - 275px);
  max-width: 650px;
  border-collapse: collapse;
  letter-spacing: 0.01 em;
  font-size: 16px;
}
th {
  background-color: #79ae98;
  height: 40px;
  color: white;
}
tr {
  height: 30px;
}

td:first-child {
  padding-left: 10px;
}
td:nth-child(2) {
  text-align: right;
}
td:nth-child(4) {
  text-align: right;
}
td:nth-child(6) {
  text-align: right;
}

.cropsTable {
  margin-left: 20px;
  margin-top: 15px;
  margin-right: 20px;
}

.highlightRow {
  height: 40px;
  font-weight: bold;
  letter-spacing: 0.05 em;
  color: #4e4b4b;
}

.cropsTable tr:nth-child(odd) {
  background-color: #ECECEC;
}
</style>
