del = angular.module 'app.delete', []

del.controller 'DeleteWarningModalCtrl', [
  '$scope'
  '$modalInstance'
  ( $scope, $modalInstance ) ->
    $scope.cancel = () ->
      $modalInstance.close()

]

del.controller 'DeleteModalCtrl', [
  '$scope'
  '$state'
  '$modalInstance'
  '$location'
  'FlashStorage'
  'RoadTripService'
  'EventsService'
  'ev'
  'rt'

  ($scope, $state, $modalInstance, $location, FlashStorage, RoadTripService, EventsService, ev, rt) ->

    _this = this

    _this.updateRoadTripWs = {
      roadTripWs: (service, data) ->

        service.putRoadTrip(data, _this.updateRoadTripWs.success, _this.updateRoadTripWs.error)

      success: (data, status, headers, config) ->
        $scope.flashMessage = FlashStorage.set(
          level: 'success'
          status: 200
          message: 'Road trip has been closed'
          critical: true

          view: 'list'
        )

        $modalInstance.close(true)
        $scope.deleteInProgress = false

      error: (data, status, headers, config) ->
        $scope.flashMessage = FlashStorage.set(
          level: 'danger'
          status: response?.status or 500
          message: response?.data?.message or "Could not close road trip"
          critical: true

          view: 'view'
        )

        $scope.deleteInProgress = false
    }

    _this.putEventWs = {
      eventWs: (service, data) ->
        id = ev.id
        service.putEvent(id, data, _this.putEventWs.success, _this.putEventWs.error)

      success: (data, status, headers, config) ->
        $modalInstance.close(true)
        $scope.deleteInProgress = false

        $state.go 'view', { id: ev.id}


      error: (data, status, headers, config) ->
        $scope.deleteInProgress = false
        # error message to be implemented

    }

    $scope.deleteRT = () ->
      $scope.message = {}
      $scope.deleteInProgress = true

      $scope.rt = rt
      $scope.rt.state = 'closed'
      _this.updateRoadTripWs.roadTripWs(RoadTripService, rt)

    $scope.deleteEvent = () ->
      $scope.message = {}
      $scope.deleteInProgress = true

      $scope.event = ev
      console.log $scope.event
      $scope.event.state = 'closed'
      $scope.event.eventCode = 'spr'
      $scope.event.status = 'rdy'
      $scope.event.station = $scope.event.station.name

      _this.putEventWs.eventWs(EventsService, $scope.event)

    $scope.cancel = () ->
      $modalInstance.close()

]