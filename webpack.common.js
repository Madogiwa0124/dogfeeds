const webpack = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const { VueLoaderPlugin } = require("vue-loader");

const getEntries = require("./config/webpack/helpers/getEntries");
const JAVASCRIPT_ENTRY_PATH = "./app/javascript/packs/";
const getOutput = require("./config/webpack/helpers/getOutput");

module.exports = {
  // jsのエントリーポイント
  // デフォルトはsrc/index.js
  // ここではJAVASCRIPT_ENTRY_PATH配下のjs/tsをentryとするようにしている
  entry: getEntries(JAVASCRIPT_ENTRY_PATH),
  // 出力設定
  // デフォルトはdist/main.js
  output: getOutput(__dirname),
  module: {
    rules: [
      // stylesheetのbuild用の設定
      {
        test: /\.(scss|css)/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
      },
      {
        test: /\.(js|ts)$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: "babel-loader",
        },
      },
      {
        test: /\.ts/,
        exclude: /(node_modules|bower_components)/,
        loader: "ts-loader",
        options: {
          // /vueをtypescriptとして扱う
          appendTsSuffixTo: [/\.vue/],
          transpileOnly: true,
        },
      },
      {
        test: /\.vue/,
        loader: "vue-loader",
        options: {
          loaders: {
            scss: "vue-style-loader!css-loader!sass-loader",
          },
        },
      },
      {
        test: /\.(png|jpe?g|gif)$/i,
        type: "asset/resource",
      },
    ],
  },
  resolve: {
    alias: {
      "@js": `${__dirname}/app/javascript`,
      "@css": `${__dirname}/app/javascript/stylesheets`,
      querystring: "querystring-es3",
      process: "process/browser",
    },
    extensions: [".ts", ".js"],
  },
  plugins: [
    // CSSを別ファイルでbuildする
    new MiniCssExtractPlugin({ filename: "[name]-[contenthash].css" }),
    // manifestファイルの出力
    new WebpackAssetsManifest({ publicPath: true }),
    new VueLoaderPlugin(),
    new webpack.DefinePlugin({
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false,
    }),
    new webpack.EnvironmentPlugin({
      RAILS_ENV: "",
      NODE_ENV: "",
      ROLLBAR_POST_CLIENT_ITEM_ACCESS_TOKEN: "",
      SOURCE_VERSION: "",
      UPLOAD_SOURCEMAP: "",
      GOOLE_ANALYTICS_ID: "",
    }),
  ],
};
