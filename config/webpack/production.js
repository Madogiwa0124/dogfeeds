process.env.NODE_ENV = process.env.NODE_ENV || "production";

const RollbarSourceMapPluginConfig = require("./plugins/rollbarSourceMapConfig");
const environment = require("./environment");

environment.config.merge({
  devtool: "hidden-source-map",
});

if (process.env.UPLOAD_SOURCEMAP === "true") {
  environment.plugins.prepend("RollbarSourceMapPlugin", RollbarSourceMapPluginConfig);
}

module.exports = environment.toWebpackConfig();
