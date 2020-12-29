process.env.NODE_ENV = "production";

// const RollbarSourceMapPlugin = require("./helpers/rollbarSourceMapConfig.js");
const { merge } = require("webpack-merge");
const common = require("../../webpack.common.js");
// const isUploadSourceMap = process.env.UPLOAD_SOURCEMAP === "true";

// const plugins = isUploadSourceMap ? common.plugins.concat(RollbarSourceMapPlugin) : common.plugins;

// console.log(common.plugins);

module.exports = merge(common, {
  mode: process.env.NODE_ENV,
});
