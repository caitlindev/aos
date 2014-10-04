describe 'pagination pagesize directive', () ->
  beforeEach () ->
    module "g4plus.pagination"

  scope = {}
  compile = {}
  element = {}

  beforeEach inject (_$compile_, _$rootScope_) ->
    scope = _$rootScope_
    compile = _$compile_

    scope.pageSize = 1
    scope.pageSizeChange = (pageSize) ->

    element = compile('
      <div g4-pagination-pagesize page-size="pageSize" page-size-change="pageSizeChange"></div>')(scope)
    scope.$digest()

  it "has select tag defined", () ->
    expect(element.find('select').length).toBe(1)
    expect(element.find('select').children().length).toBe(5)
