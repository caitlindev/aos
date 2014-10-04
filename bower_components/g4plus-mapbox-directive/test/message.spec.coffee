describe 'pagination message directive', () ->
  beforeEach () ->
    module "g4plus.pagination"

  scope = {}
  compile = {}
  element = {}

  beforeEach inject (_$compile_, _$rootScope_) ->
    scope = _$rootScope_
    compile = _$compile_

    scope.currentPage = 1
    scope.pageSize = 10
    scope.totalItems = 50

    element = compile('
      <div
        g4-pagination-message
        current-page="currentPage"
        page-size="pageSize"
        total-items="totalItems"
      >
      </div>')(scope)
    scope.$digest()

  it "has p tag defined", () ->
    expect(element.find('p').length).toBe(1)

  it "has the right message content", () ->
    messageHtml = element.find('p').html()

    expect(messageHtml).toContain('Showing')
    expect(messageHtml).toContain('<strong class="ng-binding">1</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">10</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">50</strong>')

  it "changing first page changes the message", () ->
    scope.currentPage = 2
    scope.pageSize = 10
    scope.totalItems = 50
    scope.$digest()
    messageHtml = element.find('p').html()

    expect(messageHtml).toContain('Showing')
    expect(messageHtml).toContain('<strong class="ng-binding">11</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">20</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">50</strong>')


  it "when no items show 'No results found' message", () ->
    scope.currentPage = 1
    scope.pageSize = 10
    scope.totalItems = 0
    scope.$digest()

    messageHtml = element.html()
    expect(messageHtml).toContain('<!-- ngIf: totalItems > 0 -->')
    expect(element.find('div').length).toBe(0)

  it "changing page size changes pagination", () ->
    scope.currentPage = 2
    scope.pageSize = 18
    scope.totalItems = 50
    scope.$digest()
    messageHtml = element.find('p').html()

    expect(messageHtml).toContain('Showing')
    expect(messageHtml).toContain('<strong class="ng-binding">19</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">36</strong>')
    expect(messageHtml).toContain('<strong class="ng-binding">50</strong>')


