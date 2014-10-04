'use strict'

forbidden = angular.module 'g4plus-forbidden.directive', [
  'ui.router'
]

forbidden.config ($stateProvider) ->
  # Forbidden
  # =========
  # Forbidden template
  $stateProvider.state 'forbidden', {
    url: '/forbidden'
    template: '''
      <html>
        <head>
          <title>403 - Forbidden</title>
        </head>
        <body>
          <div class="row">
            <div class="msgWrap">
              <a id="drawing" href="#nogo">
                <span id="forbidden_container">
                  <span id="pencil">
                    <span id="cap"></span>
                    <span class="penl"><span class="penlbot"></span></span>
                    <span id="penm"><span class="penmbot"></span></span>
                    <span class="penl"><span class="penlbot"></span></span>
                    <span id="pencut"></span>
                    <span class="pennib"></span>
                    <span id="lead"></span>
                    <span class="pennib"></span>
                  </span>
                  <span id="line">This is where we draw the line: Error Code 403 - Forbidden</span>
                </span>
              </a>
            </div>
          </div>
          <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-2">
              <div class="btn btn-translucent margin-right-large"><a href="javascript:void(0);" onclick="window.close();">Close</a></div>
              <div class="btn btn-primary pull-right"><a href="">Login</a></div>
            </div>
            <div class="col-md-5"></div>
          </div>
        </body>
      </html>
    '''
  }

# Directive
forbidden.directive 'g4plusForbidden', [
  '$state',
  ($state) ->
    restrict: 'A'
    replace: true
    scope: {
      user: '=user'
    }

    controller: ($scope, $rootScope, $location, $timeout) ->
      $scope.getAppPerms = (permissionsList) ->
        console.log $state.$current
        # Intersect permissions list with user's roles.
        role_matches_permslist = _.intersection(permissionsList, $scope.user).length > 0
        # If intersection false, deny access.
        if not role_matches_permslist
          $location.url '/forbidden'

      $rootScope.$on "$stateChangeSuccess", () ->
        # Check if user comes in sideways to a deeper url within the app
        if $state.$current.data?.permissions?
          $timeout(() ->
            # Delayed to work around async issues...
            #TODO Refactor to run non-async
            $scope.getAppPerms($state.$current.data.permissions)
          , 300)

        # Check user access to the app generically
        if $rootScope.permissions?
          $timeout(() ->
            # Delayed to work around async issues...
            #TODO Refactor to run non-async
            $scope.getAppPerms($rootScope.permissions)
          , 300)
]
