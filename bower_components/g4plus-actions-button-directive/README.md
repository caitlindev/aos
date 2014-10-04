# G4 Actions Button Directive

The Actions Button directive facilitates the creation of a button that contains multiple actions displayed as a dropdown.

## Usage example

```jade
div(g4-actions-button, g4-actions-label="Actions", g4-actions-list="actionsList")
```

`actionsList` is a settings array that will be defined in each controller that uses the directive
and it contains all the parameters required by the directive

```coffeescript
$scope.actionsList = [
  {label: 'Add Oil Type', action: $scope.open, icon: 'g4-icon-add'},
  {label: '', separator: true},
  {label: 'Help', action: null, link: "/help", linkState: null, icon: 'g4-icon-help'}
]
```

The `icon` parameter is required, the `action`, `link` and `linkState` parameters are optional.
If present, the `action` parameter should receive a function to be executed when the link is clicked.
The `link` is an optional parameter and if present will contain a string that is the URL to be followed.
The `linkState` is optional and is used if instead of the normal URL (ng-href) is preferred the use
of angular-ui ui-router (ui-sref).

Also, if the `separator` parameter is provided without any other parameters, then a separator line
will be created. This may be used if needed to separate different groups of actions.