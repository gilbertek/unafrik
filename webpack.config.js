'use strict';

var path = require('path');
var webpack = require('webpack');
var bourbon = require('bourbon').includePaths;
var neat = require('bourbon-neat').includePaths
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  devtool: 'source-map',

  entry: [
    "./web/static/css/app.sass",
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
    extensions: ['', '.js', '.json']
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
      {
        test: /\.scss$/,
        loader: "style!css!sass?includePaths[]=" + bourbon
      },

      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style", "css")
      },
    ]
  },

  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([{ from: "./web/static/assets" }])
  ]

};
