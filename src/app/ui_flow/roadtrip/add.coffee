
roadtripadd = angular.module 'app.roadtrip.add', []



roadtripadd.controller "RoadTripAddCtrl", [
  '$scope'
  '$location'
  '$modal'
  '$stateParams'
  '$cookieStore'
  'StatesService'
  'RoadTripService'
  'FlightsService'
  'EventsService'
  'StationsService'
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
   StationsService,
   TravelArrangementsService) ->


    $scope.employeeDirectory = $cookieStore.get('travelers')


    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})



    $scope.toMilliseconds = (timestamp) ->
      Math.round(timestamp.getTime() / 1000)


    $scope.id = $stateParams.id
    $scope.genders = ['F', 'M']






    $scope.dt = []
    $scope.at = []
    $scope.today = () ->
      $scope.dt[0] = new Date()
      $scope.at[0] = new Date()
      return

    $scope.today()
    $scope.clear = () ->
      $scope.dt = []
      $scope.at = []
      return


#    # Disable weekend selection
#    $scope.disabled = (date, mode) ->
#      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

    $scope.toggleMin = ->
      $scope.minDate = (if $scope.minDate then null else new Date())
      return

    $scope.toggleMin()


    $scope.dateOptions =
      formatYear: "yy"
      startingDay: 1

    $scope.initDate = new Date("2016-15-20")
    $scope.formats = [
      "dd-MMMM-yyyy"
      "yyyy/MM/dd"
      "dd.MM.yyyy"
      "shortDate"
    ]
    $scope.format = $scope.formats[0]


    $scope.mytime = new Date()
    $scope.hstep = 1
    $scope.mstep = 15
    $scope.options =
      hstep: [
        1
        2
        3
        4
        5
        6
        7
        8
        9
        10
        11
        12
      ]
      mstep: [
        1
        5
        10
        15
        25
        30
      ]

    $scope.ismeridian = true
    $scope.toggleMode = () ->
      $scope.ismeridian = not $scope.ismeridian

    $scope.update = () ->
      d = new Date()
      d.setHours 14
      d.setMinutes 0
      $scope.mytime = d

    $scope.clear = () ->
      $scope.mytime = null

    $scope.openDatepicker = (event) ->
      event.preventDefault()
      event.stopPropagation()






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
        "travelInfo": {
          hotels:null
          airlines:null
          cars:null
        }
      })



    if $cookieStore.get('travelers')
      $scope.travelers = $cookieStore.get('travelers')
    else
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
          "travelInfo": {
            hotels:null
            airlines:null
            cars:null
          }
        }
      ]




    $scope.$watch 'employeeDirectory.length', (newVal, oldVal) ->
      value = $scope.employeeDirectory
      if newVal > 0
          $scope.travelers = value
          $cookieStore.put('travelers', $scope.travelers)



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






    _this.getStationsWs = {
      stationsWs: (service) ->
        # WS call. Ex: mockWs.flightWs(flightWs.success, flightWs.error)
        service.getStations(_this.getStationsWs.success, _this.getStationsWs.error)

      success: (data, status, headers, config) ->
        for stations in data
          if stations.name.toUpperCase()==$scope.event.station.toUpperCase()
#            $scope.newRoadTrip.station = stations
            $scope.newRoadTrip.station = stations.name
            $scope.newRoadTrip.stationManager = stations.stationManager
            $scope.newRoadTrip.stationOnCall = stations.stationOnCall
            $scope.vendors = stations.mxVendor

            break

      error: (data, status, headers, config) ->
        # error callback
    }






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

        _this.getStationsWs.stationsWs(StationsService)

        $scope.$watch "flightList", () ->
          flights = $scope.flightList
          for flightsKey of flights
            tailNbr = flights[flightsKey].tailNbr
            flightInfo = flights[flightsKey]

            if $scope.event.tailNbr == tailNbr
              $scope.event.flightInfo = flightInfo




          if $cookieStore.get 'currentRT'
            $scope.newRoadTrip = $cookieStore.get 'currentRT'
          else
            $scope.newRoadTrip = {
              "id": $scope.id,
              "state": "open",
              "tailNbr": event.flightInfo.tailNbr,
              "flightNbr": event.flightInfo.routes[2].currentInfo.flightNbr,
              "station": event.station,
              "reason": event.description,
              "ataCodes": event.ataCode,
              "inspectionRequired": null,
              "specialEquipmentReqs": null,
              "remarks": null,
              "createdUnixTimestamp": $scope.toMilliseconds(new Date()),
              "createdBy": {
                "id":10195,
                "aisId":10195,
                "companyName":"Allegiant Air, LLC",
                "company":20,
                "name":"Nathan Sculli",
                "roles":["dev_sudo"],
                "image":null,
                "userType":"Standard User",
                "employeeGroup":"AD Administration",
                "department":"686 Information Technology",
                "email":"nathan.sculli@allegiantair.com"
              },
              "parts": $scope.parts,
              "tooling": $scope.tooling,
              "station": null,
              "stationManager": {
                "firstName":null,
                "lastName":null,
                "phone":null,
                "address":null,
                "city":null,
                "state":null,
                "zip":null
              },
              "stationOnCall": {
                "firstName":null,
                "lastName":null,
                "phone":null
              },
              "mxVendor": $scope.vendors,
              "repairScheme": null,
              "roadTripTraveler": $scope.travelers
            }


      error: (data, status, headers, config) ->
        # error callback
    }

#    Get all events
    _this.getEventWs.eventWs(EventsService)



    _this.postRoadTripWs = {
      roadTripWs: (service, data) ->
        service.postRoadTrip(data, _this.postRoadTripWs.success, _this.postRoadTripWs.error)

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





    $scope.edit = (event_id, eventType, index) ->
      $cookieStore.put 'travelers', $scope.travelers

      $cookieStore.put 'currentTraveler', {
        traveler:$scope.travelers[index]
        returnURL:$location.path()
      }
      $scope.goToPath({which:13}, 'roadtrip/add_travel/'+event_id)



    $scope.add = (event_id, index) ->
      $cookieStore.put 'travelers', $scope.travelers

      $cookieStore.put 'currentRT', $scope.newRoadTrip

      $cookieStore.put 'currentTraveler', {
        traveler:$scope.travelers[index]
        returnURL:$location.path()
      }
      $scope.goToPath({which:13}, 'roadtrip/add_travel/'+event_id)


    $scope.cancelRTcreation = () ->
      $cookieStore.remove 'travelers'
      $cookieStore.remove 'currentRT'
      $cookieStore.remove 'currentTraveler'
      goToPath({which:13}, '/view/' + event.id)


    $scope.submit = () ->
      $scope.removeEmpties($scope.parts, "partNbr", null)
      $scope.removeEmpties($scope.tooling, "toolNbr", null)
      $scope.removeEmpties($scope.travelers, "employee", "id")
      $scope.removeEmpties($scope.vendors, "name", null)

      $cookieStore.remove 'travelers'
      $cookieStore.remove 'currentRT'
      $cookieStore.remove 'currentTraveler'

      console.log $scope.newRoadTrip

#      _this.postRoadTripWs.roadTripWs(RoadTripService, $scope.newRoadTrip)

]


