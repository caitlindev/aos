describe 'autofocus directive', () ->
  beforeEach () ->
    module "g4plus.autofocus"

  scope = {}
  compile = {}
  element = {}
  timeout = {}

  beforeEach inject (_$compile_, _$rootScope_, _$timeout_) ->
    scope = _$rootScope_
    compile = _$compile_
    timeout = _$timeout_

    element = compile('
      <div>
        <input id="first_input" type="text" name="First Input" />
        <input id="second_input" type="text" name="Second Input" g4-autofocus=""/>
      </div>
    ')(scope)

    scope.$digest()

  it "has input tags defined", () ->
    expect(element.find('input').length).toBe(2)

  it "should autofocus on second input but not first", () ->
    # For focus testing dom elements should be attached to the body
    element.appendTo(document.body)

    timeout.flush()

    first_input = $(element).find('#first_input').get(0)
    second_input = $(element).find('#second_input').get(0)

    # On PhantomJS the only way to check for focused element is to use
    # document.activeElement
    #   See: https://github.com/netzpirat/guard-jasmine/issues/48
    #
    # With Firefox test runner $(input).(':focus') can be used as well
    expect(document.activeElement).toBe(second_input)
    expect(document.activeElement).not.toBe(first_input)
