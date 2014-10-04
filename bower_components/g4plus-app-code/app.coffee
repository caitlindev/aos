
module = angular.module 'g4-app-code', [
]

module.config ($httpProvider) ->
  $httpProvider.defaults.headers.common = {
    'appCode': appCode
  }

module.directive 'g4AppCode', [

  ($rootScope, getPerms, FlashStorage) ->
    return {
    restrict: 'A'

    }
]
