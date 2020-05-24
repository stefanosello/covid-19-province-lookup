module.exports = {
  test: /\.scss$/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      options: {
        prependData: `@import "src/stylesheets/application.scss";`
      }
    }
  ]
}