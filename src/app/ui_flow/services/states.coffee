"use strict"

states = angular.module("services.states", [])


states.factory "StatesService", [
  "$http",
  ($http) ->


    getStates: (success, error) ->
      $http(
        method: "GET"
        url: "/api/states/"
      ).success(success).error(error)


]