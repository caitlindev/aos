"use strict"

flights = angular.module("services.flights", [])


flights.factory "FlightsService", [
  "$http",
  ($http) ->


    getFlights: (params, success, error) ->
      $http(
        method: "GET"
        url: "/api/flights"
        params: params
        loadId: 'tableOptions'
        retrySuccess: success
        retryError: error
      )



]