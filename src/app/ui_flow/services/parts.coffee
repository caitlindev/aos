"use strict"

parts = angular.module("services.parts", [])


parts.factory "PartsService", [
  "$http",
  ($http) ->


    getParts: (success, error) ->
      $http(
        method: "GET"
        url: "/api/parts/"
      ).success(success).error(error)





]