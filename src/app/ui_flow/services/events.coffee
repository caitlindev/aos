"use strict"

events = angular.module("services.events", [])


events.factory "EventsService", [
  "$http",
  ($http) ->


    getEvents: (params, success, error) ->
      $http(
        method: "GET"
        url: "/api/events"
        params: params
        loadId: 'tableOptions'
        retrySuccess: success
        retryError: error
      )



    getEvent: (id, success, error) ->
      $http(
        method: "GET"
        url: "/api/events/" + encodeURIComponent(id)
      ).success(success).error(error)



    postEvent: (data, success, error) ->
      $http(
        method: "POST"
        url: "/api/events/"
        data: data
      ).success(success).error(error)



    putEvent: (id, data, success, error) ->
      $http(
        method: "PUT"
        url: "/api/events/" + id
        data: data
      ).success(success).error(error)



    postComment: (id, data, success, error) ->
      $http(
        method: "POST"
        url: "api/events/" + id + "/comments"
        data: data
      ).success(success).error(error)





    getVersionByTailNbr: (tailNbr, success, error) ->
      $http(
        method: "GET"
        url: "/api/events/versions/" + encodeURIComponent(tailNbr)
      ).success(success).error(error)


    getVersions: (id, success, error) ->
      $http(
        method: "GET"
        url: "/api/events/" + id + "/versions"
      ).success(success).error(error)




    getEventCodes: (id, success, error) ->
      $http({
        method: "GET"
        url: "/api/event-codes"
      }).success(success).error(error)

    getEventCode: (id, success, error) ->
      $http({
        method: "GET"
        url: "/api/event-codes/" + id
      }).success(success).error(error)




    getRootCauseCodes: (success, error) ->
      $http({
        method: "GET"
        url: "/api/root-cause-codes"
      }).success(success).error(error)




]