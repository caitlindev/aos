home = angular.module "app.home", [ ]

# Home controller
# =====
# Handles the home sub-app for the project
#  - bullet point 1
#  - bullet point 2
#  - bullet point 3
home.controller "HomeCtrl", [
  '$scope'

  ($scope) ->
    # pageTitle: holds the title of the page
    $scope.pageTitle = "MX Skeleton Project"
    # Foo variable. Very important, but loney without Bar.
    $scope.foo = "Welcome to the G4Plus Brunch/AngularJS/Jade Skeleton!"
]