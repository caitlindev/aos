"use strict"

prefs = angular.module "settings-profile", [
  "g4plus-user"
]

prefs.controller "UserProfileCtrl", [
  '$scope'
  'UserProvider'
  ($scope, UserProvider) ->

    callbacks =
      userSuccess: (user) ->
        $scope.user = user
        $scope.email = user.name
        $scope.email = $scope.email.replace(/\s+/g, '.')

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


prefs.directive "userProfile", () ->
  restrict: 'EA'
  replace: true
  scope: {}
  controller: 'UserProfileCtrl'
  template: """
    <div class="clearfix">
      <div id="row-1" class="col-sm-12">
        <div class="col-sm-4">
          <img id="profile-picture" src="http://cityofthearts.com/assets/img/layout/misc/user-placeholder.png">
        </div>
        <div class="pull-right col-sm-8 profile-user-info">
          <h1 id="user-name" class="profile-user-info">{{ user.name }}</h1>
          <hr class="title-separator"></hr>
          <h3 id="user-job-title" class="profile-user-info">{{user.department.toUpperCase()}}</h3>
          <h4 id="user-id" class="profile-user-info"><container id="profile-user-id">{{ user.aisId }}</container></h4>
        </div>
      </div>
      <div id="row-2" class="col-sm-12">
       <ul class="list-unstyled">
        <li class="pull-left col-sm-12">
          <span>
            <div class="col-sm-5 no-right-padding no-left-padding">user type</div>
            <div class="profile-details col-sm-7">{{user.userType}}</div>
          </span>
        </li>
        <li class="pull-left col-sm-12">
          <span>
            <div class="col-sm-5 no-right-padding no-left-padding">employee group</div>
            <div class="profile-details col-sm-7">{{user.employeeGroup}}</div>
          </span>
        </li>
        <li class="pull-left col-sm-12">
          <span>
            <div class="col-sm-5 no-right-padding no-left-padding">department</div>
            <div class="profile-details col-sm-7">{{user.department}}</div>
          </span>
        </li>
        <li class="pull-left col-sm-12">
          <span>
            <div class="col-sm-5 no-right-padding no-left-padding">email</div>
            <div id="user-email" class="profile-details col-sm-7">{{ email }}@allegiantair.com</div>
          </span>
        </li>
       </ul>
      </div>
    </div>
  """
