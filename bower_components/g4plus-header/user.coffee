"use strict"

user = angular.module "g4plus-user", ["settings"]

user.factory "UserProvider", [
  '$http'
  '$q'
  ($http, $q) ->

    self = @
    @promiseInProgress = null
    @user = null

    # getUser returns a promise every time, even if a user had been resolved
    @getUser = () ->

      deferredUser = $q.defer()

      # Resolve the promise using saved user
      if !!@user
        deferredUser.resolve @user

      # Make the call and return the promise in progress
      else
        callbacks =
          userSuccess: (result) ->
            self.setUser result[0]
            self.promiseInProgress = null
            deferredUser.resolve result[0]

          userError: (data, status, headers, config) ->
            deferredUser.reject data

        # Make the call if there is no promise in progress
        if !self.promiseInProgress
          $http.get("/api/user_profile")
            .success(callbacks.userSuccess)
            .error(callbacks.userError)
          @promiseInProgress = deferredUser.promise
        else
          deferredUser.promise = @promiseInProgress

      # Return a promise whether user data been resolved or not
      deferredUser.promise

    @setUser = (u) ->
      @user = u

    return {
      getUser: () ->
        return self.getUser()
    }

]

user.controller "UserCtrl", [
  '$scope'
  '$element'
  'UserProvider'
  '$modal'
  '$templateCache'
  'MXMenuService'
  ($scope, $element, UserProvider, $modal, $templateCache, MXMenuService) ->

    # Get elements
    document = angular.element window.document
    popover = $element.find('.popover')
    trigger = $element.find('button[data-toggle="popover"]')

    # Hide popover when clicking anywhere else
    document.click () ->
      popover.hide()

    # Assign the popover display toggling to the trigger button
    trigger.click (ev) ->
      ev.stopPropagation()
      popover.toggle()

    # Prevent the popover from hiding itself when clicked
    popover.click (ev) ->
      ev.stopPropagation()

    # Assign the positioning of the popover below the trigger
    popover.css
      top: trigger.height()




    _this = this


    # Get Favorites
    $scope.currentAppId = ''


    # Get Menu
    _this.getMenuWs = {
      menuWs: (success, error) ->
        MXMenuService.loadMenu(success, error)
    }

    $scope.appCode = appCode

    $scope.getMenuList = () ->
      _this.success = (data) ->
        $scope.menu = data[0].items
        return data
      _this.error = (status) ->
        console.log('menu did not load')

      _this.getMenuWs.menuWs(_this.success, _this.error)

    # load menu on page load
    $scope.getMenuList()


    $scope.checkIfAppExists = (appId) ->
      for menuItem in $scope.menu
        if menuItem.code == appCode
          return true

      return false

    $scope.menu = {}

    $scope.deleteFunc = (id) ->
      return true

    $scope.openSettings = () ->
      # Angular Bootstrap Modal Window
      modalWindow = $templateCache.get "template/modal/window.html"
      if (modalWindow.indexOf '<div class="modal-dialog">') < 0
        isModalBootstrap2 = true
      else
        isModalBootstrap2 = false

      # Might need to add some sort of detection for angular-bootstrap bs3 and bs2
      template = """
        <div class="modal-content">
          <div class="modal-body">
            <button type="button" data-dismiss="modal" aria-hidden="true" ng-click="cancel()" class="close profile-close-button"> ×</button>
            <h1>Settings</h1>

            <div class="no-top-padding no-bottom-padding">
              <user-settings delete-func="deleteFunc" />
            </div>
          </div>
        </div>
      """

      if isModalBootstrap2
        template = '<div class="modal-dialog"><div class="modal-content">' + template + '</div></div>'

      $modal.open
        template: template
        controller: "SettingsModalCtrl"
        resolve: {
          deleteFunc: () ->
            return $scope.deleteFunc
        }

    # @TODO: Temporarily hardcoding this. This will be moved to the web service.
    $scope.companyList =
      "30": "Afh, Inc."
      "20": "Allegiant Air, LLC"
      "32": "Allegiant Systems, Inc."
      "25": "Allegiant Travel Company"
      "22": "Allegiant Vacations, LLC"
      "00": "Consolidated"
      "15": "Sfb Fueling, LLC"
      "27": "Sunrise Asset Management, LLC"

    callbacks =
      userSuccess: (user) ->
        $scope.user = user

        if !!$scope.companyList[$scope.user.company]
          $scope.user.companyName = $scope.companyList[$scope.user.company]
        else
          $scope.user.companyName = $scope.companyList["20"]

      userError: (data, status, headers, config) ->
        $scope.message =
          level: "danger"
          message: data.message or "Could not retrieve user"
          tagline: "Error"
          icon: "remove"
          action: ''
          status: status or 500

    UserProvider.getUser().then callbacks.userSuccess, callbacks.userError

    return
]

user.controller "SettingsModalCtrl", [
  '$scope'
  '$modalInstance'
  'deleteFunc'
  ($scope, $modalInstance, deleteFunc) ->
    $scope.deleteFunc = deleteFunc

    $scope.cancel = () ->
      $modalInstance.dismiss()

]

user.directive "userDropdown", () ->
  restrict: 'EA'
  replace: true
  scope: {}
  controller: 'UserCtrl'
  template: """
    <div id="user-btn-group" class="btn-group pull-right">
      <button type="button" class="btn" data-toggle="popover">
        <i class="icon-user"></i>
        {{user.name}}
        <span class="fa fa-angle-down"></span>
      </button>
      <div g4plus-forbidden="g4plus-forbidden" user="user.roles" class="popover bottom pull-left">
        <p ng-show="message.message" class="alert alert-{{message.level}} margin-left margin-right margin-top">
          <i ng-if="message.level == \'success\'" class="icon-ok-circle"></i>
          <i ng-if="message.level == \'danger\'" class="icon-remove"></i>
          <strong ng-if="message.level == \'success\'">Success: </strong>
          <strong ng-if="message.level == \'danger\'">Error: </strong>
          <span> {{message.message}}.</span>
          <span ng-if="message.status">(Status: {{ message.status }})</span>
        </p><div class="arrow"></div>
        <div class="popover-content" ng-if="user">
          <h4 class="text-center pad-top">{{user.companyName}}</h4>
          <div class="user-info">
            <div class="user-id">
              <h2 class="col-sm-12">{{user.name}}</h2><h4>{{user.aisId}}</h4>
            </div>
          </div>

          <div class="no-right-padding pad-top no-left-padding no-bottom-padding user-nav favorites-nav clearfix">
            <a href="javascript:void(0);" ng-click="openSettings()" class="settings-block pull-left">
              <i class="icon-cogs text-center"></i> Settings
            </a><div class="vertical-line"></div>
            <a href="#/login/logout" class="logout-block pull-right">
              <i class="icon-signout"></i> Logout
            </a>
          </div>
        </div>
      </div>
    </div>
  """