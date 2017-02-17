'use strict';

var path = require('path');
var webpack = require('webpack');
var merge = require("webpack-merge");
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');

var common = {
  context: __dirname,
  devtool: "source-map",
  target: 'async-node',

  module: {
    rules: [{
        test: /\.js$/,
        exclude: [/node_modules/, /semantic/, /uploads/],
        use: [{
          loader: "babel-loader",
          options: { presets: ["es2015"] }
        }],
      },
      {
        test: /\.hbs$/,
        use: [{ loader: "handlebars-loader"}]
      },
      {
        test: /\.less$/,
        use: [{loader: "less-loader"}]
      },
      // {
      //   test: /\.css$/,
      //   use: [
      //     'style-loader',
      //     {
      //       loader: 'css-loader',
      //       options: { modules: true }
      //     },
      //   ]
      // },
      {
        test: [/\.sass$/, /\.css$/, /\.scss$/],
        loader: ExtractTextPlugin.extract(
          {
            fallback: "style-loader",
            loader: "css-loader!sass-loader"
          }
        )
      },
      // {
      //   test: /\.(sass|scss)$/,
      //   use: [
      //     'style-loader',
      //     'css-loader',
      //     'sass-loader',
      //   ]
      // },
      {
        test: /\.(png|jpg|gif|svg)$/,
        use: [
          { loader: "file-loader",
            query: {
              name: "images/[name].[ext]",
              limit: 1000,
            }
          }
        ]
      },
      {
        test: /\.(eot|ttf|woff|woff2)(\?\S*)?$/,
        loader: "file-loader",
        query: {
          limit: 1000,
          filename: 'fonts/[name].[chunkhash].[ext]'
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
    }),

    new webpack.DefinePlugin({
      "process.env": {
          NODE_ENV: JSON.stringify("production")
      }
    }),
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
      filename: "js/[name].js"
    },
    resolve: {
      modules: ["node_modules", __dirname + "/web/static/app"],
      moduleExtensions: ['.js', '.jsx'],
      alias: {
        "jquery": path.resolve(__dirname, "node_modules/jquery/dist/jquery.js"),
        'jQuery': path.join(__dirname, 'node_modules', 'jquery','dist', 'jquery.js'),
        "normalize": path.resolve(__dirname, "node_modules/normalize.css/normalize.css"),
      }
    },
    plugins: [
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery"
      }),
      new CopyWebpackPlugin([{from: "./web/static/assets"}]),
      new ExtractTextPlugin({filename: "css/[name].css", allChunks: true,})
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
    resolve: { modules: ["node_modules", __dirname + "/web/static/app" ]},
    plugins: [
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery"
      }),
      new CopyWebpackPlugin([{ from: "./web/static/assets"}]),
      new ExtractTextPlugin({filename: "css/[name].css", allChunks: true})
    ]
  }),

  // Admin Style with semantic-ui-css Entry Point
  merge(common, {
    entry: {
      semantic: [
        "./web/static/css/admin-semantic/admin_semantic.scss",
        "./web/static/js/admin-semantic/admin_semantic.js"]
    },
    output: {
      path: "./priv/static",
      filename: "js/[name].[chunkhash].js"
    },
    resolve: {
      alias: {
        "jquery": path.resolve(__dirname, "node_modules/jquery/dist/jquery.js"),
        "modernizr": path.resolve(__dirname, "node_modules/modernizr/src/Modernizr.js"),
        'semantic-ui': path.resolve(__dirname,
                                  'node_modules/semantic-ui-css/semantic.js'),
        'semantic-ui-calendar': path.resolve(
                          __dirname,
                          'node_modules/semantic-ui-calendar/dist/calendar.js')
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
      modules: ["node_modules", path.resolve(__dirname + "/web/static/js")],
      alias: {
        "jquery": path.resolve(__dirname, "node_modules/jquery/dist/jquery.js"),
        "modernizr": path.resolve(__dirname, "node_modules/modernizr/src/Modernizr.js"),
        'materialize': path.join(__dirname, 'node_modules',
                                  'materialize-css', 'sass', 'materialize.scss'),
      }
    },

    plugins: [
      new webpack.ProvidePlugin({ $: "jquery", jQuery: "jquery" }),
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
      modules: ["node_modules", __dirname + "/web/static/app"]
    },
    plugins: [new ExtractTextPlugin({ filename: "css/email.css" })]
  })
];
