<template>
  <div class="app-container">
    <!-- Simple Card Container -->
    <div class="card">
      <div class="card-header">
        <div class="header-content">
          <img alt="YSM logo" src="./assets/logo.png" height="60">
          <h1 class="header-title">MADS Diagnosis System</h1>
        </div>
      </div>
      <div class="card-body">
        <MadsDiagnosis />
      </div>
    </div>
    
    <div class="footer">
      © 2025 Yale School of Medicine
    </div>
  </div>
</template>

<script>
import MadsDiagnosis from './components/MadsDiagnosis.vue'

export default {
  name: 'App',
  components: {
    MadsDiagnosis
  }
}
</script>

<style>
body {
  margin: 0;
  background-color: #f8f9fa;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}

.app-container {
  max-width: 1200px;
  margin: 2rem auto;
  padding: 0 1rem;
}

.card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
  margin-bottom: 2rem;
  overflow: hidden;
}

.card-header {
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #e9ecef;
}

.header-content {
  display: flex;
  align-items: center;
}

.header-title {
  margin-left: 1rem;
  color: #3B82F6;
  font-size: 1.5rem;
}

.card-body {
  padding: 1.5rem;
}

.footer {
  color: #6c757d;
  text-align: center;
  font-size: 0.75rem;
  padding: 0.75rem;
  margin-top: 2rem;
}
</style>
