'use strict';

var path = require('path');
var webpack = require('webpack');
var bourbon = require('bourbon').includePaths;
var neat = require('bourbon-neat').includePaths;
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

var env = process.env.MIX_ENV || 'dev';
var isProduction = (env === 'prod');

var plugins = [
  new ExtractTextPlugin(
    'css/app.css', { allChunks: true }
  ),
  new CopyWebpackPlugin([{ from: './web/static/assets' }])
];

if (isProduction) {
  plugins.push(
    new webpack.optimize.UglifyJsPlugin(
      {minimize: true}
    )
  );
}

module.exports = {
  devtool: 'source-map',

  entry: [
    "./web/static/css/app.scss",
    "./web/static/js/app.js"
  ],

  output: {
    path: "./priv/static",
    filename: "js/app.js"
  },

  resolve: {
    modulesDirectories: [
      "node_modules", __dirname + "/web/static/js"
    ],

    extensions: ['', '.js', '.json', '.scss', '.sass'],
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel",
        query: {
          presets: ["es2015"]
        }
      },
      //
      // {
      //   test: /\.scss$/,
      //   loaders: ["style", "css", "sass"]
      // },

      // {
      //   test: /\.scss$/,
      //   loaders: ["style", "css?sourceMap", "sass?sourceMap&includePaths[]=" + bourbon + neat[0] + '&includePaths[]=' + neat[1]]
      // },
      // {
      //   test: /\.scss$/,
      //   loader: "style!css!sass?includePaths[]=" + bourbon
      // },

      {
       	test: /\.(sass|scss)$/,
      	loader: ExtractTextPlugin.extract('css?sourceMap!sass?sourceMap!import-glob')

      },
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style", "css")
      },

      // File loader.
      // Extracts the specified fonts and images into sepearate files and inserts the correct URL into the generated CSS.
      // For example url("../img/gfxSprite.png") in CSS becomes url(app/img/gfxSprite.da300248bf0a78b746782acb579f2e07.png)
      {
        test: /\.(jpg|png|gif|eot|woff2?|ttf|svg)$/,
        loader: 'file?name=[path][name].[hash].[ext]'
      },
    ]
  },

	sassLoader: {
    includePaths: [bourbon, neat]
	},

  plugins: plugins
};
