"use strict"

mx_menu = angular.module("services.mx_menu", [])


mx_menu.factory "MXMenuService", [
  "$http",
  ($http) ->

    loadMenu: (success, error) ->
      $http({
        method: "GET"
        url: "/api/menu/"
      }).success(success).error(error)

    createMenuItem: (data, success, error) ->
      $http({
        method: "POST"
        url: "/api/menu/"
        data: data
      }).success(success).error(error)

    deleteMenuItem: (id, success, error) ->
      $http({
        method: "DELETE"
        url: "/api/menu/" + id
      }).success(success).error(error)

]