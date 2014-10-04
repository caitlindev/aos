'use strict'

# Fec Service test
describe "ListState Service", () ->
  service = undefined

  paramsMock =
    pagination:
      page: 99
      pageSize: 99
    filters:
      programGroupId: 99
      filter_value: 'airbus'
      filter_option: 'title'
    sorting: 'test'

  paramsMockSet =
    programGroupId: 99
    filter_option: 'title'
    filter_value: 'airbus'
    pageSize: 99
    page: 99
    sort: 'test'

  listStateUrlMock = '/list?programGroupId=99&filter_option=title&' + \
                     'filter_value=airbus&pageSize=99&page=99&sort=test'

  beforeEach () ->
    module "services.list_state"

    inject (ListState) ->
      service = ListState

  it "should return a default params object", () ->
    expect(typeof service.getParams()).toBe('object')

  it "should update its param object with passed data and return it", () ->
    service.setParams(paramsMockSet)
    expect(service.getParams()).toEqual(paramsMock)

  it "should return a default url when asked", () ->
    expect(typeof service.getListStateUrl()).toBe('string')

  it "should return an updated url when asked", () ->
    service.setParams(paramsMockSet)
    expect(service.getListStateUrl()).toBe(listStateUrlMock)
