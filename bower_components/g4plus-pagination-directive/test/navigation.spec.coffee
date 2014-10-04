describe 'pagination navigation directive', () ->
  beforeEach () ->
    module "g4plus.pagination"

  scope = {}
  compile = {}
  element = {}

  beforeEach inject (_$compile_, _$rootScope_) ->
    scope = _$rootScope_.$new()
    compile = _$compile_

    scope.currentPage = 1
    scope.pageSize = 10
    scope.totalItems = 50
    scope.totalPages = 5

    scope.pageChange = () ->

    element = compile('
      <div
        g4-pagination-navigation=""
        current-page="currentPage"
        total-pages="totalPages"
        page-change="pageChange"
      ></div>')(scope)
    scope.$digest()

  it "has the dropdown defined", () ->
    expect(element.find('div.btn-group').length).toBe(1)
    expect(element.find('[data-toggle="dropdown"]').html()).toContain("1 of 5")

  it "should not display if page number is zero", () ->
    scope.totalPages = 0
    scope.$digest()
    expect(element.children().length).toEqual(0)

  it "should be able to set page", () ->
    scope.$$childTail.setPage(2)
    scope.$digest()
    expect(scope.currentPage).toEqual(2)
    expect(scope.$$childTail.page).toEqual(2)
