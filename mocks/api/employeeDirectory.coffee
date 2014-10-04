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
    "firstName":"Richard",
    "lastName":"Smith",
    "roles":["dev_sudo"],
    "image":null,
    "userType":"Standard User",
    "employeeGroup":"AD Administration",
    "department":"686 Information Technology",
    "email":"nathan.sculli@allegiantair.com"
  },
  {
    "id":10593,
    "aisId":10593,
    "companyName":"Allegiant Air, LLC",
    "company":20,
    "firstName":"Caitlin",
    "lastName":"Smith",
    "roles":["dev_sudo"],
    "image":null,
    "userType":"Standard User",
    "employeeGroup":"AD Administration",
    "department":"686 Information Technology",
    "email":"caitlin.smith@allegiantair.com"
  },
  {
    "id":10823,
    "aisId":10823,
    "companyName":"Allegiant Air, LLC",
    "company":20,
    "firstName":"John",
    "lastName":"Smith",
    "roles":["dev_sudo"],
    "image":null,
    "userType":"Standard User",
    "employeeGroup":"AD Administration",
    "department":"686 Information Technology",
    "email":"john.smith@allegiantair.com"
  },
  {
    "id":10596,
    "aisId":10596,
    "companyName":"Allegiant Air, LLC",
    "company":20,
    "firstName":"Carmelisse",
    "lastName":"Sanga",
    "roles":["dev_sudo"],
    "image":null,
    "userType":"Standard User",
    "employeeGroup":"AD Administration",
    "department":"686 Information Technology",
    "email":"carmelisse.sanga@allegiantair.com"
  }
]




# GET EMPLOYEES
router.get '/', (req, res, next) ->
  responseObj = userObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))





# GET SINGLE EMPLOYEE BY ID
router.get '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < userObj.length
    user = userObj[i]
    if user.id.toString() == requestedId.toString()
      responseObj = user
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router