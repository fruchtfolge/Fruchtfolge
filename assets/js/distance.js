const Directions = require('@mapquest/directions')
const directions = new Directions({key:'eoEN8KRKeFAMe9JR8UG53yw5Gh3XU9Ex'})

module.exports = async function distance(plot, home) {
  // calculate centroid of plot as a starting point for the route
  // mapquest uses lng/lat instead of lat/lng, so we have to reverse
  // the coordinates
  const start = turf.centerOfMass(plot.geometry).geometry.coordinates.reverse()
  const end = [home[1],home[0]]

  // request directions from mapqest
  const route = await directions.route({
    locations: [start, end],
    maxRoutes: 1,
    timeOverage: 99
  })

  return route.route.distance
}
