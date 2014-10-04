"use strict"

ataCodes = angular.module("services.ataCodes", [])


ataCodes.factory "ATAService", [
  "$http",
  ($http) ->

    getMakes: (limit, currentPage, success, error) ->
      $http(
        method: "GET"
        url: '/api/mx-aircraft/v1/api/aircraft-makes/?limit='+limit+'&page='+currentPage
      ).success(success).error(error)

    getModels: (makeOrFamily, makeOrFamilyVal, success, error) ->
      $http(
        method: "GET"
        url: '/api/mx-aircraft/v1/api/aircraft-models?filter='+makeOrFamily+':is:'+makeOrFamilyVal
      ).success(success).error(error)

    getFamilies: (make, success, error) ->
      $http(
        method: "GET"
        url: '/api/mx-aircraft/v1/api/aircraft-families?filter=make:is:'+make
      ).success(success).error(error)

    getATAchapters: (success, error) ->
      $http(
        method: "GET"
        url: "/api/ata-codes/v1/api/lists/MasterChapter"
      ).success(success).error(error)

    getATAchaptersByAircraft: (classification, acTypeId, success, error) ->
      $http(
        method: "GET"
        url: "/api/ata-codes/v1/api/chapters?aircraftTypeClassification="+classification+"&aircraftTypeId="+acTypeId
      ).success(success).error(error)

    getATAsections: (chapterId, success, error) ->
      $http(
        method: "GET"
        url: "/api/ata-codes/v1/api/sections?filter=chapterId:equals:"+chapterId
      ).success(success).error(error)

]