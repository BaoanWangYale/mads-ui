import { createApp } from 'vue'
import App from './App.vue'

// Import PrimeVue core
import PrimeVue from 'primevue/config'

// Import CSS resources - order matters
import 'primevue/resources/primevue.min.css'     // Core PrimeVue CSS
import 'primevue/resources/themes/lara-light-blue/theme.css' // Theme
import 'primeicons/primeicons.css'              // Icons
import '/node_modules/primeflex/primeflex.css'  // PrimeFlex utility CSS
import './assets/custom-styles.css'             // Custom styles (last to override)

// Components are imported directly in the component files where they're used
const app = createApp(App)
app.use(PrimeVue)

// Don't register components globally anymore - import them in each component file

app.mount('#app')
