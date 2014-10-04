view = angular.module 'app.view', ['angularFileUpload']

view.controller "ViewCtrl", [
  '$scope'
  '$location'
  '$interval'
  '$upload'
  '$modal'
  '$stateParams'
  '$window'
  'EventsService'
  'FlightsService'
  'RoadTripService'
  'StationsService'
  ($scope, $location, $interval, $upload, $modal, $stateParams, $window, EventsService, FlightsService, RoadTripService, StationsService) ->

    $scope.imagesInMedia = false
    $scope.docsInMedia = false
    $scope.id = $stateParams.id

    $scope.onFileSelect = ($files) ->

      #$files: an array of files selected, each file has name, size, and type.
      i = 0

      while i < $files.length
        file = $files[i]
        #upload.php script, node.js route, or servlet url
        #method: 'POST' or 'PUT',
        #headers: {'header-key': 'header-value'},
        #withCredentials: true,
        # or list of files ($files) for html5 only
        #fileName: 'doc.jpg' or ['1.jpg', '2.jpg', ...] // to modify the name of the file(s)
        # customize file formData name ('Content-Disposition'), server side file variable name.
        #fileFormDataName: myFile, //or a list of names for multiple files (html5). Default is 'file'
        # customize how data is added to formData. See #40#issuecomment-28612000 for sample code
        #formDataAppender: function(formData, key, val){}
        $scope.upload = $upload.upload(
          url: "api/mx-filestore-web/v1/api/files"
          data:
            myObj: $scope.myModelObj

          file: file
        ).progress((evt) ->
          # console.log "percent: " + parseInt(100.0 * evt.loaded / evt.total)
          return
        ).success((data, status, headers, config) ->
          filename = data[0].fileName
          pathType = filename.substr(filename.lastIndexOf('.') + 1, filename.length)
          if pathType == "jpg" || pathType == "jpeg" || pathType == "png" || pathType == "gif"
            $scope.imagesInMedia = true
          else
            $scope.docsInMedia = true

          uploadedFile =
            ref: data[0].fileStoreKey
            name: filename
            createdUnixTimestamp : moment().unix()
            path: 'http://localhost:3333/' + data[0].fileName

          $scope.event.documents.push(uploadedFile)
          return
        )
        i++
      return



    # Delete Modal
    $scope.openDeleteModal = () ->
      if $scope.roadTrip?
        modalInstance = $modal.open(
          controller: "DeleteWarningModalCtrl"
          templateUrl: 'src/app/ui_flow/delete/rt-warning-modal.jade'
        )
      else
        modalInstance = $modal.open(
          controller: "DeleteModalCtrl"
          templateUrl: 'src/app/ui_flow/delete/modal.jade'
          resolve: {
            rt: () -> $scope.roadTrip
            ev: () -> $scope.event
          }
        )

      modalInstance.result.then (flashMessage) ->


    $scope.cancel = () ->
      $modalInstance.close()


    $scope.goToPath = (e, path, query) ->
      if e.which == 13 || e.which==1
        $location.path(path).search({'filter_value' : query})

    $scope.comment_limit_value = 3
    $scope.increaseCommentLimit = (lng) ->
      if $scope.comment_limit_value < lng
        $scope.comment_limit_value += 3

      if $scope.comment_limit_value >= lng
        $scope.comment_limit_value = lng

    $scope.decreaseCommentLimit = (lng) ->
      if $scope.comment_limit_value > 0
        $scope.comment_limit_value -= 3

      if $scope.comment_limit_value <= 0
        $scope.comment_limit_value = 0




    $scope.history_limit_value = 3
    $scope.increaseHistoryLimit = (lng) ->
      if $scope.history_limit_value < lng
        $scope.history_limit_value += 3

      if $scope.history_limit_value >= lng
        $scope.history_limit_value = lng

    $scope.decreaseHistoryLimit = (lng) ->
      if $scope.history_limit_value > 0
        $scope.history_limit_value -= 3

      if $scope.history_limit_value <= 0
        $scope.history_limit_value = 0


    $scope.currentTime = new Date()
    $scope.toMilliseconds = (timestamp) ->
      Math.round(timestamp.getTime() / 1000)




    $scope.collapsedIcon = (isCollapsed) ->
     if isCollapsed==true
      return 'fa-angle-right'
     else
      return 'fa-angle-down'



    _this = this


    $scope.getAttachmentType = (path) ->
      paths = {
        images: '',
        docs:''
      }
      if path != undefined
        pathType = path.substr(path.lastIndexOf('.') + 1, path.length)
        if pathType == "jpg" || pathType == "jpeg" || pathType == "png" || pathType == "gif"
          paths.images = path
          $scope.imagesInMedia = true

        else
          paths.docs = path
          $scope.docsInMedia = true


      return paths






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







    _this.getStationsWs = {
      stationWs: (service) ->
        service.getStations (data, status, headers, config) ->
          for station in data
            if station.name == $scope.event.station
              $scope.event.station = station
        , (data, status, headers, config) ->
          console.log 'error'
    }







    _this.getEventVersionsWs = {
      eventVersionsWs: (service) ->
        id = $stateParams.id
        service.getVersions(id, _this.getEventVersionsWs.success, _this.getEventVersionsWs.error)

      success: (data, status, headers, config) ->
        versionList = data
        openVersions = []

        if versionList.length > 0

          # get number of event versions for ticket
          lng = versionList.length

          # function to sort by version created time
          sortByCreatedTime = (a, b) ->
            sortStatus = 0
            if a.createdUnixTimestamp < b.createdUnixTimestamp
              sortStatus = -1
            else sortStatus = 1  if a.createdUnixTimestamp > b.createdUnixTimestamp
            sortStatus

          # sort
          versionList.sort sortByCreatedTime


          ticketCloseTime = ''
          ticketOpenTime = versionList[0].createdUnixTimestamp
          if $scope.event.state == "closed"
            ticketCloseTime = versionList[lng-1].createdUnixTimestamp
          else
            ticketCloseTime = moment().unix()

          ticketDuration = ticketCloseTime - ticketOpenTime






          splitVersionsByStatus = (version) ->
            tmp = []
            for key of versionList
              if versionList[key].status.toLowerCase() == version
                tmp.push(versionList[key])

            if tmp.length
              openVersions.push(tmp)


          splitVersionsByStatus('adv')

          if $scope.event.status.toUpperCase()=="ETR"
            splitVersionsByStatus('etr')
#          splitVersionsByStatus('rdy')



          i = 1
          while i < openVersions.length + 1
            j = i-1

            if openVersions[j].length
              statusOpenTime = openVersions[j][0].createdUnixTimestamp

              if i == openVersions.length
                statusCloseTime = ticketCloseTime
              else
                if openVersions[i].length
                  statusCloseTime = openVersions[i][0].createdUnixTimestamp
                else
                  statusCloseTime = ticketCloseTime

              statusDuration = statusCloseTime - statusOpenTime

            i++

            k = 0
            while k < openVersions[j].length
              openVersions[j][k].duration = Math.round(statusDuration * 100)
              openVersions[j][k].durationPercentage = Math.round((statusDuration / ticketDuration) * 100)
              k++

          $scope.event.versionInfo = openVersions
#          console.log(openVersions)

      error: (data, status, headers, config) ->
        # error callback
    }

    $scope.user =
      loginId: "michael.freeman"
      empId: "00015"
      fullName: "Michael Freeman"

    # directive config
    $scope.commentConfig =
      user:
        loginId: $scope.user.loginId
        empId: $scope.user.empId
        fullName: $scope.user.fullName

      context: "AOS" # $stateParams.id
      namespace: "aosuser"
      path: "/api/mx-comment-web/v1/api/namespaces/aosuser/contexts/AOS/comments"
      show:
        close: false
        attachments: true
        visible: true
        isVisible: () ->
          @visible
        toggle: () ->
          @visible = !@visible
          @visible





    _this.getEventWs = {
      eventWs: (service) ->
        id = $stateParams.id
        service.getEvent(id, _this.getEventWs.success, _this.getEventWs.error)

      success: (data, status, headers, config) ->
        event = data
        $scope.getElapsedTime(event)

        $scope.event = event

        $scope.$watch "flightList", () ->
          flights = $scope.flightList
          for flightsKey of flights
            tailNbr = flights[flightsKey].tailNbr
            flightInfo = flights[flightsKey]

            if $scope.event.tailNbr == tailNbr
              $scope.event.flightInfo = flightInfo
              console.log flightInfo.routes[2]

        # Get event version data
        _this.getEventVersionsWs.eventVersionsWs(EventsService)

        # Get station data
        _this.getStationsWs.stationWs(StationsService)



      error: (data, status, headers, config) ->
        # error callback
    }

#    Get all events
    _this.getEventWs.eventWs(EventsService)




    $scope.elapsedTime = ''
    $scope.getElapsedTime = (event) ->
      $interval(() ->
        if $scope.toMilliseconds(new Date()) - event.createdUnixTimestamp > 0
          $scope.elapsedTime = $scope.toMilliseconds(new Date()) - event.createdUnixTimestamp
        else
          $scope.elapsedTime = 0
      ,1000)









    _this.getRoadTripWs = {
      roadTripWs: (service) ->
        id = $stateParams.id
        service.getRoadTrip(id, _this.getRoadTripWs.success, _this.getRoadTripWs.error)

      success: (data, status, headers, config) ->
        roadTrip = data
        if roadTrip!=''
          console.log roadTrip.state.toUpperCase()
          if (roadTrip.id.toString()==$scope.event.id.toString() && roadTrip.state.toUpperCase()!='CLOSED')
            $scope.roadTrip = roadTrip

      error: (data, status, headers, config) ->
        # error callback
    }

#    Get all events
    _this.getRoadTripWs.roadTripWs(RoadTripService)









    # item for ws
    $scope.newComment = {
        "text": null,
        "createdUnixTimestamp": $scope.toMilliseconds($scope.currentTime),
        "createdBy": {
          "loginId": "caitlin.smith",
          "empId": "10593",
          "fullName": "Caitlin Smith"
        },
        "replies": [],
        "attachments": []
      }

    _this.postCommentWs = {

      commentWs: (service, data) ->
        id = $stateParams.id

        # WS call. Ex: mockWs.rootCauseWs(rootCauseWs.success, rootCauseWs.error)
        service.postComment(id, data, _this.postCommentWs.success, _this.postCommentWs.error)

      success: (data, status, headers, config) ->
        # success callback

      error: (data, status, headers, config) ->
        # error callback
    }


    $scope.createComment = () ->
      _this.postCommentWs.commentWs(EventsService, $scope.newComment)

      id = $stateParams.id
      $window.location.reload()


]

