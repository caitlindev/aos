# * @fileoverview This file contains the dashboard module
# * @author       Caitlin Smith (caitlin.smith@allegiantair.com)
# * @module       app.dashboard
dashboard = angular.module 'app.dashboard', [
  'ngSanitize'
  'ui.bootstrap'
  'g4plus.pagination'
  'g4plus-date.filter'
  'g4plus.sort-button'
  'g4ActionsButton'
  'g4plus.list-filter'
]

# Dashboard controller
# =====
# Handles the home view for the app. Functions include:
#  - selection of aircraft program (AP)
#  - list failure effect codes (FEC) for the selected program group
#  - links to add, view, edit, delete FECsmain
#  - print FEC list to PDF
#  - links to help page
dashboard.controller 'DashboardCtrl', [
  '$scope'
  '$location'
  '$interval'
  'ListState'
  'EventsService'
  'FlightsService'
  'StationsService'
  'RoadTripService'

  ($scope, $location, $interval, ListState, EventsService, FlightsService, StationsService, RoadTripService) ->



    $scope.tab = [
      {
        title: "Dashboard"
        active: true
      }
      {
        title: "Routing"
        active: false
      }
    ]

    $scope.mapFilters =
      stations: ['LAS', 'SFB', 'AZA', 'LAX']
      events: ['AOS', 'SOS', 'HPR', 'SPR']

    $scope.changeRouting = (isCollapsed, tailNumber) ->
      if isCollapsed==false
        $scope.refreshMap = !$scope.refreshMap
        $scope.tailNumbers = tailNumber
        $scope.tab[1].active = true
      else
        $scope.tailNumbers = false

    $scope.collapsedIcon = (isCollapsed) ->
     if isCollapsed==true
      return 'fa-angle-right'
     else
      return 'fa-angle-down'


    $scope.collapsedSectionIcon = (isCollapsed) ->
     if isCollapsed==true
      return {
        class:'fa-plus-square'
        text:'Show'
      }
     else
      return {
        class:'fa-minus-square'
        text:'Hide'
      }

    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})

    $scope.filter_station = ''
    $scope.filter_stationList = []
    $scope.currentStationList = []
    $scope.changeStationFilter = (val) ->
      filter = val.toUpperCase()

      $scope.filter_stationList = []
      $scope.filter_station = filter

      if filter=='ALL'
        $scope.filter_stationList = []
        $scope.filter_station = ''
      else if filter=="AZA" || filter=="IWA"
        $scope.filter_stationList.push("AZA","IWA")
        $scope.filter_station = "IWA"
      else if filter=="WEST"
        $scope.filter_stationList.push("AZA", "IWA", "LAS", "LAX", "ENV", "OAK", "BLI", "HNL")
      else if filter=="EAST"
        $scope.filter_stationList.push("SFB", "PIE", "FLL", "PGD", "MYR")
      else if filter=="HVY"
        $scope.filter_stationList.push("OKC", "TUS", "SBD")
      else if filter=="BASE"
        $scope.filter_stationList.push("SFB", "IWA", "AZA", "LAS")
      else if filter=="NON"
        for station in $scope.currentStationList
          if station.toUpperCase()!='SFB' && station.toUpperCase()!='PIE' && station.toUpperCase()!='FLL' && station.toUpperCase()!='PGD' && station.toUpperCase()!='MYR' && station.toUpperCase()!='IWA' && station.toUpperCase()!='AZA' && station.toUpperCase()!='LAS' && station.toUpperCase()!='LAX' && station.toUpperCase()!='ENV' && station.toUpperCase()!='OAK' && station.toUpperCase()!='BLI' && station.toUpperCase()!='HNL' && station.toUpperCase()!='OKC' && station.toUpperCase()!='TUS' && station.toUpperCase()!='SBD'
            console.log station
            $scope.filter_stationList.push(station.toUpperCase())
      else
        $scope.filter_stationList.push(filter)





    $scope.currentTime = new Date()
    $scope.toMilliseconds = (timestamp) ->
      Math.round(timestamp.getTime() / 1000)



    $scope.setElapsedTime = (event) ->
      event.elapsedTime = moment().unix() - event.createdUnixTimestamp



      


    _this = this

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

    _this.getFlightsWs.flightWs(FlightsService)








    _this.getRoadTripWs = {
      roadTripWs: (service) ->
        service.getRoadTrips(_this.getRoadTripWs.success, _this.getRoadTripWs.error)

      success: (data, status, headers, config) ->

        $scope.roadTripList = data

      error: (data, status, headers, config) ->
        # error callback
    }

    _this.getRoadTripWs.roadTripWs(RoadTripService)





    _this.getEventsWs = {
      eventWs: (service) ->
        service.getEvents(null, _this.getEventsWs.success, _this.getEventsWs.error)

      success: (data, status, headers, config) ->

        events = data
        flights = $scope.flightList
        roadTrips = $scope.roadTripList

        for eventsKey of events
          $scope.currentStationList.push(events[eventsKey].station)
          for flightsKey of flights
            tailNbr = flights[flightsKey].tailNbr

            flightInfo = flights[flightsKey]

            if events[eventsKey].tailNbr == tailNbr
              events[eventsKey].flightInfo = flightInfo

          for roadTripssKey of roadTrips
            rtId = roadTrips[roadTripssKey].id.toString()
            rtState = roadTrips[roadTripssKey].state.toString().toUpperCase()

            if events[eventsKey].id.toString() == rtId && rtState=="OPEN"
              events[eventsKey].roadTrip = true
            else
#              events[eventsKey].roadTrip = false


        $scope.eventList = events
        console.log events


      error: (data, status, headers, config) ->
        # error callback
    }

#    Get all events
    _this.getEventsWs.eventWs(EventsService)









    _this = this

    _this.getStationsWs = {
      stationsWs: (service) ->
        # WS call. Ex: mockWs.flightWs(flightWs.success, flightWs.error)
        service.getStations(_this.getStationsWs.success, _this.getStationsWs.error)

      success: (data, status, headers, config) ->
        # success callback
        for stations in data
          $scope.stationList.push(stations.name)


      error: (data, status, headers, config) ->
        # error callback
    }



    # Get flight data
    $scope.stationList = []
    _this.getStationsWs.stationsWs(StationsService)



]




dashboard.filter "keepSPRinDashboard", () ->
  return (items) ->
    filteredItems = []
    currentTime = moment().unix()
    angular.forEach items, (item, i) ->
      twelveHours2Sec = 43200
      if parseInt(currentTime) - parseInt(item.modifiedUnixTimestamp) < twelveHours2Sec
        filteredItems.push(item)

      return items





dashboard.filter "filterStations", () ->
  return (items, filter) ->
    filteredItems = []

    angular.forEach items, (item, i) ->
      station = item.station.toUpperCase()
      if $.inArray(station, filter) > -1
        filteredItems.push(item)

    if !filter.length
      return items

    return filteredItems