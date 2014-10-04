'use strict'

# jasmine specs for controllers go here
describe "Edit Module", () ->
  beforeEach () -> module "app"

  describe "Edit Controller", () ->
    beforeEach () -> module "app.edit"

    $controller = undefined
    $scope = undefined
    $location = undefined
    $window = undefined
    $filter = undefined
    $timeout = undefined
    FecMock = { }
    GroupMock = { }
    ListStateMock = { }
    FlashStorageMock = { }
    getFecSuccessMock = {
      data: {
        id: 116
        programGroupId: 12
        programGroupText: "320 Family"
        code: "123"
        title: "123"
        effectiveDate: null
        discontinueDate: null
      }
      status: 200
      headers: null
      config: null
    }
    getFecErrorMock = {
      data: {
        error: {
          status: 400,
          method: "GET",
          path: "/mx-admin/v1/api/admin/fec/1111111"
        }
        message: "Some error message"
      }
      status: 400
      headers: null
      config: null
    }
    getGroupSuccessMock = {
      data: {
        3: "MD80 Model"
        4: "757 Model"
        12: "320 Family"
        19: "Test Read Parent"
        30: "Test Delete Parent"
      }
      status: 200
      headers: null
      config: null
    }
    getGroupErrorMock = {
      data: {
        error: {
          status: 400
          method: "GET"
          path: "/aircraft-web/v1/api/type/group"
        }
        message: "Some error message."
      }
      status: 400
      headers: null
      config: null
    }
    putFecSuccessMock = {
      data: {
        id: 116
        programGroupId: 12
        programGroupText: "320 Family"
        code: "123"
        title: "123"
        effectiveDate: null
        discontinueDate: null
      }
      status: 200
      headers: null
      config: null
    }
    putFecErrorMock = {
      data: {
        error: {
          status: 400,
          method: "PUT",
          path: "/mx-admin/v1/api/admin/fec/"
        }
        message: "Some error message"
      }
      status: 400
      headers: null
      config: null
    }
    FlashStorageMessageMock = [
      {
        level: "danger"
        message: "Some error message"
        tagline: "Error"
        retry: true
        status: 400
        ws: "some/ws/url"
        callback: () -> 'some callback'
        id: 0
      }
    ]

    createController = () ->
      $controller "EditCtrl",
        $scope: $scope
        $location: $location
        $window: $window
        $filter: $filter
        $timeout: $timeout
        Fec: FecMock
        Group: GroupMock
        ListState: ListStateMock
        FlashStorage: FlashStorageMock

    beforeEach inject ($rootScope, _$controller_, _$location_, _$window_, _$timeout_) ->
      $controller = _$controller_
      $scope = $rootScope.$new()
      $location = _$location_
      $window = _$window_
      $timeout = _$timeout_

    beforeEach () ->
      FecMock.getFec = jasmine.createSpy "getFec"
      FecMock.putFec = jasmine.createSpy "putFec"
      FecMock.getUrl = jasmine.createSpy "getUrl"
      GroupMock.getGroup = jasmine.createSpy "getGroup"
      GroupMock.getUrl = jasmine.createSpy "getUrl"

      FlashStorageMock.get = jasmine.createSpy "get"
      FlashStorageMock.set = jasmine.createSpy "set"
      FlashStorageMock.clearAll = jasmine.createSpy "clearAll"

      FlashStorageMock.set = FlashStorageMock.get = () ->
        FlashStorageMessageMock

      ListStateMock.getListStateUrl = () ->
        "some/url"

    it "should have defined state parameters for decribing current view", () ->
      createController()
      expect($scope.group).toBeDefined()
      expect($scope.code).toBeDefined()

    it "should call getGroup ws on page load", () ->
      createController()
      expect(GroupMock.getGroup).toHaveBeenCalled()

    it "should call getFec ws on page load", () ->
      createController()
      expect(FecMock.getFec).toHaveBeenCalled()

    it "should move Group ws response data to $scope object upon successful ws call", () ->
      GroupMock.getGroup = (success, error) ->
        success(getGroupSuccessMock.data, getGroupSuccessMock.status, getGroupSuccessMock.headers, getGroupSuccessMock.config)
      createController()
      expect($scope.group).toEqual(getGroupSuccessMock.data)

    it "should display an error when the Group ws call fails with return data", () ->
      GroupMock.getGroup = (success, error) ->
        error(getGroupErrorMock.data, getGroupErrorMock.status, getGroupErrorMock.headers, getGroupErrorMock.config)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should display an error when the Group ws call fails without return data", () ->
      GroupMock.getGroup = (success, error) ->
        error({ }, null, null, null)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should move Fec ws response data to $scope object upon successful ws call", () ->
      FecMock.getFec = (id, success, error) ->
        success(getFecSuccessMock.data, getFecSuccessMock.status, getFecSuccessMock.headers, getFecSuccessMock.config)
      createController()
      expect($scope.code).toEqual(getFecSuccessMock.data)

    it "should display an error when the getFec ws call fails with return data", () ->
      FecMock.getFec = (id, success, error) ->
        error(getFecErrorMock.data, getFecErrorMock.status, getFecErrorMock.headers, getFecErrorMock.config)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should display an error when the getFec ws call fails without return data", () ->
      FecMock.getFec = (id, success, error) ->
        error({ }, null, null, null)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should call the putFec ws when told", () ->
      createController()
      $scope.confirm()
      expect(FecMock.putFec).toHaveBeenCalled()

    it "should set a success message when the putFec ws call succeeds with return data", () ->
      FecMock.putFec = (code, success, error) ->
        success(putFecSuccessMock.data, putFecSuccessMock.status, putFecSuccessMock.headers, putFecSuccessMock.config)
      createController()
      $scope.confirm()

    it "should set a success message when the putFec ws call succeeds without return data", () ->
      FecMock.putFec = (code, success, error) ->
        success({ }, null, null, null)
      createController()
      $scope.confirm()

    it "should modify history and reroute after timeout when putFec ws call is successful", () ->
      FecMock.putFec = (code, success, error) ->
        success(putFecSuccessMock.data, putFecSuccessMock.status, putFecSuccessMock.headers, putFecSuccessMock.config)
      createController()
      $scope.confirm()
      $timeout.flush()
      expect($location.path()).toEqual('/view/116')

    it "should display an error when the putFec ws call fails with return data", () ->
      FecMock.putFec = (code, success, error) ->
        error(putFecErrorMock.data, putFecErrorMock.status, putFecErrorMock.headers, putFecErrorMock.config)
      createController()
      $scope.confirm()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should display an error when the putFec ws call fails without return data", () ->
      FecMock.putFec = (code, success, error) ->
        error({ }, null, null, null)
      createController()
      $scope.confirm()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should jump back in browser history on on cancel", () ->
      createController()
      $scope.cancel()
    # TODO: Figure out how to mock $history