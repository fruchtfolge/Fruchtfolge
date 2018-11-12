module.exports = function query(req, res) {
  return new Promise ((resolve, reject) => {
    let body = ''

    req.on('data', (data) => {
      body += data

      if (body.length > 1e6)
        req.connection.destroy()
    })

    req.on('end', () => {
      try {
        const post = JSON.parse(body)
        resolve(post)
      } catch (e) {
        reject(e)
      }

    })

    req.on('error', err => {
      reject(err)
    })
  })
}
