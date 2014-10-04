'use strict'

describe "Date formatting filter", () ->
  beforeEach () -> angular.mock.module "app.filters"

  maintenanceDate = undefined

  beforeEach inject ($filter) ->
    maintenanceDate = $filter "date"

  it "should format the date", () ->
    expect(maintenanceDate("20131222")).toEqual("2013/12/22")
    expect(maintenanceDate("131222")).toEqual("2013/12/22")

  it "should not format invalid date", () ->
    expect(maintenanceDate(1)).toEqual(1)
    expect(maintenanceDate("11111")).toEqual("11111")