const {environment} = require('@rails/webpacker');
const {join} = require('path');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const SvgStore = require('webpack-svgstore-plugin');

environment.config.merge({
  module: {
    rules: [
      {
        test: /\.styl$/i,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            'css-loader',
            'stylus-loader'
          ]
        })
      },
      {
        test: /\.(js|jsx)?(\.erb)?$/,
        exclude: [],
        include: [
          join(__dirname, '../../app/'),
          /node_modules\/gsap/,
          /node_modules\/image-comparison/,
          /node_modules\/query-string/,
          /node_modules\/strict-uri-encode/
        ],
        use: [
          {
            loader: 'babel-loader'
          }
        ]
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            stylus: ExtractTextPlugin.extract({
              fallback: 'vue-style-loader',
              use: [
                'css-loader',
                {
                  loader: 'stylus-loader',
                  options: {
                    import: [join(__dirname, '../../app/frontend/styles/global.styl')]
                  }
                }
              ]
            })
          }
        }
      },
      {
        test: /\.pug$/,
        loader: 'pug'
      }
    ],
  },
  plugins: [
    new SvgStore({
      svgoOptions: {
        plugins: [
          {
            removeTitle: true,
            removeViewBox: true,
            sortAttrs: true,
            addClassesToSVGElement: true,
            addAttributesToSVGElement: true,
            removeStyleElement: true,
            convertStyleToAttrs: true
          }
        ]
      },
      prefix: 'icon-'
    })
  ],
  resolve: {
    alias: {
      vue: 'vue/dist/vue.common.js'
    }
  }
});

module.exports = environment;
