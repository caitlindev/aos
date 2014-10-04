// Karma configuration
module.exports  = function (karma) {
  karma.set({
    // base path, that will be used to resolve files and excludes.
    basePath: '../',

    // frameworks to use
    frameworks: ['jasmine'],

    // list of files / patterns to load into the browser.
    files: [
      // Load angular
      'bower_components/angular/angular.js',
      'bower_components/angular-route/angular-route.js',
      "bower_components/angular-ui-router/release/angular-ui-router.js",
      "bower_components/lodash/dist/lodash.compat.js",
      // Load angular bootstrap
      'bower_components/angular-bootstrap/ui-bootstrap.js',


      // Load mocks directly from bower.
      'bower_components/angular-mocks/angular-mocks.js',

      // Files
      'src/*.coffee',
      'test/*.spec.coffee'
    ],

    preprocessors: {
      'src/*.coffee': [ "coffee"],
      'test/*.coffee': ['coffee']
    },

    coverageReporter: {
      'type': 'html',
      'dir': 'test/coverage/'
    },


    // list of files to exclude
    exclude: [],

    //Test results reporter to use.
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress', 'coverage'],

    // web server port
    port: 9876,

    // cli runner port
    runnerPort: 9100,

    // enable/disable colors in the output (reporters and logs)
    colors: true,

    // Level of logging
    // possible values: karma.LOG_DISABLE || karam.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
    logLevel: karma.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes.
    autoWatch: true,

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only MAC)
    // - PhantomJS
    // - IE (only Windows)
    browsers:['PhantomJS'],

    //If browser does not capture in given timeout [ms] kill it.
    captureTimeout: 6000,

    //Plugins to Load
    plugins: [
      'karma-jasmine',
      'karma-phantomjs-launcher',
      'karma-coffee-preprocessor',
      'karma-coverage'
    ],

    // Continuous Integration Mode
    // if true, it captures browsers runs tests then exits.
    singleRun: false
  });
};