const nodeEnv = process.env.NODE_ENV;

/**
 * 指定したルートディレクトリ配下配下でOutputを生成
 * 例)
 *  - NODE_ENV: test
 * { path: "packs", publicPath: "/packs/", filename: "[name]-[hash].js" }
 *  - NODE_ENV: production
 * { path: "packs-test", publicPath: "/packs-test/", filename: "[name]-[hash].js" }
 * @param {string} rootPath path生成のルート
 */
module.exports = function getOutput(rootPath) {
  const path = nodeEnv == "test" ? "packs-test" : "packs";

  return {
    // 出力先のディレクトリ
    path: `${rootPath}/public/${path}`,
    publicPath: `/${path}/`,
    // 出力先のファイル
    filename: "[name]-[hash].js",
  };
};
