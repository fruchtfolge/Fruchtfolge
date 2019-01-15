<template>
  <div>
    <div v-if="loading" class="blur loading">
      <div class="lds-spinner"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>
      <h2 style="text-align: center;top: 480px;position: relative;">Die Antragsdaten werden geladen ... <br> Der Vorgang kann einige Minuten in Anspruch nehmen</h2>
    </div>
    <div style="width: 50%; min-width: 500px; margin: auto; top: 120px;">
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
  </div>
</template>

<script>
import mapquest from '~/assets/js/mapquest'

export default {
  data() {
    return {
      loading: false,
      zidId: '',
      zidPass: '',
      curYear: 2019,
      street: '',
      city: '',
      postcode: ''
    }
  },
  notifications: {
    showAddressWarn: {
      title: 'ADRESSE UNVOLLSTÄNDIG',
      message: 'Bitte füllen Sie das Adressfeld komplett aus.',
      type: 'warn'
    },
    showZidErr: {
      title: 'INVEKOS FEHLER',
      message: 'Bitte stellen Sie sicher, dass Ihre 12-stellige Betriebsnummer vollständig ist, und Sie das korekkte Passwort eingegeben haben. ',
      type: 'warn'
    },
    noAddressErr: {
      title: 'ADRESSE UNGÜLTIG',
      message: 'Die angegebene Adresse konnte nicht gefunden werden.',
      type: 'error'
    },
    showAddressSucc: {
      title: 'ADRESSE GESPEICHERT',
      message: 'Die Hof-Adresse wurde in den Einstellungen gespeichert.',
      type: 'success'
    },
    showZidSucc: {
      title: 'DATEN IMPORTIERT',
      message: 'Die ELAN Antragsdaten wurden erfolgreich importiert.',
      type: 'success'
    },
    showError: {
      title: 'EIN FEHLER IST AUFGETRETEN',
      message: 'Unbekannter Fehler.',
      type: 'error'
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
      if (!this.street || !this.city) return this.showAddressWarn()
      try {
        const settings = await this.$db.get('settings')
        const address = await mapquest.forward(this.street, this.postcode, this.city)

        settings.street = this.street
        settings.city = this.city
        settings.postcode = this.postcode
        settings.home = address.home
        settings.state_district = address.state_district

        await this.$db.put(settings)
        this.showAddressSucc()
      } catch (e) {
        console.log(e)
        this.noAddressErr()
      }
    },
    async getElan() {
      try {
        const settings = await this.$db.get('settings')
        const stateCode = this.zidId.slice(0,3)
        if (this.zidId.length === 12 && stateCode === 276 && this.zidPass) {
          if (!settings.home || !settings.region) return this.showAddressWarn()
          // make request
        } else {
          this.showZidErr()
        }
      } catch (e) {
        console.log(e)
        this.showError({message: e})
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
}
</style>
