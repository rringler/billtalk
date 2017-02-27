// Note: You must restart bin/webpack-watcher for changes to take effect

var path = require('path')
var glob = require('glob')
var extname = require('path-complete-extname')

var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  entry: glob.sync(path.join('..', 'app', 'javascript', 'packs', '*.js*')).reduce(
    function(map, entry) {
      var basename = path.basename(entry, extname(entry))
      map[basename] = entry
      return map
    }, {}
  ),

  output: {
    filename: '[name].js',
    path: path.resolve('..', 'public', 'packs')
  },

  module: {
    rules: [
      {
        test: /\.coffee(.erb)?$/,
        loader: 'coffee-loader'
      },
      {
        test: /\.jsx?(.erb)?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: [
            'react',
            ['latest', { 'es2015': { 'modules': false } }],
            'stage-1'
          ]
        }
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          loader: 'css-loader!sass-loader',
        }),
      },
      {
        test: /\.(jpg|jpeg|png|eot|svg|ttf|woff|woff2)$/,
        loader: 'url-loader',
        query: {
          limit: 10000,
        },
      },
      {
        test: /.erb$/,
        enforce: 'pre',
        exclude: /node_modules/,
        loader: 'rails-erb-loader',
        options: {
          runner: 'DISABLE_SPRING=1 ../bin/rails runner'
        }
      },
    ]
  },

  plugins: [
    new ExtractTextPlugin('styles.css')
  ],

  resolve: {
    extensions: [ '.js', '.jsx', '.coffee' ],
    modules: [
      path.resolve('../app/javascript'),
      path.resolve('../vendor/node_modules')
    ]
  },

  resolveLoader: {
    modules: [ path.resolve('../vendor/node_modules') ]
  }
}
