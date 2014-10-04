flashModule = angular.module('g4plus.flash-messages', ['error.modal'])

flashModule.factory 'FlashStorage', () ->

  #
  # Message is structured as an object with the following elements
  #
  # Required
  #  * level: One of ['success', 'info', 'warning', 'danger']
  #  * message: the message to show
  #
  # Optional:
  #  * tagline: ['Success', 'Warning', 'Error']
  #  * icon: ['ok-circle', 'exclamation-sign', 'remove']
  #  * status: Http code
  #  * critical: [true, false]
  #  * retry: [true, false]
  #  * ws: Url for retry function
  #  * callback: the function you want to call on successful retry
  #  * view: set the view you wish the message to be diisplayed in [list, view, edit]

  # Expample
# in controller
#  --------------
# errorCallback = (data, status, config, header) ->
#  $scope.flashMessage = FlashStorage.set(
#    level: 'danger'
#    status: status or '500'
#    message: data.message or 'List could not be retrieved'
#    ws: config.url
#    critical: true
#    callback: $scope.getList
#    view: 'list'
#  )
#  $scope.flashMessage = FlashStorage.get('list')
#  in jade
#  ----------
#  p(flash-message, message="flashMessage")
  messages = {}
  count = 0

  set: (mes) ->
    mes['id'] = count++

    # Setup a default que name if none set. All flash messages will go in a que.
    mes.view = "view-default" unless mes.view
    mes['unique'] = "#{mes.message} #{mes.view}"

    # Initialize flash message que as empty array. This is done only once on
    # further requests the array will be reset while keeping the original array
    # reference !
    #  messages['view'].length = 0
    if not messages?[mes.view]
      messages[mes.view] = []

    _.forEach messages, (value, key) ->
      if key isnt mes.view
        # Reset flash message que array not for current view
        value.length = 0
      else
        # Clear up duplicate messages before pushing the new one
        pos = -1
        _.forEach value, (msg, index) ->
          pos = key if mes.unique is msg.unique
        value.splice pos, 1 if pos isnt -1

    # Push new flash message in the que
    messages[mes.view].push(mes)

    return messages[mes.view]

  get: (view) ->
    view = "view-default" unless view
    return messages[view]
  clearAll: ->
    _.forEach messages, (value) ->
      value.length = 0
    return
  clear: (x, field) ->
    field = "id" unless field
    _.forEach messages, (value) ->
      pos = -1
      _.forEach value, (msg, key) ->
        pos = key if msg[field] is x

      value.splice pos, 1 if pos isnt -1
    return

flashModule.directive "flashMessage", () ->
  restrict: "EA"
  replace: true
  scope:
    message: "=message"
  template: """
    <div ng-repeat='item in message track by $index'>
      <div ng-if="item" class="alert alert-{{ item.level }}">
        <i ng-if="item.level == 'success'" class="icon-ok-circle">&nbsp;</i>
        <i ng-if="item.level == 'danger'" class="icon-remove">&nbsp;</i>
        <strong ng-if="item.level == 'success'">Success:&nbsp;</strong>
        <strong ng-if="item.level == 'danger'">Error:&nbsp;</strong>
        <span> {{item.message}}.</span>
        <span ng-if="item.status">(Status: {{ item.status }})</span>
        <span retry-message="retry-message" message="item" callback="item.callback" class=''></span>
        <button type="button" aria-hidden="true"
                ng-click="clearMessage(item.id)" class="close" >&times;</button>
      </div>
    </div>
  """
  controller: ($scope, FlashStorage, $timeout) ->
    # Make sure we watch the message que array for changes and correctly
    # setup the clear handler.
    # This is for items that are inserted after the directive was loaded.
    $scope.$watch 'message', (new_value) ->
      if $scope.message != undefined
        _.forEach $scope.message, (item) ->
          if item != undefined and item.status != 500
            itemId = item.id
            $timeout (->
              $scope.clearMessage(itemId)
            ), 5000
    , true

    $scope.clearMessage = (x) ->
      FlashStorage.clear(x)

flashModule.directive 'retryMessage', ($http, FlashStorage, $timeout) ->
  restrict: 'EA'
  scope:
    message: '=message'
    callback:'=callback'
  template: """
    <span ng-if="count" ng-hide='retryBtn'>
      <strong>Retry:</strong>
      <span>{{count}} in {{countDown}}</span>
    </span>
    <span ng-if="retryBtn">
      <strong>Retries Failed:</strong>
      <span class='btn btn-default' ng-click='retry(message, 0)'>Retry</span>
    </span>
  """
  link: (scope, element, attrs) ->
    scope.$watch 'message.message', (->
      if scope.message != undefined and scope.message.status == 500 and scope.message.retry == true and scope.message.critical != true
        $timeout (->
          scope.retry(scope.message, 0)
        ), 1000
      if scope.message != undefined and scope.message.status == 500 and scope.message.critical == true
        $timeout (->
          scope.failGetModal(scope.message)
        ), 1000
    ),true

    scope.countDownTimer = (seconds, done) ->
      scope.countDown = seconds
      if seconds > 0
        run = () ->
          scope.countDownTimer(scope.countDown - 1, done)
          scope.$digest()
        $timeout( run, 1000 )
      else
        done()
    scope.retry = (message, x) ->
      scope.count = x
      scope.success = (data, status, header, config) ->
        message.callback()
        scope.clearMessage(scope.message.id)
      scope.error = (data, status, header, config) ->
        scope.count = scope.count + 1
        if scope.count < 4
          scope.countDownTimer(5, () -> scope.retry(scope.message, scope.count))
        else
          scope.retryBtn = true
          $timeout (->
            if scope.count != 1
              scope.clearMessage(scope.message.id)
          ), 5000
      if scope.count < 4
        scope.retryBtn = false
        $timeout (->
          $http.get(message.ws).success(scope.success).error(scope.error)
        ), 1000
  controller: ($scope, FlashStorage, $modal) ->
    $scope.failGetModal = (message) ->
      $scope.clearMessage(message.id)
      modalInstance = $modal.open
        template: """
           <div class="modal-header">
              <h1><span class="alg-blue">Critical Error</span></h1>
           </div>
           <form class="form-horizontal clearfix">
              <div class="modal-body no-bottom-padding">
                <div ng-show="retryBtn == false" class="alert alert-danger"><strong>Error:</strong>
                  <span>Unable to load information. Retry attempt {{tries}} in {{countDown}}</span>
                </div>
                <div ng-if="retryBtn == true" class="alert alert-danger"><strong>Error:</strong>
                  <span>Retry attempts failed.&nbsp;</span>
                </div>
                <fieldset class="modal-footer footer form-actions row">
                    <button ng-click="retryAgain()" class="btn btn-default pull-right" ng-show='retryBtn == true'>Retry</button>
                </fieldset>
              </div>
           </form>
        """
        controller: "errorModalCtrl"
        resolve:
          urlData: -> message.ws
      modalInstance.result.then () ->
        message.callback()

    msgId = $scope.message?.id
    if $scope.message != undefined and $scope.message.status != 500
      $timeout (->
        $scope.clearMessage(msgId)
      ), 5000
    if $scope.message != undefined and $scope.message.retry != true
      $timeout (->
        $scope.clearMessage(msgId)
      ), 5000
    $scope.clearMessage = (x) ->
      FlashStorage.clear(x)

errorModal = angular.module("error.modal", [])

errorModal.controller 'errorModalCtrl', ($scope,$modalInstance, urlData, $http, $timeout) ->

  $scope.retryBtn = false

  $scope.urlData = urlData
  $scope.tries = 0
  countdown = (seconds, done) ->
    $scope.countDown = seconds
    if seconds > 0
      run = () -> countdown seconds - 1, done
      $timeout( run, 1000 )
    else
      done()
  $scope.reloadWS = () ->
    $http.get($scope.urlData).success($scope.retryDmiSuccess).error($scope.retryDmiError)
  $scope.retryDmiSuccess = (data, status, header, config) ->
    window.location.reload()
  $scope.retryDmiError = (data, status, header, config) ->
    $scope.tries = $scope.tries + 1
    if $scope.tries < 4
      countdown(5, () -> $scope.reloadWS())
    else
      $scope.retryBtn = true
  $scope.reloadWS()

  $scope.retryAgain = ->
    window.location.reload()