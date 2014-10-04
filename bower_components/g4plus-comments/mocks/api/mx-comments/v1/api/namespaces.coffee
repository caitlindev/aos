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
      applicationContext: 'SD12'
    }
    {
      id: 2
      title: 'General Document'
      applicationContext: 'SD13'
    }
  ]
  'avluser': [
    {
      id: 3
      title: 'Audit Request'
      applicationContext: 'AU1'
    }
    {
      id: 4
      title: 'Audit Order'
      applicationContext: 'AU2'
    }
  ]
}

commentsList = [
  {
    "applicationContext": "SD12"
    "applicationNamespace": "mx.sourcedocs"
    "id": 1
    "text": "Some comment 1..."
    "dateCreatedTimestamp": 1404032864
    "creatingUser": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": [
      {
        "applicationContext": "SD12"
        "applicationNamespace": "mx.sourcedocs"
        "id": 1
        "text": "Reply comment..."
        "dateCreatedTimestamp": 1404040064
        "creatingUser": {
          "loginId": "michael.freeman"
          "empId": "00015"
          "fullName": "Michael Freeman"
        }
        "attachments": []
      }
      {
        "applicationContext": "SD12"
        "applicationNamespace": "mx.sourcedocs"
        "id": 2,
        "text": "Reply comment 2..."
        "dateCreatedTimestamp": 1404047264
        "creatingUser": {
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
    "applicationContext": "SD12"
    "applicationNamespace": "mx.sourcedocs"
    "id": 2
    "text": "Some comment 2..."
    "dateCreatedTimestamp": 1403960864
    "creatingUser": {
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
    "applicationContext": "SD12"
    "applicationNamespace": "mx.sourcedocs"
    "id": 3
    "text": "Some comment 3..."
    "dateCreatedTimestamp": 1403906864
    "creatingUser": {
      "loginId": "joe.allegro"
      "empId": "00016"
      "fullName": "Joe Allegro"
    }
    "replies": []
    "attachments": []
  }
  {
    "applicationContext": "AU2"
    "applicationNamespace": "avluser"
    "id": 4
    "text": "Lorem Ipsum Avuluser AU2 4 ..."
    "dateCreatedTimestamp": 1403820404
    "creatingUser": {
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
    "applicationContext": "AU2"
    "applicationNamespace": "avluser"
    "id": 5
    "text": "Lorem Ipsum Avuluser AU2 5 ..."
    "dateCreatedTimestamp": 1403734004
    "creatingUser": {
      "loginId": "michael.freeman"
      "empId": "00015"
      "fullName": "Michael Freeman"
    }
    "replies": []
    "attachments": []
  }
  {
    "applicationContext": "AU2"
    "applicationNamespace": "avluser"
    "id": 6
    "text": "Lorem Ipsum Avuluser AU2 6..."
    "dateCreatedTimestamp": 1403647604
    "creatingUser": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": []
    "attachments": []
  }
  {
    "applicationContext": "AU2"
    "applicationNamespace": "avluser"
    "id": 7
    "text": "Lorem Ipsum Avuluser AU2 7..."
    "dateCreatedTimestamp": 1403561204
    "creatingUser": {
      "loginId": "john.smith"
      "empId": "00013"
      "fullName": "John Smith"
    }
    "replies": [
      {
        "applicationContext": "AU2"
        "applicationNamespace": "avluser"
        "id": 3
        "text": "Reply comment 3..."
        "dateCreatedTimestamp": 1403647604
        "creatingUser": {
          "loginId": "michael.freeman"
          "empId": "00015"
          "fullName": "Michael Freeman"
        }
        "attachments": []
      }
      {
        "applicationContext": "AU2"
        "applicationNamespace": "avluser"
        "id": 4,
        "text": "Reply comment 4..."
        "dateCreatedTimestamp": 1403651204
        "creatingUser": {
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
    "applicationContext": "AU2"
    "applicationNamespace": "avluser"
    "id": 8
    "text": "Lorem Ipsum Avuluser AU2 8..."
    "dateCreatedTimestamp": 1403478404
    "creatingUser": {
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
    if type is item.applicationNamespace
      comments.push item
  return comments


findCommentsNamespaceContext = (type, ctx) ->
  comments = []
  for item in commentsList
    if type is item.applicationNamespace && ctx is item.applicationContext
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