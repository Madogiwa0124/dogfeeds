// NOTE: settingsは一旦capybara側の設定と合わせた
module.exports = {
  ci: {
    collect: {
      url: ["http://localhost:3001"],
      startServerCommand: `bin/rails s -p 3001`,
      startServerReadyPattern: "Puma starting",
      settings: {chromeFlags: 'headless --disable-gpu --no-sandbox --disable-dev-shm-usage'},
      numberOfRuns: 3
    },
    upload: {
      target: 'filesystem',
      outputDir: './.lighthouseci_result'
    },
  },
};
