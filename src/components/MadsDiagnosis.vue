<template>
  <div class="diagnosis-container">
    <h2 class="text-xl mb-3">{{ msg || 'Medical Diagnosis Assistant' }}</h2>
    
    <div class="form-container">
      <div class="field">
        <label for="case-input" class="font-bold mb-2 block">Patient Case Information</label>
        
        <!-- Only use standard HTML textarea -->
        <textarea
          id="case-input" 
          v-model="diagnosisText" 
          rows="6" 
          cols="80"
          style="width: 100%; min-height: 200px; display: block; border: 1px solid #ced4da; padding: 8px;"
        ></textarea>
        
        <small class="text-secondary">Please provide as much detail as possible for an accurate diagnosis</small>
      </div>
      
      <div class="field mt-3">
        <!-- Only use standard HTML button -->
        <button 
          @click="submitDiagnosis" 
          style="background-color: #3B82F6; color: white; border: none; border-radius: 4px; padding: 8px 16px; cursor: pointer;"
        >
          Get Diagnosis
        </button>
      </div>
    </div>
    
    <hr style="margin: 24px 0; border: 0; border-top: 1px solid #e9ecef;" />
    
    <div class="diagnosis-results mt-4">
      <h3 class="text-lg font-semibold mb-3">Diagnosis Results</h3>
      
      <div v-if="loading" style="text-align: center; padding: 16px; color: #3B82F6;">Loading...</div>
      
      <div v-else>
        <div v-if="diagnosisOutput" v-html="diagnosisOutput" style="background-color: #f8f9fa; border-radius: 6px; border-left: 4px solid #3B82F6; min-height: 100px; max-height: 500px; overflow-y: auto; padding: 12px;"></div>
        <div v-else style="background-color: #EFF6FF; border-left: 4px solid #BFDBFE; color: #3B82F6; padding: 16px; border-radius: 4px;">Submit patient information to get a diagnosis</div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import config from '../config';

async function get_diagnosis_response(case_text) {
  console.log('axios instance created:', case_text);
  
  try {
    const response = await axios.post(config.apiBaseUrl + '/mads/diagnosis', {
      case: case_text,
    });
    console.log('Response from server:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error occurred while fetching diagnosis:', error);
    throw error; // Rethrow or handle the error as needed
  }
}

function formatResponse(response) {
  if (!response || !response.diagnosisResponse || !response.diagnosisResponse.finalDiagnosis) {
    return "<div style='color: #ef4444;'>Error occurred in diagnosis</div>";
  } else {
    const diagnosisResponse = response.diagnosisResponse;
    let formatted_response = '<div style="margin-bottom: 16px;"><h4 style="font-size: 16px; font-weight: 700; margin-bottom: 8px;">Initial Analysis:</h4>';
    const initialDiagnosises = diagnosisResponse.initialDiagnosises;
    
    for (const initialDiagnosis of initialDiagnosises) {
      let splitedDiagnosis = initialDiagnosis.split('</analysis> \n');
      if (splitedDiagnosis.length > 1) {
        let analysis = splitedDiagnosis[0].substring(10);
        let diagnosis = splitedDiagnosis[1].substring(11);
        diagnosis = diagnosis.replace('</diagnosis>', '');
        
        formatted_response += `<div style="padding: 8px; margin-bottom: 8px; border-bottom: 1px solid #e5e7eb;">
          <div style="font-style: italic;">${analysis}</div>
          <div style="margin-top: 4px;">${diagnosis}</div>
        </div>`;
      }else{
        formatted_response='';
      }
    }
    
    formatted_response += '</div>';
    formatted_response += `<div style="margin-top: 16px;">
      <h4 style="font-size: 16px; font-weight: 700; margin-bottom: 8px;">Final Diagnosis:</h4>
      <div style="padding: 12px; background-color: #f0f7ff; border-radius: 6px;">${diagnosisResponse.finalDiagnosis}</div>
    </div>`;
    
    console.log('formatted_response:', formatted_response);
    return formatted_response;
  }
}

export default {
  name: 'MadsDiagnosis',
  props: {
    msg: String
  },
  data() {
    return {
      diagnosisText: config.defaultCaseDescription || '',
      diagnosisOutput: '',
      loading: false,
      config: config
    };
  },
  methods: {
    async submitDiagnosis() {
      if (!this.diagnosisText.trim()) {
        return;
      }
      
      this.loading = true;
      this.diagnosisOutput = '';
      
      try {
        const response = await get_diagnosis_response(this.diagnosisText);
        this.diagnosisOutput = formatResponse(response);
      } catch (error) {
        this.diagnosisOutput = `<div style="color: #ef4444;">Error: ${error.message || 'Failed to get diagnosis'}</div>`;
      } finally {
        this.loading = false;
      }
    }
  }
}
</script>

<style scoped>
.diagnosis-container {
  padding: 1rem 0;
}

.form-container {
  margin-bottom: 1.5rem;
}

.field {
  margin-bottom: 1rem;
}

.text-lg {
  font-size: 1.125rem;
}

.font-semibold {
  font-weight: 600;
}

.mt-3 {
  margin-top: 0.75rem;
}

.mt-4 {
  margin-top: 1rem;
}

.mb-3 {
  margin-bottom: 0.75rem;
}

.text-secondary {
  color: #6c757d;
  font-size: 0.875rem;
}
</style>
