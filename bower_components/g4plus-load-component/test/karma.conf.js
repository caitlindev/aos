/**
 * Created by taylor.kaplan on 3/6/14.
 */
module.exports = function(karma) {
    karma.set({
        basePath: '../',
        frameworks: ['jasmine'],
        files: [
            'bower_components/angular/angular.js',
            'bower_components/angular-bootstrap/ui-bootstrap.js',
            'bower_components/angular-mocks/angular-mocks.js',
            'bower_components/g4plus-retry-call/src/*.coffee',
            'src/*.coffee',
            'test/*.coffee'
        ],
        preprocessors: {
            'src/*.coffee': ['coverage'],
            'test/*.coffee': ['coffee'],
            'bower_components/g4plus-retry-call/src/*.coffee': ['coffee']
        },
        coverageReporter: {
            'type': 'html',
            'dir': 'test/coverage/'
        },
        captureTimeout: 6000,
        exclude: [],
        reporters: ['progress','coverage'],
        port: 9876,
        runnerPort: 9100,
        colors: true,
        logLevel: karma.LOG_INFO,
        autoWatch: true,
        browsers:['PhantomJS'],
        plugins: [
            'karma-jasmine',
            'karma-phantomjs-launcher',
            'karma-coffee-preprocessor',
            'karma-coverage'
        ],
        singleRun: false
    });
}