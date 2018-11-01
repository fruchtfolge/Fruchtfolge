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
      <input v-model="postcode" type="text" class="input" placeholder="PLZ">
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
import mapquest from '~/assets/js/mapquest'

export default {
  data() {
    return {
      zidId: '',
      zidPass: '',
      curYear: 2019,
      street: '',
      city: '',
      postcode: ''
    }
  },
  watch: {
    street() {
      if (this.street !== this.settings.street) this.debouncedGetHome()
    },
    postcode() {
      if (this.postcode !== this.settings.postcode) this.debouncedGetHome()
    },
    city() {
      if (this.city !== this.settings.city) this.debouncedGetHome()
    }
  },
  async created() {
    // we don't want to call MapQuest for geocoding the new address
    // while the user is still typing -> debouncing request
    this.debouncedGetHome = _.debounce(this.getHome, 500)

    try {
      // get settings from db (if available)
      this.settings = await this.$db.get('settings')

      // allocate settings to reactive properties
      this.zidId = this.settings.zidId
      this.zidPass = this.settings.zidPass
      this.curYear = this.settings.curYear
      this.street = this.settings.street
      this.postcode = this.settings.postcode
      this.city = this.settings.city
    } catch (e) {
      console.log(e)
    }
  },
  methods: {
    // get settings object, forward gecode the farm address
    // and store coordinates in settings.home
    async getHome() {
      if (!this.street || !this.city) return console.log('Bitte vollständige Adresse angeben!')
      try {
        const settings = await this.$db.get('settings')
        const address = await mapquest.forward(this.street, this.postcode, this.city)
        console.log(address)

        settings.street = this.street
        settings.city = this.city
        settings.postcode = this.postcode
        settings.home = address.home
        settings.state_district = address.state_district

        await this.$db.put(settings)
      } catch (e) {
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
