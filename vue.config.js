const { defineConfig } = require('@vue/cli-service')
const webpack = require('webpack')

module.exports = defineConfig({
  transpileDependencies: true,
  configureWebpack: {
    plugins: [
      new webpack.DefinePlugin({
        '__VUE_PROD_HYDRATION_MISMATCH_DETAILS__': JSON.stringify(true),
      })
    ],
    watchOptions: {
      ignored: [
        '**/node_modules/**',
        'C:/pagefile.sys',
        'C:/DumpStack.log.tmp',
        'C:/swapfile.sys'
      ]
    }
  }
})
