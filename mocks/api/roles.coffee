express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



rolesObj = [
  {
    "items": [
      {
        "id": 1,
        "code": "mx_admin_full",
        "name": "MX Administrator",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 2,
        "code": "mx_admin_edit",
        "name": "MX Admin Editor",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 3,
        "code": "mx_admin_read",
        "name": "MX Admin Reader",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 4,
        "code": "ac_admin_full",
        "name": "AC Administrator",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 5,
        "code": "ac_admin_edit",
        "name": "AC Admin Editor",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 6,
        "code": "ac_admin_read",
        "name": "AC Admin Reader",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 7,
        "code": "super_read",
        "name": "System Reader",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 8,
        "code": "super_edit",
        "name": "System Editor",
        "childRoles": [],
        "childCodes": []
      },
      {
        "id": 9,
        "code": "super_admin",
        "name": "System Administrator",
        "childRoles": [],
        "childCodes": []
      }
    ],
    "total": 9,
    "sorts": [],
    "filters": [],
    "limit": null,
    "page": null
  }
]




# GET ATA CODES
router.get '/', (req, res, next) ->
  responseObj = rolesObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))





# GET SINGLE ATA CODE
router.get '/', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < rolesObj.length
    event = rolesObj[i]
    if event.id.toString() == requestedId.toString()
      responseObj = event
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router