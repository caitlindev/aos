"use strict"

settings = angular.module "settings", [
  "ngCookies"
  "settings-preferences"
  "settings-profile"
  "settings-favorites"
]

settings.factory "DevRolesModule", [
  '$cookies'
  '$location'
  '$cookieStore'
  ($cookies, $location, $cookieStore) ->
    isDev: (forceDev) ->
      isDev = forceDev or false
      environments = ["sbx", "int", "qat", "dev"]

      # Check for cookie-based environment indication
      for e in environments
        if !!$cookies["_ais_" + e]
          isDev = true
          break

      # If not dev environment, check the $location.host()
      if !isDev
        host = $location.host()
        if host == 'localhost'
          isDev = true
        else
          for e in environments
            if host.indexOf '.' + e + '.'
              isDev = true
              break

      return isDev

    getDevRoles: () ->
      devRolesDirective =
        nav: null
        tabContent: null
#      kill roles for now
#      if @isDev()
#        try
#          devRolesModule = angular.injector [
#              "ng"
#              "g4plus-user"
#              "g4plus.flash-messages"
#              "settings-devroles"
#              "ui.bootstrap"
#            ]
#          devRolesModule.invoke ($compile) ->
#            devRolesDirective.nav = $compile '<li><a href="javascript:void(0);" ng-click="showContent(\'user-details-devroles\', $event)" class="current"><i class="icon-lock"></i> Roles</a></li>'
#            devRolesDirective.tabContent = $compile '<div id="user-details-devroles" class="tab-pane active"><user-dev-roles /></div>'
#        catch error
#          if !!window.console
#            console.log error.message
#
#      return devRolesDirective
]

settings.controller "UserSettingsCtrl", [
  '$scope'
  '$element'
  'DevRolesModule'
  ($scope, $element, DevRolesModule) ->

    settingsNav = $element.find('.nav')
    tabContents = $element.find('.tab-content')

    $scope.showContent = (contentId, ev) ->

      # Make all not current
      settingsNav.find('a').removeClass('current')

      # Hide all content except contentId
      tabContents.children('div:not(#' + contentId + ')').hide()

      # Clicked element, Self
      navEl = angular.element ev.currentTarget
      navEl.addClass('current')

      # Click element's corresponding content tab-pane
      navContent = tabContents.children('#' + contentId)
      navContent.fadeIn(100)

      return

    devRolesModule = DevRolesModule.getDevRoles()

    if !!devRolesModule.nav and !!devRolesModule.tabContent
      settingsNav.append(devRolesModule.nav($scope))
      tabContents.append(devRolesModule.tabContent($scope))
    else
      ev = jQuery.Event "click"
      ev.currentTarget = settingsNav.find('a:first')
      $scope.showContent('user-details-profile', ev)

    return
]

settings.directive "userSettings", () ->
  restrict: 'EA'
  replace: true
  scope: {
    favoritesData: "=favoritesData"
    deleteFunc: "=deleteFunc"
  }
  controller: "UserSettingsCtrl"
  template: """
    <div id="user-settings" class="clearfix">
      <ul class="nav col-sm-3">
        <li><a href="javascript:void(0);" ng-click="showContent('user-details-profile', $event)"><i class="icon-user"></i> Profile</a></li>
        <li><a href="javascript:void(0);" ng-click="showContent('user-details-preferences', $event)"><i class="icon-cog"></i> Preferences</a></li>
        <!--<li><a href="javascript:void(0);" ng-click="showContent('user-details-favorites', $event)"><i class="icon-heart"></i> Favorites</a></li>-->
      </ul>
      <div class="user-details col-sm-9">
        <div class="tab-content">
          <div id="user-details-profile" class="tab-pane"><user-profile /></div>
          <div id="user-details-preferences" class="tab-pane"><user-preferences /></div>
          <div id="user-details-favorites" class="tab-pane"><user-favorites favorites-data="favoritesData" delete-func="deleteFunc" /></div>
        </div>
      </div>
    </div>
  """
  link: (scope, el, attr) ->
#    console.log(scope.favoritesData)