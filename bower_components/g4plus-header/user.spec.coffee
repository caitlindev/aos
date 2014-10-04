"use strict"

describe "G4Plus User", () ->

  beforeEach () ->
    module "ui.bootstrap"
    module "g4plus-user"

  mockUser = undefined
  expectUser = undefined
  $httpBackend = undefined
  $rootScope = undefined

  beforeEach inject (_$httpBackend_, _$rootScope_) ->
    mockUser =
      user:
        createdAt: 1393539612,
        aisId: "86323",
        adId: "mel.cruz",
        email: "mel.cruz@allegiantair.com",
        name: "mel cruz",
        company: "20",
        roles: [
          'dev_sudo'
          'mx_admin_edit'
        ]

    $httpBackend = _$httpBackend_
    $rootScope = _$rootScope_

    expectUser = (result, data) ->
      result = result or mockUser
      data = data or {}
      $httpBackend.expectGET("/api/login/check").respond result, data

  describe "UserProvider factory", () ->

    UserProvider = undefined

    beforeEach inject (_UserProvider_) ->
      UserProvider = _UserProvider_

    it "should query the user and send it back to the callback", () ->
      tmpUser = angular.extend {}, mockUser
      calledUser = undefined
      expectUser(tmpUser)

      successCallback = (result) ->
        calledUser = result
        return

      # !self.promiseInProgress
      UserProvider.getUser().then successCallback
      expect(calledUser).toBe undefined

      # promiseInProgress
      UserProvider.getUser().then successCallback
      $httpBackend.flush()
      $rootScope.$digest()
      expect(calledUser).toEqual tmpUser.user

      # let's change the original expected result
      tmpUser.user.test = "test"

      resolvedUser = undefined
      resolvedSuccessCallback = (result) ->
        resolvedUser = result

      # tmpUser expected was changed but it still should use the original
      UserProvider.getUser().then resolvedSuccessCallback
      $rootScope.$digest()
      expect(resolvedUser).toEqual calledUser

    it "should reject data and call the errorCallback", () ->

      message = "Error message"
      expectUser(400, { message:message })
      errorMessage = undefined

      successCallback = (result) -> return

      errorCallback = (data) ->
        errorMessage = data.message
        return

      expect(errorMessage).toBe undefined
      UserProvider.getUser().then successCallback, errorCallback
      $httpBackend.flush()
      $rootScope.$digest()
      expect(errorMessage).toBe message

  describe "UserCtrl Controller", () ->

    html = undefined
    initCtrl = undefined
    userCtrlScope = undefined
    $modal = undefined

    beforeEach inject ($compile, $controller, _$modal_) ->
      userCtrlScope = $rootScope.$new()
      $modal = _$modal_

      # get the template
      comp = $compile('<user-dropdown></user-dropdown>')($rootScope)
      html = angular.element comp[0]

      initCtrl = () ->
        $controller "UserCtrl",
          $scope: userCtrlScope
          $element: html
          $modal: $modal

    it "should have a $scope.user", () ->
      expectUser()
      initCtrl()
      $httpBackend.flush()
      expect(userCtrlScope.user[1]).toEqual mockUser.user[1]
      expect(userCtrlScope.user.company).toEqual mockUser.user.company

    it "should add a companyName property to user object", () ->
      expectUser()
      initCtrl()
      $httpBackend.flush()
      expect(userCtrlScope.user[1]).toEqual mockUser.user[1]
      expect(userCtrlScope.user.companyName)
        .toEqual userCtrlScope.companyList[userCtrlScope.user.company]

    it "should set company default to 'Allegiant Air, LLC'", () ->
      tmpUser = angular.extend {}, mockUser
      # not in the list
      tmpUser.user.company = 100
      expectUser(tmpUser)
      initCtrl()
      $httpBackend.flush()
      expect(userCtrlScope.user[1]).toEqual mockUser.user[1]
      expect(userCtrlScope.user.companyName)
        .toEqual 'Allegiant Air, LLC'

    it "should produce an error", () ->
      UserProvider = undefined
      $controller = undefined
      expectedErrorStatus = 400
      expectedErrorData =
        message: "Error message from service"

      inject (_UserProvider_, _$controller_) ->
        UserProvider = _UserProvider_
        $controller = _$controller_

      # Mock UserProvider to go directly to error
      UserProvider =
        getUser: () ->
          then: (succes, error) ->
            error expectedErrorData, expectedErrorStatus, null, null

      expectUser(expectedErrorStatus, expectedErrorData)
      $controller "UserCtrl",
        $scope: userCtrlScope
        $element: html
        UserProvider: UserProvider

      $httpBackend.flush()
      expect(userCtrlScope.message).toBeDefined()
      expect(userCtrlScope.message.message).toBe expectedErrorData.message

      $httpBackend.resetExpectations()
      expectedErrorData = {}
      expectUser(expectedErrorStatus, expectedErrorData)
      $controller "UserCtrl",
        $scope: userCtrlScope
        $element: html
        UserProvider: UserProvider
      expect(userCtrlScope.message.message).not.toBe null

    it "should have the openSettings() function", () ->
      modalWindow = undefined
      modalWindowPath = "template/modal/window.html"
      $templateCache = undefined
      inject (_$templateCache_) ->
        $templateCache = _$templateCache_
        # mock modalWindowPath
        $templateCache.put modalWindowPath, '<div><div class="modal-dialog"></div></div>'
        modalWindow = $templateCache.get modalWindowPath

      $modal.open = (options) ->
        return options

      spyOn($modal, "open").andCallThrough()
      initCtrl()
      expect(userCtrlScope.openSettings).toBeDefined()
      userCtrlScope.openSettings()
      expect($modal.open).toHaveBeenCalled()

      modalWindow = modalWindow.replace '<div class="modal-dialog">', ''
      $templateCache.put modalWindowPath, modalWindow
      modalOptions = userCtrlScope.openSettings()
      expect($modal.open).toHaveBeenCalled()
      expect(modalOptions.template.indexOf '<div class="modal-dialog">').toBeGreaterThan -1

    it "should have popover click events", () ->
      doc = angular.element window.document
      popover = html.find('.popover')
      trigger = html.find('button[data-toggle="popover"]')
      initCtrl()
      expect(popover.css('display')).toBe ''
      doc.click()
      expect(popover.css('display')).toBe 'none'

      expect(popover.css('display')).toBe 'none'
      trigger.click()
      expect(popover.css('display')).toBe 'block'

      popover.click()

  describe "SettingsModalCtrl Controller", () ->

    modalCtrl = undefined
    modalScope = undefined
    $modalInstance =
      dismiss: () ->
        return

    beforeEach inject ($controller) ->
      modalScope = $rootScope.$new()

      modalCtrl = () ->
        $controller "SettingsModalCtrl",
          $scope: modalScope
          $modalInstance: $modalInstance

    it "should have a cancel() function", () ->
      spyOn $modalInstance, "dismiss"
      modalCtrl()
      expect(modalScope.cancel).toBeDefined()
      modalScope.cancel()
      expect($modalInstance.dismiss).toHaveBeenCalled()