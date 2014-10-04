"use strict"

prefs = angular.module "settings-preferences", [
  "user-profile-directives"
  'LocalStorageModule'
]

prefs.config [
  "localStorageServiceProvider"
  (localStorageServiceProvider) ->
    localStorageServiceProvider.setPrefix "AOS"
]

prefs.controller "UserPreferencesCtrl", [
  '$scope'
  'localStorageService'
  ($scope, localStorageService) ->

    # Cleanup will happen here after demo from 1st of October 2014. Gabriel Kovacs :)

    # $scope.storageType = "Local storage"
    # $scope.storageType = "Session storage"  if localStorageService.getStorageType().indexOf("session") >= 0
    # $scope.storageType = "Cookie"  unless localStorageService.isSupported

    $scope.showOverlay = false

    $scope.savePreferences = () ->
      $scope.showOverlay = true

    # Get/set default starting value
    localAftAll = localStorageService.get('aftAll')
    $scope.aft = (if (localAftAll isnt "") then localAftAll else true)

    $scope.$watch "hvy", (value) ->
      $scope.hvyValue = localStorageService.get("hvy")
      return

    # initialHvy = (if (localStorageService.get('localhvy') isnt "" or localStorageService.get('localhvy') isnt null) then localStorageService.get('localhvy') else false)
    # $scope.hvy = initialHvy

    $scope.hvy = localStorageService.get("hvy")

    # Need refactor after demo
    $scope.changeStateHvy = (hvy) ->
      localStorageService.set('hvy', hvy)
      $scope.hvy = hvy

    $scope.changeStateBase = (base) ->
      localStorageService.set('base', base)

    $scope.notice =
          level: 'success'
          icon: 'ok-circle'
          tagline: 'Success'
          message: "Preferences were updated successfully!"
          action: 'updated'

]

prefs.directive "userPreferences", () ->
  restrict: 'EA'
  replace: true
  scope: {}
  controller: 'UserPreferencesCtrl'
  template: """
    <div>
      <!-- <h2>Preferences</h2> -->
      <div class="form-container">
        <div reload-notice wait-for="showOverlay" om-notice="notice" show="showOverlay"></div>

        <div class="row">
          <h2>Clock</h2>
          <div class="clock-container">
            <div ng-controller="ClockCtrl" class="btn-group clock">
              <button data-toggle="dropdown" type="button" class="btn dropdown-toggle"><span></span><i class="fa fa-angle-down"></i></button>
              <ul class="dropdown-menu no-padding">
                <li ng-repeat="clock in clockItems"><a href="javascript:void(0);" role="button" ng-click="saveTimeZone(clock); savePreferences()" tooltip-placement="left" tooltip="Set {{clock.zone}} as Default"></a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="row"><h2 class="default-view-title">Default viewing options</h2></div>

        <div class="row fleet-type-container">
          <h4><strong>Aircraft Fleet Type</strong></h4>
          <div class="col-sm-3 first-col">
            <label class="checkbox old">
                <input type="checkbox" ng-model="aftAll" ng-change="changeState(aftAll)"> ALL
            </label>
            <label class="checkbox old">
                <input type="checkbox"> B757
            </label>
          </div>
          <div class="col-sm-9">
            <label class="checkbox old">
                <input type="checkbox"> MD80
            </label>
            <label class="checkbox old">
                <input type="checkbox"> A320 Family
            </label>
          </div>
        </div>

        <div class="row maintenance-station-container">
          <h4><strong>Maintenance Station</strong></h4>
          <div class="col-sm-12 first-col">
              <label class="checkbox old">
                  <input type="checkbox"> ALL
              </label>
          </div>
          <div class="col-sm-3 first-col">
            <label class="checkbox old">
                <input type="checkbox"> EAST
            </label>
          </div>
          <div class="col-sm-9 first-col">
            <label class="checkbox old">
                <input type="checkbox"> WEST
            </label>
          </div>

          <div class="col-sm-3 first-col">
            <label class="checkbox old">
                <input type="checkbox"> NON
            </label>
            <label class="checkbox old">
                <input type="checkbox"> IWA/AZA
            </label>
            <label class="checkbox old">
                <input type="checkbox"> BLI
            </label>
            <label class="checkbox old">
                <input type="checkbox"> FLL
            </label>
            <label class="checkbox old">
                <input type="checkbox"> HNL
            </label>
          </div>

          <div class="col-sm-3">
            <label class="checkbox old">
                <input type="checkbox"> OAK
            </label>
            <label class="checkbox old">
                <input type="checkbox"> LAS
            </label>
            <label class="checkbox old">
                <input type="checkbox"> LAX
            </label>
            <label class="checkbox old">
                <input type="checkbox"> ENV
            </label>
            <label class="checkbox old">
                <input type="checkbox"> MYR
            </label>
          </div>

          <div class="col-sm-3">
            <label class="checkbox old">
                <input type="checkbox" ng-model="sfb" ng-change="changeStateSfb(sfb)"> SFB
            </label>
            <label class="checkbox old">
                <input type="checkbox" ng-model="pie" ng-change="changeStatePie(pie)"> PIE
            </label>
            <label class="checkbox old">
                <input type="checkbox" ng-model="pgd" ng-change="changeStatePgd(pgd)"> PGD
            </label>
            <label class="checkbox old">
                <input type="checkbox" ng-model="hvy" ng-change="changeStateHvy(hvy)"> HVY
            </label>
            <label class="checkbox old">
                <input type="checkbox" ng-model="base" ng-change="changeStateBase(base)"> BASE
            </label>
          </div>

        </div>

      </div>
    </div>
  """
