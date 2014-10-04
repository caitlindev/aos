"use strict"

describe "dashboardChart directive", () ->
  beforeEach () ->
    module "g4plus.chart"
  scope = undefined
  element = undefined
  compile = undefined

  beforeEach inject (_$compile_, _$rootScope_) ->
    scope = _$rootScope_.$new()
    compile = _$compile_

  it "should print dashboard chart directive", () ->
    element = angular.element("<dashboard-chart></dashboard-chart>")
    compile(element) scope