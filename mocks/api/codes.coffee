express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



ataCodesObj = [
  {
    "createdUnixTimestamp" : 1405374943,
    "createdBy" : {
      "loginId" : "testLoginId",
      "empId" : "testEmployeeId",
      "fullName" : "testName"
    },
    "modifiedUnixTimestamp" : 1405375943,
    "modifiedBy" : {
      "loginId" : "testLoginId",
      "empId" : "testEmployeeId",
      "fullName" : "testName"
    },
    "version" : 1,
    "code" : "03",
    "title" : "Lifting and Shoring",
    "description" : "",
    "aircraft" : "All",
    "children" : [
      {
        "createdUnixTimestamp" : 1405374943,
        "createdBy" : {
          "loginId" : "testLoginId",
          "empId" : "testEmployeeId",
          "fullName" : "testName"
        },
        "modifiedUnixTimestamp" : 1405375943,
        "modifiedBy" : {
          "loginId" : "testLoginId",
          "empId" : "testEmployeeId",
          "fullName" : "testName"
        },
        "version" : 1,
        "code" : "10",
        "title" : "Storage 2",
        "description" : "",
        "aircraft" : "MD80 Model",
        "children" : []
      },
      {
        "createdUnixTimestamp" : 1405374943,
        "createdBy" : {
          "loginId" : "testLoginId",
          "empId" : "testEmployeeId",
          "fullName" : "testName"
        },
        "modifiedUnixTimestamp" : 1405375943,
        "modifiedBy" : {
          "loginId" : "testLoginId",
          "empId" : "testEmployeeId",
          "fullName" : "testName"
        },
        "version" : 1,
        "code" : "15",
        "title" : "Storage",
        "description" : "",
        "aircraft" : "757 Model",
        "children" : []
      }
    ]
  }
]




# GET ATA CODES
router.get '/', (req, res, next) ->
  responseObj = ataCodesObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))





# GET SINGLE ATA CODE
router.get '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < ataCodesObj.length
    event = ataCodesObj[i]
    if event.id.toString() == requestedId.toString()
      responseObj = event
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router