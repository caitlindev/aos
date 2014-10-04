"use strict"

loadingModule = angular.module "g4plus-loading.directive", [ ]

loadingModule.provider "promiseTracker", ->
  trackers = {}
  @$get = [
    "$q"
    "$timeout"
    ($q, $timeout) ->
      cancelTimeout = (promise) ->
        $timeout.cancel promise  if promise
        return
      promiseTracker = (id) ->
        throw new Error("Tracker with id \"" + id + "\" does not exist! Use promiseTracker.register()")  unless trackers[id]
        trackers[id]
      Tracker = (options) ->
        options = options or {}
        
        #Array of promises being tracked
        tracked = []
        self = this
        
        #Allow an optional "minimum duration" that the tracker has to stay active for.
        minDuration = options.minDuration
        
        #Allow an option "maximum amount of time" that the tracker can stay active.
        maxDuration = options.maxDuration
        
        #Allow a delay that will stop the tracker from activating until that time is reached
        activationDelay = options.activationDelay
        minDurationPromise = undefined
        maxDurationPromise = undefined
        activationDelayPromise = undefined
        self._destroy = ->
          minDurationPromise = cancelTimeout(minDurationPromise)
          maxDurationPromise = cancelTimeout(maxDurationPromise)
          activationDelayPromise = cancelTimeout(activationDelayPromise)
          self.cancel()
          return

        self.active = ->
          
          #Even if we have a promise in our tracker, we aren't active until delay is elapsed
          return false  if activationDelayPromise
          tracked.length > 0

        self.cancel = ->
          
          #Resolve backwards because we splice the tracked array every time resolve is called
          i = tracked.length - 1

          while i >= 0
            tracked[i].resolve()
            i--
          return

        
        #Create a promise that will make our tracker active until it is resolved.
        #@return deferred - our deferred object that is being tracked
        self.createPromise = ->
          
          #If the tracker was just inactive and this the first in the list of
          #promises, we reset our 'minimum duration' and 'maximum duration'
          #again.
          startMinMaxDuration = ->
            minDurationPromise = $timeout(angular.noop, minDuration)  if minDuration
            maxDurationPromise = $timeout(deferred.resolve, maxDuration)  if maxDuration
            return
          
          #Create a callback for when this promise is done. It will remove our
          #tracked promise from the array if once minDuration is complete
          onDone = (isError) ->
            (value) ->
              (minDurationPromise or $q.when()).then ->
                index = $.inArray(deferred, tracked)
                tracked.splice index, 1
                
                #If this is the last promise, cleanup the timeouts
                #for maxDuration and activationDelay
                if tracked.length is 0
                  maxDurationPromise = cancelTimeout(maxDurationPromise)
                  activationDelayPromise = cancelTimeout(activationDelayPromise)
                return

              return
          deferred = $q.defer()
          tracked.push deferred
          if tracked.length is 1
            if activationDelay
              timeoutCallback = ->
                activationDelayPromise = cancelTimeout(activationDelayPromise)
                startMinMaxDuration()
                return
              activationDelayPromise = $timeout timeoutCallback, activationDelay
            else
              startMinMaxDuration()
          deferred.promise.then onDone(false), onDone(true)
          return deferred
          return

        self.addPromise = (promise) ->
          then_ = promise and (promise.then or promise.$then or (promise.$promise and promise.$promise.then))
          throw new Error("promiseTracker#addPromise expects a promise object!")  unless then_
          deferred = self.createPromise()
          
          #When given promise is done, resolve our created promise
          #Allow $then for angular-resource objects
          then_ (success = (value) ->
            deferred.resolve value
            value
          ), error = (value) ->
            deferred.reject value
            $q.reject value

          deferred

        return
      promiseTracker.register = (id, options) ->
        throw new Error("Tracker with id \"" + id + "\" already exists!")  if trackers[id]
        trackers[id] = new Tracker(options)
        trackers[id]

      promiseTracker.deregister = (id) ->
        if trackers[id]
          trackers[id]._destroy()
          delete trackers[id]
        return

      return promiseTracker
  ]
  return

loadingModule.config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.interceptors.push [
      '$q'
      'promiseTracker'
      ($q, promiseTracker) ->
        request: (config) ->
          if config.tracker
            config.tracker = [config.tracker]  unless angular.isArray(config.tracker)
            config.$promiseTrackerDeferred = config.$promiseTrackerDeferred or []
            angular.forEach config.tracker, (trackerName) ->
              deferred = promiseTracker(trackerName).createPromise(config)
              config.$promiseTrackerDeferred.push deferred
              return

          $q.when config

        response: (response) ->
          if response.config and response.config.$promiseTrackerDeferred
            angular.forEach response.config.$promiseTrackerDeferred, (deferred) ->
              deferred.resolve response
              return

          $q.when response

        responseError: (response) ->
          if response.config and response.config.$promiseTrackerDeferred
            angular.forEach response.config.$promiseTrackerDeferred, (deferred) ->
              deferred.reject response
              return

          $q.reject response
    ]
]

loadingModule.run [ "promiseTracker", (promiseTracker) ->
  # Create / get our tracker with unique ID
  promiseTracker.register 'loading'
]

loadingModule.directive "g4plusLoading", [ "promiseTracker", (promiseTracker) ->
  restrict: "A"
  transclude: true
  replace: true
  template: """
    <div id="loading-overlay" style="position: absolute; top: 0; left: 0; background: rgba(0, 0, 0, 0.4); z-index: 9999; width: 100%; height:100%; position: fixed;" ng-show="loadingTracker.active()">
      <div style="position: absolute; top: 50%; left: 50%;"><img src="data:image/gif;base64,R0lGODlhEAAQAPIAAP///wAAAMLCwkJCQgAAAGJiYoKCgpKSkiH/C05FVFNDQVBFMi4wAwEAAAAh/hpDcmVhdGVkIHdpdGggYWpheGxvYWQuaW5mbwAh+QQJCgAAACwAAAAAEAAQAAADMwi63P4wyklrE2MIOggZnAdOmGYJRbExwroUmcG2LmDEwnHQLVsYOd2mBzkYDAdKa+dIAAAh+QQJCgAAACwAAAAAEAAQAAADNAi63P5OjCEgG4QMu7DmikRxQlFUYDEZIGBMRVsaqHwctXXf7WEYB4Ag1xjihkMZsiUkKhIAIfkECQoAAAAsAAAAABAAEAAAAzYIujIjK8pByJDMlFYvBoVjHA70GU7xSUJhmKtwHPAKzLO9HMaoKwJZ7Rf8AYPDDzKpZBqfvwQAIfkECQoAAAAsAAAAABAAEAAAAzMIumIlK8oyhpHsnFZfhYumCYUhDAQxRIdhHBGqRoKw0R8DYlJd8z0fMDgsGo/IpHI5TAAAIfkECQoAAAAsAAAAABAAEAAAAzIIunInK0rnZBTwGPNMgQwmdsNgXGJUlIWEuR5oWUIpz8pAEAMe6TwfwyYsGo/IpFKSAAAh+QQJCgAAACwAAAAAEAAQAAADMwi6IMKQORfjdOe82p4wGccc4CEuQradylesojEMBgsUc2G7sDX3lQGBMLAJibufbSlKAAAh+QQJCgAAACwAAAAAEAAQAAADMgi63P7wCRHZnFVdmgHu2nFwlWCI3WGc3TSWhUFGxTAUkGCbtgENBMJAEJsxgMLWzpEAACH5BAkKAAAALAAAAAAQABAAAAMyCLrc/jDKSatlQtScKdceCAjDII7HcQ4EMTCpyrCuUBjCYRgHVtqlAiB1YhiCnlsRkAAAOwAAAAAAAAAAAA==" alt="Loading..."/><span style="color: #444">&nbsp;Loading...</span></div>
    </div>
  """
  link: (scope) ->
    scope.loadingTracker = promiseTracker('loading')
]