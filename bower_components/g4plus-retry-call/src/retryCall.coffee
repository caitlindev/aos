# * @fileoverview This file contains the g4plus.retry-call module (handles http interception and reports status)
# * @author Taylor Kaplan (taylor.kaplan@allegiantair.com)
# * @module g4plus.retry-call
retryModule = angular.module 'g4plus.retry-call', ['ui.bootstrap']

retryModule.factory 'RetryCall', ($q, $rootScope) ->
  # _requests: hash of all outgoing _requests configs
  _requests = {}
  # _failedRequests: hash of failed response objects
  _failedRequests = {}
  # _successfulRequests: hash of successful response objects
  _successfulRequests = {}
  # _uniqueId: an autoincrementing id that keeps track of all _requests
  _uniqueId = 0

  # RetryCall Factory returns an object which is mandated
  # by the $http interceptor api. To allow access to the
  # factories public methods, we must do it through the
  # returned objects properties.
  interceptObject = {
    # appendSuccessfulRequest
    # ------
    # Appends a successful response object to the successful request hash
    # * @param{object} response Response object returned to interceptor
    'appendSuccessfulRequest': (response) ->
      if response.config.requestId isnt undefined
        _successfulRequests[response.config.requestId] = response
        $rootScope.$broadcast('RetryCall:successfulRequests', _successfulRequests)
      return
    # getSuccessfulRequest
    # ------
    # Returns successful response object
    # * @param{integer} _uniqueId Autoincremented unique request id
    'getSuccessfulRequest': (_uniqueId) ->
      _successfulRequests[_uniqueId]
    # getSuccessfulRequests
    # ------
    # Returns successful _requests hash
    'getSuccessfulRequests': () ->
      _successfulRequests
    # deleteSuccessfulRequest
    # ------
    # Deletes successful response object in successful request hash
    # * @param{integer} _uniqueId Autoincremented unique request id
    'deleteSuccessfulRequest': (_uniqueId) ->
      delete _successfulRequests[_uniqueId]
      $rootScope.$broadcast('RetryCall:successfulRequests', _successfulRequests)
      return
    # hasSuccessfulRequest
    # ------
    # Returns true if successful response obj exists. False if not.
    # * @param{integer} _uniqueId Autoincremented unique request id
    'hasSuccessfulRequest': (_uniqueId) ->
      _successfulRequests[_uniqueId] isnt undefined
    # clearSuccessfulRequest
    # ------
    # Clears successful requests
    'clearSuccessfulRequests': () ->
      _successfulRequests = {}
      $rootScope.$broadcast('RetryCall:successfulRequests', _successfulRequests)
      _successfulRequests
    # appendRequest
    # ------
    # Appends a failed request object to the request hash
    # * @param{object} config Configuration object sent to $http()
    'appendRequest': (config) ->
      # Add request if not present in _requests array
      config.requestId = _uniqueId
      _requests[_uniqueId] = config
      _uniqueId++
      $rootScope.$broadcast('RetryCall:requests',_requests)
      return
    # getRequest
    # ------
    # Returns request object
    # * @param{integer} _uniqueId Autoincremented unique request id
    'getRequest': (_uniqueId) ->
      _requests[_uniqueId]
    # getRequests
    # ------
    # Returns _requests hash
    'getRequests': () ->
      _requests
    # deleteRequest
    # ------
    # Deletes request in _requests hash
    # * @param{integer} _uniqueId Autoincremented unique request id
    'deleteRequest': (_uniqueId) ->
      delete _requests[_uniqueId]
      $rootScope.$broadcast('RetryCall:requests',_requests)
      return
    # hasRequest
    # ------
    # Returns true if request object exists in _requests hash. False if not.
    # * @param{integer} _uniqueId Autoincremented unique request id
    'hasRequest': (_uniqueId) ->
      _requests[_uniqueId] isnt undefined
    # clearRequests
    # ------
    # Clears all pending requests
    'clearRequests': () ->
      _requests = {}
      $rootScope.$broadcast 'RetryCall:requests', _requests
      _requests
    # appendFailedRequest
    # ------
    # Appends failed response object to failed _requests hash.
    # * @param{object} response Response object given to interceptor.
    'appendFailedRequest': (response) ->
      # Add _requests to manual _requests
      if _failedRequests[response.config.requestId] is undefined
        response.attempts = 0
        response.timeleft = 5
        _failedRequests[response.config.requestId] = response
        interceptObject.deleteRequest response.config.requestId
      $rootScope.$broadcast('RetryCall:failedRequests',_failedRequests)
      return
    # getFailedRequest
    # ------
    # Returns failed response object
    # * @param{integer} _uniqueId Autoincremented unique request id
    'getFailedRequest': (_uniqueId) ->
      _failedRequests[_uniqueId]
    # getFailedRequests
    # ------
    # Returns failed response hash.
    'getFailedRequests': () ->
      _failedRequests
    # deleteFailedRequest
    # ------
    # Deletes failed response object from failed response hash
    # * @param{integer} _uniqueId Autoincremented unique request id
    'deleteFailedRequest': (_uniqueId) ->
      delete _failedRequests[_uniqueId]
      $rootScope.$broadcast('RetryCall:failedRequests',_failedRequests)
      return
    # hasFailedRequest
    # ------
    # Returns true if failed response object in failed responses hash. False if not.
    # * @param{integer} _uniqueId Autoincremented unique request id
    'hasFailedRequest': (_uniqueId) ->
      _failedRequests[_uniqueId] isnt undefined
    # clearFailedRequests
    # ------
    # Clears failed requests
    'clearFailedRequests': () ->
      _failedRequests = {}
      $rootScope.$broadcast('RetryCall:failedRequests', _successfulRequests)
      _failedRequests
    # request
    # ------
    # Intercepts request
    # * @param{object} config Config object for $http()
    'request': (config) ->
      if config.hasOwnProperty('requestId') isnt true
        interceptObject.appendRequest(config)
      config || $q.when(config)
    # requestError
    # ------
    # Intercepts request errors
    # * @param{object} rejection Object passed when there is an error in the request
    'requestError': (rejection) ->
      $q.reject rejection
    # response
    # ------
    # Intercepts responses
    # * @param{response} response Response object passed
    'response': (response) ->
      if response.status < 300
        requestId = response.config.requestId
        if response.config.hasOwnProperty('retrySuccess')
          $q.when response.config.retrySuccess(response.data,response.status,response.headers(),response.config)
        # We finished the request so take it out of the queue
        if _requests.hasOwnProperty(requestId)
          interceptObject.deleteRequest(requestId,1)
        else if _failedRequests.hasOwnProperty(requestId)
          interceptObject.deleteFailedRequest(requestId,1)
        if response.config.method.toUpperCase() isnt 'GET'
          # Our countdown timere
          response.timeleft = 5
          interceptObject.appendSuccessfulRequest(response)
      response || $q.when(response)
    # responseError
    # ------
    # Intercepts response errors. Triggered for 400 >= status.
    # * @param{object} response Response object
    'responseError': (response) ->
      # Retry request if automatic attempts > 0
      if !response.config?
        return $q.reject(response)
      else if response.config.hasOwnProperty('automaticAttempts') and response.config.automaticAttempts > 0
        response.config.automaticAttempts--
        $http(response.config)
      else if response.config.hasOwnProperty('requestId')
        interceptObject.appendFailedRequest(response)
      $q.reject(response)
  }

  return interceptObject

retryModule.factory 'ServiceIdDispenser', () ->
  _currentServiceId = 0

  getId: (callback) ->
    _currentServiceId++
    if callback?
      callback _currentServiceId
    return _currentServiceId


retryModule.factory 'CriticalErrorManager', ['$rootScope', 'RetryCall', ($rootScope, RetryCall) ->
  _criticalErrors = {}
  _serviceLock = null
  $rootScope.$on 'RetryCall:failedRequests', (fr) ->
    _criticalErrors = {}
    failedRequests = RetryCall.getFailedRequests()
    for key, request of failedRequests
      if request.config.critical? and (request.config.critical is true or request.config.critical is 'true')
        _criticalErrors[request.config.requestId] = request
    $rootScope.$broadcast 'CriticalErrorManager:criticalErrors'

  CriticalErrorManager =
    getCriticalErrors: (serviceId) ->
      if !_serviceLock?
        _serviceLock = serviceId
        return _criticalErrors
      else if serviceId is _serviceLock
        return _criticalErrors
      else
        throw 'lock already acquired'
      return

    deleteCriticalError: (serviceId, requestId) ->
      if _serviceLock is null
        _serviceLock = serviceId
        return _criticalErrors
      else if serviceId is _serviceLock
        # Clean up references to free up memory
        delete _criticalErrors[requestId]
        RetryCall.deleteFailedRequest requestId
      else
        throw 'lock already acquired'
      return
]

retryModule.directive 'retryCall', [
  '$http'
  '$rootScope'
  '$location'
  '$interval'
  'RetryCall'
  'ServiceIdDispenser'
  'CriticalErrorManager'
  ($http, $rootScope, $location, $interval, RetryCall, ServiceIdDispenser, CriticalErrorManager) ->
    restrict: 'EA'
    scope:
      retryId: "@"
      showUrl: "="
      filterStatus: "="
      clearErrorsOnViewChange: "="
      clearSuccessOnViewChange: "="
      showSuccessfulRequests: "="
      showFailedRequests: "="
      taglineForError: "@"
      taglineForSuccess: "@"
      defaultErrorMessage: "@"
      defaultSuccessMessage: "@"
    template: """
              <div>
                <div ng-repeat="request in successfulRequests">
                  <div class="alert alert-success" ng-if="correctRetryId(request) && showSuccess()">
                    <strong>
                      <i ng-click="closeSuccess(request.config)" class="icon-ok-circle" style="cursor:pointer">&nbsp;</i>
                      <span> {{ getTaglineForSuccess() }} {{ successMessage(request.config) }} {{url(request)}} </span>
                      <button type="button" class="close" ng-click="closeSuccess(request.config)">
                        x
                      </button>
                    </strong>
                  </div>
                </div>
                <div ng-repeat="request in failedRequests">
                  <div class="alert alert-danger" ng-if="correctRetryId(request) && showFailed() && isNotCritical(request.config) && filterErrors(request)">
                    <strong>
                      <span ng-show="!request.data.message">{{getTaglineForError()}} {{ errorMessage(request.config) }} {{url(request)}}</span>
                        {{ request.data.message }}
                        Request attempts: {{ request.attempts }}
                        Send another request in: {{ request.timeleft }} (seconds)
                      <button ng-click='retry(request.config)' type='button' class='btn btn-danger'>
                        Retry
                      </button>
                      <button type="button" class="close" ng-click="cancel(request.config)">
                        x
                      </button>
                    </strong>
                  </div>
                </div>
                <!-- Critical code goes here -->
                <div ng-if="hasCriticalErrors()">
                  <div class="modal-backdrop fade in" modal-backdrop="" style="z-index: 1040;"></div>
                  <div class="modal fade in" modal-window="" style="z-index: 1050; display: block;">
                    <div class="modal-dialogue" style="position:relative; display:block; height: 100%;">
                      <div class="modal-content" style="margin: auto; max-width: 700px; min-width: 200px; top:25%">
                        <div class="modal-header">
                          <h3>Critical Error</h3>
                        </div>
                        <div class="modal-body">
                          <div class="alert alert-danger" ng-repeat="request in criticalErrors">
                            <strong>
                              <span ng-show="!request.data.message">{{getTaglineForError()}} {{ errorMessage(request.config) }} {{url(request)}}</span>
                                {{ request.data.message }}
                              <button ng-click='retry(request.config)' type='button' class='btn btn-danger'>
                                Retry
                              </button>
                            </strong>
                          </div>
                        </div>
                      </div>
                    </div>
                </div>
                <!-- End of critical code -->
              </div>
          """
    # Directive Controller
    # =====
    # Handles the status report of $http requests
    # - Shows failed requests and counts down until next automatic request attempt
    # - Shows successful, non-GET responses
    # - Allows user to manually retry failed requests
    link: ($scope,$element,$attrs) ->
      # _path: gives us our current url
      _path = $location.path()

      if $scope.filterStatus?
        $scope.filter = $scope.filterStatus
      else
        $scope.filter = []

      getCriticalErrors = (serviceId) ->
        try
          $scope.criticalErrors = CriticalErrorManager.getCriticalErrors serviceId
        catch err
          $scope.criticalErrors = {}

      # _serviceId: used for file locking resources such as displaying critical errors in modal
      _serviceId = ServiceIdDispenser.getId (serviceId) ->
        getCriticalErrors serviceId

      # $scope.failedRequests: sets reference to internal failed requests hash in RetryCall factory
      $scope.failedRequests = RetryCall.getFailedRequests()
      # $scope.failedRequests: sets reference to internal successful requests hash in RetryCall factory
      $scope.successfulRequests = RetryCall.getSuccessfulRequests()
      # $scope.location: keeps a record of which view we are in
      $scope.location =
        view: $location.path()
      # _lock: prevents us from starting multiple intervals when we broadcast a change.
      _lock = true
      # _intervalKey: the key that allows us to stop $interval
      _intervalKey = null

      $scope.getTaglineForError = () ->
        if !$scope.taglineForError?
          return 'Error: '
        $scope.taglineForError

      $scope.getTaglineForSuccess = () ->
        if !$scope.taglineForSuccess?
          return 'Success: '
        $scope.taglineForSuccess

      $scope.showSuccess = () ->
        return !$scope.showSuccessfulRequests? or $scope.showSuccessfulRequests

      $scope.showFailed = () ->
        return !$scope.showFailedRequests? or $scope.showFailedRequests

      $scope.hasCriticalErrors = () ->
        Object.keys($scope.criticalErrors).length > 0

      $scope.correctRetryId = (request) ->
        return !$scope.retryId? or request.config.retryId is $scope.retryId

      $scope.url = (request) ->
        if !$scope.showUrl? or !$scope.showUrl
          return ""
        else
          "Url: #{request.config.url}"

      $scope.successMessage = (config) ->
        if !config.successMessage?
          if $scope.defaultSuccessMessage?
            return $scope.defaultSuccessMessage
          else
            return 'Action was successful!'
          return $scope.defaultSuccessMessage
        config.successMessage

      $scope.errorMessage = (config) ->
        if !config.errorMessage?
          if $scope.defaultErrorMessage?
            return $scope.defaultErrorMessage
          else
            return 'There was an error.'
        config.errorMessage

      $scope.isNotCritical = (config) ->
        !(config.critical? and config.critical == true or config.critical == 'true')

      $scope.deleteCriticalError = (request) ->
        try
          CriticalErrorManager.deleteCriticalError(request.config.requestId)
        catch err
          return

      # If there are critical errors then we display the critical errors modal
      $scope.$on 'CriticalErrorManager:criticalErrors', () ->
        getCriticalErrors _serviceId

      # Clear failed requests on view change
      $scope.$on('$locationChangeSuccess',() ->
        if $scope.location.view isnt $location.path()
          if $scope.clearErrorsOnViewChange? and $scope.clearErrorsOnViewChange
            $scope.failedRequests = RetryCall.clearFailedRequests()
          if $scope.clearSuccessOnViewChange? and $scope.clearSuccessOnViewChange
            $scope.successfulRequests = RetryCall.clearSuccessfulRequests()
          $scope.location.view = $location.path()
      )

      $scope.filterErrors = (request) ->
        # Filter on status
        $scope.filter.length is 0 or request.status in $scope.filter

      # $scope.retry
      # -------
      # Allows people to retry http request manually
      # * @param{object} config Config object for $http()
      $scope.retry = (config) ->
        failedRequest = RetryCall.getFailedRequest(config.requestId)
        failedRequest.timeleft = 5
        failedRequest.attempts = 0
        $http(config)
      $scope.closeSuccess = (config) ->
        RetryCall.deleteSuccessfulRequest(config.requestId)
      $scope.cancel = (config) ->
        if config.hasOwnProperty('retryError')
          response = RetryCall.getFailedRequest(config.requestId)
          config.retryError(response.data,response.status,response.headers(),response.config)
        RetryCall.deleteFailedRequest(config.requestId)

      # _countDown
      # ------
      # Responsible for updating timer on scope objects
      _countDown = () ->
        numberOfFailedRequests = Object.keys($scope.failedRequests).length
        numberOfSuccessfulRequests = Object.keys($scope.successfulRequests).length
        if numberOfFailedRequests is 0 and numberOfSuccessfulRequests is 0
          # Stop counting down if there are no more failed requests
          $interval.cancel _intervalKey
          # Re-enable our controller to make intervals
          _lock = true
        # Loop through and decrement timer and increment attempts
        # for failed requests
        for key, request of $scope.failedRequests when !request.config.critical?
          # We don't want several directives counting down on the same request
          # at the same time so we need to allow only one directive to countdown
          # using a directive lock.
          #
          # Countdown lock on our request
          if !request.config.serviceId?
            request.config.serviceId = _serviceId
          else if request.config.serviceId isnt _serviceId
            # We don't hold the countdown lock so we should skip
            continue

          if request.timeleft > 0
            request.timeleft--
          else if request.attempts < 3
            request.attempts++
            request.timeleft = 5
            $http request.config
          else
            RetryCall.deleteFailedRequest key
        # Loop through and decrement timer for successful requests
        for key, request of $scope.successfulRequests
          # We don't want several directives counting down on the same request
          # at the same time so we need to allow only one directive to countdown
          # using a directive lock.
          #
          # Countdown lock on our request
          if !request.config.serviceId?
            request.config.serviceId = _serviceId
          else if request.config.serviceId isnt _serviceId
            # We don't hold the countdown lock so we should skip
            continue

          if request.timeleft > 0
            request.timeleft--
          else
            RetryCall.deleteSuccessfulRequest key

      # _runInterval
      # -----
      # Allows only one _countDown interval to run
      # * @param{object} responses Can either be a successful or failed responses hash
      _runInterval = (responses) ->
        # If there is an interval then _lock will be false
        # and we cannot start another interval.
        if _lock
          # Disable our controller from creating another countdown
          # interval while this one finishes out.
          _lock = false
          _intervalKey = $interval _countDown, 1000
          return

      # This listener is responsible for decrementing our timers and incrementing
      # attempts for our failed requests. We will automatically retry any failed
      # requests after 5 seconds.
      $scope.$on 'RetryCall:failedRequests', _runInterval
      $scope.$on 'RetryCall:successfulRequests', _runInterval
      $scope.$on '$destroy', () ->
        $interval.cancel _intervalKey
]

retryModule.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.interceptors.push('RetryCall')
  return
]