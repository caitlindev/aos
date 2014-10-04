express = require 'express'
bodyParser = require 'body-parser'
moment = require 'moment'

router = express.Router()

router.use bodyParser.json()

_nowTS = () ->
  nowTS = moment().utc().unix()
  # console.log nowTS
  console.log 'now moment ', new Date(nowTS * 1000)
  return nowTS

###### COMMENTS #####

commentsList = [
  {
    "contextRef": "SD12"
    "appNamespace": "mx.sourcedocs"
    "id": 1
    "text": "Some comment 1..."
    "createdUnixTimestamp": 1404032864
    "createdBy": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": [
      {
        "contextRef": "SD12"
        "appNamespace": "mx.sourcedocs"
        "id": 1
        "text": "Reply comment..."
        "createdUnixTimestamp": 1404040064
        "createdBy": {
          "loginId": "michael.freeman"
          "empId": "00015"
          "fullName": "Michael Freeman"
        }
        "attachments": []
      }
      {
        "contextRef": "SD12"
        "appNamespace": "mx.sourcedocs"
        "id": 2,
        "text": "Reply comment 2..."
        "createdUnixTimestamp": 1404047264
        "createdBy": {
          "loginId": "john.smith"
          "empId": "00013"
          "fullName": "John Smith"
        }
        "attachments": []
      }
    ]
    "attachments": []
  }
  {
    "contextRef": "SD12"
    "appNamespace": "mx.sourcedocs"
    "id": 2
    "text": "Some comment 2..."
    "createdUnixTimestamp": 1403960864
    "createdBy": {
      "loginId": "michael.freeman"
      "empId": "00015"
      "fullName": "Michael Freeman"
    }
    "replies": []
    "attachments": [
      {
        "id": 1,
        "ref": "abcd1234"
        "name": "SomeFile.pdf"
      }
    ]
  }
  {
    "contextRef": "SD12"
    "appNamespace": "mx.sourcedocs"
    "id": 3
    "text": "Some comment 3..."
    "createdUnixTimestamp": 1403906864
    "createdBy": {
      "loginId": "joe.allegro"
      "empId": "00016"
      "fullName": "Joe Allegro"
    }
    "replies": []
    "attachments": []
  }
  {
    "contextRef": "AU2"
    "appNamespace": "avluser"
    "id": 4
    "text": "Lorem Ipsum Avuluser AU2 4 ..."
    "createdUnixTimestamp": 1403820404
    "createdBy": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": []
    "attachments": [
      {
        "id": 1,
        "ref": "abcd1234"
        "name": "SomeFile.pdf"
      }
    ]
  }
  {
    "contextRef": "AU2"
    "appNamespace": "avluser"
    "id": 5
    "text": "Lorem Ipsum Avuluser AU2 5 ..."
    "createdUnixTimestamp": 1403734004
    "createdBy": {
      "loginId": "michael.freeman"
      "empId": "00015"
      "fullName": "Michael Freeman"
    }
    "replies": []
    "attachments": []
  }
  {
    "contextRef": "AU2"
    "appNamespace": "avluser"
    "id": 6
    "text": "Lorem Ipsum Avuluser AU2 6..."
    "createdUnixTimestamp": 1403647604
    "createdBy": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": []
    "attachments": []
  }
  {
    "contextRef": "AU2"
    "appNamespace": "avluser"
    "id": 7
    "text": "Lorem Ipsum Avuluser AU2 7..."
    "createdUnixTimestamp": 1403561204
    "createdBy": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": [
      {
        "contextRef": "AU2"
        "appNamespace": "avluser"
        "id": 3
        "text": "Reply comment 3..."
        "createdUnixTimestamp": 1403647604
        "createdBy": {
          "loginId": "michael.freeman"
          "empId": "00015"
          "fullName": "Michael Freeman"
        }
        "attachments": []
      }
      {
        "contextRef": "AU2"
        "appNamespace": "avluser"
        "id": 4,
        "text": "Reply comment 4..."
        "createdUnixTimestamp": 1403651204
        "createdBy": {
          "loginId": "john.smith"
          "empId": "00013"
          "fullName": "John Smith"
        }
        "attachments": []
      }
    ]
    "attachments": [
      {
        "id": 2,
        "ref": "abcd1234"
        "name": "SomeFile1.pdf"
      }
    ]
  }
  {
    "contextRef": "AU2"
    "appNamespace": "avluser"
    "id": 8
    "text": "Lorem Ipsum Avuluser AU2 8..."
    "createdUnixTimestamp": 1403478404
    "createdBy": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": []
    "attachments": []
  }
]

lastReply = 20
lastAttachment = 20
lastComment = 33

findComment = (id) ->
  for itm in commentsList
    if itm.id is parseInt(id, 10)
      return itm
  return null

findReply = (id) ->
  for itm in commentsList
    for repl in itm.replies
      if repl.id is parseInt(id, 10)
        return repl
  return null


# router.get '/', (req, res) ->
#   res.status(200).send commentsList

router.post '/', (req, res) ->
  # return res.status(400).send {message: 'Post Comment Error'}

  newItem = {
    "contextRef":  req.body.ref
    "appNamespace": req.body.ns
    "id": lastComment++
    "text": req.body.text
    "createdUnixTimestamp": _nowTS()
    "createdBy": req.body.createdBy
    "replies": []
    "attachments": []
  }

  commentsList.push newItem

  res.status(201).send newItem

router.get '/:id', (req, res) ->
  comment = findComment(req.params.id)

  return res.status(404).send { message: 'Not found' } if not comment

  res.status(200).send comment

router.post '/:id/replies', (req, res) ->
  #return res.status(400).send {message: 'Post Reply Error'}

  comment = findComment(req.params.id)
  return res.status(404).send { message: 'Comment Not found' } if not comment

  newItem = {
    "contextRef": comment.contextRef
    "appNamespace": comment.appNamespace
    "id": lastReply++
    "text": req.body.text
    "createdUnixTimestamp": _nowTS()
    "createdBy": req.body.createdBy
    "attachments": []
  }

  comment.replies.push newItem
  #console.log comment

  res.status(201).send newItem


router.get '/:id/replies/:replyId', (req, res) ->
  comment = findComment(req.params.id)

  return res.status(404).send { message: 'Comment Not found' } if not comment

  outReply = null
  for itm in comment.replies
    if itm.id is parseInt(req.params.replyId, 10)
      outReply = itm

  return res.status(404).send { message: 'Reply Not found' } if not outReply
  res.status(200).send outReply

router.post '/:id/attachments', (req, res) ->
  # return res.status(400).send { message: 'Post Attachment Error' }
  comment = findComment(req.params.id)

  if not comment
    reply = findReply(req.params.id)

  return res.status(404).send { message: 'Not found' } if not comment and not reply

  newItem = {
    "id": lastAttachment++,
    "ref": req.body.ref
    "name": req.body.name
  }

  if comment
    comment.attachments.push newItem
  else
    reply.attachments.push newItem

  res.status(201).send newItem

router.get '/:id/attachments/:attachmentId', (req, res) ->
  comment = findComment(req.params.id)

  return res.status(404).send { message: 'Comment Not found' } if not comment

  outAttach = null
  for itm in comment.attachments
    if itm.id is parseInt(req.params.attachmentId, 10)
      outAttach = itm

  return res.status(404).send { message: 'Attachment Not found' } if not outAttach
  res.status(200).send outAttach

router.delete '/:id/attachments/:attachmentId', (req, res) ->
  comment = findComment(req.params.id)
  if not comment
    reply = findReply(req.params.id)
  #return res.status(404).send { message: 'Comment Not found' }
  return res.status(404).send { message: 'Comment Not found' } if not comment and not reply
  outAttach = null
  if comment
    for itm in comment.attachments
      if itm.id is parseInt(req.params.attachmentId, 10)
        outAttach = itm
    comment.attachments = []
  else
    for itm in reply.attachments
      if itm.id is parseInt(req.params.attachmentId, 10)
        outAttach = itm
    reply.attachments = []
  return res.status(404).send { message: 'Attachment Not found' } if not outAttach

  res.status(200).send {message: 'Deleted Successfully'}

###### END COMMENTS #####

module.exports = router