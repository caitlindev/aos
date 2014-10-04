"use strict"

userProfileDirectives = angular.module "user-profile-directives", [
  "g4plus.flash-messages"
]


userProfileDirectives.controller "OverlayMessageCtrl", [
  '$scope'
  '$element'
  '$window'
  ($scope, $element, $window) ->

    overlayMessage =
      width: 0
      height: 0
      init: (width, height) ->
        @width = width
        @height = height
        $element.width(@width).height(@height)
        @addBackdrop()

      positionContent: () ->
        content = $element.find('.overlay-message-content')
        contentWidth = (@width * .8)
        content.css
          "width": contentWidth
          "margin-left": -(contentWidth/2)
          "margin-top": -(content.height()/2)
        return

      addBackdrop: () ->
        $element.find('.backdrop').width(@width).height(@height)

    $scope.reload = () ->
      $window.location.reload()
      return

    $scope.cancel = () ->
      $element.addClass('hide')
      $scope.show = false
      return

    $scope.$watchCollection "[waitFor, show]", () ->
      if !!$scope.waitFor && $scope.show
        container = $element.parent().parent()
        console.log container
        $element.removeClass('hide')
        overlayMessage.init container.width(), container.height()
        overlayMessage.positionContent()

      if !$scope.show
        $element.addClass('hide')

    return
]

userProfileDirectives.directive "reloadNotice", () ->
  restrict: 'EA'
  replace: true
  controller: "OverlayMessageCtrl"
  scope:
    waitFor: '@'
    omNotice: '='
    show: '='
  template: """
    <div class="overlay-message hide">
      <div class="overlay-message-content">
        <div ng-hide="omNotice.message">
          <p>In progress &#8230;</p>
          <div  class="progress progress-striped active">
            <div class="progress-bar" role="progressbar" style="width: 100%"></div>
          </div>
        </div>
        <div ng-show="omNotice.level == 'success'">
          <br/><br/><br/>
          <h3 class="text-danger no-bottom-margin"><strong>{{omNotice.message}}</strong></h3>
          <br/>
          <p>The browser needs to be reloaded for the changes to take effect.</p>
          <div class="clearfix">
            <button class="btn btn-translucent" ng-click="cancel()">Cancel</button>
            <button class="btn btn-primary" ng-click="reload()">Reload Browser</button>
          </div>
        </div>
      </div>
      <div class="backdrop"></div>
    </div>
  """