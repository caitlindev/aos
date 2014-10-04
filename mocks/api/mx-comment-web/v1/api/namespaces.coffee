express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.json()

###### NAMESPACES COMMENTS #####
namespaceList = [
  {
    title: 'MX SourceDocs'
    uri: 'mx.sourcedocs'
  }
  {
    title: 'AVL User'
    uri: 'avluser'
  }
]

namespaceItems = {
  'mx.sourcedocs': [
    {
      id: 1
      title: 'Source Document'
      contextRef: 'SD12'
    }
    {
      id: 2
      title: 'General Document'
      contextRef: 'SD13'
    }
  ]
  'avluser': [
    {
      id: 3
      title: 'Audit Request'
      contextRef: 'AU1'
    }
    {
      id: 4
      title: 'Audit Order'
      contextRef: 'AU2'
    }
  ]
}

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


findCommentsNamespace = (type) ->
  comments = []
  for item in commentsList
    if type is item.appNamespace
      comments.push item
  return comments


findCommentsNamespaceContext = (type, ctx) ->
  comments = []
  for item in commentsList
    if type is item.appNamespace && ctx is item.contextRef
      comments.push item
  return comments

isValidNumber = (param) ->
  return false if not param or isNaN(parseInt(param, 10))
  return (parseInt(param, 10) > 0)  


router.get '/:namespace/comments', (req, res) ->
  item = findCommentsNamespace(req.params.namespace)
  # return res.status(404).send { message: 'Not found' }
  return res.status(404).send { message: 'Not found' } if not item

  page = 1
  limit = 2

  if isValidNumber(req.query.page)
    page = parseInt(req.query.page, 10)

  if isValidNumber(req.query.limit)
    limit = parseInt(req.query.limit, 10)

  start = (page - 1) * limit
  res.status(200).send {
    items: item.slice(start, start + limit)
    total: item.length
    page: page
    limit: limit
  } 

router.get '/:namespace/contexts/:ctx/comments', (req, res) ->
  item = findCommentsNamespaceContext(req.params.namespace, req.params.ctx)
  #return res.status(404).send { message: 'Not found' }
  return res.status(404).send { message: 'Not found' } if not item

  page = 1
  limit = 2

  if isValidNumber(req.query.page)
    page = parseInt(req.query.page, 10)

  if isValidNumber(req.query.limit)
    limit = parseInt(req.query.limit, 10)

  start = (page - 1) * limit
  res.status(200).send {
    items: item.slice(start, start + limit)
    total: item.length
    page: page
    limit: limit
  } 


###### END NAMESPACES COMMENTS #####

module.exports = router