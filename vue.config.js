// Simple Vue config without using defineConfig
module.exports = {
  // Simple configuration that should work with both webpack 4 and 5
  configureWebpack: {
    // Set mode explicitly
    mode: process.env.NODE_ENV === 'production' ? 'production' : 'development',
    
    // Explicitly resolve extensions
    resolve: {
      extensions: ['.js', '.vue', '.json']
    },
    
    // Avoid performance hints
    performance: {
      hints: false
    }
  },
  
  // Disable the problematic plugins
  chainWebpack: config => {
    // Remove the progress plugin that's causing validation errors
    config.plugins.delete('progress');
    
    // Also remove other potentially problematic plugins if needed
    // config.plugins.delete('friendly-errors');
  },
  
  // Configure the dev server with CORS
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
