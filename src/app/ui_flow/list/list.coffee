list = angular.module 'app.list', [
  'services.events'
  'g4plus.directives'
]

list.controller "ListCtrl", [
  '$scope'
  '$location'
  '$state'
  'EventsService'
  'FlightsService'
  'ListState'

  ($scope, $location, $state, EventsService, FlightsService, ListState) ->
    $scope.goToPath = (path) ->
      $location.path(path)

    getEvents = {
      success: (data, status, headers, config) ->
      error: (data, status, headers, config) ->
    }



    # Upon any change to $scope.superList.params, updates the URL with new query parameters
    $scope.updateUrl = () ->
      $location.url(ListState.getListStateUrl())

    # Extract url params and update $scope.superList params with the new values
    $scope.getParams = () ->
      ListState.setParams($location.search())

    # Send event to load list based on parameter changes
    $scope.updateList = () ->
      $scope.$broadcast 'SuperList:reload'

    # Scope variables
    # --------
    # eventCodeList: current set of Event codes
    $scope.list = [ ]
    # list_length: current length of list after filter is applied
    $scope.list_length = 0

    # super list configuration options
    $scope.superList =
      service:
        data: EventsService.getEvents
        type: 'http' # array, promise, resource
        loadId: 'tableOptions'
        hasSorting: false
        hasPagination: false
        hasFiltering: false



      columns: [
        {
          title: 'Tail'
          field: 'tailNbr'
          sorting: false
        }
        {
          title: 'Station'
          field: 'station'
          sorting: false
          cellClass: 'station'
        }
        {
          title: 'Status'
          field: 'status'
          sorting: false
          cellClass: 'status'
        }
        {
          title: 'Event'
          field: 'description'
          sorting: false
          columnClass: 'medium'
        }
        {
          title: 'Event Code'
          field: 'eventCode'
          sorting: false
        }
        {
          title: 'ATA'
          field: 'ataCode'
          sorting: false
        }
        {
          title: 'Root Cause'
          field: 'rootCause'
          sorting: false
        }
        {
          title: 'Reporter'
          field: 'createdBy.fullName'
          sorting: false
        }
      ]

      filters: [
        {
          key: '_all'
          label: 'All'
          visible: true
          type: 'keyword'
        }
        {
          key: 'station'
          label: 'Station'
          visible: true
          type: 'keyword'
        }
        {
          key: 'event'
          label: 'Event'
          visible: true
          type: 'keyword'
        }
        {
          key: 'eventCode'
          label: 'Event Code'
          visible: true
          type: 'keyword'
        }
        {
          key: 'createdUnixTimestamp'
          label: 'Date Created'
          visible: true
          type: 'keyword'
        }
      ]

      params: ListState.getParams()

      success: getEvents.success
      error: getEvents.error

      updateUrl: $scope.updateUrl

    $scope.getParams()

    # register events when route is updated and trigger list update
    $scope.$on '$routeUpdate', () ->
      $scope.getParams()
      $scope.updateList()
]




