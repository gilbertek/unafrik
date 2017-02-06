'use strict';

var path = require('path');
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');

var env = process.env.MIX_ENV || 'dev';
var isProduction = (env === 'prod')

// helpers for writing path names
// e.g. join("web/static") => "/full/disk/path/to/hello/web/static"
function join(dest) { return path.resolve(__dirname, dest); }

function web(dest) { return join('web/static/' + dest); }

var config = {
  context: __dirname,
  devtool: 'source-map',

  // our application's entry points - for this example we'll use a single each for
  // css and js
  entry: {
    app: [ web('css/app/app.scss'), web('js/app/app.js')],
    admin: [web('css/admin/admin.scss'), web('js/admin/admin.js')],
  },

  // where webpack should output our files
  output: {
    path: join('priv/static'),
    filename: 'js/[name].js',
    chunkFilename: "js/[id].js"
  },

  resolve: {
    extensions: ['', '.js', '.scss'],
    modulesDirectories: [ "node_modules", __dirname + "/web/static/js" ],
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        // Do not use ES6 compiler in vendor code
        ignore: [/web\/static\/vendor/],
        loader: 'babel',
        query: {
          cacheDirectory: true,
          // plugins: ['transform-decorators-legacy'],
          presets: ['es2015'],
        },
      },
      {
        test   : /\.css$/,
        loaders: [
          'style-loader',
          'css-loader',
          'resolve-url-loader'
        ]
      },
      {
        test   : /\.(scss|sass)$/,
        loaders: [
          'style-loader',
          'css-loader',
          'resolve-url-loader',
          'sass-loader?sourceMap'
        ]
      },
      // {
      //   test: /\.(scss|sass)$/,
      //   loader: ExtractTextPlugin.extract(
      //     'style',
      //     'css!sass?indentedSyntax&includePaths[]=' + __dirname +  '/node_modules'
      //   ),
      {
        test: /\.hbs$/,
        loader: "handlebars-loader"
      },
      {
        test: /\.(eot|ttf|woff|woff2)(\?\S*)?$/,
        loader: "file-loader",
        query: {
          limit: 1000,
          name: "fonts/[name].[ext]?[hash]"
        }
      },
      {
        test: /\.(png|jpe?g|gif|svg)(\?\S*)?$/,
        loader: "file-loader",
        query: {
          limit: 1000,
          name: "images/[name].[ext]?[hash]"
        }
      }
    ],
  },

  // Tell the ExtractTextPlugin where the final CSS file should be generated
  // (relative to config.output.path)
  plugins: [
    new ExtractTextPlugin("css/[name].css", { allChunks: true }),
    new CopyWebpackPlugin([{ from: './web/static/assets' }]),
    new webpack.ProvidePlugin(
      { $: "jquery",
        jQuery: "jquery",
        u: "umbrellajs",
        modernizr: "modernizr"
      }
    ),
  ],
};

// Minify files with uglifyjs in production
if (isProduction) {
  config.plugins.push(
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false},
      output: {comments: false}
    }),
    new OptimizeCssAssetsPlugin()
  );
}

module.exports = config;
