'use strict'

comments = angular.module 'g4plus-comments', [
  'g4plus.flash-messages'
  'g4plus-file-upload'
  'custom.file-upload'
  'delete.modal'
]

comments.factory "Comments", [
  '$http'
  ($http) ->
    listComments: (path, mainEntity, limit, page, s, e) ->
      if (limit is null or page is null)
        page = 1 if isNaN parseInt(page, 10)
        limit = 2 if isNaN parseInt(limit, 10)
        posComments = path.indexOf('/' + mainEntity)
        newPath = path.substring(0, (if posComments isnt -1 then (posComments + mainEntity.length + 1) else path.length))
        path = newPath + '?limit=' + limit + '&page=' + page

      $http.get(path).success(s).error(e)
      return

    postComment: (mainEndpoint, mainEntity, data, s, e) ->
      data = data || {}
      $http.post(mainEndpoint + mainEntity, data).success(s).error(e)

    postReply: (mainEndpoint, mainEntity, commentId, data, s, e) ->
      data = data || {}
      $http.post(mainEndpoint + mainEntity + "/" + commentId + "/replies", data).success(s).error(e)
      return
    postAttachment: (mainEndpoint, mainEntity, commentId, data, s, e) ->
      data = data || {}
      $http.post(mainEndpoint + mainEntity + "/" + commentId + "/attachments",  data).success(s).error(e)
      return
    deleteAttachment: (mainEndpoint, mainEntity, commentId, attachmentId, s, e) ->
      $http.delete(mainEndpoint + mainEntity + "/" + commentId + '/attachments/' + attachmentId).success(s).error(e)
      return
]

comments.directive "g4Comments", ['$compile', ($compile) ->
  templateUrl: (elem, attrs) ->
    if attrs.templateDir
      "src/app/g4plus-comments/templates/" + attrs.templateDir + "/comment-block.jade"
    else
      "src/app/g4plus-comments/templates/v1/comment-block.jade"
  transclude: true
  scope: {
    config: '='
  }
  link: (scope, el, attr) ->
    scope.$on "deleted", (event, comment, mess, parentId, isReply) ->
      myElement = el.find('#attach_' + comment.id)
      myElement.remove()

      if isReply
        scope.replyNotice['comment'+parentId] = mess
      else
        scope.notice = mess

  controller: 'commentsCtrl'
]

comments.controller 'commentsCtrl', [
  "$scope"
  "$http"
  "$attrs"
  "$element"
  "Comments"
  "$timeout"
  "$modal"
  "FlashStorage"
  "$parse"
  ($scope, $http, $attrs, $element, Comments, $timeout, $modal, FlashStorage, $parse) ->
    commentable = {}
    $scope.comments = []
    $scope.showButton = false
    $scope.total = 0
    $scope.limit = null
    $scope.page = null
    $scope.notice = {}
    $scope.replyNotice = {}
    timeStamps = []
    timeStampsDiff = 5 * 60 # 5 min

    refreshTimeout = null

    doRefresh = () ->
      $timeout.cancel refreshTimeout

      nowTS = _nowTS()
      nextTS = null

      angular.forEach timeStamps, (timeStamp) ->
        timeStamp += timeStampsDiff
        if timeStamp > nowTS
          if nextTS is null or timeStamp < nextTS
            nextTS = timeStamp

      if nextTS
        refreshTimeout = $timeout doRefresh, (nextTS - nowTS) * 1000

    callbacks =
      commentListSuccess: (comments) ->
        if ($scope.page == 1)
          $scope.comments = []
        $scope.comments = $scope.comments.concat(comments.items)

        nowTS = _nowTS()

        checkTS = (comment) ->
          if _checkUser(comment.creatingUser) and (comment.dateCreatedTimestamp > (nowTS - timeStampsDiff))
            timeStamps.push comment.dateCreatedTimestamp

        angular.forEach comments.items, (comment) ->
          if comment?.attachments?.length
            checkTS(comment)
          if comment?.replies?.length
            angular.forEach comment?.replies, (reply) ->
              if reply?.attachments?.length
                checkTS(reply)

        doRefresh()

        $scope.total = parseInt(comments.total)
        $scope.limit = parseInt(comments.limit)
        $scope.page  = parseInt(comments.page)


      commentListError: (data, status, headers, config) ->
        FlashStorage.set
          reply: false
          level: "danger"
          message: data.message or "Could not retrieve comments"
          tagline: "Error"
          icon: "remove"
          status: status or 500
          view: 'comments-view'
        $scope.notice = FlashStorage.get 'comments-view'

      commentPostSuccess: (response) ->
        if $scope.commentForm.fileInfo
          attachment = _prepareAttachment(null)
          attachmentPostSuccess = (responseAttachment) ->
            response.attachments.push responseAttachment
            _resetFormAttachment($scope.commentForm)

            timeStamps.push response.dateCreatedTimestamp
            doRefresh()

          attachmentPostError = (data, status, headers, config) ->
            FlashStorage.set
              reply: false
              level: "danger"
              message: data.message or "Could not save attachment"
              tagline: "Error"
              icon: "remove"
              status: status or 500
              view: 'comments-view'
            $scope.notice = FlashStorage.get 'comments-view'

          Comments.postAttachment($scope.config.mainEndpoint, $scope.config.mainEntity, response.id, attachment, attachmentPostSuccess, attachmentPostError)

        _resetFormComment()
        $scope.comments.push response
        $scope.total++

        FlashStorage.set
          reply: false
          level: "success"
          message: "Comment successfully added"
          status: 200
          view: 'comments-view'
        $scope.notice = FlashStorage.get 'comments-view'

      commentPostError: (data, status, headers, config) ->
        FlashStorage.set
          reply: false
          level: "danger"
          message: data.message or "Could not save comment"
          tagline: "Error"
          icon: "remove"
          status: status or 500
          view: 'comments-view'
        $scope.notice = FlashStorage.get 'comments-view'


    $scope.$watch "config.path", (path) ->
      if path
        Comments.listComments(path, $scope.config.mainEntity, $scope.limit, $scope.page, callbacks.commentListSuccess, callbacks.commentListError)

    $scope.hasMoreItemsToShow = ->
      $scope.page < ($scope.total / $scope.limit)

    $scope.showMoreItems = ->
      $scope.page++
      $scope.config.path = _updatePath($scope.page)

    $scope.formatDate = (seconds) ->
      hour = moment.utc(seconds, 'X').format("HH:mm")
      date = moment.utc(seconds, 'X').format("MM/DD/YYYY")
      return hour + " GMT " + date

    $scope.showButtons = ->
      $scope.showButton = true

    $scope.commentReply = (comment) ->
      comment.interact = ""
      comment.replying = true

      $timeout (->
        $element.find('#reply-box-'+comment.id).focus()
        return
      ), 100
      return true

    $scope.cancelComment = () ->
      $scope.showButton = false
      $scope.commentForm.fileInfo = null
      _resetFormComment()

    $scope.cancelReply = (comment, replyForm) ->
      _commentResetState comment
      replyForm.$setPristine()

    $scope.createComment = ->
      if $scope.body
        comment = _prepareComment($scope.body)
        Comments.postComment($scope.config.mainEndpoint, $scope.config.mainEntity, comment, callbacks.commentPostSuccess, callbacks.commentPostError)

    $scope.replyComment = (comment, replyForm) ->
      if comment.interact
        reply = _prepareComment(comment.interact)
        $scope.replyNotice = {}
        replyPostSuccess = (response) ->
          if replyForm.fileInfo
            attachment = _prepareAttachment(replyForm)

            attachmentPostSuccess = (responseAttachment) ->
              response.attachments.push responseAttachment
              _resetFormAttachment(replyForm)

              timeStamps.push response.dateCreatedTimestamp
              doRefresh()

            attachmentPostError = (data, status, headers, config) ->
              FlashStorage.set
                reply: true
                level: "danger"
                message: data.message or "Could not save attachment"
                tagline: "Error"
                icon: "remove"
                status: status or 500
                view: 'comments-reply-view-'+comment.id
              $scope.replyNotice['comment' + comment.id] = FlashStorage.get 'comments-reply-view-'+comment.id

            Comments.postAttachment($scope.config.mainEndpoint, $scope.config.mainEntity, response.id, attachment, attachmentPostSuccess, attachmentPostError)

          _commentResetState comment
          replyForm.$setPristine()
          comment.replies.push response

          FlashStorage.set
            reply: true
            level: "success"
            message: "Reply successfully added"
            status: 200
            view: 'comments-reply-view-'+comment.id

          $scope.replyNotice['comment' + comment.id] = FlashStorage.get 'comments-reply-view-'+comment.id


        replyPostError = (data, status, headers, config) ->
          FlashStorage.set
            reply: true
            level: "danger"
            message: data.message or "Could not save reply"
            tagline: "Error"
            icon: "remove"
            status: status or 500
            view: 'comments-reply-view-'+comment.id
          $scope.replyNotice['comment' + comment.id] = FlashStorage.get 'comments-reply-view-'+comment.id

        Comments.postReply($scope.config.mainEndpoint, $scope.config.mainEntity, comment.id, reply, replyPostSuccess, replyPostError)

    $scope.deleteAttachment = (comment, templateDir, parent)->
      comment.attachDelete = true
      modalInstance = $modal.open
        templateUrl: "src/app/g4plus-comments/templates/"+templateDir+"/delete-attachment.jade"
        controller: "deleteModalCtrl"
        resolve:
          commentData: -> comment
          parentData: -> parent
          mainEndpoint: -> $scope.config.mainEndpoint
          mainEntity: -> $scope.config.mainEntity

    $scope.canDeleteAttachment = (comment) ->
      nowTs = _nowTS()
      return true if _checkUser(comment.creatingUser) and (comment.dateCreatedTimestamp + timeStampsDiff > nowTs)

    #helpers
    _checkUser = (user) ->
      return true if user.empId is $scope.config.user.empId

    _nowTS = () ->
      return moment.utc().unix()

    _prepareComment = (body) ->
      comment =
        applicationContext: if $scope.config?.context then $scope.config.context else ''
        applicationNamespace: $scope.config.namespace
        text: body
        creatingUser: $scope.config.user

    _prepareAttachment = (replyForm) ->
      attachment =
        id: if replyForm is null then $scope.commentForm.fileInfo.id else replyForm.fileInfo.id
        ref: if replyForm is null then $scope.commentForm.fileInfo.fileStoreKey else replyForm.fileInfo.fileStoreKey
        name:if replyForm is null then $scope.commentForm.fileInfo.fileName else replyForm.fileInfo.fileName

    _updatePath = (page) ->
      namespacePath = "namespaces/" + $scope.config.namespace + '/'
      contextPath = ''
      if $scope.config?.context
        contextPath = "contexts/" + $scope.config.context + '/'
      return $scope.config.mainEndpoint + namespacePath + contextPath + 'comments?limit=' + $scope.limit + '&page=' + page

    _resetFormComment = ->
      $scope.body = null
      $scope.commentForm.$setPristine()
      $scope.showButton = false

    _resetFormAttachment = (form)->
      form.fileInfo = null

    _commentResetState = (comment) ->
      comment.replying = false

]

deleteModal = angular.module("delete.modal", [])

deleteModal.controller 'deleteModalCtrl', [
  '$rootScope'
  '$scope'
  '$modalInstance'
  'commentData'
  'parentData'
  'mainEndpoint'
  'mainEntity'
  '$http'
  'Comments'
  'FlashStorage'
  ($rootScope, $scope, $modalInstance, commentData, parentData, mainEndpoint, mainEntity, $http, Comments, FlashStorage) ->
    $scope.comment = commentData
    $scope.replyNotice = {}
    mess = {}
    $scope.attachment = commentData.attachments[0]
    isReply = if commentData.replies? then false else true
    template = if isReply then 'comments-reply-view-'+parentData.id else 'comments-view'
    $scope.cancelDelete = ->
      $modalInstance.dismiss 'cancel'

    $scope.deleteAttach =  ->

      attachmentDeleteSuccess = (response) ->
        FlashStorage.set
          reply: isReply
          level: "success"
          message: "Attachment deleted"
          status: 200
          view: template

        if isReply
          mess = FlashStorage.get 'comments-reply-view-'+parentData.id
          parentId = parentData.id
        else
          mess = FlashStorage.get 'comments-view'
          parentId = null

        $rootScope.$broadcast('deleted', commentData, mess, parentId, isReply)
        $modalInstance.close true

      attachmentDeleteError = (data, status, headers, config) ->
        FlashStorage.set
          level: "danger"
          message: data.message or "Could not delete attachment"
          tagline: "Error"
          icon: "remove"
          status: status or 500
          view: 'delete-dialog'
        $scope.notice = FlashStorage.get 'delete-dialog'

      Comments.deleteAttachment(mainEndpoint, mainEntity, $scope.comment.id, $scope.attachment.id, attachmentDeleteSuccess, attachmentDeleteError)

    return
]

customFileUpload = angular.module("custom.file-upload", [])

customFileUpload.directive 'g4FileInfoCustom', [ '$http', ($http) ->
  restrict: 'A'
  replace: false
  transclude: true
  templateUrl: (elem, attrs) ->
    if attrs.templateDir
      "src/app/g4plus-comments/templates/"+attrs.templateDir+"/show-attachment.jade"
    else
      "src/app/g4plus-comments/templates/v1/show-attachment.jade"

  scope:
    currentFile: '=g4FileInfoCustom'

  link: (scope, element, attrs) ->
    scope.getDownloadUrl = () ->
      if scope.currentFile?.ref
        return '/api/mx-filestore-web/v1/api/files/' + scope.currentFile.ref
      else
        return null
]



