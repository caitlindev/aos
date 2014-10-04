
roadtripedit = angular.module 'app.roadtrip.edit', []



roadtripedit.controller "RoadTripEditCtrl", [
  '$scope'
  '$location'
  '$modal'
  '$stateParams'
  '$cookieStore'
  'StatesService'
  'RoadTripService'
  'FlightsService'
  'EventsService'
  'TravelArrangementsService'

  ($scope,
   $location,
   $modal,
   $stateParams,
   $cookieStore,
   StatesService,
   RoadTripService,
   FlightsService,
   EventsService,
   TravelArrangementsService) ->


    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})


    $scope.id = $stateParams.id

    $scope.genders = ['F', 'M']




    $scope.addPartFields = () ->
      $scope.parts.push({
        id:null,
        partNbr:null,
        qty:null,
        description:null,
        status:null
    })

    $scope.parts = [
      {
        id:null,
        partNbr:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        partNbr:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        partNbr:null,
        qty:null,
        description:null,
        status:null
      }
    ]

    $scope.deleteItem = (list, index) ->
      list.splice(index, 1)







    $scope.addToolingFields = () ->
      $scope.tooling.push({
        id:null,
        toolNbr:null,
        qty:null,
        description:null
    })

    $scope.tooling = [
      {
        id:null,
        toolNbr:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        toolNbr:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        toolNbr:null,
        qty:null,
        description:null,
        status:null
      }
    ]





    $scope.addTravelerFields = () ->
      $scope.travelers.push({
        "employee": {
          "firstName":null,
          "lastName":null,
          "id":null,
          "phone":null,
          "base":null,
          "DOB":null,
          "gender":null
        },
        "travelInfo": {}
      })

    $scope.travelers = [
      {
        "employee": {
          "firstName":null,
          "lastName":null,
          "id":null,
          "phone":null,
          "base":null,
          "DOB":null,
          "gender":null
        },
        "travelInfo": {}
      }
    ]







    $scope.addVendorFields = () ->
      $scope.vendors.push({
        "name":null,
        "contactFirstName":null,
        "contactLastName":null,
        "phone":null,
        "fax":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "contract":null
      })

    $scope.vendors = [
      {
        "name":null,
        "contactFirstName":null,
        "contactLastName":null,
        "phone":null,
        "fax":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "contract":null
      }
    ]






    _this = this

    _this.getStatesWs = {
      statesWs: (service) ->

        service.getStates(_this.getStatesWs.success, _this.getStatesWs.error)

      success: (data, status, headers, config) ->
        $scope.states = data

      error: (data, status, headers, config) ->
        # error callback
    }

    _this.getStatesWs.statesWs(StatesService)






    _this.getRoadTripWs = {
      roadTripWs: (service, id) ->

        service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error)

      success: (data, status, headers, config) ->
        $scope.roadTrip = data
        console
        $scope.fixData(data)

      error: (data, status, headers, config) ->
        # error callback
    }





    $scope.fixData = (data) ->
      if data.parts.length > 0
        $scope.parts = data.parts

      if data.tooling.length > 0
        $scope.tooling = data.tooling

      if data.roadTripTraveler.length > 0
        $scope.travelers = data.roadTripTraveler

      if $cookieStore.get('addTravel')
        addTravel = $cookieStore.get('addTravel')
        $scope.travelers = addTravel.newTraveler
        console.log($scope.travelers)
        $cookieStore.remove('addTravel')


      if $cookieStore.get('editTravel')
        editTravel = $cookieStore.get('editTravel')
        $scope.travelers = editTravel.newTraveler
        $cookieStore.remove('editTravel')


      if data.mxVendor.length > 0
        $scope.vendors = data.mxVendor





    _this.getRoadTripWs.roadTripWs(RoadTripService, $scope.id)




    # Delete Modal
    $scope.openDeleteModal = () ->
      modalInstance = $modal.open(
        controller: "DeleteModalCtrl"
        templateUrl: 'src/app/ui_flow/delete/modal.jade'
        resolve: {
          rt: () -> $scope.roadTrip
        }
      )

      modalInstance.result.then (flashMessage) ->
        $scope.goToPath({which:13}, '/view/' + $scope.roadTrip.id)

    $scope.cancel = () ->
      $modalInstance.close()









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
        service.getEvent($scope.id, _this.getEventWs.success, _this.getEventWs.error)

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



    _this.putRoadTripWs = {
      roadTripWs: (service, data) ->

        service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error)

      success: (data, status, headers, config) ->
        $scope.goToPath({which:13}, '/roadtrip/view/' + $scope.id)

      error: (data, status, headers, config) ->
        # error callback
    }



    $scope.removeEmpties = (list, attr, attr2) ->
      i=0
      while i < list.length
        item = list[i]
        if attr2==null
          if item[attr]==null || item[attr]==undefined || item[attr]==''
            list.splice(i, 1)
            i--
        else
          if item[attr][attr2]==null || item[attr][attr2]==undefined || item[attr][attr2]==''
            list.splice(i, 1)
            i--
        i++





    $scope.edit = (event_id, editType, index) ->
      $cookieStore.put('editTravel', {
        "newTraveler":$scope.travelers,
        "path":$location.path(),
        "index":index
      })
      $scope.goToPath({which:13}, 'roadtrip/edit_travel/' + event_id + '/' + editType)

    $scope.add = (event_id, index) ->
      $cookieStore.put('addTravel', {
        "newTraveler":$scope.travelers,
        "path":$location.path(),
        "index":index
      })
      $scope.goToPath({which:13}, 'roadtrip/add_travel/'+event_id)




    $scope.submit = () ->
      $scope.roadTrip.parts = $scope.parts
      $scope.roadTrip.tooling = $scope.tooling
      $scope.roadTrip.roadTripTraveler = $scope.travelers
      $scope.roadTrip.mxVendor = $scope.vendors


      $scope.removeEmpties($scope.parts, "partNbr", null)
      $scope.removeEmpties($scope.tooling, "toolNbr", null)
      $scope.removeEmpties($scope.travelers, "employee", "id")
      $scope.removeEmpties($scope.vendors, "name", null)

      _this.putRoadTripWs.roadTripWs(RoadTripService, $scope.roadTrip)

]


