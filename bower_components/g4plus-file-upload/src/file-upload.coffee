# File upload Module
# ==================
# Make sure you include this module if you want to use the directive
fileUpload = angular.module 'g4plus-file-upload', [
  'blueimp.fileupload'
]

fileUpload.directive 'g4FileUpload', [ '$parse', ($parse) ->
  restrict: 'A'
  replace: false
  transclude: true
  scope:
    currentFile: '=g4CurrentFile'
    currentFileInfo: '=g4CurrentFileInfo'
  template:  '''
    <div data-file-upload="options">
      <div class="pad-bottom">
        <span class="btn btn-default btn-secondary fileinput-button" ng-class="{disabled: active()}">
          <span ng-transclude></span>
          <input type="file" name="uploadedFile" ng-disabled="active()">
        </span>
        <span class="btn btn-default btn-secondary" ng-if="!options.autoUpload" ng-click="lastInQueue(queue).$submit()"
          ng-class="{disabled: (active() || !lastInQueue(queue) || lastInQueue(queue).error) }">
          Start upload
        </span>
        <span class="btn btn-translucent" ng-click="cancel()" ng-class="{disabled: !active()}">
          Cancel upload
        </span>
      </div>
      <div class="alert alert-danger" ng-show="errorMessage">
        <button type="button" class="close" ng-click="errorMessage=''">&times;</button>
        <strong>Error:</strong> {{ errorMessage }}
      </div>
      <div ng-show="active()">
        <div class="progress progress-striped active" data-file-upload-progress="progress()">
          <div class="progress-bar progress-bar-success" ng-style="{width: num + '%'}"></div>
        </div>
      </div>
    </div>
  '''
  link: (scope, element, attrs) ->
    scope.options =
      url: '/api/mx-filestore-web/v1/api/files'
      autoUpload: true
      prependFiles: true
      formData: []

    scope.lastInQueue = (queue) ->
      return null if (not queue or queue.length is 0)
      return (if (scope.options?.prependFiles) then queue[0] else queue[queue.length - 1])

    updateOptions = () ->
      options = null
      getOptions = $parse(attrs.g4FileUpload) if attrs.g4FileUpload
      options = getOptions(scope.$parent) if getOptions
      angular.extend(scope.options, scope.optionsConfig) if options

    scope.$watch 'attrs.g4FileUpload', () ->
      updateOptions()

    scope.$on 'fileuploadstart', (e, data) ->
      scope.errorMessage = ''

    scope.$on 'fileuploaddone', (e, data) ->
      e.stopPropagation()
      dataResponse = data._response?.result?[0]
      if dataResponse?.id
        scope.currentFile = dataResponse.id
        scope.currentFileInfo = dataResponse

    scope.$on 'fileuploadadd', (e, data) ->
      e.stopPropagation()
      data.scope.cancel() if data.scope
      return

    scope.$on 'fileuploadfail', (e, data) ->
      e.stopPropagation()
      return null if data.errorThrown is 'abort'
      scope.errorMessage = data.errorThrown if data.errorThrown

    scope.$on 'fileuploadstart', (e, data) ->
      e.stopPropagation()
]

fileUpload.directive 'g4FileInfo', [ '$http', ($http) ->
  restrict: 'A'
  replace: false
  transclude: true
  template: '''
    <div>
      <span ng-hide="currentFile.fileStoreKey" ng-transclude></span>
      <span ng-show="currentFile.fileStoreKey">
        <a x-ng-href="{{ getDownloadUrl() }}" target="_blank">{{ currentFile.fileName }}</a>
        <span>{{  getFileSize(currentFile.fileSize) }}
      </span>
    </div>
  '''
  scope:
    currentFile: '=g4FileInfo'

  link: (scope, element, attrs) ->
    scope.getDownloadUrl = () ->
      if scope.currentFile?.fileStoreKey
        return '/api/mx-filestore-web/v1/api/files/' + scope.currentFile.fileStoreKey
      else
        return null

    scope.getFileSize = (input) ->
      if isNaN(input) or input is null
        return input

      return input + 'B' if input < 1024
      i = -1
      byteUnits = ['kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']
      loop
        input = input / 1024
        i++
        break unless input > 1024

      return Math.max(input, 0.1).toFixed(1) + byteUnits[i]
]