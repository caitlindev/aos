"use strict"

mx_menu_favorites = angular.module("services.mx_menu_favorites", [])


mx_menu_favorites.factory "MXMenuFavoritesService", [
  "$http",
  ($http) ->

    loadFavorites: (success, error) ->
      $http({
        method: "GET"
        url: "/api/favorites/"
      }).success(success).error(error)

    createFavorite: (data, success, error) ->
      $http({
        method: "POST"
        url: "/api/favorites/"
        data: data
      }).success(success).error(error)

    deleteFavorite: (id, success, error) ->
      $http({
        method: "DELETE"
        url: "/api/favorites/" + id
      }).success(success).error(error)

]