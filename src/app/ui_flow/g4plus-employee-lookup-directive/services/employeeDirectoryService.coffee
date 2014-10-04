"use strict"

ataCodes = angular.module("services.employeeDirectory", [])


ataCodes.factory "EmployeeDirectoryService", [
  "$http",
  ($http) ->

    getEmployees: (success, error) ->
      $http(
        method: "GET"
        url: "/api/employeeDirectory"
      ).success(success).error(error)


]