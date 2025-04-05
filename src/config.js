const config = {
  apiBaseUrl: process.env.VUE_APP_DIAGNOSIS_API_BASE_URL || 'http://127.0.0.1:5000',
  timeout: parseInt(process.env.VUE_APP_DIAGNOSIS_API_TIMEOUT || '8000'),
  // Add other configuration settings as needed
};

export default config;
