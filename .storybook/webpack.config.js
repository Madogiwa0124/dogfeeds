const path = require("path");
const rootPath = path.resolve(__dirname, "../");

module.exports = ({ config }) => {
  config.resolve.alias["@"] = rootPath;
  config.resolve.alias["~"] = rootPath;
  config.resolve.alias["@js"] = `${rootPath}/app/javascript`;
  config.resolve.alias["@css"] = `${rootPath}/app/javascript/stylesheets`;
  config.resolve.alias["@spec"] = `${rootPath}/spec/javascript`;
  config.resolve.alias["querystring"] = "querystring-es3";
  config.resolve.alias["process"] = "process/browser";

  config.module.rules.push({
    test: /\.(scss|css)/,
    use: ["style-loader", "css-loader", "sass-loader"],
  });

  return config;
};
