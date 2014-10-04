"use strict"

describe "Loading Directive", () ->

  # Before Each Test Load Module
  beforeEach () ->
    module "g4plus-loading.directive"

  scope = null
  compile = null
  element = null
  controller = null

  promiseTracker = undefined
  timeout = undefined
  q = undefined
  http = undefined
  backend = undefined

  digest = ->
    scope.$digest()

  beforeEach inject(($compile, $rootScope, $timeout, $q, $http, $httpBackend, _promiseTracker_) ->
    promiseTracker = _promiseTracker_
    timeout = $timeout
    q = $q
    http = $http

    $httpBackend.whenGET('/ok').respond(200);
    $httpBackend.whenGET('/error').respond(404);
    backend = $httpBackend

    scope = $rootScope.$new()
    element = $compile('<div g4plus-loading=""></div>')(scope)
    digest()
  )

  it "should create a tracker with api", ->
    tracker = promiseTracker('loading')
    expect(typeof tracker.addPromise).toBe "function"
    expect(typeof tracker.createPromise).toBe "function"
    expect(typeof tracker._destroy).toBe "function"
    expect(typeof tracker.cancel).toBe "function"
    return

  it "should not be active by default", ->
    tracker = promiseTracker('loading')
    expect(tracker.active()).toBe false
    return

  it "should fail getting tracker", ->
    expect(-> promiseTracker('unknown')).toThrow()
    return

  it "should fail adding tracker", ->
    tracker = promiseTracker.register('add once')
    expect(-> promiseTracker.register('add once')).toThrow()
    return

  it "should not error with then, $then, $promise.then", ->
    tracker = promiseTracker('loading')
    tracker.addPromise q.defer().promise
    tracker.addPromise $then: q.defer().promise.then
    tracker.addPromise $promise:
      then: q.defer().promise.then
    return

  it "should set active to true when promises are added", ->
    tracker = promiseTracker.register 'active'
    tracker.createPromise()
    tracker.createPromise()
    expect(tracker.active()).toBe true
    return

  it "should set active to false when promises are added and resolved/rejected", ->
    tracker = promiseTracker.register 'resolving'
    p1 = tracker.createPromise()
    p2 = tracker.createPromise()
    expect(tracker.active()).toBe true
    p1.resolve()
    digest()
    expect(tracker.active()).toBe true
    p2.reject()
    digest()
    expect(tracker.active()).toBe false
    return

  it "cancel should deactivate and resolve all promises", ->
    tracker = promiseTracker.register 'canceling'
    p1 = tracker.createPromise()
    expect(tracker.active()).toBe true
    spyOn p1, "resolve"
    tracker.cancel()
    digest()
    expect(p1.resolve).toHaveBeenCalled()
    promiseTracker.deregister 'canceling'
    return

  it "should delay, be active, wait until duration, then be inactive", ->
    tracker = promiseTracker.register 'delay', {
      minDuration: 500
      activationDelay: 250
    }
    p1 = tracker.createPromise()
    expect(tracker.active()).toBe false
    timeout.flush()
    expect(tracker.active()).toBe true
    p1.resolve()
    digest()
    expect(tracker.active()).toBe true
    timeout.flush()
    expect(tracker.active()).toBe false
    return

  it "should error with object", ->
    tracker = promiseTracker.register 'addPromise'
    expect(->
      tracker.addPromise {}
      return
    ).toThrow()
    return

  it "should error with deferred", ->
    tracker = promiseTracker.register 'addPromise'
    expect(->
      tracker.addPromise q.defer()
      return
    ).toThrow()
    return

  it "should not error with then, $then, $promise.then", ->
    tracker = promiseTracker.register 'testing'
    tracker.addPromise q.defer().promise
    tracker.addPromise $then: q.defer().promise.then
    tracker.addPromise $promise:
      then: q.defer().promise.then

    return

  it "should return promise from createPromise", ->
    tracker = promiseTracker.register 'testing'
    promise = q.defer().promise
    created = q.defer()
    spyOn(tracker, "createPromise").andCallFake ->
      created

    ret = tracker.addPromise(promise)
    expect(ret).toBe created
    return

  it "should resolve returned promise when passed in promise is resolved", ->
    tracker = promiseTracker.register 'testing'
    deferred = q.defer()
    trackerPromise = tracker.addPromise(deferred.promise)
    spyOn trackerPromise, "resolve"
    deferred.resolve 1
    digest()
    expect(trackerPromise.resolve).toHaveBeenCalledWith 1
    return

  it "should reject returned promise when passed in promise is rejected", ->
    tracker = promiseTracker.register 'testing'
    deferred = q.defer()
    trackerPromise = tracker.addPromise(deferred.promise)
    spyOn trackerPromise, "reject"
    deferred.reject 2
    digest()
    expect(trackerPromise.reject).toHaveBeenCalledWith 2
    return

  it "should end on its own after maxDuration", inject(($q, $timeout, $rootScope, promiseTracker) ->
    track = promiseTracker.register("track", { maxDuration: 10000 })
    d1 = $q.defer()
    track.addPromise d1.promise
    expect(track.active()).toBe true
    $timeout.flush()
    expect(track.active()).toBe false
    return
  )
  it "should cleanup the maxDuration timeout after finishing", inject(($q, $timeout, $rootScope, promiseTracker) ->
    track = promiseTracker.register("track", { maxDuration: 10000 })
    d1 = $q.defer()
    spyOn $timeout, "cancel"
    expect(track._maxPromise).toBeUndefined()
    track.addPromise d1.promise
    expect(track.active()).toBe true
    expect($timeout.cancel).not.toHaveBeenCalled() #sanity
    d1.resolve()
    $rootScope.$apply()
    expect($timeout.cancel).toHaveBeenCalled()
    expect(track.active()).toBe false
    expect(track._maxPromise).toBeFalsy()
    return
  )

  it "should add a promise to tracking with http config option", ->
    tracker = promiseTracker.register 'tracker'
    tracker2 = promiseTracker.register 'tracker2'
    spyOn(tracker, "createPromise").andCallThrough()
    spyOn(tracker2, "createPromise").andCallThrough()
    http.get "/ok",
      tracker: 'tracker'

    digest()
    expect(tracker.createPromise).toHaveBeenCalled()
    tracker.createPromise.reset()
    http.get "/ok",
      tracker: [
        'tracker'
        'tracker2'
      ]

    digest()
    expect(tracker.createPromise).toHaveBeenCalled()
    expect(tracker2.createPromise).toHaveBeenCalled()
    return

  it "should resolve on good response", ->
    tracker = promiseTracker.register 'tracker'
    deferred = q.defer()
    spyOn(tracker, "createPromise").andCallFake ->
      deferred

    spyOn deferred, "resolve"
    http.get "/ok",
      tracker: 'tracker'

    digest()
    backend.flush()
    expect(deferred.resolve).toHaveBeenCalled()
    expect(deferred.resolve.mostRecentCall.args[0].status).toBe 200
    return

  it "should reject on error response", ->
    tracker = promiseTracker.register 'tracker'
    deferred = q.defer()
    spyOn(tracker, "createPromise").andCallFake ->
      deferred

    spyOn deferred, "reject"
    http.get "/error",
      tracker: 'tracker'

    digest()
    backend.flush()
    expect(deferred.reject).toHaveBeenCalled()
    expect(deferred.reject.mostRecentCall.args[0].status).toBe 404
    return

