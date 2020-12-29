const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const VueLoaderPlugin = require("vue-loader/lib/plugin");

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
          options: {
            presets: ["@babel/preset-env"],
            plugins: [
              // NOTE: `ReferenceError regeneratorRuntime is not defined`が発生していたので解消
              // https://github.com/babel/babel/issues/9849#issuecomment-612595221
              "@babel/plugin-transform-runtime",
            ],
          },
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
    ],
  },
  resolve: {
    alias: {
      vue: "vue/dist/vue.esm.js",
      "@js": `${__dirname}/app/javascript`,
      "@css": `${__dirname}/app/javascript/stylesheets`,
    },
    extensions: [".ts", ".js"],
  },
  plugins: [
    // CSSを別ファイルでbuildする
    new MiniCssExtractPlugin({ filename: "[name]-[hash].css" }),
    // manifestファイルの出力
    new WebpackAssetsManifest({ publicPath: true }),
    new VueLoaderPlugin(),
  ],
};
