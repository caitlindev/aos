'use strict'

describe "Delete module", () ->
  beforeEach () -> module "mx-ics"

  describe "delete controller", () ->
    beforeEach () -> module "mx-ics.delete"

    $controller = undefined
    $scope = undefined
    icsDataMock = {}
    modalInstanceMock = {}
    IcsMock = {}

    createController = () ->
      $controller "DeleteModalCtrl",
        $scope: $scope
        ics: icsDataMock
        $modalInstance: modalInstanceMock
        Ics: IcsMock

    beforeEach inject (_$controller_, $rootScope) ->
      $controller = _$controller_
      $scope = $rootScope.$new()

    beforeEach () ->
      icsDataMock =
        id: 1
        code: "code"
        title: "title"
        effectiveDate: "11-01-1977"
        discontinueDate: "10-01-1988"
      modalInstanceMock.close = jasmine.createSpy "close"
      modalInstanceMock.dismiss = jasmine.createSpy "dismiss"

    
    it "should use the set inspection check set object", () ->
      createController()
      expect($scope.ics).toBe(icsDataMock)

    it "should delete passed in object", () ->
      IcsMock.delete = jasmine.createSpy "delete"
      IcsMock.delete.andCallFake (id, success, error) ->
        success()
      createController()
      $scope.delete()
      expect(IcsMock.delete).toHaveBeenCalled()
      expect(modalInstanceMock.close).toHaveBeenCalled()

    it "should not delete passed in object on error", () ->
      IcsMock.delete = jasmine.createSpy "delete"
      IcsMock.delete.andCallFake (id, success, error) ->
        error()
      createController()
      $scope.delete()
      expect(IcsMock.delete).toHaveBeenCalled()
      expect($scope.errorMessage).not.toBe("")

    it "should dismiss modal on cancel", () ->
      createController()
      $scope.cancel()
      expect(modalInstanceMock.dismiss).toHaveBeenCalled()
