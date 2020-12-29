const glob = require("glob");
const path = require("path");

function entryName(RootPath, filePath) {
  const dirName = filePath.replace(RootPath, "").replace(path.basename(filePath), "");
  return `${dirName}${path.basename(filePath, path.extname(filePath))}`;
}

/**
 * 指定したentryのルートディレクトリ配下のjsまたはtsファイルのファイル名とパスのobjectを取得
 * 例)
 *  - /entries/foo.ts => { foo: "/entries/foo.ts" }
 *  - /entries/bars/bar.ts => { "bars/bar": "/entries/bars/bar.ts" }
 * @param {string} entryRoot entryのルートディレクトリ
 */
module.exports = function getEntries(entryRoot) {
  const result = {};
  const filePaths = glob.sync(`${entryRoot}/**/*.{js,ts}`);
  filePaths.forEach((filePath) => {
    result[entryName(entryRoot, filePath)] = filePath;
  });
  return result;
};
