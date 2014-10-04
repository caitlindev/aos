"use strict"

describe "setting-devroles Module", () ->

  beforeEach () ->
    module "ui.bootstrap"
    module "settings"
    module "settings-devroles"
    module "g4plus-user"

  mockUser = undefined
  mockRoles = undefined
  expectUser = undefined
  expectRoles = undefined
  $httpBackend = undefined
  $rootScope = undefined
  $controller = undefined
  UserProvider = undefined
  Roles = undefined
  FlashStorage = undefined

  beforeEach inject (_$httpBackend_, _$rootScope_, _$controller_,
    _UserProvider_, _Roles_, _FlashStorage_) ->

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

    mockRoles =
    {
      "items": [
        {
          "id": 1,
          "code": "mx_admin_full",
          "name": "MX Administrator",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 2,
          "code": "mx_admin_edit",
          "name": "MX Admin Editor",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 3,
          "code": "mx_admin_read",
          "name": "MX Admin Reader",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 4,
          "code": "ac_admin_full",
          "name": "AC Administrator",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 5,
          "code": "ac_admin_edit",
          "name": "AC Admin Editor",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 6,
          "code": "ac_admin_read",
          "name": "AC Admin Reader",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 7,
          "code": "super_read",
          "name": "System Reader",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 8,
          "code": "super_edit",
          "name": "System Editor",
          "childRoles": [],
          "childCodes": []
        },
        {
          "id": 9,
          "code": "super_admin",
          "name": "System Administrator",
          "childRoles": [],
          "childCodes": []
        }
      ],
      "total": 9,
      "sorts": [],
      "filters": [],
      "limit": null,
      "page": null
    }

    $httpBackend = _$httpBackend_
    $rootScope = _$rootScope_
    $controller = _$controller_
    UserProvider = _UserProvider_
    Roles = _Roles_
    FlashStorage = _FlashStorage_

    expectUser = (result, data) ->
      result = result or mockUser
      data = data or {}
      $httpBackend.expectGET("/api/login/check").respond result, data

    expectRoles = (result, data) ->
      result = result or mockRoles
      data = data or {}
      $httpBackend.whenGET("/api/g4-auth-web/v1/api/role").respond result, data

  describe "Roles Factory", () ->

    callbacks =
      successCallback: () ->
        return

      errorCallback: () ->
        return

    it "should have a list() function", () ->
      expect(Roles.list).toBeDefined()
      expect(typeof Roles.list).toBe 'function'

    it "should call the list success callback", () ->
      spyOn callbacks, "successCallback"
      Roles.list callbacks.successCallback, callbacks.errorCallback
      expectRoles()
      $httpBackend.flush()
      expect(callbacks.successCallback).toHaveBeenCalled()

    it "should have the post() function", () ->
      expect(Roles.post).toBeDefined()
      expect(typeof Roles.post).toBe 'function'

    it "should call the post success callback", () ->
      # @TODO: waiting on the real web service for this
#      spyOn callbacks, "successCallback"
      Roles.post {}, callbacks.successCallback, callbacks.errorCallback
      Roles.post null, callbacks.successCallback, callbacks.errorCallback
#      expectRoles()
#      $httpBackend.flush()
#      expect(callbacks.successCallback).toHaveBeenCalled()

  describe "PermissionsCtrl Controller", () ->

    permScope = undefined
    permCtrl = undefined
    $element = undefined
    $timeout = undefined

    beforeEach inject ($compile, _$timeout_) ->

      permScope = $rootScope.$new()
      $element = angular.element $compile('<div user-dev-roles></div>')($rootScope)[0]
      $timeout = _$timeout_

      permCtrl = () ->
        $controller "PermissionsCtrl",
          $scope: permScope
          $element: $element
          $timeout: $timeout
          UserProvider: UserProvider

    it "should get $scope.user", () ->
      expectUser()
      expectRoles()
      permCtrl()
      $httpBackend.flush()
      expect(permScope.user).toEqual mockUser.user

    it "should get $scope.user and not update selectedRoles if user roles are empty", () ->
      tmpUser = angular.extend {}, mockUser
      tmpUser.user.roles = undefined
      expectUser(tmpUser)
      expectRoles()
      permCtrl()
      expect(permScope.selectedRoles).toEqual []
      $httpBackend.flush()
      expect(permScope.selectedRoles).toEqual []

    it "should show the user web service error notice", () ->

      expectedStatus = 400
      expectedMessage =
        message: "User error"

      UserProvider.getUser = () ->
        then: (s, e) ->
          e expectedMessage, expectedStatus, null, null

      expectUser(400, {message: "User error"})
      expectRoles()
      permCtrl()
      $httpBackend.flush()
      expect(permScope.notice).toBeDefined()
      expect(permScope.notice[0].message).toBe expectedMessage.message
      expect(permScope.notice[0].status).toBe expectedStatus

    it "should show the user web service error notice", () ->

      UserProvider.getUser = () ->
        then: (s, e) ->
          e {message: null}, null, null, null

      expectUser(400, {message: "User error"})
      expectRoles()
      permCtrl()
      $httpBackend.flush()
      expect(permScope.notice).toBeDefined()
      expect(permScope.notice[0].level).toBe 'danger'
      expect(permScope.notice[0].message).toBe "Could not retrieve user"

    it "should show a roles error notice", () ->

      Roles.list = (s, e) ->
        e {}, 400, null, null

      expectUser()
      expectRoles(400, {message: "Roles error"})
      permCtrl()
      $httpBackend.flush()
#      expect(permScope.notice).toBeDefined()
#      expect(permScope.notice[0].level).toBe 'danger'
#      expect(permScope.notice[0].message).toBe "Roles error"