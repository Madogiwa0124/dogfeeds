// NOTE: Rollbarにブラウザ側で発生したエラー通知を送る機能を有効化
// https://docs.rollbar.com/docs/browser-js

import process from "process";
import Rollbar from "rollbar";

const token = process.env.ROLLBAR_POST_CLIENT_ITEM_ACCESS_TOKEN;
const railsEnv = process.env.RAILS_ENV;
const codeVersion = process.env.SOURCE_VERSION;
const rollbarParamsValidation = () => !!(!(railsEnv === "test") && token);

export default new Rollbar({
  accessToken: token,
  captureUncaught: true,
  captureUnhandledRejections: true,
  enabled: rollbarParamsValidation(),
  payload: {
    environment: railsEnv,
    client: {
      javascript: {
        source_map_enabled: true,
        code_version: codeVersion,
        guess_uncaught_frames: true,
      },
    },
    server: {
      root: "webpack:///./",
    },
  },
});
