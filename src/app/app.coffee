"use strict"

# App module
# =====
# Defines the app module and list dependent controllers
#  - bullet point 1
#  - bullet point 2
#  - bullet point 3
App = angular.module("app", [
  'ui.router'
  'src.templates'
  'mx.menu'
  'app.list'
  'app.dashboard'
  'app.view'
  'app.add'
  'app.edit'
  'app.delete'
  'app.roadtrip.add'
  'app.roadtrip.view'
  'app.roadtrip.edit'
  'app.roadtrip.edittravel'
  'app.roadtrip.addtravel'
  'services.events'
  'services.roadtrips'
  'services.flights'
  'services.stations'
  'services.list_state'
  'services.states'
  'services.tailNumbers'
  'services.parts'
  'services.travel_arrangements'
  'g4plus.directives'
  'g4plus-date.directive'
  'g4plus-date.filter'
  'g4plus.sort-button'
  'g4plus-loading.directive'
  'g4ActionsButton'
  'g4plus.autofocus'
  'g4plus-super-list'
  'g4plus.chart'
  'g4plus-mapbox.directive'
  'g4plus.ata-select'
  'g4plus-comments'
  'g4plus-file-upload'
  'ui.select2'
  'g4plus.employee-lookup'
])

# App config
# =====
# Configures the project with routes
App.config ($stateProvider, $urlRouterProvider) ->
  # Home route
  $stateProvider.state 'dashboard', {
    url: '/dashboard'
    templateUrl: 'src/app/ui_flow/dashboard/dashboard.jade'
    controller: 'DashboardCtrl'
    pageTitle: 'Dashboard'
  }

  # List wih parameters
  $stateProvider.state 'list', {
    url: '/list?select&page&pageSize&filter_value&filter_option'
    templateUrl: 'src/app/ui_flow/list/list.jade'
    controller: 'ListCtrl'
  }

  # View
  $stateProvider.state 'view', {
    url: '/view/:id'
    templateUrl: 'src/app/ui_flow/view/view.jade'
    controller: 'ViewCtrl'
  }

  # View with parameters
  $stateProvider.state 'view-param/:id', {
    url: '/view/:id'
    templateUrl: 'src/app/ui_flow/view/view.jade'
    controller: 'ViewCtrl'
  }

  # Add
  $stateProvider.state 'add', {
    url: '/add'
    templateUrl: 'src/app/ui_flow/add/add.jade'
    controller: 'AddCtrl'
  }

  # Road Trip
  $stateProvider.state 'roadtrip/view', {
    url: '/roadtrip/view/:id'
    templateUrl: 'src/app/ui_flow/roadtrip/view.jade'
    controller: 'RoadTripViewCtrl'
  }
  $stateProvider.state 'roadtrip/edit', {
    url: '/roadtrip/edit/:id'
    templateUrl: 'src/app/ui_flow/roadtrip/edit.jade'
    controller: 'RoadTripEditCtrl'
  }
  $stateProvider.state 'roadtrip/add', {
    url: '/roadtrip/add/:id'
    templateUrl: 'src/app/ui_flow/roadtrip/add.jade'
    controller: 'RoadTripAddCtrl'
  }
  $stateProvider.state 'roadtrip/add_travel', {
    url: '/roadtrip/add_travel/:id'
    templateUrl: 'src/app/ui_flow/roadtrip/add_travel.jade'
    controller: 'RoadTripAddTravelCtrl'
  }
  $stateProvider.state 'roadtrip/edit_travel', {
    url: '/roadtrip/edit_travel/:id/:editType'
    templateUrl: 'src/app/ui_flow/roadtrip/edit_travel.jade'
    controller: 'RoadTripEditTravelCtrl'
  }

  # Edit
  $stateProvider.state 'edit', {
    url: '/edit/:id'
    templateUrl: 'src/app/ui_flow/edit/edit.jade'
    controller: 'EditCtrl'
  }

  # For any unmatched url, redirect to /home
  $urlRouterProvider.otherwise('/dashboard')

# App controller
# =====
# Handles control of the app
App.controller "AppCtrl", AppCtrl = ($scope, $rootScope) ->

  $rootScope.appTitle = "AOS Work Control"

  # $stateChangeSuccess
  # --------
  # Updates the window title upon a state change (another sub-app is loaded)
  $scope.$on "$stateChangeSuccess", (event, toState, toParams, fromState, fromParams) ->
    $scope.pageTitle = toState.data.pageTitle + " | G4Plus"  if angular.isDefined(toState.data) && angular.isDefined(toState.data.pageTitle)

App.config ($httpProvider) ->
  $httpProvider.defaults.headers.get = {}  unless $httpProvider.defaults.headers.get
  # disable IE ajax request caching
  $httpProvider.defaults.headers.get['If-Modified-Since'] = '0'
