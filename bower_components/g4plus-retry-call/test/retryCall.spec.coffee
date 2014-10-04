'use strict'

describe 'Retry Call Module', ()->

  RetryCall = undefined

  # automaticAttempts is an int
  # url, retrySuccess and retryError are booleans
  createConfig = (automaticAttempts, url, retrySuccess, retryError)->
      config = {}
      config.automaticAttempts = automaticAttempts
      if retrySuccess
        config.retrySuccess = ()->
          "success"
      if retryError
        config.retryError = ()->
          "error"
      if url
        config.url = "/succeed"
      else
        config.url = "/fail"
      config

  createResponse = (status, automaticAttempts, url, retrySuccess, retryError)->
    response =
      'status': status
      'config': createConfig(automaticAttempts, url, retrySuccess, retryError)

  createResponses = (numberOfRequests, status, automaticAttempts, url, retrySuccess, retryError)->
    responses = []
    if status < 400 then status = 400
    for i in [0..numberOfRequests - 1]
      response = createResponse(status, automaticAttempts, url, retrySuccess, retryError)
      response.config.requestId = i
      response.headers = ->
        {}
      responses[i] = response
    responses

  createRequests = (numberOfRequests, status, automaticAttempts, url, retrySuccess, retryError)->
    requests = []
    for i in [0..numberOfRequests - 1]
      request = createConfig(automaticAttempts, url, retrySuccess, retryError)
      request.requestId = i
      requests[i] = request
    requests

  buildRequests = ()->
    responses = createResponses(10,200,3,true,true,true)
    requests = createRequests(4, 200, 4, true, true, true)
    for i in [0..9]
      if i in [0..3]
        requests[i].requestId = i + 20
        RetryCall.appendRequest(requests[i])
        RetryCall.appendSuccessfulRequest(responses[i])
      else
        responses[i].status = 400
        RetryCall.appendFailedRequest(responses[i])
    return

  # Build our module
  beforeEach () ->
    module('g4plus.retry-call')

  beforeEach inject (_RetryCall_) ->
    RetryCall = _RetryCall_

  describe "appendSuccessfulRequest", ()->
    it "should append a request", ()->
      successfulRequest = RetryCall.getSuccessfulRequest(0)
      expect(successfulRequest).toBe(undefined)
      successfulRequest = createResponse(200,5,true,true,true)
      successfulRequest.config.requestId = 0
      RetryCall.appendSuccessfulRequest(successfulRequest)
      compareRequest = RetryCall.getSuccessfulRequest(0)
      expect(successfulRequest).toBe(compareRequest)

  describe "getSuccessfulRequest", ()->
    beforeEach () ->
      successfulRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendSuccessfulRequest(successfulRequests[i])

    it "should get the correct request", ()->
      successfulRequest = RetryCall.getSuccessfulRequest(2)
      expect(successfulRequest.config.requestId).toBe(2)

  describe "getSuccessfulRequests", ()->
    beforeEach () ->
      successfulRequests = createResponses(4,200,3,true,true,true)
      for i in [0..3]
        RetryCall.appendSuccessfulRequest(successfulRequests[i])

    it "should be equal to successful requests", ()->
      compareRequests = createResponses(4,200,3,true,true,true)
      successfulRequests = RetryCall.getSuccessfulRequests()
      for i in [0..3]
        expect(compareRequests[i].config.requestId).toEqual(successfulRequests[i].config.requestId)

  describe "deleteSuccessfulRequest", ()->
    beforeEach () ->
      successfulRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendSuccessfulRequest(successfulRequests[i])

    it "should delete the request", ()->
      successfulRequest = RetryCall.getSuccessfulRequest(0)
      expect(successfulRequest).not.toBe(undefined)
      RetryCall.deleteSuccessfulRequest(0)
      successfulRequest = RetryCall.getSuccessfulRequest(0)
      expect(successfulRequest).toBe(undefined)

  describe "hasSuccessfulRequest", ()->
    beforeEach () ->
      successfulRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendSuccessfulRequest(successfulRequests[i])

    it 'should return false', ()->
      expect(RetryCall.hasSuccessfulRequest(4)).toBeFalsy()

    it 'should return true', ()->
      expect(RetryCall.hasSuccessfulRequest(0)).toBeTruthy()

  describe "appendRequest", ()->
    it "should return an array of length 3", ()->
      config = createConfig(3, true, true, true)
      RetryCall.appendRequest(config)
      requests = RetryCall.getRequests()
      expect(requests[config.requestId]).toBe(config)

  describe "getRequest", ()->
    it "should get the request object", ()->
      config = createConfig(5, true, true, true)
      RetryCall.appendRequest(config)
      request = RetryCall.getRequest(0)
      expect(request).toBe(config)

  describe "getRequests", ()->
    it "should return an array", ()->
      requests = createRequests(5, 200, 3, true, true, true)
      for request in requests
        RetryCall.appendRequest(request)
      getRequests = RetryCall.getRequests()
      expect(requests).toEqual(getRequests)

  describe "deleteRequest", ()->
    it "should return undefined", ()->
      requests = createRequests(5, 200, 3, true, true, true)
      for request in requests
        RetryCall.appendRequest(request)
      request = RetryCall.getRequest(3)
      expect(request).not.toBe(undefined)
      RetryCall.deleteRequest(3)
      request = RetryCall.getRequest(3)
      expect(request).toBe(undefined)

  describe "hasRequest", ()->
    beforeEach ()->
      requests = createRequests(5, 200, 3, true, true, true)
      for request in requests
        RetryCall.appendRequest(request)

    it "should return true", ()->
      expect(RetryCall.hasRequest(2)).toBeTruthy()

    it "should return false", ()->
      RetryCall.deleteRequest(3)
      expect(RetryCall.hasRequest(3)).toBeFalsy()

  describe "appendFailedRequest", ()->
    # Public Accessors
    it "should call deleteRequest", ()->
      spyOn(RetryCall,'deleteRequest')
      response = createResponse(400, 5, true, true, true)
      RetryCall.appendFailedRequest(response)
      expect(RetryCall.deleteRequest).toHaveBeenCalled()

    # Public Accessors
    it "should add to failed request array", ()->
      response = createResponse(400, 3, true, true, true)
      RetryCall.appendFailedRequest(response)
      failedRequests = RetryCall.getFailedRequests()
      expect(failedRequests[response.config.requestId]).toBe(response)

  describe "getFailedRequest", ()->

    it "should get the same request that was appended", ()->
      response = createResponse(400, 3, true, true, true)
      response.config.requestId = 0
      RetryCall.appendFailedRequest(response)
      failedRequest = RetryCall.getFailedRequest(0)
      expect(failedRequest).toBe(response)

  describe "getFailedRequests", ()->
    beforeEach ()->
      failedRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendFailedRequest(failedRequests[i])

    it "should get a list of failed requests", ()->
      failedRequests = RetryCall.getFailedRequests()
      expect(failedRequests).toEqual(failedRequests)

  describe "deleteFailedRequest", ()->
    beforeEach ()->
      failedRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendFailedRequest(failedRequests[i])

    it "should delete failed request", ()->
      failedRequests = RetryCall.getFailedRequests()
      failedRequest = RetryCall.getFailedRequest(2)
      expect(failedRequests[2]).toEqual(failedRequest)
      RetryCall.deleteFailedRequest(2)
      failedRequest = RetryCall.getFailedRequest(2)
      expect(failedRequest).toBe(undefined)

  describe "hasFailedRequest", ()->
    beforeEach ()->
      failedRequests = createResponses(4,400,3,true,true,true)
      for i in [0..3]
        RetryCall.appendFailedRequest(failedRequests[i])

    it "should be false after deleting failed request", ()->
      request = RetryCall.getFailedRequest(2)
      expect(request).not.toBe(undefined)
      RetryCall.deleteFailedRequest(2)
      request = RetryCall.getFailedRequest(2)
      expect(request).toBe(undefined)
      expect(RetryCall.hasFailedRequest(2)).toBeFalsy()

    it "should be true before deleting", ()->
      expect(RetryCall.hasFailedRequest(2)).toBeTruthy()

  describe 'request', ()->
    it "should append a config object to our requests", ()->
      expect(RetryCall.hasRequest(0)).toBeFalsy()
      config = createConfig(4, true, true, true)
      RetryCall.request(config)
      expect(RetryCall.hasRequest(0)).toBeTruthy()

    it "should not add another config object to our requests", ()->
      compareRequests = RetryCall.getRequests()
      expect(Object.keys(compareRequests).length).toBe(0)
      config = createConfig(4, true, true, true)
      RetryCall.request(config)
      compoareRequests = RetryCall.getRequests()
      expect(Object.keys(compareRequests).length).toBe(1)
      RetryCall.request(config)
      compareRequests = RetryCall.getRequests()
      expect(Object.keys(compareRequests).length).toBe(1)

  describe 'requestError', ()->
    $q = null

    beforeEach inject (_$q_)->
      $q = _$q_

    it "should return a $q.reject object", ()->
      spyOn $q, 'reject'
      failedRequest = createResponse(400, 4, true, true, true)
      RetryCall.requestError(failedRequest)
      expect($q.reject).toHaveBeenCalled()

  describe 'response', ()->
    responseSuccess = null
    responseFail = null

    beforeEach ()->
      responseSuccess = createResponse(200,3,true,true,true)
      responseSuccess.headers = ()->
        {}
      responseFail = createResponse(400,3,true,true,true)
      responseFail.headers = ()->
        {}

    it "should fire a success callback", ()->
      responseSuccess.config.method = 'GET'
      spyOn responseSuccess.config, 'retrySuccess'
      expect(responseSuccess.config.retrySuccess).not.toHaveBeenCalled()
      RetryCall.response(responseSuccess)
      expect(responseSuccess.config.retrySuccess).toHaveBeenCalled()

    it "should delete our request from the request queue", ()->
      # Expect that request is not there
      expect(RetryCall.hasRequest(0)).toBeFalsy()
      # Create some request
      request = createConfig(4, true, true, true)
      # Add request to request queue
      RetryCall.appendRequest(request)
      # Expect that request is there
      expect(RetryCall.hasRequest(0)).toBeTruthy()
      # Create response
      responseSuccess.config.requestId = 0
      responseSuccess.config.method = 'GET'
      # Send response to RetryCall.response
      RetryCall.response(responseSuccess)
      expect(RetryCall.hasRequest(0)).toBeFalsy()

    it "should delete our request from the failed request queue", ()->
      # Expect that request is not there
      expect(RetryCall.hasFailedRequest(0)).toBeFalsy()
      # Create some request
      request = createResponse(400, true, true, true)
      request.config.requestId = 0
      # Add request to request queue
      RetryCall.appendFailedRequest(request)
      # Expect that request is there
      expect(RetryCall.hasFailedRequest(0)).toBeTruthy()
      # Create response
      responseFail.config.requestId = 0
      responseFail.config.method = 'GET'
      # Send response to RetryCall.response
      RetryCall.response(responseFail)
      expect(RetryCall.hasRequest(0)).toBeFalsy()

    it "should append our request to successful request queue", ()->
      expect(RetryCall.hasSuccessfulRequest(0)).toBeFalsy()
      responseSuccess.config.requestId = 0
      responseSuccess.config.method = "POST"
      RetryCall.response(responseSuccess)
      expect(RetryCall.hasSuccessfulRequest(0)).toBeTruthy()

    it "should not append our request to successful request queue", ()->
      expect(RetryCall.hasSuccessfulRequest(0)).toBeFalsy()
      responseSuccess.config.requestId = 0
      responseSuccess.config.method = "GET"
      expect(RetryCall.hasSuccessfulRequest(0)).toBeFalsy()

  describe 'responseError', ()->
    $q = null
    responseSuccess = null
    responseFail = null

    beforeEach inject (_$http_, _$q_)->
      window.$http = _$http_
      $q = _$q_

    beforeEach ()->
      responseSuccess = createResponse(200,3,true,true,true)
      responseSuccess.headers = ()->
        {}
      responseFail = createResponse(400,3,true,true,true)
      responseFail.headers = ()->
        {}

    it "should return $q.reject object", ()->
      responseSuccess.config = null
      spyOn $q, 'reject'
      RetryCall.responseError(responseSuccess)
      expect($q.reject).toHaveBeenCalled()

    it "should send an $http request and subtract number of automatic requests", ()->
      spyOn window, '$http'
      RetryCall.responseError(responseSuccess)
      expect(window.$http).toHaveBeenCalled()

    it "should append to failed request", ()->
      spyOn RetryCall, 'appendFailedRequest'
      responseFail.config.automaticAttempts = 0
      responseFail.config.requestId = 0
      RetryCall.responseError(responseFail)
      expect(RetryCall.appendFailedRequest).toHaveBeenCalled()

  describe 'retry-call directive', ()->
    element = $rootScope = $scope = $compile = defaultData = null
    $linkScope = $location = $interval = null

    createDirective = (attribute)->
      template = "<div retry-call #{attribute}></div>"
      # Create Directive
      elmement = $compile(template) $scope
      # finalize directive
      $scope.$digest()
      $linkScope = $scope.$$childTail

    beforeEach ()->
      inject (_$rootScope_, _$compile_, _$location_, _$interval_,_$httpBackend_) ->
        $rootScope = _$rootScope_
        $scope = $rootScope.$new()
        $compile = _$compile_
        $location = _$location_
        $interval = _$interval_
        $httpBackend = _$httpBackend_
        $httpBackend.when('GET', 'template/modal/backdrop.html').respond 200, '<div></div>'
        $httpBackend.when('GET', 'template/modal/window.html').respond 200, '<div></div>'

    describe "$scope.$on('$locationChangeSuccess')", ()->
      beforeEach ()->
        createDirective()
        $location.path('/test')
        # When location changes, $rootScope broadcasts:
        # $locationChangeStart: before switching to new url
        # $locationChangeSuccess: if url change was successful
        $rootScope.$broadcast('$locationChangeSuccess')

      it "should return {view: '/test'} ", ()->
        expect($linkScope.location).toEqual({view: '/test'})

      it "should return failedRequests {}", ()->
        expect($linkScope.failedRequests).toEqual {}

      it "should return successfulRequests {}", ()->
        expect($linkScope.successfulRequests).toEqual {}

      it "should return failed requests", ()->
        buildRequests()
        expect($linkScope.failedRequests).toEqual RetryCall.getFailedRequests()

      it "should return successful requests", ()->
        buildRequests()
        expect($linkScope.successfulRequests).toEqual RetryCall.getSuccessfulRequests()

    describe "$scope.retry", ()->
      $httpBackend = null
      failedResponse =
        data:
          message: 'fail!'
      successfulResponse =
        data:
          message: 'success!'

      beforeEach ()->
        createDirective()
        inject ( _$httpBackend_, _$http_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('GET', '/succeed').respond 200, successfulResponse
          $httpBackend.when('GET', '/fail').respond 400, failedResponse

      it "should get failed requests", ()->
        expect($linkScope.failedRequests).toEqual {}
        buildRequests()
        RetryCall.deleteFailedRequest(1)
        expect($linkScope.failedRequests).toEqual RetryCall.getFailedRequests()

      it "should submit a request attempt to /succeed", ()->
        buildRequests()
        failedRequest = RetryCall.getFailedRequest(4)
        failedRequest.config.method = 'GET'
        $httpBackend.expectGET('/succeed')
        $linkScope.retry(failedRequest.config)
        $httpBackend.flush()

    describe "$scope.closeSuccess", ()->
      beforeEach ->
        createDirective()
        buildRequests()

      it "should delete successful requests", ()->
        expect(RetryCall.hasSuccessfulRequest(2)).toBeTruthy()
        $linkScope.closeSuccess({requestId: 4})
        expect(RetryCall.hasSuccessfulRequest(4)).toBeFalsy()

      it "should get successful requests", ()->
        expect(RetryCall.hasSuccessfulRequest(2)).toBeTruthy()
        $linkScope.closeSuccess({requestId: 2})
        expect(RetryCall.hasSuccessfulRequest(2)).toBeFalsy()

    describe "$scope.cancel", ()->
      beforeEach ->
        createDirective()
        buildRequests()

      it "should run error callback", ()->
        request = RetryCall.getFailedRequest(4)
        expect(request.config.requestId).toBe(4)
        spyOn(request.config, 'retryError')
        $linkScope.cancel(request.config)
        expect(request.config.retryError).toHaveBeenCalled()

      it "should delete failed request", ()->
        expect(RetryCall.hasFailedRequest(4)).toBeTruthy()
        request = RetryCall.getFailedRequest(4)
        $linkScope.cancel(request.config)
        expect(RetryCall.hasFailedRequest(4)).toBeFalsy()

      it "should get failed requests", ()->
        requests = RetryCall.getFailedRequests()
        request = RetryCall.getFailedRequest(4)
        expect(Object.keys(requests).length).toBe(6)
        $linkScope.cancel(request.config)
        requests = $linkScope.failedRequests
        expect(Object.keys(requests).length).toBe(5)
        expect($linkScope.failedRequests).toBe(RetryCall.getFailedRequests())

    describe "black box testing for run interval", ()->
      $interval = null
      $httpBackend = null
      failedResponse =
        data:
          message: 'fail!'
      successfulResponse =
        data:
          message: 'success!'

      beforeEach ->
        createDirective()
        inject (_$http_, _$httpBackend_, _$interval_)->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $interval = _$interval_

        $httpBackend.when('POST', '/succeed').respond 200, successfulResponse
        $httpBackend.when('GET', '/fail').respond 400, failedResponse

        # create successful requests
        successfulRequest = createConfig(3, true, true, true)
        successfulRequest.method = 'POST'
        # create failed requests
        failedRequest = createConfig(3,false,true,true)
        failedRequest.method = 'GET'

        # send requests
        $http(successfulRequest)
        $http(failedRequest)

        # process our requests
        $httpBackend.flush()

      it "should not allow multiple countdown intervals", ()->
        # Signal multiple events to try get run interval to run
        # multiple times
        $scope.$broadcast('RetryCall:failedRequests')
        $scope.$broadcast('RetryCall:failedRequests')
        failedKey = Object.keys($linkScope.failedRequests)[0]
        successKey = Object.keys($linkScope.successfulRequests)[0]
        compareFailed = $linkScope.failedRequests[failedKey].timeleft
        compareSuccess = $linkScope.successfulRequests[successKey].timeleft
        $interval.flush(1000)
        expect( $linkScope.failedRequests[failedKey].timeleft - compareFailed).toBe(-1)
        expect( $linkScope.successfulRequests[successKey].timeleft - compareSuccess).toBe(-1)

      it "should increment attempts if timeleft less than 0", ()->
        failedKey = Object.keys($linkScope.failedRequests)[0]
        expect($linkScope.failedRequests[failedKey].attempts).toBe(0)
        $interval.flush(6000)
        expect($linkScope.failedRequests[failedKey].attempts).toBe(1)

      it "should delete failed request when timeleft is 0 and attempts is 3", ()->
        failedKey = Object.keys($linkScope.failedRequests)[0]
        expect($linkScope.failedRequests[failedKey]).toBeDefined()
        $linkScope.failedRequests[failedKey].timeleft = 0
        $linkScope.failedRequests[failedKey].attempts = 3
        $interval.flush(1000)
        expect($linkScope.failedRequests[failedKey]).toBeUndefined()

      it "should delete successful request when timeleft is less than 1", ()->
        successKey = Object.keys($linkScope.successfulRequests)[0]
        expect($linkScope.successfulRequests[successKey]).toBeDefined()
        $interval.flush(6000)
        expect($linkScope.successfulRequests[successKey]).toBeUndefined()

    ###New Tests###

    describe "retry-id", () ->
      $httpBackend = null

      makeRequests = () ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/succeed').respond 200, '<div></div>'

        config1 = (createConfig(0,true))
        config1.retryId = 'aaa'
        config1.method = 'POST'

        config2 = (createConfig(0,true))
        config2.retryId = 'bbb'
        config2.method = 'POST'

        config3 = (createConfig(0,true))
        config3.method = 'POST'

        $http(config1)
        $http(config2)
        $http(config3)

        $httpBackend.flush()

      it "should show all requests by default", () ->
        createDirective()
        makeRequests()
        for key, request of $linkScope.successfulRequests
          expect($linkScope.correctRetryId(request.config)).toBeTruthy()

      it "should show only requests with same retry-id", () ->
        createDirective("retry-id = 'aaa' ")
        makeRequests()
        for key, request of $linkScope.successfulRequests
          if request.config.retryId is 'aaa'
            expect($linkScope.correctRetryId(request)).toBeTruthy()
          else
            expect($linkScope.correctRetryId(request)).toBeFalsy()

    describe "show-url", () ->
      $httpBackend = null

      makeRequests = () ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/succeed').respond 200, '<div></div>'

        config1 = (createConfig(0,true))
        config1.retryId = 'aaa'
        config1.method = 'POST'

        config2 = (createConfig(0,true))
        config2.retryId = 'bbb'
        config2.method = 'POST'

        config3 = (createConfig(0,true))
        config3.method = 'POST'

        $http(config1)
        $http(config2)
        $http(config3)

        $httpBackend.flush()

      it "should not give the url by default", () ->
        createDirective()
        makeRequests()
        for key, request of $linkScope.successfulRequests
          expect($linkScope.url(request)).toEqual('')

      it "should give the url when true", () ->
        createDirective(" show-url = 'true' ")
        makeRequests()
        for key, request of $linkScope.successfulRequests
          expect($linkScope.url(request)).toEqual("Url: #{request.config.url}")

      it "should not give the url when false", () ->
        createDirective(" show-url = 'false' ")
        makeRequests()
        for key, request of $linkScope.successfulRequests
          expect($linkScope.url(request)).toEqual('')

    describe "filter-status", () ->
      $httpBackend = null

      makeRequests = () ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/400').respond 400, ''
          $httpBackend.when('POST', '/401').respond 401, ''
          $httpBackend.when('POST', '/404').respond 404, ''

        config1 = (createConfig(0,true))
        config1.url = '/404'
        config1.method = 'POST'

        config2 = (createConfig(0,true))
        config2.url = '/401'
        config2.method = 'POST'

        config3 = (createConfig(0,true))
        config3.url = '/400'
        config3.method = 'POST'

        $http(config1)
        $http(config2)
        $http(config3)

        $httpBackend.flush()

      it "should display all status codes by default", () ->
        createDirective()
        makeRequests()
        for key, request of $linkScope.failedRequests
          expect($linkScope.filterErrors(request)).toBeTruthy()

      it "should only display designated status codes", () ->
        createDirective(" filter-status = '[400]' ")
        makeRequests()
        for key, request of $linkScope.failedRequests
          if request.status is 400
            expect($linkScope.filterErrors(request)).toBeTruthy()
          else
            expect($linkScope.filterErrors(request)).toBeFalsy()

    describe "clear-errors-on-view-change", () ->
      $httpBackend = null

      makeRequests = () ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/fail').respond 400, ''

        config = (createConfig(0,false))
        config.method = 'POST'

        $http(config)

        $httpBackend.flush()

      expectedResults = (endResult,option) ->
        # Set Path
        $location.path('/test')
        # Create Directive
        createDirective("clear-errors-on-view-change = #{option}")
        # Check that there are no failed requests
        expect(Object.keys($linkScope.failedRequests).length).toEqual(0)
        # Make failed requests
        makeRequests()
        # Check that we have failed requests
        expect(Object.keys($linkScope.failedRequests).length).toEqual(1)
        # Broadcast change path
        $rootScope.$broadcast('$locationChangeSuccess')
        # Expect that since path has not changed that we still have the failed requests
        expect(Object.keys($linkScope.failedRequests).length).toEqual(1)
        # Change $location.path
        $location.path('/test2')
        # Broadcast change path
        $rootScope.$broadcast('$locationChangeSuccess')
        # Expect that our failed requests have now been cleared
        expect(Object.keys($linkScope.failedRequests).length).toEqual(endResult)

      it "should not clear errors on view change by default", () ->
        expectedResults(1,null)

      it "should clear errors on view change when true", () ->
        expectedResults(0,true)

      it "should not clear errors on view change when false", () ->
        expectedResults(1,false)

    describe "clear-success-on-view-change", () ->
      $httpBackend = null

      makeRequests = () ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/succeed').respond 200, ''

        config = (createConfig(0,true))
        config.method = 'POST'

        $http(config)

        $httpBackend.flush()

      expectedResults = (endResult,option) ->
        # Set Path
        $location.path('/test')
        # Create Directive
        createDirective("clear-success-on-view-change = #{option}")
        # Check that there are no failed requests
        expect(Object.keys($linkScope.successfulRequests).length).toEqual(0)
        # Make failed requests
        makeRequests()
        # Check that we have failed requests
        expect(Object.keys($linkScope.successfulRequests).length).toEqual(1)
        # Broadcast change path
        $rootScope.$broadcast('$locationChangeSuccess')
        # Expect that since path has not changed that we still have the failed requests
        expect(Object.keys($linkScope.successfulRequests).length).toEqual(1)
        # Change $location.path
        $location.path('/test2')
        # Broadcast change path
        $rootScope.$broadcast('$locationChangeSuccess')
        # Expect that our failed requests have now been cleared
        expect(Object.keys($linkScope.successfulRequests).length).toEqual(endResult)

      it "should not clear success on view change by default", () ->
        expectedResults(1,null)

      it "should clear success on view change when true", () ->
        expectedResults(0,true)

      it "should not clear success on view change when false", () ->
        expectedResults(1,false)

    describe "show-successful-requests", () ->
      it "should show successful requests by default", () ->
        createDirective()
        expect($linkScope.showSuccess()).toBeTruthy()

      it "should show sucessful requests when true", () ->
        createDirective("show-successful-requests = 'true'")
        expect($linkScope.showSuccess()).toBeTruthy()

      it "should not show successful requests when false", () ->
        createDirective("show-successful-requests = 'false'")
        expect($linkScope.showSuccess()).toBeFalsy()

    describe "show-failed-requests", () ->
      it "should show failed requests by default", () ->
        createDirective()
        expect($linkScope.showFailed()).toBeTruthy()

      it "should show failed requests when true", () ->
        createDirective("show-failed-requests = 'true'")
        expect($linkScope.showFailed()).toBeTruthy()

      it "should not show failed requests when false", () ->
        createDirective("show-failed-requests = 'false'")
        expect($linkScope.showFailed()).toBeFalsy()

    describe "tagline-for-error", () ->

      it "should be 'Error: ' by default", () ->
        createDirective()
        expect($linkScope.getTaglineForError()).toEqual('Error: ')

      it "should be whatever the user sets it to", () ->
        createDirective(" tagline-for-error = 'PASS' ")
        expect($linkScope.getTaglineForError()).toEqual('PASS')

    describe "tagline-for-success", () ->

      it "should be 'Success: ' by default", () ->
        createDirective()
        expect($linkScope.getTaglineForSuccess()).toEqual('Success: ')

      it "should be whatever the user sets it to", () ->
        createDirective(" tagline-for-success = 'PASS' ")

    describe "default-error-message", () ->
      $httpBackend = null

      makeRequests = (message) ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/fail').respond 400, ''

        config = (createConfig(0,false))
        config.method = 'POST'
        config.errorMessage = message

        $http(config)

        $httpBackend.flush()

      it "should be 'There was an error.' by default", () ->
        createDirective()
        makeRequests()
        keys = Object.keys $linkScope.failedRequests
        config = $linkScope.failedRequests[keys[0]].config
        expect($linkScope.errorMessage(config)).toEqual('There was an error.')

      it "should be whatever the user sets it to", () ->
        createDirective(" default-error-message = 'This test shall pass!' ")
        makeRequests()
        keys = Object.keys $linkScope.failedRequests
        config = $linkScope.failedRequests[keys[0]].config
        expect($linkScope.errorMessage(config)).toEqual('This test shall pass!')

      it "should be overridden by config", () ->
        createDirective(" default-error-message = 'This test shall pass!' ")
        makeRequests('This error message shall be overridden!')
        keys = Object.keys $linkScope.failedRequests
        config = $linkScope.failedRequests[keys[0]].config
        expect($linkScope.errorMessage(config)).toEqual('This error message shall be overridden!')

    describe "default-success-message", () ->
      $httpBackend = null

      makeRequests = (message) ->
        inject (_$http_, _$httpBackend_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $httpBackend.when('POST', '/succeed').respond 200, ''

        config = (createConfig(0,true))
        config.method = 'POST'
        config.successMessage = message

        $http(config)

        $httpBackend.flush()

      it "should be 'Action was successful!' by default", () ->
        createDirective()
        makeRequests()
        keys = Object.keys $linkScope.successfulRequests
        config = $linkScope.successfulRequests[keys[0]].config
        expect($linkScope.successMessage(config)).toEqual('Action was successful!')

      it "should be whatever the user sets it to", () ->
        createDirective(" default-success-message = 'This test shall pass!' ")
        makeRequests()
        keys = Object.keys $linkScope.successfulRequests
        config = $linkScope.successfulRequests[keys[0]].config
        expect($linkScope.successMessage(config)).toEqual('This test shall pass!')

      it "should be overridden by config", () ->
        createDirective(" default-success-message = 'This test shall pass!' ")
        makeRequests('This success message shall be overridden!')
        keys = Object.keys $linkScope.successfulRequests
        config = $linkScope.successfulRequests[keys[0]].config
        expect($linkScope.successMessage(config)).toEqual('This success message shall be overridden!')