import axios from 'axios'

export default {
  async distance(plot, home) {
    // mapquest uses lng/lat instead of lat/lng, so we have to reverse
    // the coordinates
    const start = [plot.center[1], plot.center[0]]
    const end = [home[1],home[0]]

    // request directions from mapqest
    const url = `https://open.mapquestapi.com/directions/v2/route?key=eoEN8KRKeFAMe9JR8UG53yw5Gh3XU9Ex&location&from=${start}&to=${end}&unit=k`
    const request = await axios.get(url)
    console.log(request)
    return request.distance
  },

  async forward(street, postcode, city) {
    const url = `https://open.mapquestapi.com/geocoding/v1/address?key=eoEN8KRKeFAMe9JR8UG53yw5Gh3XU9Ex&location=${street},${postcode} ${city}`
    const results = await axios.get(url)
    const coordinates = [results.data.results[0].locations[0].latLng.lng, results.data.results[0].locations[0].latLng.lat]

    return coordinates
  },

  async reverse(plot) {
    const url = `https://open.mapquestapi.com/geocoding/v1/reverse?key=eoEN8KRKeFAMe9JR8UG53yw5Gh3XU9Ex&location=${plot.center[1]},${plot.center[0]}`
    const request = await axios.get(url)
    const results = JSON.parse(request)[0]
    console.log(results)
    if (results.locations[0].adminArea6) {
      return results.locations[0].adminArea6
    } else if (results.locations[0].street){
      return results.locations[0].street
    } else {
      return results.locations[0].adminArea5
    }
  }

}
