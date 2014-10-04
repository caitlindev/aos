"use strict"

devRoles = angular.module "settings-devroles", [
  "g4plus.flash-messages"
  "user-profile-directives"
]

devRoles.factory "Roles", [
  '$http'
  ($http) ->
    list: (s, e) ->
      $http.get("/api/g4-auth-web/v1/api/role")
        .success(s).error(e)
      return

    post: (data, s, e) ->
      data = data || {}
      $http.post("/api/login/roles/test", data)
        .success(s).error(e)
      return
]

devRoles.controller "PermissionsCtrl", [
  '$scope'
  '$element'
  '$timeout'
  'UserProvider'
  'Roles'
  'FlashStorage'
  ($scope, $element, $timeout, UserProvider, Roles, FlashStorage) ->

    localDigest = () ->
      # @TODO: Find out why a $digest() is required
      # here on an "injected module call" in a modal.
      # It seems that putting this injected module
      # on a modal requires the $digest because it's somehow
      # outside of the "Angular" world now.
      try
        $scope.$digest()
      catch error
        error

    callbacks =
      userSuccess: (user) ->
        $scope.user = user

        # Get all roles
        calls.getRoles()

        #localDigest()

      userError: (data, status, headers, config) ->
        FlashStorage.set
          level: "danger"
          message: data.message or "Could not retrieve user"
          tagline: "Error"
          icon: "remove"
          status: status or 500
          view: 'settings-roles'
        $scope.notice = FlashStorage.get 'settings-roles'

        localDigest()

      rolesSuccess: (result) ->
        $scope.roles = result.items
        $scope.roles.push
          id: "15"
          name: "Dev Sudo"
          code: "dev_sudo"

        localDigest()

        if !!$scope.user.roles and !!$scope.user.roles.length

          # Check the corresponding inputs based on incoming roles
          for role in $scope.user.roles
            $scope.updateSelected role
            $element.find('input[name="' + role + '"]').attr('checked', true)

        return

      rolesError: (data, status, headers, config) ->
        FlashStorage.set
          level: "danger"
          message: data.message or "Could not retrieve roles"
          tagline: "Error"
          icon: "remove"
          status: status or 500
          view: 'settings-roles'
        $scope.notice = FlashStorage.get 'settings-roles'
        localDigest()

      postRolesSuccess: (result) ->
        $scope.notice =
          level: 'success'
          icon: 'ok-circle'
          tagline: 'Success'
          message: "Roles were updated successfully!"
          action: 'updated'
        $scope.userRolesForm.$pristine = true

        localDigest()
        return

      postRolesError: (data, status, headers, config) ->
        $scope.showOverlay = false
        FlashStorage.set
          level: "danger"
          message: data.message or "Roles update failed"
          tagline: "Error"
          icon: "remove"
          status: 400
          view: 'settings-roles'
        $scope.notice = FlashStorage.get 'settings-roles'
        localDigest()
        return

    i = 0

    calls =
      getUser: () ->
        UserProvider.getUser().then callbacks.userSuccess, callbacks.userError
        return

      getRoles: () ->
        Roles.list callbacks.rolesSuccess, callbacks.rolesError
        return

      postRoles: (data) ->
        $scope.notice = null
        $scope.showOverlay = true

        # Test only
        $timeout (() ->
          if i < 2
            callbacks.postRolesError({}, null, null, null)
          else
            callbacks.postRolesSuccess($scope.user)
          i++
          $scope.$apply()
        ), 1000

        # Roles.post data, callbacks.postRolesSuccess, callbacks.postRolesError

        return

    $scope.roles = []
    $scope.selectedRoles = []

    $scope.updateSelected = (val, ev) ->
      if !!ev
        $scope.userRolesForm.$pristine = false

      # @NOTE: Apparently, '.indexOf is not supported in IE8
      index = $.inArray val, $scope.selectedRoles
      if index < 0
        $scope.selectedRoles.push val
      else
        $scope.selectedRoles.splice index, 1

      return

    $scope.postRoles = (data) ->
      calls.postRoles(data)

    # Get current user's roles
    calls.getUser()

    return
]

devRoles.directive "userDevRoles", () ->
  restrict: 'EA'
  replace: true
  controller: "PermissionsCtrl"
  scope:
    roles: '&'
  template: """
    <div>
      <h2>Roles</h2>
      <div class="form-container">
        <div reload-notice wait-for="{{roles}}" om-notice="notice" show="showOverlay"></div>
        <div ng-show="notice[0].level">
          <div flash-message message="notice"></div>
        </div>
        <form ng-show="roles.length" class="form-horizontal" name="userRolesForm" ng-submit="postRoles(selectedRoles)">
          <fieldset>
            <ul class="list-unstyled lined roles clearfix" style="border-radius: 0 !important">
              <li ng-repeat="role in roles" class="dev-roles-list col-sm-6 no-right-padding no-left-padding no-bottom-padding">
                <label for="role-{{role.id}}"><span><span></span></span>
                  {{role.name}}
                  <input id="role-{{role.id}}" type="checkbox" name="{{role.code}}" ng-click="updateSelected(role.code, $event)" />
                  <span></span>
                </label>
              </li>
            </ul>
          </fieldset>
          <fieldset class="form-actions">
            <input type="submit" value="Confirm Edit Roles" ng-disabled="userRolesForm.$pristine" class="btn btn-primary pull-right"/>
            <input type="reset" value="Reset Roles" class="btn btn-translucent pull-right margin-right" ng-hide="userRolesForm.$pristine" />
          </fieldset>
        </form>
      </div>
    </div>



  """



