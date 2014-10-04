'use strict'

describe "SetUrlRoutes service", () ->
  beforeEach () ->
    module "g4plus-breadcrumb.directive"
    module "ngRoute"
    module "ui.router"
    module(($stateProvider) ->
      $stateProvider.state 'list', {
        abstract: true
        url: '/list'
        template: '<div ui-view=""></div>'
        controller: ['$scope', ($scope) -> ]
        data:
          breadcrumb:
            title: 'List'
            root: true
          pageTitle: 'List'
      }

      $stateProvider.state 'view', {
        url: '/view/:discoveryId'
        controller: 'ViewCtrl'
        data:
          breadcrumb:
            title: 'View'
            view: true
          pageTitle: 'Details'
      }

      $stateProvider.state 'edit', {
        url: '/edit/:discoveryId'
        controller: 'EditCtrl'
        data:
          breadcrumb:
            title: 'Edit'
            edit: true
          pageTitle: 'Edit'
      }
      $stateProvider.state "custom", {
        url: "/custom"
        template: '''
          <p>Custom view</p>
        '''
        data:
          pageTitle: "custom page"
          breadcrumbs:
            custom: true
            routes: [
              {title: "foo", url:"/foo"},
              {title: "bar", url: "/bar"},
              {title: "Custom", url:"/custom"}
            ]
      }
      return
    )
  location = undefined
  scope = {}
  linkFn = undefined
  element = undefined
  state = undefined
  it "should set the edit url", () ->
    statesMock = [
      {url:"/edit/:id"}
    ]
    inject (SetUrlRoutes) ->
      expect(SetUrlRoutes.set(statesMock)).toEqual(["/edit/"])
  it "should return the breadcrumb routes for edit and view", () ->
    inject (SetUrlRoutes) ->
      crumbs = SetUrlRoutes.get()
      expect(crumbs).toEqual({ view : '/view/', edit : '/edit/', add : '/add' })

  beforeEach inject ($rootScope, $browser, $compile, $state, $injector, $location, $timeout)->
      scope = $rootScope.$new()
      location = $location
      element = angular.element("<div g4plus-breadcrumb></div>")
      $compile(element)($rootScope)
      scope.$digest()
      state = jasmine.getEnv().currentSpec.$injector.get('$state')
      fromState =
        url: '/list'
        data:
          breadcrumb:
            title: 'List'
            root: true

      fromParams = []

      toState =
        url: '/edit'
        data:
          breadcrumb:
            title: 'Edit'
            edit: true
      location.url("/custom")
      toParams = [{discoveryId: 1}]
      $rootScope.$broadcast "$stateChangeSuccess", toState, toParams, fromState, fromParams

      $rootScope.$apply()
      $timeout.flush()

  it "should set breadcrumbs for custom route", () ->
    scope.$digest()
    expect(element.html()).toContain("foo")
    expect(element.html()).toContain("bar")
    expect(element.html()).toContain("Custom")
  it "should set breadcrumbs for edit route", () ->
      inject ($location, $rootScope, $timeout) ->
        fromState =
          url: '/list'
          data:
            breadcrumb:
              title: 'List'
              root: true

        fromParams = []

        toState =
          url: '/edit'
          data:
            breadcrumb:
              title: 'Edit'
              edit: true
        toParams = [{1}]
        $location.url("'/edit/:discoveryId'")
        $rootScope.$broadcast "$stateChangeSuccess", toState, toParams, fromState, fromParams
        $rootScope.$apply()
        $timeout.flush()
        scope.$digest()
        expect(element.html()).toContain("List")
        expect(element.html()).toContain("View")
        expect(element.html()).toContain("Edit")
  it "should set breadcrumbs for view route", () ->
    inject ($location, $rootScope, $timeout) ->
      fromState =
        url: '/list'
        data:
          breadcrumb:
            title: 'List'
            root: true

      fromParams = []

      toState =
        url: '/edit'
        data:
          breadcrumb:
            title: 'Edit'
            edit: true
      toParams = [{1}]
      $location.url("'/view/:discoveryId'")
      $rootScope.$broadcast "$stateChangeSuccess", toState, toParams, fromState, fromParams
      $rootScope.$apply()
      $timeout.flush()
      scope.$digest()
      expect(element.html()).toContain("List")
      expect(element.html()).toContain("View")
  it "should set breadcrumbs for list route", () ->
    inject ($location, $rootScope, $timeout) ->
      fromState =
        url: '/list'
        data:
          breadcrumb:
            title: 'List'
            root: true

      fromParams = []

      toState =
        url: '/edit'
        data:
          breadcrumb:
            title: 'Edit'
            edit: true
      toParams = [{1}]
      $location.url("'/list'")
      $rootScope.$broadcast "$stateChangeSuccess", toState, toParams, fromState, fromParams
      $rootScope.$apply()
      $timeout.flush()
      scope.$digest()
      expect(element.html()).toContain("List")