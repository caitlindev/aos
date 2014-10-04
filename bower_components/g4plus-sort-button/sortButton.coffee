"use strict"

# * @fileoverview Directive for adding sort buttons.
# * @author       Mel Cruz (mel.cruz@allegiantair.com)
# * @module       g4plus.sort-button
#
# Sample Usage:
#     table.table-lined
#       thead(current-sort-col="params.sort")
#         th(sort-by="cardNumber") My Column
#         th(sort-by="title") Second Column
#
sb = angular.module "g4plus.sort-button", []

# currentSortCol
# -----
# This directive takes the current sort column value
# and maintains a two-way binding to allow the directive
# to update the sort column.
sb.directive "currentSortCol", () ->
  restrict: 'A'
  replace: false
  scope:
    currentSortCol: '='
  controller: "currentSortColCtrl"

# currentSortColCtrl
# -----
# This controller provides access for the sortBy directive
# to update the two-way binding for the current sort column.
sb.controller "currentSortColCtrl", [
  '$scope'
  '$element'
  '$attrs'
  ($scope, $element, $attrs) ->

    # Set the currentSortCol variable to the new non-empty value
    $scope.$watch "currentSortCol", (newValue) ->
      if !!newValue
        $scope.currentSortCol = newValue

    # ### @getCurrentSortCol
    # Gets the current sort column.
    #
    # - @returns {String} returns the current sort column
    @getCurrentSortCol = () -> return $scope.currentSortCol

    # ### @getCurrentSortCol
    # Sets the current sort column.
    #
    # - @param {String} newCol value of the new sort column
    @setCurrentSortCol = (newCol) ->
      $scope.currentSortCol = newCol

    return
]

# sortBy
# -----
# This directive takes the sort column name and matches it
# against the current sort column and adjust the button
# icons accordingly.
sb.directive "sortBy", () ->
  restrict: 'A'
  replace: false
  require: '^currentSortCol'
  scope:
    sortBy: '@'
  controller: "sortCtrl"

  # ### link function
  # Linking function that provides access to the required controller.
  #
  # - @param {Object} scope the scope of the directive controller
  # - @param {Object} element the element to which the directive is
  # applied to.
  # - @param {Object} attrs the attributes object
  # - @param {Object} currentSortColCtrl this is the controller instance provided by the 'require'.
  link: (scope, element, attrs, currentSortColCtrl) ->

    # Call the required controller function to get the current sort column.
    scope.currentSortCol = currentSortColCtrl.getCurrentSortCol()

    # #### setSortColumn
    # Sets the new sort column and switches the direction
    # if the new sort column is the same as the current sort column.
    #
    # - @param {String} col the new column to set
    scope.setSortColumn = (col) ->
      newDir = ''
      if scope.currentSortCol.match col
        newDir = if scope.currentSortCol.match /^-/ then '' else '-'

      scope.sortDirection = newDir
      scope.currentSortCol = newDir+col
      currentSortColCtrl.setCurrentSortCol(newDir+col)

      element.siblings().removeClass('col-control')

      return

    # ### isSortColumn
    # This function checks if the sortBy column is the same as the current sort column.
    #
    # - @param {String} col column name
    # - @returns {Boolean} returns true if col matches the current sort column.
    scope.isSortColumn = (col) ->
      p = new RegExp '^(\-)?'+col+'$', 'g'
      return if currentSortColCtrl.getCurrentSortCol().match p then true else false

  transclude: true
  template: """
    <span ng-transclude></span> <a href="javascript:void(0);" ng-click="setSortColumn(sortBy)"><i ng-class="(sortDirection && isSortColumn(sortBy)) ? ('icon-angle-'+sortDirectionIcon) : 'icon-sort'"></i></a>
  """

# sortCtrl
# ----
# This controller provides functions for the `sortBy` directive.
sb.controller "sortCtrl", [
  '$scope'
  '$element'
  '$attrs'
  ($scope, $element, $attrs) ->

    # Set up a watch on currentSortCol.
    $scope.$watch "currentSortCol", () ->
      if !!$scope.currentSortCol
        if $scope.isSortColumn($scope.sortBy)

          # Get direction, then reverse it.
          $scope.sortDirection = if (!!$scope.currentSortCol && $scope.currentSortCol.match /^-/) then '-' else '+'

          # Set the active class `col-control` on the `th`.
          # Note that this happens on load.
          $element.addClass('col-control')

    # Watch sortDirection and update the associated icon.
    $scope.$watch "sortDirection", () ->
      $scope.sortDirectionIcon = if ($scope.sortDirection == '-') then 'down' else 'up'

]