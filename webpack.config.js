'use strict';

var path = require('path');
var webpack = require('webpack');
var merge = require("webpack-merge");
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');

var env = process.env.MIX_ENV || 'dev';
var isProduction = (env === 'prod')
var TARGET = process.env.npm_lifecycle_event;

var common = {
  context: __dirname,
  devtool: "source-map",

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/, /semantic/, /uploads/],
        loader: "babel-loader",
        options: {
          presets: ["es2015"]
        }
      },
      {
        test: /\.hbs$/,
        loader: "handlebars-loader"
      },
      {
        test: /\.less$/,
        loader: "less-loader"
      },
      {
        test: [/\.sass$/, /\.css$/, /\.scss$/],
        loader: ExtractTextPlugin.extract(
          {
            fallbackLoader: "style-loader",
            loader: "css-loader!sass-loader"
          }
        )
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: "file-loader?name=/images/[name].[ext]"
      },
      {
        test: /\.(eot|ttf|woff|woff2)(\?\S*)?$/,
        loader: "file-loader",
        query: {
          limit: 1000,
          name: "fonts/[name].[ext]?[hash]"
        }
      },
    ]
  },

  plugins: [
    new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false},
      output: {comments: false},
      sourceMap: true
    }),
    new webpack.LoaderOptionsPlugin({
      minimize: true
    })
  ]
};

module.exports = [
  // Application Style Entry Point
  merge(common, {
    entry: {
      app: ["./web/static/css/app/app.scss",
            "./web/static/js/app/app.js"]
    },
    output: {
      path: "./priv/static",
      filename: "js/[name].[chunkhash].js"
    },
    resolve: {
      modules: [
        "node_modules",
        __dirname + "/web/static/app"
      ]
    },
    plugins: [
      new CopyWebpackPlugin([{ from: "./web/static/assets"}]),
      new ExtractTextPlugin("css/app.css")
    ]
  }),

  // Admin Style Entry Point
  merge(common, {
    entry: {
      admin: ["./web/static/css/admin/admin.scss",
              "./web/static/js/admin/admin.js"]
    },
    output: {
      path: "./priv/static",
      filename: "js/[name].[chunkhash].js"
    },
    resolve: {
      modules: [
        "node_modules",
        __dirname + "/web/static/app"
      ]
    },
    plugins: [
      new CopyWebpackPlugin([{ from: "./web/static/assets"}]),
      new ExtractTextPlugin("css/admin.css")
    ]
  }),

  // Admin Style with semantic-ui-css Entry Point
  merge(common, {
    entry: {
      semantic: [
        // "./web/static/css/admin-semantic/calendar.css",
        // "./web/static/js/admin-semantic/calendar.js",
        "./web/static/css/admin-semantic/admin_semantic.scss",
        "./web/static/js/admin-semantic/admin_semantic.js"]
    },
    output: {
      path: "./priv/static",
      filename: "js/[name].[chunkhash].js"
    },
    resolve: {
      alias: {
        'jquery': path.join(
                                  __dirname,
                                  'node_modules',
                                  'jQuery',
                                  'dist',
                                  'jquery.js'),
        'semantic-ui': path.join(
                                  __dirname,
                                  'node_modules',
                                  'semantic-ui-css',
                                  'semantic.js'),
        'semantic-ui-calendar': path.join(
                                            __dirname,
                                            'node_modules',
                                            'semantic-ui-calendar',
                                            'dist',
                                            'calendar.js')
      }
    },
    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"}),
      new ExtractTextPlugin("css/admin_semantic.css")
    ]
  }),

  // Admin Style with materialize css Entry Point
  merge(common, {
    entry: {
      materialize: [
        "./web/static/css/admin-materialize/admin_materialize.scss",
        "./web/static/js/admin-materialize/admin_materialize.js"]
    },

    output: {
      path: "./priv/static",
      filename: "js/[name].[chunkhash].js"
    },

    resolve: {
      modules: [
        "node_modules",
        path.resolve(__dirname + "/web/static/js")
      ],

      alias: {
        'materialize': path.join(
                                  __dirname,
                                  'node_modules',
                                  'materialize-css',
                                  'sass',
                                  'materialize.scss'),
      }
    },

    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"}),
      new ExtractTextPlugin("css/admin_semantic.css")
    ]
  }),

  // Emails Style Entry Point
  merge(common, {
    entry: "./web/static/css/email/email.scss",
    output: {
      path: "./priv/static",
      filename: "css/email.css"
    },
    resolve: {
      modules: [
        "node_modules",
        __dirname + "/web/static/app"
      ]
    },
    plugins: [
      new ExtractTextPlugin("css/email.css")
    ]
  })
];
