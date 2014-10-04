'use strict'

# jasmine specs for controllers go here
describe "Home Module", () ->
  beforeEach () -> angular.mock.module "app"

  describe "Home Controller", () ->
    beforeEach () -> angular.mock.module "app.home"

    $controller = undefined
    $scope = undefined

    createController = () ->
      $controller "HomeCtrl",
        $scope: $scope

    beforeEach inject ($rootScope, _$controller_) ->
      $controller = _$controller_
      $scope = $rootScope.$new()

    it "should have defined state parameters for decribing current view", () ->
      createController()
      expect($scope.pageTitle).toBeDefined()
      expect($scope.foo).toBeDefined()

    it "should have a method for docco comments", () ->
      createController()
      $scope.methodForDoccoDemonstration()