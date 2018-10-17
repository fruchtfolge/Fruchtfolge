<template>
  <div style="width: 50vw; position: absolute; top: 120px; left: 15%; margin-left: -25vw">
      <h1 style="font-family: 'Open Sans Condensed'; font-weight: normal; letter-spacing: 0.2em">DATENEINGABE</h1>
      <span>Für die Optimierung werden Daten bezüglich Ihrer bewirtschafteten Flächen benötigt. Dabei werden insbesondere die Schlagskizzen (Geodaten) sowie die Vorfrüchte der Felder für die Optimierungsrechnung verwendet. Die Flächendaten können aus dem ELAN-Downloadportal durch eingabe der ZID-Nummer und Passwort bzw. durch einen Dateiupload hochgeladen werden.
      <br>
      <strong>Datenschutzhinweis:</strong> Ihre Invekos-Daten (Betriebsnummer und Passwort) werden über eine gesicherte SSL-Verbindung zur Abfrage im ELAN-Downloadportal übertragen. Die Anmeldedaten werden nicht gespeichert.</span>
      <div style="width: 100%; height: 12px; border-bottom: 1px solid black; text-align: center; margin-top: 40px; margin-bottom: 40px">
          <span style="font-size: 20px; letter-spacing: 0.2em; background-color: #F3F5F6; padding: 0 20px;">
        ZID-DATEN ABFRAGE <!--Padding is optional-->
      </span>
      </div>
      <input type="text" id='zid' class="input" name="zid" placeholder="ZID-Betriebsnummer">
      <br>
      <input type="password" id='zid-pw' class="input" name="zid-pw" placeholder="Passwort">
      <br>
      <button type="button" id='zid-btn' class="invekosBtn" name="zid-btn">ABSENDEN</button>
      <div style="width: 100%; height: 12px; border-bottom: 1px solid black; text-align: center; margin-top: 40px; margin-bottom: 40px">
          <span style="font-size: 20px; letter-spacing: 0.2em; background-color: #F3F5F6; padding: 0 20px;">
        ODER ELAN-DATEI UPLOAD
      </span>
      </div>
      <span>XML-Datei</span>
      <input type="file" accept=".xml" id='xml' name="xml">
      <br>
      <span>GML-Datei</span>
      <input type="file" accept=".gml" id='gml' name="gml">
  </div>
</template>

<script>
export default {

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
