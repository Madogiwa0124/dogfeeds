process.env.NODE_ENV = "production";

const { merge } = require("webpack-merge");
const RollbarSourceMapPlugin = require("./helpers/rollbarSourceMapConfig.js");
const common = require("../../webpack.common.js");
const isUploadSourceMap = process.env.UPLOAD_SOURCEMAP === "true";
const plugins = isUploadSourceMap ? [RollbarSourceMapPlugin] : [];

module.exports = merge(common, {
  mode: process.env.NODE_ENV,
  devtool: "hidden-source-map",
  plugins: plugins,
});
