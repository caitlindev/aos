
roadtripaddtravel = angular.module 'app.roadtrip.addtravel', []



roadtripaddtravel.controller "RoadTripAddTravelCtrl", [
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
    $scope.employee_id = $stateParams.employee_id




    $scope.travelers = $cookieStore.get('travelers')
    $scope.currentTraveler = $cookieStore.get('currentTraveler').traveler
    $scope.returnURL = $cookieStore.get('currentTraveler').returnURL




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



    $scope.addHotelFields = () ->
      $scope.currentTraveler.travelInfo.hotels.push({
        "name":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "phone":null,
        "confNbr":null,
      })


    if $scope.currentTraveler.travelInfo.hotels==undefined
      $scope.currentTraveler.travelInfo.hotels = [
        {
          "name":null,
          "address":null,
          "city":null,
          "state":null,
          "zip":null,
          "phone":null,
          "confNbr":null,
        }
      ]




    $scope.addAirlineFields = () ->
      $scope.currentTraveler.travelInfo.airlines.push({
        "id":$scope.id_count,
        "name":null,
        "departure":{
          "flightNbr":null,
          "station":null,
          "departUnixTimestamp":null,
          "seat":null,
          "confNbr":null
        },
        "arrival":{
          "flightNbr":null,
          "station":null,
          "arriveUnixTimestamp":null,
          "seat":null,
          "confNbr":null
        }
      })

      $scope.id_count++

    if $scope.currentTraveler.travelInfo.airlines==undefined
      $scope.currentTraveler.travelInfo.airlines = [
        {
          "name":null,
          "departure":{
            "flightNbr":null,
            "station":null,
            "departUnixTimestamp":null,
            "seat":null,
            "confNbr":null
          },
          "arrival":{
            "flightNbr":null,
            "station":null,
            "arriveUnixTimestamp":null,
            "seat":null,
            "confNbr":null
          }
        }
      ]




    $scope.addCarFields = () ->
      $scope.currentTraveler.travelInfo.cars.push({
        "name":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "phone":null,
        "confNbr":null,
      })


    if $scope.currentTraveler.travelInfo.cars==undefined
      $scope.currentTraveler.travelInfo.cars = [
        {
          "name":null,
          "address":null,
          "city":null,
          "state":null,
          "zip":null,
          "phone":null,
          "confNbr":null,
        }
      ]

    $scope.deleteItem = (list, index) ->
      list.splice(index, 1)



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
    $scope.id_count=1






    _this.putRoadTripWs = {
      roadTripWs: (service, data) ->

        service.putRoadTrip(data, _this.putRoadTripWs.success, _this.putRoadTripWs.error)

      success: (data, status, headers, config) ->
        $scope.goToPath({which:13}, '/roadtrip/view/' + $scope.id)

      error: (data, status, headers, config) ->
        # error callback
    }


    $scope.toMilliseconds = (timestamp) ->
      Math.round(timestamp.getTime() / 1000)


    $scope.submit = () ->
      $scope.removeEmpties($scope.currentTraveler.travelInfo.hotels, "name", null)
      $scope.removeEmpties($scope.currentTraveler.travelInfo.airlines, "name", null)
      $scope.removeEmpties($scope.currentTraveler.travelInfo.cars, "name", null)



      i=0
      while i < $scope.travelers.length
        traveler = $scope.travelers[i]
        if traveler.employee.id == $scope.currentTraveler.employee.id
          $scope.travelers[i] = $scope.currentTraveler

        i++

      $cookieStore.put('travelers', $scope.travelers)

      k=0
      airlines = $scope.currentTraveler.travelInfo.airlines
      while k < airlines.length
        departureTime = moment($scope.dt[k]).format('ddd ll') + " " + moment($scope.mytime_dt).format('hh:mm:ss')
        airlines[k].departure.departUnixTimestamp = $scope.toMilliseconds(new Date(departureTime))

        arrivalTime = moment($scope.at[k]).format('ddd ll') + " " + moment($scope.mytime_at).format('hh:mm:ss')
        airlines[k].arrival.arriveUnixTimestamp = $scope.toMilliseconds(new Date(arrivalTime))
        k++

      console.log $scope.currentTraveler
      $scope.goToPath({which:13}, $scope.returnURL)

]


