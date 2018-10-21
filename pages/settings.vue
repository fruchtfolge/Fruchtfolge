<template>
  <div style="width: 50vw; position: absolute; top: 120px; left: 15%; margin-left: -25vw">
      <h1 style="font-family: 'Open Sans Condensed'; font-weight: normal; letter-spacing: 0.2em">EINSTELLUNGEN</h1>
      <span>Für die Optimierung wird der Standort Ihres Betriebes benötigt. Dieser wird für die Berechnung der Hof-Feld-Distanzen der einzelnen Schläge verwendet. Anhand dieser Information werden die Deckungsbeiträge schlagspezifisch errechnet.</span>
      <br>
      <div style="width: 100%; height: 12px; border-bottom: 1px solid black; text-align: center; margin-top: 40px; margin-bottom: 40px">
          <span style="font-size: 20px; letter-spacing: 0.2em; background-color: #F3F5F6; padding: 0 20px;">
        ADRESSE <!--Padding is optional-->
      </span>
      </div>
      <input v-model="street" type="text" class="input" placeholder="Straße und Hausnummer">
      <br>
      <input v-model="city" type="text" class="input" placeholder="Stadt">
      <br>
      <div style="width: 100%; height: 12px; border-bottom: 1px solid black; text-align: center; margin-top: 40px; margin-bottom: 40px">
          <span style="font-size: 20px; letter-spacing: 0.2em; background-color: #F3F5F6; padding: 0 20px;">
        PLANUNGSJAHR <!--Padding is optional-->
      </span>
      </div>
      <input v-model="curYear" type="number" class="input" placeholder="2019">
      <br>

      <h1 style="padding-top: 50px; font-family: 'Open Sans Condensed'; font-weight: normal; letter-spacing: 0.2em">DATENEINGABE</h1>
      <span>Für die Optimierung werden Daten bezüglich Ihrer bewirtschafteten Flächen benötigt. Dabei werden insbesondere die Schlagskizzen (Geodaten) sowie die Vorfrüchte der Felder für die Optimierungsrechnung verwendet. Wenn Ihr Betrieb den Flächenantrag in Nordrhein-Westfalen stellt, können die Flächendaten aus dem ELAN-Downloadportal durch eingabe der ZID-Nummer und Passwort automatisch eingefügt werden.
      <br>
      <strong>Datenschutzhinweis:</strong> Ihre Invekos-Daten (Betriebsnummer und Passwort) werden über eine gesicherte SSL-Verbindung zur Abfrage im ELAN-Downloadportal übertragen. Die Anmeldedaten werden lokal auf Ihrem Rechner gespeichert.</span>
      <div style="width: 100%; height: 12px; border-bottom: 1px solid black; text-align: center; margin-top: 40px; margin-bottom: 40px">
          <span style="font-size: 20px; letter-spacing: 0.2em; background-color: #F3F5F6; padding: 0 20px;">
        ZID-DATEN ABFRAGE <!--Padding is optional-->
      </span>
      </div>
      <input v-model="zidId" type="text" id='zid' class="input" name="zid" placeholder="ZID-Betriebsnummer">
      <br>
      <input v-model="zidPass" type="password" id='zid-pw' class="input" name="zid-pw" placeholder="Passwort">
      <br>
      <button type="button" id='zid-btn' class="invekosBtn" name="zid-btn">ABSENDEN</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      zidId: '',
      zidPass: '',
      curYear: 2019,
      street: '',
      city: '',
    }
  },
  async created() {
    try {
      // get settings from db (if available)
      const settings = await this.$db.get('settings')

      // allocate settings to reactive properties
      this.zidId = settings.zidId
      this.zidPass = settings.zidPass
      this.curYear = settings.curYear
      this.street = settings.street
      this.citty = settings.city
    } catch (e) {
      if (e.status === 404) {
        // if no settings found, construct settings object
        this.$db.put({
          _id: 'settings',
          zidId: '',
          zidPass: '',
          curYear: this.curYear,
          street: this.street,
          city: this.city
        })
      } else {
        console.log(e)
      }
    }
  }
}
</script>

<style scoped>
.input {
  margin-bottom: 5px;
  width: 233px;
  height: 33px;
  border-style: solid;
  border-width: 1px;
  border-color: grey;
  background-color: transparent;
  font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  letter-spacing: 0.1em;
  font-size: 18px;
  color: grey;
  padding-left: 5px;
  border-radius: 0 !important;
}
.invekosBtn {
  margin-top: 20px;
  width: 241px;
  height: 40px;
  border-style: solid;
  border-width: 2px;
  border-color: black;
  background-color: transparent;
  font-family: 'Open Sans Condensed', Helvetica, Arial, sans-serif;
  letter-spacing: 0.2em;
  font-size: 18px;
  color: black;
  padding: 5px;
  border-radius: 0px !important;
}
</style>
