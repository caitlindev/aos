"use strict"

stations = angular.module("services.tail_routes", [])


stations.factory "TailRoutesService", [
  "$http",
  ($http) ->


    getTailRoutes: (params, success, error) ->
      $http(
        method: "GET"
        url: "/api/tailroutes/"
      ).success(success).error(error)



    getTailRouteByTailNbr: (tailNbr, success, error) ->
      $http(
        method: "GET"
        url: "/api/tailroutes/" + encodeURIComponent(tailNbr)
      ).success(success).error(error)


]