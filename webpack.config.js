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

// helpers for writing path names
// e.g. join("web/static") => "/full/disk/path/to/hello/web/static"
function join(dest) { return path.resolve(__dirname, dest); }
function web(dest) { return join('web/static/' + dest); }

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
        loader: "style!css!less"
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
      output: {comments: false}
    })
  ]
};

if(TARGET === 'start') {
  module.exports = [
    // Application Style Entry Point
    merge(common, {
      entry: [
        "./web/static/css/app/app.scss",
        "./web/static/js/app/app.js"
      ],
      output: {
        path: "./priv/static",
        filename: "js/app.js"
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
}

if(TARGET === 'build') {
}
// var config = {
//   context: __dirname,
//   devtool: 'source-map',
//
//   // our application's entry points - for this example we'll use a single each for
//   // css and js
//
//   entry: {
//     app: [ web('css/app/app.scss'), web('js/app/app.js')],
//     admin: [web('css/admin/admin.scss'), web('js/admin/admin.js')],
//   },
//
//   // where webpack should output our files
//   output: {
//     path: join('priv/static'),
//     filename: 'js/[name].js',
//     chunkFilename: "js/[id].js"
//   },
//
//   resolve: {
//     extensions: ['', '.js', '.scss'],
//     modulesDirectories: [
//       "node_modules",
//       __dirname + "/web/static/js",
//       "semantic-ui-css/dist" ],
//     alias: {
//       'semantic-ui': path.join(__dirname, 'node_modules', 'semantic-ui-css', 'semantic.js')
//     }
//   },
//
//   module: {
//     loaders: [
//       {
//         test: /\.js$/,
//         exclude: /node_modules/,
//         // Do not use ES6 compiler in vendor code
//         ignore: [/web\/static\/vendor/],
//         loader: 'babel',
//         query: {
//           cacheDirectory: true,
//           // plugins: ['transform-decorators-legacy'],
//           presets: ['es2015'],
//         },
//       },
      // {
      //   test   : /\.css$/,
      //   loaders: [
      //     'style-loader',
      //     'css-loader',
      //     'resolve-url-loader'
      //   ]
      // },
      // {
      //   test   : /\.(scss|sass)$/,
      //   loaders: [
      //     'style-loader',
      //     'css-loader',
      //     'resolve-url-loader',
      //     'sass-loader?sourceMap'
      //   ]
      // },
//       // {
//       //   test: /\.(scss|sass)$/,
//       //   loader: ExtractTextPlugin.extract(
//       //     'style',
//       //     'css!sass?indentedSyntax&includePaths[]=' + __dirname +  '/node_modules'
//       //   ),
//
//       {
//         test: /\.(eot|ttf|woff|woff2)(\?\S*)?$/,
//         loader: "file-loader",
//         query: {
//           limit: 1000,
//           name: "fonts/[name].[ext]?[hash]"
//         }
//       },
//       {
//         test: /\.(png|jpe?g|gif|svg)(\?\S*)?$/,
//         loader: "file-loader",
//         query: {
//           limit: 1000,
//           name: "images/[name].[ext]?[hash]"
//         }
//       }
//     ],
//   },
//
//   // Tell the ExtractTextPlugin where the final CSS file should be generated
//   // (relative to config.output.path)
//   plugins: [
//     new ExtractTextPlugin("css/[name].css", { allChunks: true }),
//     new CopyWebpackPlugin([{ from: './web/static/assets' }]),
//     new webpack.ProvidePlugin(
//       { $: "jquery",
//         jQuery: "jquery",
//         u: "umbrellajs",
//         modernizr: "modernizr"
//       }
//     ),
//   ],
// };
//
// // Minify files with uglifyjs in production
// if (isProduction) {
//   config.plugins.push(
//     new webpack.optimize.DedupePlugin(),
//     new webpack.optimize.UglifyJsPlugin({
//       compress: {warnings: false},
//       output: {comments: false}
//     }),
//     new OptimizeCssAssetsPlugin()
//   );
// }
//
// module.exports = config;