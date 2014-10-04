# List Filter Module
# ==================
# Make sure you include this module if you want to use the directive
listFilter = angular.module 'g4plus.list-filter', [
  'g4plus.autofocus'
]

listFilter.directive "g4ListFilter", () ->
  restrict: "A"
  replace: false
  scope:
    options:  "=g4FilterOptions"
    filterBy: "=g4FilterBy"
    filter_value: "=g4FilterValue"
    filter_option: "=g4FilterOption"
  template:  """
    <div class='filter-box'>
      <ul class="horizontal">
        <li class="pull-right margin-left no-right-margin" ng-if="options">
          <div class="btn-group text-left">

            <span
              type="button"8
              data-toggle="dropdown"
              class="filter-button dropdown-toggle ng-binding">
              <span class="fa fa-angle-down"></span>
              <p>{{optionToLabel(filter_option)}}</p>
            </span>

            <button
              type="button"
              class="btn btn-secondary">
              <span class="fa fa-search"></span>
            </button>

            <ul class="dropdown-menu no-padding pull-right">

              <li ng-repeat="option in options">
                <a ng-click="filterByOption(option.key)"
                   href="javascript: void(0);">

                  {{option.label}}

                </a>
              </li>

            </ul>

          </div>
        </li>

        <li class="pull-right margin-left no-right-margin">
          <div class="btn-group text-left">
            <label for="g4-list-filter-input" class="control-label text-right">
              Filter:
            </label>
            <input type="text"
              placeholder="Search"
              class="form-control ng-pristine"
              ng-model="filter_value"
              id="g4-list-filter-input"
              ng-keyup="filterByValue($event)"
              g4-autofocus
            />
          </div>
        </li>
      </ul>
    </div>
  """
  link: (scope, element, attrs) ->
    scope.optionToLabel = (searched_key) ->
      for option in scope.options
        if option.key == searched_key
          return option.label.toUpperCase()
      return ''

    scope.filterByOption = (new_option) ->
      scope.filterBy?(scope.filter_value, new_option)

    scope.filterByValue = (ev) ->
      if ev.which == 13
        scope.filterBy?(scope.filter_value, scope.filter_option)

# This will reset filter in case the length becomes 0
#      else if scope.filter_value.length == 0
#        scope.executeFilterBy('', scope.filter_option)

