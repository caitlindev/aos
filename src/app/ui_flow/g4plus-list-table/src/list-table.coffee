"use strict"


listTable = angular.module "g4plus-list-table.directive", [
  "ui.bootstrap"
]


listTable.directive "g4plusListTable", ["$filter", ($filter) ->
  restrict: "A"
  templateUrl: "g4plus-list-table-template.html"
  transclude: false
  scope: {
    options: "=g4plusListTable"

  }

  link: (scope, el, attr) ->
    scope.stationValues = []
    scope.filterByStation = (input) ->
      return jQuery.inArray(input.station.toUpperCase(), scope.filterArr) != -1

    scope.parseData = (item, column) ->

      if column.field.indexOf('.') > -1
        multipleColumns = column.field.split('.')
        itemField = item[multipleColumns[0]][multipleColumns[1]]
      else
        itemField = item[column.field]
      if column.field.indexOf('ataCode') > -1
        itemField = item.ataCode[0].chapter + item.ataCode[0].section

      if column.field?
        if column.filter
          return $filter([column.filter])(itemField, column.filterData) if column.filterData
          return $filter(itemField)(itemField)
        else
          return itemField
      else
        return ""

    scope.hasAction = (action) ->
      return scope.options?.actions?[ action + "Action" ]

    scope.hasState = (action) ->
      return scope.options?.actions?[ action + "State" ] \
        && scope.options?.actions?[ action + "StateParam" ] \
        && not scope.options?.actions?[ action + "Action" ]

    scope.hasLink = (action) ->
      return scope.options?.actions?[ action + "Link" ] \
        && not scope.options?.actions?[ action + "Action" ] \
        && not scope.options?.actions?[ action + "State" ]

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
]

listTable.run ["$templateCache", ($templateCache) ->
  return $templateCache.put "g4plus-list-table-template.html", """
    <table ng-class="options.tableClass" ng-show="options.items.length">
      <thead>
        <tr class="header_bar">
          <th ng-repeat="column in options.columns" ng-class="getColumnClass(column)" scope="col">{{ column.title }}
            <a href="javascript:void(0);" ng-if="hasSorting(column)" ng-click="setSortColumn(column)">
              <i ng-class="getSortingClass(column)"></i>
            </a>
          </th>
          <th ng-if="options.actions" class="actions medium" scope="col"></th>
        </tr>
      </thead>
      <tbody>
        <tr ng-repeat="item in options.items">
          <td ng-repeat="column in options.columns" ng-class="column.cellClass">
            <a ng-click, href="/#/view/{{item.id}}">{{ parseData(item, column) }}</a>
          </td>
          <td ng-if="options.actions" class="actions">
            <div class="clearfix">
              <a class="pull-right margin-left text-muted text-delete"
                 ng-if="hasAction('delete')"
                 ng-click="options.actions.deleteAction(item)">
                <i class="fa g4-icon-trash"></i> Delete
              </a>
              <a class="pull-right margin-left text-muted text-delete"
                 ng-if="hasLink('delete')"
                 ng-href="{{ options.actions.deleteLink + item.id }}">
                <i class="fa g4-icon-trash"></i> Delete
              </a>
              <a class="pull-right margin-left text-muted text-delete"
                 ng-if="hasState('delete')"
                 ui-sref="{{ options.actions.deleteState + '({' + options.actions.deleteStateParam + ': item.id })' }}">
                <i class="fa g4-icon-trash"></i> Delete
              </a>
              <a class="pull-right primary margin-left"
                 ng-if="hasAction('edit')"
                 ng-click="options.actions.editAction(item)">
                <i class="fa g4-icon-edit"></i> Edit
              </a>
              <a class="pull-right primary margin-left"
                 ng-if="hasLink('edit')"
                 ng-href="{{ options.actions.editLink + item.id }}">
                <i class="fa g4-icon-edit"></i> Edit
              </a>
              <a class="pull-right primary margin-left"
                 ng-if="hasState('edit')"
                 ui-sref="{{ options.actions.editState + '({' + options.actions.editStateParam + ': item.id })' }}">
                <i class="fa g4-icon-edit"></i> Edit
              </a>
              <a class="pull-right margin-left text-muted text-view"
                 ng-if="hasAction('view')"
                 ng-click="options.actions.viewAction(item)">
                <i class="fa g4-icon-view"></i> View
              </a>
              <a class="pull-right margin-left text-muted text-view"
                 ng-if="hasLink('view')"
                 ng-href="{{ options.actions.viewLink + item.id }}">
                <i class="fa g4-icon-view"></i> View
              </a>
              <a class="pull-right margin-left text-muted text-view"
                 ng-if="hasState('view')"
                 ui-sref="{{ options.actions.viewState + '({' + options.actions.viewStateParam + ': item.id })' }}">
                <i class="fa g4-icon-view"></i> View
              </a>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
    <p class="clearfix alert alert-warning margin-left margin-right margin-top"
       ng-show="!options.items.length && options.noItemsFoundMessage">
      {{ options.noItemsFoundMessage }}
      <a href="javascript:void(0);" ng-click="options.resetFilter()" ng-show="options.resetFilter">
       clear filter <i class="icon-remove"></i>
      </a>
    </p>
  """
]
