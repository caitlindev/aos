"use strict"

describe "Actions Button Directive", () ->
  beforeEach () ->
    module "g4ActionsButton"

  scope = null
  compile = null

  beforeEach inject ($rootScope, $compile) ->
    scope = $rootScope.$new()
    compile = $compile

  it "should render the label and icon", () ->
    scope.actionsList = [{label: 'Add Generic Object', action: null, icon: 'g4-icon-add'}]

    element = compile("""
      <div g4-actions-button="g4-actions-button" g4-actions-label="Actions" g4-actions-list="actionsList"></div>
      """)(scope)

    scope.$digest()
    expect(element.html()).toContain('Add Generic Object')
    expect(element.find('ul > li > a > i.g4-icon-add')).toBeDefined()


  it "should render the action attribute", () ->
    scope.actionsList = [{label: 'Add Generic Object', action: 'doSomething', icon: 'g4-icon-add'}]

    element = compile("""
      <div g4-actions-button="g4-actions-button" g4-actions-label="Actions" g4-actions-list="actionsList"></div>
      """)(scope)

    scope.$digest()
    expect(element.find('ul > li > a').attr('ng-click')).toBeDefined()



  it "should render the link attribute", () ->
    scope.actionsList = [{label: 'Add Generic Object', link: '/link', icon: 'g4-icon-add'}]

    element = compile("""
      <div g4-actions-button="g4-actions-button" g4-actions-label="Actions" g4-actions-list="actionsList"></div>
      """)(scope)

    scope.$digest()
    expect(element.find('ul > li > a').attr('ng-href')).toEqual('/link')



  it "should render the stateLink attribute", () ->
    scope.actionsList = [{label: 'Add Generic Object', stateLink: '/state-link', icon: 'g4-icon-add'}]

    element = compile("""
      <div g4-actions-button="g4-actions-button" g4-actions-label="Actions" g4-actions-list="actionsList"></div>
      """)(scope)

    scope.$digest()
    expect(element.find('ul > li > a').attr('ui-sref')).toEqual('/state-link')



  it "should render the separator", () ->
    scope.actionsList = [{label: '', separator: true}]

    element = compile("""
      <div g4-actions-button="g4-actions-button" g4-actions-label="Actions" g4-actions-list="actionsList"></div>
      """)(scope)

    scope.$digest()
    expect(element.find('.divider')).toBeDefined()