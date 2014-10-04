'use strict'

# jasmine specs for controllers go here

# jasmine specs for controllers go here
describe "List Module", () ->
  beforeEach () -> module "app"

  describe "List Controller", () ->
    beforeEach () -> module "app.list"

    $controller = undefined
    $scope = undefined
    $location = undefined
    $http = undefined
    modalMock = { }
    GroupMock = { }
    FecMock = { }
    ListStateMock = { }
    FlashStorageMock = { }
    modalInstanceMock = { }
    getFecsSuccessMock = {
      data: [
        {
          id: 115
          programGroupId: 12
          programGroupText: "320 Family"
          code: "100"
          title: "Test1"
          effectiveDate: null
          discontinueDate: null
        },
        {
          id: 16
          programGroupId: 12
          programGroupText: "320 Family"
          code: "101"
          title: "Test1"
          effectiveDate: null
          discontinueDate: null
        },
        {
          id: 17
          programGroupId: 12
          programGroupText: "320 Family"
          code: "102"
          title: "Test1"
          effectiveDate: null
          discontinueDate: null
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "103"
          title: "Test1"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "104"
          title: "Test1"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "200"
          title: "Test2"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "201"
          title: "Test2"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "202"
          title: "Test2"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "203"
          title: "Test2"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        },
        {
          id: 18
          programGroupId: 12
          programGroupText: "320 Family"
          code: "204"
          title: "Test2"
          effectiveDate: null
          discontinueDate: "2222-11-11"
        }
      ]
      status: 200
      headers: null
      config: null
    }
    getFecsErrorMock = {
      data: {
        error: {
        status: 400
        method: "GET"
        path: "/mx-admin/v1/api/admin/fecz"
        }
        message: "Some error message."
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
    ListStateParamsMock =
    {
      aircraftProgramId: 99
      filter: "Non"
      pageSize: "100"
      page: "4"
      sort: "code"
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
      $controller "ListCtrl",
        $scope: $scope
        $location: $location
        $modal: modalMock
        Group: GroupMock
        Fec: FecMock
        ListState: ListStateMock
        FlashStorage: FlashStorageMock

    beforeEach inject ($rootScope, _$controller_, _$location_, _$httpBackend_) ->
      $controller = _$controller_
      $scope = $rootScope.$new()
      $location = _$location_
      $http = _$httpBackend_

    beforeEach () ->
      GroupMock.getGroup = jasmine.createSpy "getGroup"
      GroupMock.getUrl = jasmine.createSpy "getUrl"
      FecMock.getFecs = jasmine.createSpy "getFecs"
      FecMock.getUrl = jasmine.createSpy "getUrl"
      ListStateMock.setParams = jasmine.createSpy "setParams"
      ListStateMock.getParams = jasmine.createSpy "getParams"
      ListStateMock.getListStateUrl = jasmine.createSpy "getListStateUrl"
      FlashStorageMock.get = jasmine.createSpy "get"
      FlashStorageMock.set = jasmine.createSpy "set"
      FlashStorageMock.clearAll = jasmine.createSpy "clearAll"

      ListStateMock.getParams = () ->
        ListStateParamsMock

      FlashStorageMock.set = FlashStorageMock.get = () ->
        FlashStorageMessageMock

      modalMock.open = jasmine.createSpy "open"
      modalMock.open.andCallFake (obj) ->
        obj
      modalMock.open.andReturn
        result: modalInstanceMock

      modalInstanceMock.then = jasmine.createSpy "then"
      modalInstanceMock.then.andCallFake (callback) ->
        callback()

    it "should parse query parameters if present", () ->
      $location.url("/list?programGroupId=99&filter_option=code&filter_value=1&pageSize=100&page=4&sort=code")
      createController()
      expect($location.search()).toEqual(
        {
          programGroupId: '99'
          filter_option: 'code'
          filter_value: '1'
          pageSize: '100'
          page: '4'
          sort: 'code'
        }
      )

    it "should query Group ws on page load", () ->
      createController()
      expect(GroupMock.getGroup).toHaveBeenCalled()
      expect(GroupMock.getGroup.callCount).toBe(1)

    it "should move Group ws response data to $scope object upon successful ws call", () ->
      GroupMock.getGroup = (success, error) ->
        success(getGroupSuccessMock.data, getGroupSuccessMock.status, getGroupSuccessMock.headers, getGroupSuccessMock.config)
      createController()
      expect($scope.group).toEqual(getGroupSuccessMock.data)

    it "should display an error when Group ws call fails with return data", () ->
      GroupMock.getGroup = (success, error) ->
        error(getGroupErrorMock.data, getGroupErrorMock.status, getGroupErrorMock.headers, getGroupErrorMock.config)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should display an error when Group ws call fails without return data", () ->
      GroupMock.getGroup = (success, error) ->
        error({ }, null, null, null)
      createController()
      expect($scope.message).toEqual(FlashStorageMessageMock)

    it "should open a modal for delete", () ->
      createController()
      $scope.openDelete()
      expect(modalMock.open).toHaveBeenCalled()

    it "should update code list on delete modal close", () ->
      createController()
      $scope.updateList = jasmine.createSpy "updateList"
      $scope.$digest()
      $scope.openDelete()
      expect($scope.updateList).toHaveBeenCalled()