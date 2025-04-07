import { createApp } from 'vue'
import App from './App.vue'

// Import PrimeVue core
import PrimeVue from 'primevue/config'

// Components are imported directly in the component files where they're used
const app = createApp(App)
app.use(PrimeVue)

// Don't register components globally anymore - import them in each component file

app.mount('#app')
