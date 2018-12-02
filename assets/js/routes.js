module.exports = [{
  path: '/',
  name: 'HOME',
  icon: 'static/home.png'
},
{
  path: '/settings',
  name: 'EINSTELLUNGEN',
  icon: 'static/settings.png'
},
{
  path: '/maps',
  name: 'SCHLÄGE',
  file: 'maps',
  icon: 'static/plots.png',
},
{
  subPage: true,
  path: '/maps',
  name: 'Karte',
  file: 'maps',
  icon: 'static/plots.png',
},
{
  subPage: true,
  path: '/plotsTable',
  name: 'Übersicht',
  file: 'plotsTable',
  icon: 'static/plots.png'
},
{
  path: '/crops',
  name: 'KULTUREN',
  icon: 'static/crops.png'
},
{
  subPage: true,
  path: '/crops',
  name: 'Deckungsbeiträge',
  icon: 'static/crops.png'
},
{
  subPage: true,
  path: '/timeseries',
  name: 'Marktentwicklung',
  icon: 'static/crops.png'
},
{
  subPage: true,
  path: '/crops_settings',
  name: 'Eigenschaften',
  icon: 'static/crops.png'
},
{
  path: '/constraints',
  name: 'NEBENBEDINGUNGEN',
  icon: 'static/constraints.png'
},
{
  subPage: true,
  path: '/constraints',
  name: 'Anbaurestriktionen',
  icon: 'static/constraints.png'
},
{
  subPage: true,
  path: '/labour',
  name: 'Arbeitszeiten',
  icon: 'static/constraints.png'
},
{
  path: '/results',
  name: 'ERGEBNISSE',
  icon: 'static/results.png'
}]
