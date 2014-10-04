"use strict"

tailNumbers = angular.module("services.tailNumbers", [])


tailNumbers.factory "TailNumberService", [
  "$http",
  ($http) ->

    getTailNumbers: (success, error) ->
      $http(
        method: "GET"
        url: "/api/tails"
      ).success(success).error(error)

]