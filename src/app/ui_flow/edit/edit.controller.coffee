
edit = angular.module 'app.edit', []






edit.controller "EditCtrl", [
  '$scope'
  '$location'
  '$modal'
  '$stateParams'
  'EventsService'
  'FlightsService'
  'StationsService'
  ($scope, $location, $modal, $stateParams, EventsService, FlightsService, StationsService) ->

    $scope.currentTime = moment().utc().format('hh:mm a')

    $scope.selectedCodes = {}




    $scope.toMilliseconds = (timestamp) ->
      Math.round(timestamp.getTime() / 1000)




    $scope.partsStatus = ['In Stock', 'Out Of Stock', 'On Order']
    $scope.partSelected = $scope.partsStatus[0]

    $scope.addPartFields = () ->
      $scope.parts.push({
        id:null,
        part:null,
        qty:null,
        description:null,
        status:null
    })

    $scope.parts = [
      {
        id:null,
        part:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        part:null,
        qty:null,
        description:null,
        status:null
      },
      {
        id:null,
        part:null,
        qty:null,
        description:null,
        status:null
      }
    ]







    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})


    $scope.today = () ->
      $scope.dt = new Date()
      return

    $scope.today()
    $scope.clear = () ->
      $scope.dt = null
      return

#
#    # Disable weekend selection
#    $scope.disabled = (date, mode) ->
#      mode is "day" and (date.getDay() is 0 or date.getDay() is 6)

    $scope.toggleMin = ->
      $scope.minDate = (if $scope.minDate then null else new Date())
      return

    $scope.toggleMin()
    $scope.open = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened = true
      return

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
      $scope.openDate = true






    _this = this
    $scope.rootCauseCodeList = [{id:0, description:'Select Event Code first...', code:'A'}]


    # Get Event Codes
    _this.getEventCodesWs = {
      eventCodeWs: (id, service) ->
        service.getEventCodes(id, _this.getEventCodesWs.success, _this.getEventCodesWs.error)
      success: (data, status, headers, config) ->
        $scope.eventCodeList = data.items

        _this.getRootCauseCodesWs.rootCauseCodeWs(EventsService)

      error: (data, status, headers, config) ->
        # error callback
    }


    # Get Root Cause Codes
    _this.getRootCauseCodesWs = {
      rootCauseCodeWs: (service) ->
        service.getRootCauseCodes(_this.getRootCauseCodesWs.success, _this.getRootCauseCodesWs.error)
      success: (data, status, headers, config) ->

        for rcCodeIds in $scope.eventCodeList
          tmpRootCauseList = []
          for eachRcCodeIds in rcCodeIds.rootCauseCodeIds

            for rcCode in data.items
              if eachRcCodeIds.toString() == rcCode.id.toString()
                eachRcCodeIds = rcCode.description
                tmpRootCauseList.push({id:rcCode.id, description:eachRcCodeIds, code:rcCode.code})

                if rcCode.code == $scope.event.rootCause.toUpperCase()
                  $scope.event.rootCause = rcCode.code.toLowerCase()

          rcCodeIds.rootCauseCodeIds = tmpRootCauseList

          $scope.changeRootCauseList($scope.event.eventCode)


      error: (data, status, headers, config) ->
        # error callback
    }



    _this.getEventCodesWs.eventCodeWs(2, EventsService)



    $scope.changeRootCauseList = (code) ->
      $scope.rootCauseCodeList = code.rootCauseCodeIds









    # Get Tail Numbers
    _this.getTailNbrWs = {
      tailNbrWs: (service) ->
        # WS call. Ex: mockWs.tailNbrWs(tailNbrWs.success, tailNbrWs.error)
        service.getFlights(null, _this.getTailNbrWs.success, _this.getTailNbrWs.error)

      success: (data, status, headers, config) ->
        $scope.tailNbrList = data

      error: (data, status, headers, config) ->
        console.log('error')
    }

    # Get tailNbr data
    _this.getTailNbrWs.tailNbrWs(FlightsService)







    _this.getStationsWs = {
      stationsWs: (service) ->
        # WS call. Ex: mockWs.stationsWs(stationsWs.success, stationsWs.error)
        service.getStations(_this.getStationsWs.success, _this.getStationsWs.error)

      success: (data, status, headers, config) ->
        # success callback
        $scope.stationsList = data

        for key of data
          $scope.stationArray.push(data[key].name.toUpperCase())

      error: (data, status, headers, config) ->
        # error callback
    }



    # Get stations data
    _this.getStationsWs.stationsWs(StationsService)

    $scope.filter_station = 'Station'
    $scope.changeStationFilter = (val) ->
      $scope.filter_station = val

    $scope.stationArray = []
    $(()->
      $("#stations").autocomplete({
        source: $scope.stationArray
      })
    )









    _this.getEventWs = {
      eventWs: (service) ->
        # WS call. Ex: mockWs.eventWs(eventWs.success, eventWs.error)
        id = $stateParams.id

        service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error)

      success: (data, status, headers, config) ->
        $scope.event = data

        for code in $scope.eventCodeList
          if code.code.toUpperCase() == $scope.event.eventCode.toUpperCase()
            $scope.event.eventCode = code
            break

        if data.ataCode.length > 0
          $scope.selectedCodes = data.ataCode

        if data.parts.length > 0
          $scope.parts = data.parts
          $scope.dt = moment.unix($scope.event.advisoryUnixTimestamp)._d
          $scope.mytime = $scope.dt

      error: (data, status, headers, config) ->
        console.log 'error'
    }

#    Get all events
    _this.getEventWs.eventWs(EventsService)




    _this.putEventWs = {
      eventWs: (service, data) ->
        id = $stateParams.id

        service.putEvent(id, data, _this.putEventWs.success, _this.putEventWs.error)

      success: (data, status, headers, config) ->
        $scope.goToPath({which:13}, '/view/' + data.id)

      error: (data, status, headers, config) ->
        # error callback
    }


    $scope.submit = () ->
      advisoryTime = moment($scope.dt).format('ddd ll') + " " + moment($scope.mytime).format('hh:mm:ss')
      if $scope.event.status.toUpperCase()=="ADV"
        $scope.event.advisoryUnixTimestamp = $scope.toMilliseconds(new Date(advisoryTime))
      else if $scope.event.status.toUpperCase()=="ETR"
        $scope.event.etrUnixTimestamp = $scope.toMilliseconds(new Date(advisoryTime))


      $scope.event.eventCode = $scope.event.eventCode.code
      $scope.event.rootCause = $scope.event.rootCause.code

      $scope.event.ataCode = $scope.selectedCodes
      console.log $scope.event

      _this.putEventWs.eventWs(EventsService, $scope.event)




]







edit.filter "startFrom", ->
  (input, start) ->
    if input!=undefined
      start = +start #parse to int
      input.slice start
