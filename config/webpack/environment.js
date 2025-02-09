const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    // Popper: 'popper.js/dist/popper',
    // 'window.jQuery': 'jquery'
  })
)

module.exports = environment
