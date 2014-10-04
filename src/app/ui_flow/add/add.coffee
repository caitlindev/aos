
add = angular.module 'app.add', []



add.controller "AddCtrl", [
  '$scope'
  '$location'
  '$modal'
  'EventsService'
  'FlightsService'
  'StationsService'
  'ATAService'
  ($scope, $location, $modal, EventsService, FlightsService, StationsService, ATAService) ->

    $scope.currentTime = moment().utc().format('HH:mm a')

    $scope.selectedCodes = []


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

    if ($scope.parts==undefined)
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

    $scope.addToSelectedCodes = (e, value) ->
      if e.which == 13 || e.which==1
        e.preventDefault()
        $scope.selectedCodes.push({
          chapter:value.substr(0,2)
          section:value.substr(2,2)
        })



    $scope.today = () ->
      $scope.dt = new Date()
      return

    $scope.today()
    $scope.clear = () ->
      $scope.dt = null
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

    $scope.formats = [
      "dd-MMMM-yyyy"
      "yyyy/MM/dd"
      "dd.MM.yyyy"
      "shortDate"
    ]
    $scope.format = $scope.formats[0]

    $scope.mytime = moment(new Date()).utc().format("YYYY-MM-DD HH:mm")
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
      d = moment(new Date()).utc().format("YYYY-MM-DD HH:mm")
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
    $scope.rootCauseCodeList = [{id:0, description:'Select an event code...', code:'A'}]


    # Get Event Codes
    _this.getEventCodesWs = {
      eventCodeWs: (id, service) ->
        service.getEventCodes(id, _this.getEventCodesWs.success, _this.getEventCodesWs.error)
      success: (data, status, headers, config) ->
        $scope.eventCodeList = data.items
        _this.getRootCauseCodesWs.rootCauseCodeWs(EventsService)

#        console.log($scope.eventCodeList)
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

          rcCodeIds.rootCauseCodeIds = tmpRootCauseList


      error: (data, status, headers, config) ->
        # error callback
    }



    _this.getEventCodesWs.eventCodeWs(2, EventsService)



    $scope.changeRootCauseList = (code) ->
      $scope.rootCauseCodeList = code.rootCauseCodeIds




    # Get ATA Codes
    $scope.ataCodesList = $scope.selectedCodes



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

    $scope.filter_tailNbr = 'Tail Number'
    $scope.changeTailNbrFilter = (val) ->
      $scope.filter_tailNbr = val




    # Get Stations
    _this.getStationsWs = {
      stationsWs: (service) ->
        # WS call. Ex: mockWs.stationsWs(stationsWs.success, stationsWs.error)
        service.getStations(_this.getStationsWs.success, _this.getStationsWs.error)

      success: (data, status, headers, config) ->
        # success callback
        $scope.stationsList = data
        console.log data

      error: (data, status, headers, config) ->
        # error callback
    }

    # Get stations data
    _this.getStationsWs.stationsWs(StationsService)

    $scope.filter_station = 'Station'
    $scope.changeStationFilter = (val) ->
      $scope.filter_station = val






    $scope.filteredParts = (partsList) ->
      i = 0
      newPartsList = []

      while i < partsList.length
        part = partsList[i]
        if part.part != null
          newPartsList.push(part)
        i++

      return newPartsList


    # item for ws
    $scope.newEvent =
      id: null
      type: "aos"
      tailNbr: null
      station: null
      location: null
      description: null
      advisoryUnixTimestamp: null
      etrUnixTimestamp: null
      eventCode: null
      rootCause: $scope.rootCauseCodeList[0]
      ataCode: $scope.ataCodesList[0]
      status: null
      state: "open"
      createdUnixTimestamp: $scope.toMilliseconds(new Date())
      createdBy:
        loginId: "caitlin.smith"
        empId: "10593"
        fullName: "Caitlin Smith"

      modifiedUnixTimestamp: null
      modifiedBy:
        loginId: "caitlin.smith"
        empId: "10593"
        fullName: "Caitlin Smith"

      parts: [
        {
          id: 1000
          part: "064-50000 [Series]"
          qty: 4
          description: "DME-XCVR"
          status: "In Stock"
        }
        {
          id: 2000
          part: "17M903 [Series]"
          qty: 1
          description: "LCD Monitor Assembly"
          status: "On Order"
        }
        {
          id: 3000
          part: "064-50000 [Series]"
          qty: 1
          description: "Recorder"
          status: "In Stock"
        }
        {
          id: 4000
          part: "064-50000 [Series]"
          qty: 4
          description: "Radar Antenna"
          status: "In Stock"
        }
      ]
      roadTrips: []
      comments: []
      documents: []



    _this.postEventWs = {
      eventWs: (service, data) ->
        service.postEvent(data, _this.postEventWs.success, _this.postEventWs.error)

      success: (data, status, headers, config) ->
        # success callback
        $scope.goToPath({which:13}, '/dashboard')

      error: (data, status, headers, config) ->
        # error callback
    }


    $scope.submit = () ->
#      if $scope.newEvent.status.toUpperCase()=='ADV'
#        advisoryTime = moment($scope.dt).format('ddd ll') + " " + moment($scope.mytime).format('HH:mm:ss')
#        $scope.newEvent.advisoryUnixTimestamp = $scope.toMilliseconds(new Date(advisoryTime))
#        $scope.newEvent.etrUnixTimestamp

      $scope.newEvent.eventCode = $scope.newEvent.eventCode.code
      $scope.newEvent.rootCause = $scope.newEvent.rootCause.code

      if $scope.newEvent.status.toUpperCase()=='ETR'
        etrTime = moment($scope.dt).format('ddd ll') + " " + moment($scope.mytime).format('HH:mm:ss')
        $scope.newEvent.etrUnixTimestamp = $scope.toMilliseconds(new Date(etrTime))
        $scope.newEvent.advisoryUnixTimestamp

      $scope.newEvent.createdUnixTimestamp = $scope.toMilliseconds(new Date())

      $scope.newEvent.ataCode = $scope.selectedCodes

      _this.postEventWs.eventWs(EventsService, $scope.newEvent)

]




add.filter "startFrom", ->
  (input, start) ->
    if input!=undefined
      start = +start #parse to int
      input.slice start





