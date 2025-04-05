// Simple Vue config without using defineConfig
module.exports = {
  transpileDependencies: [],
  
  // Add development server options for CORS
  devServer: {
    host: 'localhost',
    port: 8081,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With, content-type, Authorization'
    }
  }
}
