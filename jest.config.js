module.exports = {
  // Automatically clear mock calls and instances between every test
  clearMocks: true,

  // An array of file extensions your modules use
  moduleFileExtensions: ["js", "ts", "vue"],

  // A map from regular expressions to module names or to arrays of module names that allow to stub out resources with a single module
  moduleNameMapper: {
    "^@js(.*)$": "<rootDir>/app/javascript/$1",
    "^@css(.*)$": "<rootDir>/app/javascript/stylesheets/$1",
    "^@spec(.*)$": "<rootDir>/spec/javascript/$1",
  },

  // The glob patterns Jest uses to detect test files
  testMatch: ["**/?(*.)+(spec).[tj]s"],

  // An array of regexp pattern strings that are matched against all test paths, matched tests are skipped
  testPathIgnorePatterns: ["/node_modules/", "/vendor/bundle/"],

  // A map from regular expressions to paths to transformers
  transform: {
    "^.+\\.js$": "babel-jest",
    "^.+\\.ts$": "ts-jest",
    ".*\\.(vue)$": "vue-jest",
  },
};
