"use strict"

travel = angular.module("services.travel_arrangements", [])


travel.factory "TravelArrangementsService", [
  "$http",
  ($http) ->
    roadTripInProgress = {}

    setRoadTripInProgress = (obj) ->
      roadTripInProgress = obj

    getRoadTripInProgress = () ->
      return roadTripInProgress

    return {
      setRoadTripInProgress: setRoadTripInProgress,
      getRoadTripInProgress: getRoadTripInProgress
    }


]