chartData = angular.module 'services.chart', []
# Chart Service
# ======================


# This is the interface to dashboard chart
chartData.factory 'Chart', [
  '$resource'
  '$location'

  ($resource, $location) ->
    return $resource '/api/events/', [], {
      query: { method: 'GET', isArray: true, tracker: 'loading' }
      post: { method: 'POST' }
      update: { method: 'PUT' }
      get: { method: 'GET', tracker: 'loading' }
    }
]






