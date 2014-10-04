
roadtripedittravel = angular.module 'app.roadtrip.edittravel', []



roadtripedittravel.controller "RoadTripEditTravelCtrl", [
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
    $scope.editType = $stateParams.editType




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
      $scope.hotels.push({
        "name":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "phone":null,
        "confNbr":null,
      })

    $scope.hotels = [
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
      $scope.airlines.push({
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

    $scope.airlines = [
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
      $scope.cars.push({
        "name":null,
        "address":null,
        "city":null,
        "state":null,
        "zip":null,
        "phone":null,
        "confNbr":null,
      })

    $scope.cars = [
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






    $scope.id_count=0
    $scope.fixData = (travelers) ->

      if travelers.travelInfo.hotel.length > 0
        $scope.hotels = travelers.travelInfo.hotel

      if travelers.travelInfo.airline.length > 0
        j=0
        al=[]
        for airline in travelers.travelInfo.airline
          airline.id = j
          $scope.dt[j] = $scope.mytime_dt = moment.unix(airline.departure.departUnixTimestamp)._d
          $scope.at[j] = $scope.mytime_at = moment.unix(airline.arrival.arriveUnixTimestamp)._d

          al.push(airline)
          j++

          $scope.id_count = j

        $scope.airlines = al

      if travelers.travelInfo.car.length > 0
        $scope.cars = travelers.travelInfo.car



    $scope.editTravel = $cookieStore.get('editTravel')
    $scope.roadTripTraveler = $scope.editTravel.newTraveler[$scope.editTravel.index]
    $scope.returnURL = $scope.editTravel.path

    if $scope.roadTripTraveler.travelInfo.hotel.length
      $scope.hotels = $scope.roadTripTraveler.travelInfo.hotel

    if $scope.roadTripTraveler.travelInfo.airline
      $scope.airlines = $scope.roadTripTraveler.travelInfo.airline

    if $scope.roadTripTraveler.travelInfo.car
      $scope.cars = $scope.roadTripTraveler.travelInfo.car




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
      $scope.removeEmpties($scope.hotels, "name", null)
      $scope.removeEmpties($scope.airlines, "name", null)
      $scope.removeEmpties($scope.cars, "name", null)

      $scope.roadTripTraveler.travelInfo.hotel = $scope.hotels
      $scope.roadTripTraveler.travelInfo.airline = $scope.airlines
      $scope.roadTripTraveler.travelInfo.car = $scope.cars

      i=0
      while i < $scope.airlines.length
        departureTime = moment($scope.dt[i]).format('ddd ll') + " " + moment($scope.mytime_dt).format('hh:mm:ss')
        $scope.airlines[i].departure.departUnixTimestamp = $scope.toMilliseconds(new Date(departureTime))

        arrivalTime = moment($scope.at[i]).format('ddd ll') + " " + moment($scope.mytime_at).format('hh:mm:ss')
        $scope.airlines[i].arrival.arriveUnixTimestamp = $scope.toMilliseconds(new Date(arrivalTime))
        i++


      $scope.editTravel.newTraveler[$scope.editTravel.index] = $scope.roadTripTraveler
      $cookieStore.put('editTravel', {
        "newTraveler":$scope.editTravel.newTraveler,
        "path":$location.path(),
        "index":$scope.editTravel.index
      })

      $scope.goToPath({which:13}, $scope.returnURL)

]


