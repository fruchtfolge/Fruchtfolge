export default async function ({$axios,app,redirect,route}) {
  async function deleteAndRedirect(settings) {
    if (app.$db) {
      // get elements in db
      const result = await app.$db.info()
      if (result.doc_count > 0) {
        await app.$db.destroy()
      }
    }
    if (route.path !== '/') {
      return redirect('/')
    }
  }
  
  let settings
  try {
    settings = await app.$db.get('settings')
  } catch (e) {
    return await deleteAndRedirect()
  }
  try {
    // check if user auth tokens are available
    if (settings.auth) {
      $axios.setHeader('Authorization','Bearer ' + settings.auth.token + ':' + settings.auth.password)
      // get session
      const { data } = await $axios.get('http://localhost:3001/auth/session')
    } else {
      throw new Error('no auth')
    }
  } catch (e) {
    return await deleteAndRedirect(settings)
  }
}
