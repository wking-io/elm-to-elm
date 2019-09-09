'use strict';

const autoprefixer = require('autoprefixer');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const paths = require('./paths');

// Options for PostCSS as we reference these options twice
// Adds vendor prefixing based on your specified browser support in
// package.json
const postcssOptions = isProduction => {
  const defaultOptions = [
    require('tailwindcss')(paths.tailwind),
    require('postcss-flexbugs-fixes'),
    autoprefixer({
      browsers: [
        '>1%',
        'last 4 versions',
        'Firefox ESR',
        'not ie < 9', // React doesn't support IE8 anyway
      ],
      flexbox: 'no-2009',
    }),
  ];

  return {
    // Necessary for external CSS imports to work
    ident: 'postcss',
    plugins: [...defaultOptions, ...(isProduction ? [require('cssnano')] : [])],
  };
};

const extractCSS = new MiniCssExtractPlugin({
  filename: 'css/[name].css',
});

// This is the production configuration.
// It compiles slowly and is focused on producing a fast and minimal bundle.
// The development configuration is different and lives in a separate file.
module.exports = (_, { mode }) => {
  const isProduction = mode === 'production';
  return {
    stats: 'minimal',
    // Don't attempt to continue if there are any errors.
    bail: isProduction,
    // In production, we only want to load the polyfills and the app code.
    entry: paths.entry,
    output: {
      path: paths.build,
      filename: 'js/[name].js',
    },
    devtool: isProduction ? false : 'inline-source-map',
    module: {
      strictExportPresence: true,
      rules: [
        // Disable require.ensure as it's not a standard language feature.
        {
          parser: {
            requireEnsure: false,
          },
        },
        {
          test: /\.(js|jsx|mjs)$/,
          enforce: 'pre',
          use: [
            {
              options: {
                eslintPath: require.resolve('eslint'),
                configFile: paths.eslint,
                ignore: false,
                useEslintrc: false,
              },
              loader: require.resolve('eslint-loader'),
            },
          ],
          include: paths.src,
          exclude: [/[/\\\\]node_modules[/\\\\]/],
        },
        {
          // "oneOf" will traverse all following loaders until one will
          // match the requirements. When no loader matches it will fall
          // back to the "file" loader at the end of the loader list.
          oneOf: [
            {
              test: /\.js$/,
              include: paths.js,
              exclude: [/elm-stuff/, /node_modules/],
              use: [
                {
                  loader: require.resolve('babel-loader'),
                  options: {
                    presets: [
                      [
                        '@babel/preset-env',
                        {
                          modules: false,
                          targets: {
                            browsers: ['last 2 versions', 'safari >= 7'],
                          },
                        },
                      ],
                    ],
                  },
                },
              ],
            },
            {
              test: /\.elm$/,
              exclude: [/elm-stuff/, /node_modules/],
              use: {
                loader: 'elm-webpack-loader',
                options: {
                  debug: true,
                },
              },
            },
            {
              test: /\.css$/,
              exclude: [/elm-stuff/, /node_modules/],
              include: paths.styles,
              use: [
                MiniCssExtractPlugin.loader,
                {
                  loader: require.resolve('css-loader'),
                  options: {
                    importLoaders: 1,
                    url: false,
                  },
                },
                {
                  loader: require.resolve('postcss-loader'),
                  options: postcssOptions(isProduction),
                },
              ],
            },
            {
              test: /\.(gif|png|jpe?g|svg)$/i,
              use: [
                {
                  loader: require.resolve('file-loader'),
                  options: { name: 'images/[name].[ext]' },
                },
                {
                  loader: require.resolve('image-webpack-loader'),
                  options: {
                    disable: isProduction === false,
                  },
                },
              ],
            },
            {
              test: /\.(eot|svg|ttf|woff|woff2|otf)$/,
              use: [
                {
                  loader: require.resolve('file-loader'),
                  options: { name: 'fonts/[name].[ext]' },
                },
              ],
            },
          ],
        },
      ],
    },
    plugins: [
      new webpack.NamedModulesPlugin(),
      extractCSS,
      // Moment.js is an extremely popular library that bundles large locale files
      // by default due to how Webpack interprets its code. This is a practical
      // solution that requires the user to opt into importing specific locales.
      // https://github.com/jmblog/how-to-optimize-momentjs-with-webpack
      // You can remove this if you don't use Moment.js:
      new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),
    ],
    // Some libraries import Node modules but don't use them in the browser.
    // Tell Webpack to provide empty mocks for them so importing them works.
    node: {
      dgram: 'empty',
      fs: 'empty',
      net: 'empty',
      tls: 'empty',
      child_process: 'empty',
    },
  };
};
