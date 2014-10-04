'use strict'

describe "Load Component Module", () ->
  # Before Each
  beforeEach () ->
    module 'g4plus.retry-call'
    module 'g4plus.load-component'

  # Inject

  # After Each

  describe "load-component directive", () ->
    $rootScope = $scope = $httpBackend = $compile = RetryCall = null

    createDirective = (template = "<div load-component></div>", type, id) ->
      scope = $rootScope.$new()
      scope.loadType = type
      scope.loadId = id
      $compile(template) scope
      scope.$digest()
      # Return link scope
      scope

    describe "loading components with common and unique ids", () ->
      testDirective = {}
      config =
        'method': 'GET'
        'url': '/succeed'
        'requestId': 0

      allButThese = (allShouldBe, except, callback) ->
        for key, directive of testDirective
          if directive.loadId in except
            expect(directive.loading isnt allShouldBe).toBeTruthy()
          else
            expect(directive.loading is allShouldBe).toBeTruthy()
        if callback isnt undefined then callback()

      beforeEach () ->
        # Inject
        inject (_$rootScope_,_$compile_,_$http_,_$httpBackend_,_RetryCall_) ->
          window.$http = _$http_
          $httpBackend = _$httpBackend_
          $rootScope = _$rootScope_
          $compile = _$compile_
          RetryCall = _RetryCall_
        # Progress directive makes a call to template/progress/progressbar.html
        $httpBackend.when('GET', 'template/progressbar/progressbar.html').respond 200, '<div>test</div>'

        testDirective['splash'] = createDirective("""
          <div load-component></div>
        """, 'splash', 'splash')
        testDirective['spinner'] = createDirective("""
          <div load-component></div>
        """, 'spinner', 'spinner')
        testDirective['progress'] = createDirective("""
          <div load-component></div>
        """, 'progress', 'progress')
        testDirective['splashCommon'] = createDirective("""
          <div load-component></div>
        """, 'splash', 'common')
        testDirective['spinnerCommon'] = createDirective("""
          <div load-component></div>
        """, 'spinner', 'common')
        testDirective['progressCommon'] = createDirective("""
          <div load-component></div>
        """, 'progress', 'common')

      it "should only load splash", () ->
        config.loadId = 'splash'
        # Nothing should be loading
        allButThese false, [], () ->
          # Call $http load-id service
          RetryCall.appendRequest(config)
          allButThese false, ['splash'], () ->
            # Simulate request finish
            RetryCall.deleteRequest(0)
            allButThese false, [], undefined

      it "should only load spinner", () ->
        config.loadId = 'spinner'
        # Nothing should be loading
        allButThese false, [], () ->
          # Call $http load-id service
          RetryCall.appendRequest(config)
          allButThese false, ['spinner'], () ->
            # Simulate request finish
            RetryCall.deleteRequest(0)
            allButThese false, [], undefined


      it "should only load progress", () ->
        config.loadId = 'progress'
        # Nothing should be loading
        allButThese false, [], () ->
          # Call $http load-id service
          RetryCall.appendRequest(config)
          allButThese false, ['progress'], () ->
            # Simulate request finish
            RetryCall.deleteRequest(0)
            allButThese false, [], undefined

      it "should only load commons", () ->
        config.loadId = 'common'
        # Nothing should be loading
        allButThese false, [], () ->
          # Call $http load-id service
          RetryCall.appendRequest(config)
          allButThese false, ['common'], () ->
            # Simulate request finish
            RetryCall.deleteRequest(0)
            allButThese false, [], undefined