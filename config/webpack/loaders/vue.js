const ExtractTextPlugin = require("extract-text-webpack-plugin")

module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
    options: { ExtractTextPlugin }
  }]
}
