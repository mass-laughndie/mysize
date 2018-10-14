const CleanWebpackPlugin = require('clean-webpack-plugin');
const WebpackSprocketsRailsManifestPlugin = require('webpack-sprockets-rails-manifest-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const webpack = require('webpack');
const path = require('path');

const isProduction = process.env.NODE_ENV === 'production';

const FILENAME = isProduction ? '[name]-[chunkhash]' : '[name]';

module.exports = {
  entry: {
    'frontend/global': './src/javascripts/global.ts',
    'frontend/test': './src/javascripts/test',
    'frontend/latest': './src/javascripts/latest',
    'frontend/follow': './src/javascripts/follow',
    'frontend/follow_square': './src/javascripts/follow_square',
    'frontend/mypage_square': './src/javascripts/mypage'
  },

  output: {
    path: path.resolve(__dirname, '../public/assets'),
    filename: `${FILENAME}.js`,
    chunkFilename: `${FILENAME}.js`
  },

  devtool: isProduction ? undefined : 'inline-source-map',

  resolve: {
    extensions: ['.ts', '.tsx', '.js', 'json', '.css', '.scss']
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: { loader: require.resolve('babel-loader') }
      },
      {
        test: /\.(ts|tsx)$/,
        exclude: /node_modules/,
        use: { loader: require.resolve('ts-loader') }
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: require.resolve('css-loader'),
              options: {
                localIdentName: isProduction ? '[hash:base64:5]' : '[local]',
                modules: true
              }
            },
            'sass-loader'
          ]
        })
      },
      {
        test: /\.module\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: require.resolve('css-loader'),
              options: {
                localIdentName: isProduction ? '[hash:base64:5]' : '[local]',
                modules: true,
                sourceMap: true,
                minimize: isProduction,
                importLoaders: 2
              }
            },
            'sass-loader'
          ]
        })
      },
      {
        test: /\.(jpeg|jpg|gif|png|svg|eot|woff|woff2|ttf|wav|mp3)$/,
        use: {
          loader: require.resolve('file-loader'),
          options: {
            name: '[path][name]-[hash].[ext]',
            outputPath: 'frontend/images/',
            publicPath: '/assets/frontend/images/'
          }
        }
      }
    ]
  },

  plugins: [
    new CleanWebpackPlugin(['frontend'], {
      root: path.resolve(__dirname, `../public/assets`),
      verbose: true
    }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
    new webpack.EnvironmentPlugin({
      NODE_ENV: isProduction ? 'production' : 'development'
    }),
    new WebpackSprocketsRailsManifestPlugin({
      manifestFile: '../../config/sprockets-manifest.json'
    }),
    new ExtractTextPlugin({ filename: 'styles.css', allChunks: true })
  ],

  optimization: {
    splitChunks: {
      name: true,
      minChunks: Infinity
    },
    runtimeChunk: {
      name: 'frontend/manifest'
    }
  }
};
