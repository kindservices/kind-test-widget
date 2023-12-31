import './app.css'
import KindTestApp from './KindTestApp.svelte'
/**
 * see: https://blog.logrocket.com/build-web-components-svelte/
 * "The final step is to import our custom components in the Svelte main.js file so that they are generated at build time"
 * 
 * so ... 
 */

import KindTest from './lib/KindTest.svelte'

const kindTestApp = new KindTestApp({
  target: document.getElementById('webcomponent-app'),
})

export default kindTestApp
