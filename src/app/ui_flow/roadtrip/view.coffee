
roadtripview = angular.module 'app.roadtrip.view', []



roadtripview.controller "RoadTripViewCtrl", [
  '$scope'
  '$location'
  '$stateParams'
  '$modal'
  'RoadTripService'
  'FlightsService'
  'EventsService'
  ($scope, $location, $stateParams, $modal, RoadTripService, FlightsService, EventsService) ->

    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})

    _this = this

    _this.getRoadTripWs = {
      roadTripWs: (service, id) ->

        service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error)

      success: (data, status, headers, config) ->
        $scope.roadTrip = data
        console.log($scope.roadTrip)

      error: (data, status, headers, config) ->
        # error callback
    }

    $scope.id = $stateParams.id
    _this.getRoadTripWs.roadTripWs(RoadTripService, $scope.id)






    _this.getFlightsWs = {
      flightWs: (service) ->
        # WS call. Ex: mockWs.flightWs(flightWs.success, flightWs.error)
        service.getFlights(null, _this.getFlightsWs.success, _this.getFlightsWs.error)

      success: (data, status, headers, config) ->
        # success callback

        $scope.flightList = data

      error: (data, status, headers, config) ->
        # error callback
    }

    # Get flight data
    _this.getFlightsWs.flightWs(FlightsService)



    _this.getEventWs = {
      eventWs: (service) ->
        id = $stateParams.id
        service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error)

      success: (data, status, headers, config) ->
        event = data

        $scope.event = event

        $scope.$watch "flightList", () ->
          flights = $scope.flightList
          for flightsKey of flights
            tailNbr = flights[flightsKey].tailNbr
            flightInfo = flights[flightsKey]

            if $scope.event.tailNbr == tailNbr
              $scope.event.flightInfo = flightInfo



      error: (data, status, headers, config) ->
        # error callback
    }

#    Get all events
    _this.getEventWs.eventWs(EventsService)

    # Delete Modal
    $scope.openRTDeleteModal = () ->
      modalInstance = $modal.open(
        controller: "DeleteModalCtrl"
        templateUrl: 'src/app/ui_flow/delete/rt-modal.jade'
        resolve: {
          rt: () -> $scope.roadTrip
          ev: () -> $scope.event
        }
      )

      modalInstance.result.then (flashMessage) ->
        $scope.goToPath({which:1}, '/view/' + $scope.roadTrip.id)

    $scope.cancel = () ->
      $modalInstance.close()



]


