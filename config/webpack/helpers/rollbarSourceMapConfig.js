const RollbarSourceMapPlugin = require("rollbar-sourcemap-webpack-plugin");

const token = process.env.ROLLBAR_POST_SERVER_ITEM_ACCESS_TOKEN;
const codeVersion = process.env.SOURCE_VERSION;
const publicPath = process.env.PUBLIC_PATH + "/packs";

module.exports = new RollbarSourceMapPlugin({
  accessToken: token,
  version: codeVersion,
  publicPath: publicPath,
  ignoreErrors: true,
});
