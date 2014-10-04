express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



userObj = [
  {
    "id":10195,
    "aisId":10195,
    "companyName":"Allegiant Air, LLC",
    "company":20,
    "name":"Mark Sherear",
    "roles":["dev_sudo"],
    "image":null,
    "userType":"Standard User",
    "employeeGroup":"AD Administration",
    "department":"686 Information Technology",
    "email":"mark.sherear@allegiantair.com"
  }
]




# GET USER
router.get '/', (req, res, next) ->
  res.setHeader('Content-Type', 'application/json')
  res.send(userObj)






module.exports = router