"use strict"

listTable = angular.module "g4plus-list-table.directive", [
  "ui.bootstrap"
]

listTable.directive "g4plusListTable", ["$filter", "$compile", "$templateCache", "$http"
, ($filter, $compile, $templateCache, $http) ->
  restrict: "A"
  transclude: false
  scope: {
    options: "=g4plusListTable"
  }

  link: (scope, el, attr) ->
    scope.parseData = (item, column) ->
      if column.field?
        if column.filter
          return $filter([column.filter])(item[column.field], column.filterData) if column.filterData
          return $filter([column.filter])(item[column.field])
        else
          return item[column.field]
      else
        return ""

    scope.hasAction = (action) ->
      return scope.options?.actions?[ action + "Action" ]

    scope.hasState = (action) ->
      return scope.options?.actions?[ action + "State" ] && scope.options?.actions?[ action + "StateParam" ] && not scope.options?.actions?[ action + "Action" ]

    scope.hasLink = (action) ->
      return scope.options?.actions?[ action + "Link" ] && not scope.options?.actions?[ action + "Action" ] && not scope.options?.actions?[ action + "State" ]

    scope.setSortColumn = (column) ->
      if scope?.options?.sortColumn && scope?.options?.sortColumn is column.field
        scope.options.sortDirection = (if (scope.options.sortDirection is "-") then "" else "-")

      scope.options.sortColumn = column.field

      scope.options?.onSortColumn?(scope.options.sortColumn, scope.options.sortDirection)

    scope.hasSorting = (column) ->
      return (column.sorting)

    scope.getSortingClass = (column) ->
      if column?.field? && scope.options.sortColumn is column.field
        return "icon-sort-" + (if (scope.options.sortDirection is "-") then "down" else "up")
      else
        return "icon-sort"

    scope.getColumnClass = (column) ->
      columnClass = (if (column?.columnClass?) then column.columnClass else "")
      if column?.sorting && scope.options.sortColumn is column.field
        columnClass += ' col-control'
      return columnClass

    _buildActions = () ->
      return '' if not scope.options?.actions
      a = scope.options.actions
      aT = []

      lnk = ''
      if a.deleteAction or (a.deleteState and a.deleteStateParam) or a.deleteLink
        lnk = '<a class="pull-right margin-left primary"'
        if a.deleteAction
          lnk += ' ng-click="options.actions.deleteAction(item)" '
        else if a.deleteLink
          lnk += ' ng-href="{{ options.actions.deleteLink + item.id }}" '
        else if a.deleteState
          lnk += ' ui-sref="{{ options.actions.deleteState + \'({\' + options.actions.deleteStateParam + \': item.id })\' }}" '

        lnk += '><i class="fa g4-icon-trash"></i> Delete</a>'
        aT.push lnk

      if a.editAction or (a.editState and a.editStateParam) or a.editLink
        lnk = '<a class="pull-right primary margin-left"'
        if a.editAction
          lnk += ' ng-click="options.actions.editAction(item)" '
        else if a.editLink
          lnk += ' ng-href="{{ options.actions.editLink + item.id }}" '
        else if a.editState
          lnk += ' ui-sref="{{ options.actions.editState + \'({\' + options.actions.editStateParam + \': item.id })\' }}" '

        lnk += '><i class="fa g4-icon-edit"></i> Edit</a>'
        aT.push lnk

      if a.viewAction or (a.viewState and a.viewStateParam) or a.viewLink
        lnk = '<a class="pull-right primary margin-left"'
        if a.viewAction
          lnk += ' ng-click="options.actions.viewAction(item)" '
        else if a.viewLink
          lnk += ' ng-href="{{ options.actions.viewLink + item.id }}" '
        else if a.viewState
          lnk += ' ui-sref="{{ options.actions.viewState + \'({\' + options.actions.viewStateParam + \': item.id })\' }}" '

        lnk += '><i class="fa g4-icon-view"></i> View</a>'
        aT.push lnk

      if a.custom and angular.isArray(a.custom)
        aT.push '<a ng-repeat="action in options.actions.custom" class="pull-right margin-left" ng-class="action.class" ng-click="action.callback(item)"><i ng-if="action.icon" class="{{action.icon}}"></i> {{action.title}}</a>'

      scope.hasActions = (aT.length)
      if aT.length
        scope.hasActions = true
        return '<td class="actions"><div class="clearfix">' + aT.join(' ') + '</div></td>'
      return ''

    _buildActionsHeader = () ->
      return '<th class="actions medium" scope="col"></th>' if scope.hasActions
      return ''

    _loadTemplate = (templateUrl) ->
      $http.get(templateUrl, { cache: $templateCache })
      .success (tC) ->
        tC = tC.replace '{{_actions_}}', _buildActions()
        tC = tC.replace '{{_actions_header_}}', _buildActionsHeader()
        el.replaceWith($compile(tC)(scope))

    templateUrl = scope.options.templateUrl || "g4plus-list-table-template.html"
    _loadTemplate(templateUrl)
]

listTable.run ["$templateCache", ($templateCache) ->
  return $templateCache.put "g4plus-list-table-template.html", """
    <table ng-class="options.tableClass" ng-show="options.items.length">
      <thead>
        <tr>
          <th ng-repeat="column in options.columns" ng-class="getColumnClass(column)" scope="col">{{ column.title }}
            <a href="javascript:void(0);" ng-if="column.sorting" ng-click="setSortColumn(column)">
              <i ng-class="getSortingClass(column)"></i>
            </a>
          </th>
          {{_actions_header_}}
        </tr>
      </thead>
      <tbody>
        <tr ng-repeat="item in options.items">
          <td ng-repeat="column in options.columns" ng-class="column.cellClass">
            <a href="javascript:void(0);" ng-click="column.callback(item)" ng-if="column.callback">{{ parseData(item, column) }}</a>
            <span ng-if="!column.callback">{{ parseData(item, column) }}</span>
          </td>
          {{_actions_}}
        </tr>
      </tbody>
    </table>
    <p class="clearfix alert alert-warning margin-left margin-right margin-top" ng-show="!options.items.length && options.noItemsFoundMessage">{{ options.noItemsFoundMessage }} <a href="javascript:void(0);" ng-click="options.resetFilter()" ng-show="options.resetFilter"> clear filter <i class="icon-remove"></i></a></p>
  """
]
