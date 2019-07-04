process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');
const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");

const smp = new SpeedMeasurePlugin();

// const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
// environment.plugins.append('BundleAnalyzer',
//     new BundleAnalyzerPlugin()
// );

const webpackConfig = environment.toWebpackConfig();
module.exports = smp.wrap(webpackConfig);
