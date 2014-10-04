'use strict'

superList = angular.module 'g4plus-super-list', [
  'ui.bootstrap'
  'g4plus-list-table.directive'
  'g4plus.pagination'
  'g4plus.list-filter'
  'g4plus.autofocus'
  'g4plus.load-component'
]

superList.directive 'g4plusSuperList', ['$filter', '$timeout', '$compile', '$templateCache'
, ($filter, $timeout, $compile) ->
  restrict: 'A'
  transclude: true
  templateUrl: (element, attrs) ->
    layoutTypes = ['basic', 'left-column', 'right-column', 'single-column']
    tUrl = 'basic'
    if attrs.g4Layout and attrs.g4Layout in layoutTypes
      tUrl = attrs.g4Layout
    return 'g4plus-super-list-' + tUrl + '.html'

  scope: {
    service: '=g4Service'
    actions: '=g4Actions'
    columns: '=g4Columns'
    filters: '=g4Filters'
    params: '=g4Params'
    updateUrl: '=g4UpdateUrl'
    successCall: '=g4Success'
    errorCall: '=g4Error'
    options: '=?g4Options'
  }
  link: (scope, element, attrs) ->
    loadId = scope?.service?.loadId
    loadType = if (scope?.service?.loadType) then scope.service.loadType else 'progress'
    if scope?.service?.loadId
      elm = $compile('<div load-component load-id="'+loadId+'" load-type="'+loadType+'"></div>')(scope)
      element.append elm

  controller: ($scope) ->
    # supported types
    _serviceTypes = [ 'array', 'promise', 'resource', 'http' ]

    $scope.service = { type: _serviceTypes[0] } if not $scope.service
    $scope.qip = true

    _updateUrl = () ->
      # check if update url is defined
      $scope.updateUrl() if angular.isFunction($scope.updateUrl)

    _validateParams = () ->
      # validate paramters
      _before = angular.copy($scope.params)
      $scope.params = {} if not $scope.params
      $scope.params.pagination = {} if not $scope.params.pagination

      _pagination = $scope.params.pagination
      _pagination.page = 1 if isNaN parseInt(_pagination.page, 10)
      _pagination.pageSize = 10 if isNaN parseInt(_pagination.pageSize, 10)

      _pagination.page = Math.max 1, _pagination.page
      _pagination.pageSize = Math.max 10, _pagination.pageSize

      if !angular.equals(_before, $scope.params)
        _updateUrl()

      sorting = $scope.params.sorting
      sortColumn = ''
      sortDirection = ''

      if sorting
        if sorting[0] is '-'
          sortColumn = sorting.substring(1)
          sortDirection = '-'
        else
          sortColumn = sorting
          sortDirection = ''

      for col in $scope.columns
        if col.sorting and col.sortingField and col.sortingField is sortColumn
          sortColumn = col.field
          break

      $scope.tableOptions.sortColumn = sortColumn
      $scope.tableOptions.sortDirection = sortDirection

      $scope.filterState.optionList = []
      for filter in $scope.filters
        if filter.visible and filter.key and filter.label
          $scope.filterState.optionList.push({ key: filter.key, label: filter.label })

    # set sorting callback
    _setSorting = (column, direction) ->
      sortField = column
      for col in $scope.columns
        if col.sorting and col.sortingField and col.field and col.field is column
          sortField = col.sortingField
          break

      $scope.params.sorting = direction + sortField
      $scope.params.pagination.page = 1
      _updateUrl()

    # filter:
    $scope.filterState =
      optionList: []
      filterBy: (value, option) ->
        $scope.params.filters.filter_value = value
        $scope.params.filters.filter_option = option
        _updateUrl()
      resetFilter: () ->
        angular.forEach $scope.params.filters, (value, key) ->
          $scope.params.filters[key] = ''
        $scope.params.filters.filter_option = '_all'
        $scope.params.pagination.page = 1
        _updateUrl()

    # table list:
    $scope.tableOptions =
      items: []
      noItemsFoundMessage: 'There are no entries that matched the filter.'
      resetFilter: $scope.filterState.resetFilter
      tableClass: 'table-lined'
      actions: $scope.actions
      columns: $scope.columns
      onSortColumn: _setSorting
      templateUrl: (if ($scope.options?.tableTemplateUrl) then $scope.options.tableTemplateUrl else null)

    # pagination:
    $scope.pagination =
      totalItems: 0
      totalPages: 0
      pageSizeChange: (pageSize) ->
        $scope.params.pagination.page = 1
        $scope.params.pagination.pageSize = pageSize
        $scope.updateUrl()

      pageChange: (page) ->
        $scope.params.pagination.page = page
        $scope.updateUrl()

    _filterItems = (input, value, option) ->
      output = input
      # Only check when filtering by some input value
      if value and value.length
        if option && option != '_all'
          filter_column = {}
          filter_column[option] = value
          output = $filter('filter')(input, filter_column)
        else
          output = $filter('filter')(input, value)
      return output

    _success = (data, status, header, config) ->
      items = []
      visibleItems = []
      total = 0

      if angular.isArray(data?.items)
        items = data.items
        total = data.total
      else if angular.isArray(data)
        items = data
        total = data.length

      if items and not $scope.service.hasSorting
        sortColumn = $scope.tableOptions.sortColumn
        sortDirection = (if ($scope.tableOptions?.sortDirection is '-') then true else false)
        items = $filter('orderBy')(items, sortColumn, sortDirection) if $scope.tableOptions.sortColumn

      if items and not $scope.service.hasFiltering
        _filters = $scope.params.filters
        angular.forEach $scope.filters, (filter) ->
          if filter.key
            if (filter.type is 'strict' or filter.type is 'field') and _filters?[filter.key]
              filter_data = {}
              filter_data[filter.key] = _filters[filter.key]
              items = $filter('filter')(items, filter_data, 'strict')
            else if filter.type is 'keyword' and _filters?.filter_option is filter.key
              items = _filterItems(items, _filters.filter_value, _filters.filter_option)
        total = items.length

      if items and not $scope.service.hasPagination
        fromItem = ($scope.params.pagination.page - 1) * $scope.params.pagination.pageSize
        toItem = $scope.params.pagination.page * $scope.params.pagination.pageSize
        items = items.slice fromItem, toItem

      $scope.tableOptions.items = items
      $scope.pagination.totalItems = total
      $scope.pagination.totalPages = Math.ceil total / $scope.params.pagination.pageSize

      if $scope.params.pagination.page > 1 && $scope.params.pagination.page > $scope.pagination.totalPages
        $scope.params.pagination.page = $scope.pagination.totalPages
        $scope.updateUrl()

      $scope.qip = false

      $scope.successCall(data, status, header, config) if angular.isFunction($scope.successCall)

    _error = (data, status, header, config) ->
      $scope.qip = false
      $scope.tableOptions.items = []
      $scope.pagination.totalItems = 0
      $scope.pagination.totalPages = 0
      $scope.errorCall(data, status, header, config) if angular.isFunction($scope.errorCall)

    _loadListSimple = (data) ->
      _success(data)

    _loadListPromise = (promise) ->
      promise.then _success, _error if promise

    _getQueryPrams = () ->
      params = {}
      if $scope.service.hasFiltering
        params.filter = ''
        _filters = $scope.params.filters
        angular.forEach $scope.filters, (filter) ->
          if filter.key
            if filter.type == 'strict' and _filters?[filter.key]
              if filter.prefix
                params.filter += filter.prefix + _filters?[filter.key]
              else
                params.filter += '|' + filter.key + '::' + _filters?[filter.key]
            else if filter.type == 'field' && _filters?[filter.key]
              params[filter.key] = _filters[filter.key]
            else if filter.type == 'keyword' and _filters.filter_option is filter.key and _filters.filter_value
              if filter.prefix
                params.filter += filter.prefix + _filters.filter_value
              else
                params.filter += '|' + filter.key + '::' + _filters.filter_value

      if $scope.service.hasSorting and $scope.params.sorting
        params.sort = $scope.params.sorting
      if $scope.service.hasPagination
        params.page = $scope.params.pagination.page
        params.limit = $scope.params.pagination.pageSize
      return params

    _loadListResource = (resource) ->
      params = _getQueryPrams()
      _loadListPromise(resource?(params)?.$promise)

    _loadListHttp = (httpCall) ->
      params = _getQueryPrams()
      httpCall params, _success, _error

    _loadList = () ->
      $scope.qip = true
      _validateParams()

      data = $scope.service?.data
      switch $scope.service.type
        when 'array' then _loadListSimple(data)
        when 'promise' then _loadListPromise(data?.$promise)
        when 'resource' then _loadListResource(data)
        when 'http' then _loadListHttp(data)
        else _loadListSimple(data)

    $scope.$on 'SuperList:reload', (event, e) ->
      _loadList()

    _loadList()
]

superList.run ['$templateCache', ($templateCache) ->
  return $templateCache.put 'g4plus-super-list-basic.html', '''
    <form class="table-tools form-horizontal row no-left-padding no-right-padding">
      <fieldset>
        <div class="filter-box" g4-list-filter="" g4-filter-options="filterState.optionList" g4-filter-by="filterState.filterBy" g4-filter-value="params.filters.filter_value" g4-filter-option="params.filters.filter_option"></div>
      </fieldset>
    </form>

    <form class="pull-left table-tools form-horizontal row no-left-padding no-right-padding">
      <fieldset>
        <ul class="horizontal pull-left no-left-padding margin-left">
            <li>
              <span ng-transclude></span>
              <div g4-pagination-pagesize="" page-size="params.pagination.pageSize" page-size-change="pagination.pageSizeChange"></div>
            </li>
        </ul>
      </fieldset>
    </form>

    <div class="pull-right row pad-left pad-right" ng-hide="qip" ng-hide="options.noPagination">
      <div class="pull-right" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
      <div class="pull-right pagination-message margin-right" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
    </div>

    <div g4plus-list-table="tableOptions" ng-hide="qip"></div>

    <div class="row pad-left pad-right" ng-hide="qip" ng-hide="options.noPagination">
      <div class="pull-right" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
      <div class="pull-right pagination-message margin-right" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
    </div>
  '''
]

superList.run ['$templateCache', ($templateCache) ->
  return $templateCache.put 'g4plus-super-list-left-column.html', '''
    <div class="row">
      <div class="col-xs-2 page-filters">
        <div class="form-group">
          <button class="btn btn-secondary pull-right" ng-click="filterState.resetFilter()">Reset</button>
          <label class="bold">Filter</label>
        </div>
        <span ng-transclude></span>
      </div>
      <div class="col-xs-10">
        <div class="table-tools row" ng-hide="options.noPagination">
          <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
          <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
        </div>
        <div g4plus-list-table="tableOptions" ng-hide="qip"></div>
        <div class="table-tools row" ng-hide="options.noPagination">
          <div g4-pagination-pagesize="" page-size="params.pagination.pageSize" page-size-change="pagination.pageSizeChange"></div>
          <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
          <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
        </div>
      </div>
    </div>
  '''
]

superList.run ['$templateCache', ($templateCache) ->
  return $templateCache.put 'g4plus-super-list-right-column.html', '''
    <div class="row">
      <div class="col-xs-10">
        <div class="table-tools row" ng-hide="options.noPagination">
          <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
          <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
        </div>
        <div g4plus-list-table="tableOptions" ng-hide="qip"></div>
        <div class="table-tools row" ng-hide="options.noPagination">
          <div g4-pagination-pagesize="" page-size="params.pagination.pageSize" page-size-change="pagination.pageSizeChange"></div>
          <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
          <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
        </div>
      </div>
      <div class="col-xs-2 page-filters">
        <div class="form-group">
          <button class="btn btn-primary pull-right" ng-click="filterState.resetFilter()">Reset</button>
          <label class="bold">Filter</label>
        </div>
        <span ng-transclude></span>
      </div>
    </div>
  '''
]

superList.run ['$templateCache', ($templateCache) ->
  return $templateCache.put 'g4plus-super-list-single-column.html', '''
    <div class="row">
      <div class="row table-tools" ng-hide="options.noPagination">
        <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
        <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
      </div>
      <div g4plus-list-table="tableOptions" ng-hide="qip"></div>
      <div class="row table-tools" ng-hide="options.noPagination">
        <div g4-pagination-pagesize="" page-size="params.pagination.pageSize" page-size-change="pagination.pageSizeChange"></div>
        <div class="pull-right margin-left" g4-pagination-navigation="" current-page="params.pagination.page" total-pages="pagination.totalPages" page-change="pagination.pageChange"></div>
        <div class="pull-right pagination-message" g4-pagination-message="" current-page="params.pagination.page" page-size="params.pagination.pageSize" total-items="pagination.totalItems"></div>
      </div>
    </div>
  '''
]
