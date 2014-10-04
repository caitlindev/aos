pagination = angular.module 'g4plus.pagination', [ ]

pagination.directive "g4PaginationMessage", () ->
  restrict: "A"
  replace: true
  scope:
    page: "=currentPage"
    pageSize: "=pageSize"
    totalItems: "=totalItems"
  template:  """
    <div>
      <p ng-if="totalItems > 0">
        Showing <strong>{{ startRecord() }}</strong>
        to <strong>{{ endRecord() }}</strong>
        of <strong>{{ totalItems }}</strong> entries
      </p>
    </div>
  """
  link: (scope, element, attrs) ->

    scope.startRecord = () -> 
      (scope.page - 1) * scope.pageSize + 1

    scope.endRecord = () -> 
      endRecord = (scope.page) * scope.pageSize
      endRecord = scope.totalItems if scope.totalItems < endRecord
      endRecord

pagination.directive "g4PaginationNavigation", () ->
  restrict: "A"
  replace: true
  scope:
    page: "=currentPage"
    totalPages: "=totalPages"
    onPageChange: "=pageChange"
  template: """
    <div>
      <ul
        ng-if="totalPages > 1"
        class="pagination pagination-sm pull-right"
      >
        
        <li
          ng-disabled="page <= 1"
          ng-class="page <= 1 ? 'disabled' : '' ">
          
          <a href="javascript:void(0)" ng-click="setPage(page - 1)"><i class="fa fa-angle-left"></i></a>
       
        </li>
        
        <li>
          <div class="btn-group">
            <a data-toggle="dropdown">
              {{ page }} &nbsp;&nbsp;
              <i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu no-padding bottom-up">
              <li
                ng-repeat="p in pages()"
                ng-class="(p == page) ? 'active' : '' "
              >
                <a
                  href="javascript:void(0)"
                  ng-click="setPage(p)">
                  {{ p }}
                </a>
              </li>
            </ul>
          </div>
        </li>

        <li
          ng-disabled="page >= pages().length"
          ng-class="page >= pages().length ? 'disabled' : '' ">

          <a href="javascript:void(0);" ng-click="setPage(page + 1)"><i class="fa fa-angle-right"></i></a>

        </li>

      </ul>
    </div>
  """

  link: (scope, element, attrs) ->

    scope.page = parseInt(scope.page)

    scope.pages = () -> [1...(scope.totalPages + 1)]

    scope.setPage = (page) ->
      if page >= 1 and page <= scope.totalPages
        scope.page = page
        scope.onPageChange?(page)

pagination.directive "g4PaginationPagesize", () ->
  restrict: "A"
  replace:  true
  scope:
    pageSize: "=pageSize"
    onPageSizeChange: "=pageSizeChange"
  template: """
    <span>
      <select
        id="items-per-page"
        ng-model="pageSize"
        ng-options="value for value in pageSizeList"
        ng-change="setPageSize()"
        class="form-control">
      </select>
      &nbsp;
      <label
        for="items-per-page"
        class="control-label no-left-padding">
        Items per page
      </label>
    </span>
  """

  link: (scope, element, attrs) ->
    scope.pageSizeList = [10, 25, 50, 100]

    scope.setPageSize = () ->
      scope.onPageSizeChange?(scope.pageSize)