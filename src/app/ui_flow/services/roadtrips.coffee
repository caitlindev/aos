"use strict"

roadtrips = angular.module("services.roadtrips", [])


roadtrips.factory "RoadTripService", [
  "$http",
  ($http) ->


    getRoadTrips: (success, error) ->
      $http(
        method: "GET"
        url: "/api/roadtrips/"
      ).success(success).error(error)


    getRoadTrip: (id, success, error) ->
      $http(
        method: "GET"
        url: "/api/roadtrips/" + encodeURIComponent(id)
      ).success(success).error(error)



    postRoadTrip: (data, success, error) ->
      $http(
        method: "POST"
        url: "/api/roadtrips/"
        data: data
      ).success(success).error(error)



    putRoadTrip: (data, success, error) ->
      $http(
        method: "PUT"
        url: "/api/roadtrips/" + data.id
        data: data
      ).success(success).error(error)




]