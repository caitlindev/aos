"use strict"

describe "List Table Directive", () ->

  # Before Each Test Load Module
  beforeEach () ->
    module "g4plus-list-table.directive"

  scope = null
  compile = null
  element = null
  controller = null
  $state = null

  beforeEach inject ($compile, $rootScope) ->
    scope = $rootScope.$new()

    scope.items = [
      {
        code: 'Code1'
        title: 'Title1'
        description: 'Description1'
        numbers: 1
      }
      {
        code: 'Code2'
        title: 'Title2'
        description: 'Description2'
        numbers: 2
      }
      {
        code: 'Code3'
        title: 'Title3'
        description: 'Description3'
      }
    ]
    scope.tableOptions =
      items: scope.items
      noItemsFoundMessage: 'There are no entries that matched the filter.'
      tableClass: 'table-lined rounded'
      actions:
        deleteAction: (item) ->
        editState: 'edit'
        editStateParam: 'id'
        viewLink: '#/view/'
      columns: [
        {
          title: 'Code'
          field: 'code'
          columnClass: 'narrow'
          sorting: true
          filter: 'lowercase'
        }
        {
          title: 'Title'
          field: 'title'
          columnClass: 'narrow'
          sorting: true
          filter: 'uppercase'
        }
        {
          title: 'Description'
          field: 'description'
          columnClass: 'narrow'
          sorting: false
        }
        {
          title: 'Numbers'
          field: 'numbers'
          columnClass: 'narrow'
          sorting: false
          filter: 'number'
          filterData: 10
        }
      ]
      onSortColumn: (column, direction) ->
    
    element = $compile('<div g4plus-list-table="tableOptions"></div>')(scope)

    scope.$digest()

  it "should have columns", () ->
    scope.$digest()

    theadElement = element.find 'thead'
    thElements = theadElement.find 'th'

    expect(thElements.length).toEqual(5)
    
  it "should have rows", () ->
    scope.$digest()

    tbodyElement = element.find 'tbody'
    trElements = tbodyElement.find 'tr'

    expect(trElements.length).toEqual(3)

  it "should not have actions", () ->
    scope.tableOptions.actions = null
    scope.$digest()

    theadElement = element.find 'thead'
    thElements = theadElement.find 'th'

    expect(thElements.length).toEqual(4)

  it "should change sorting", () ->
    scope.$digest()

    theadElement = element.find 'thead'
    aElements = theadElement.find 'a'
    $(aElements[0]).click()
    scope.$digest()

    expect(scope.tableOptions.sortColumn).toBe('code')

    $(aElements[0]).click()
    scope.$digest()

    expect(scope.tableOptions.sortColumn).toBe('code')
    expect(scope.tableOptions.sortDirection).toBe('-')

    $(aElements[0]).click()
    scope.$digest()

    expect(scope.tableOptions.sortColumn).toBe('code')
    expect(scope.tableOptions.sortDirection).toBe('')
  
  it "should show not found items message", () ->
    scope.tableOptions.resetFilter = jasmine.createSpy "resetFilter"
    scope.$digest()
    pElement = element.find 'p'
    testMe = pElement.text()
    expect(pElement.length).toEqual(1)
    expect(testMe).toContain('There are no entries that matched the filter.')
    aElement = pElement.find 'a'
    expect(aElement).not.toBeNull()
    $(aElement).click()
    scope.$digest()
    expect(scope.tableOptions.resetFilter).toHaveBeenCalled()

  it "should show not found items message but not resetFilter", () ->
    scope.$digest()
    pElement = element.find 'p'
    testMe = pElement.text()
    expect(pElement.length).toEqual(1)
    expect(testMe).toContain('There are no entries that matched the filter.')
    expect(pElement.find('a').hasClass('ng-hide')).toBe(true)