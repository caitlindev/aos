'use strict'

# Fec Service test
describe "Fec Service", () ->
  httpBackend = undefined
  service = undefined

  urlMock = "/api/mx-admin/v1/api/admin/fec/"
  urlAffixMock = "0"
  getFecsParamsMock = { item: 0 }
  urlParamsMock = "?item=0"
  postFecDataMock = { item: 0, data: "new" }
  putFecDataMock = { item: 0, data: "updated" }
  restResponseMock = { status: "done" }

  success = () ->
    'success'

  error = () ->
    'error'

  beforeEach () ->
    module "services.fec"

    inject (_$httpBackend_, Fec) ->
      httpBackend = _$httpBackend_
      service = Fec

  afterEach () ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  it "should recieve a repsonse for getFec", () ->
    httpBackend.whenGET(urlMock + urlAffixMock).respond(restResponseMock)
    httpBackend.expectGET(urlMock + urlAffixMock)
    service.getFec(urlAffixMock, success, error)
    httpBackend.flush()

  it "should recieve a repsonse for getFecs", () ->
    httpBackend.whenGET(urlMock + urlParamsMock).respond(restResponseMock)
    httpBackend.expectGET(urlMock + urlParamsMock)
    service.getFecs(getFecsParamsMock, success, error)
    httpBackend.flush()

  it "should recieve a repsonse for postFec", () ->
    httpBackend.whenPOST(urlMock).respond(restResponseMock)
    httpBackend.expectPOST(urlMock)
    service.postFec(postFecDataMock, success, error)
    httpBackend.flush()

  it "should recieve a repsonse for deleteFec", () ->
    httpBackend.whenDELETE(urlMock + urlAffixMock).respond(restResponseMock)
    httpBackend.expectDELETE(urlMock + urlAffixMock)
    service.deleteFec(urlAffixMock, success, error)
    httpBackend.flush()

  it "should recieve a repsonse for putFec", () ->
    httpBackend.whenPUT(urlMock).respond(restResponseMock)
    httpBackend.expectPUT(urlMock)
    service.putFec(putFecDataMock, success, error)
    httpBackend.flush()

  it "should return the current url when asked", () ->
    expect(service.getUrl()).toBe(urlMock)
