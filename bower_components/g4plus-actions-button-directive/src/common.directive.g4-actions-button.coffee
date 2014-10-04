actionsButtonTemplate = ""

ActionsButton = angular.module "g4ActionsButton", []

ActionsButton.directive "g4ActionsButton", () ->
  restrict: "A"
  replace: true
  template: actionsButtonTemplate 
  scope: {
    actionsList: "=g4ActionsList"
    actionsLabel: "@g4ActionsLabel"
  }
  link: ($scope, element, attributes) ->
    $scope.doAction = (action) ->
      if angular.isFunction(action.action) then action.action()

    $scope.isType = (action, paramType) ->
      switch paramType 
        when "action"
          if action.action then return true
        when "link"
          if action.link and not action.action? then return true
        when "state"
          if action.stateLink then return true
        when "none"
          if not (action.action or action.link or action.stateLink or action.separator) 
            return true
      return false

actionsButtonTemplate = """
<div class="btn-group">
  <button type="button" data-toggle="dropdown" class="btn btn-success dropdown-toggle">{{ actionsLabel }}&nbsp;
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu no-padding pull-right text-left">
    <li ng-repeat="action in actionsList" ng-class="{divider: action.separator}">
      <a href="javascript:void(0);" ng-if="isType(action, 'action')" ng-click="doAction(action)">
        <i ng-class="action.icon" class="fa"></i>&nbsp;{{ action.label }}
      </a>
      <a href="javascript:void(0);" ng-if="isType(action, 'link')" ng-href="{{ action.link }}">
        <i ng-class="action.icon" class="fa"></i>&nbsp;{{ action.label }}
      </a>
      <a href="javascript:void(0);" ng-if="isType(action, 'state')" ui-sref="{{ action.stateLink }}">
        <i ng-class="action.icon" class="fa"></i>&nbsp;{{ action.label }}
      </a>
      <a href="javascript:void(0);" ng-if="isType(action, 'none')">
        <i ng-class="action.icon" class="fa"></i>&nbsp;{{ action.label }}
      </a>
    </li>
  </ul>
</div>
"""