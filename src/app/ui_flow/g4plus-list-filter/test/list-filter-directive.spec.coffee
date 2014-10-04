describe 'list filter directive', () ->
  beforeEach () ->
    module "g4plus.list-filter"

  scope = {}
  compile = {}
  element = {}
  timeout = {}

  beforeEach inject (_$compile_, _$rootScope_, _$timeout_) ->
    scope = _$rootScope_
    compile = _$compile_
    timeout = _$timeout_

    scope.filter_state =
      option: '_all'
      value: 'test'
      optionList: [
        { key: '_all', label: 'All' }
        { key: 'title', label: 'Title' }
        { key: 'code', label: 'Code' }
      ]
      filterBy: jasmine.createSpy "filterBy"

    element = compile('
      <div
        class="col-md-6"
        g4-list-filter
        g4-filter-value="filter_state.value"
        g4-filter-by="filter_state.filterBy"
        g4-filter-options="filter_state.optionList"
        g4-filter-option="filter_state.option"
      )
      </div>
    ')(scope)

    scope.$digest()

  it "has input tag defined", () ->
    expect(element.find('input').length).toBe(1)

  it "should work with empty options element", () ->
    scope.filter_state.optionList = null
    element = compile('
      <div
        class="col-md-6"
        g4-list-filter
        g4-filter-value="filter_state.value"
        g4-filter-by="filter_state.filterBy"
        g4-filter-option="filter_state.option"
      )
      </div>
    ')(scope)

    scope.$digest()

    directiveScope = element.isolateScope()

    expect(directiveScope.filter_option).toBe('_all')

  it "dropdown with 3 options", () ->
    expect(element.find('ul.dropdown-menu li').length).toBe(3)

  it "updating input should trigger a call for filterBy", () ->
    # To be able to test changing of an input element:
    #   * update input
    #   * issue change event
    #   * issue enter event
    element.find('#g4-list-filter-input').val('boeing')
    e = $.Event("change")
    element.find('#g4-list-filter-input').trigger(e)

    e = $.Event("keyup")
    e.which = 13
    e.keykode = 13
    element.find('#g4-list-filter-input').trigger(e)

    scope.$digest()

    expect(scope.filter_state.filterBy).toHaveBeenCalledWith('boeing', '_all')

  it "selecting a different dropdown item should call a filterBy", () ->
    element.find(".dropdown-menu a").eq(1).click()

    scope.$digest()

    expect(scope.filter_state.filterBy).toHaveBeenCalledWith('test', 'title')


  it "should give focus to the input element on first load", () ->
    # For focus testing dom elements should be attached to the body
    element.appendTo(document.body)

    timeout.flush()

    input = $(element).find('#g4-list-filter-input').get(0)

    # On PhantomJS the only way to check for focused element is to use
    # document.activeElement.
    #   See:
    #     https://github.com/netzpirat/guard-jasmine/issues/48
    #
    # On Firefox $(input).(':focus') can be used as well
    #
    expect(document.activeElement).toBe(input)
