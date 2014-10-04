"use strict"

stations = angular.module("services.stations", [])


stations.factory "StationsService", [
  "$http",
  ($http) ->


    getStations: (success, error) ->
      $http(
        method: "GET"
        url: "/api/stations/"
      ).success(success).error(error)





]