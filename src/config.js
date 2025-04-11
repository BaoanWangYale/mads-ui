const config = {
  apiBaseUrl: process.env.VUE_APP_DIAGNOSIS_API_BASE_URL || 'http://127.0.0.1:5000',
  timeout: parseInt(process.env.VUE_APP_DIAGNOSIS_API_TIMEOUT || '8000'),
  defaultCaseDescription: process.env.VUE_APP_DEFAULT_CASE_DESCRIPTION || "Enter the patient's case information in detail here..."
  // Add other configuration settings as needed
};

export default config;
