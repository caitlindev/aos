"use strict"

favs = angular.module "settings-favorites", [
  "g4plus-user"
  "services.mx_menu_favorites"
  "services.mx_menu"
]

favs.controller "UserFavoritesCtrl", [
  '$scope'
  'MXMenuFavoritesService'
  ($scope, MXMenuFavoritesService) ->

    $scope.updateFavorites = (favorites) ->
      $scope.favoritesData = favorites

]


favs.directive "userFavorites", () ->
  restrict: 'EA'
  replace: true
  scope: {
    favoritesData: "=favoritesData"
    deleteFunc: "=deleteFunc"
  }
  controller: 'UserFavoritesCtrl'
  template: """
    <div>
      <div class="form-container col-sm-12 no-right-padding no-left-padding">
        <h2 id="header-title">Manage Favorites</h2>

        <ul class="list-unstyled lined favorites-box" style="border-radius: 0 !important">
          <li ng-model="favoritesData" ng-repeat="app in favoritesData" class="favorites-list no-right-padding">
            <span>
              <div ng-click="deleteFunc(app.id, updateFavorites)" class="pull-right remove-icon">
                <i class='icon icon-minus-sign'></i>
              </div>
              <a href="{{app.url}}" target="_blank">&nbsp;&nbsp;{{app.name}}</a>
            </span>
          </li>
          <li ng-if="favoritesData == 0">You don't have any favorites yet.</li>
        </ul>
      </div>
    </div>
  """
