express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



rtObj = [
  {
    "id": 1000,
    "state": "open",
    "tailNbr": "AA1234",
    "flightNbr": "100",
    "station": "las",
    "reason": "Free-text reason description",
    "ataCodes": [
      {
        "code":"2145",
        "isPrimary":false
      }
    ],
    "inspectionRequired": true,
    "specialEquipmentReqs": "Free-text requirements description",
    "remarks": "Free-text remarks",
    "createdUnixTimestamp": 1000383438,
    "createdBy": {
      "id":10195,
      "aisId":10195,
      "companyName":"Allegiant Air, LLC",
      "company":20,
      "name":"Nathan Sculli",
      "roles":["dev_sudo"],
      "image":null,
      "userType":"Standard User",
      "employeeGroup":"AD Administration",
      "department":"686 Information Technology",
      "email":"nathan.sculli@allegiantair.com"
    },
    "parts": [
      {
        id: 1000
        partNbr: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
      }
      {
        id: 2000
        partNbr: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
      }
      {
        id: 3000
        partNbr: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
      }
      {
        id: 4000
        partNbr: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
      }
    ],
    "tooling": [
      {
        id: 1000
        toolNbr: "064-50000 [Series]"
        qty: 4
        description: "DME-XCVR"
      }
      {
        id: 2000
        toolNbr: "17M903 [Series]"
        qty: 1
        description: "LCD Monitor Assembly"
      }
      {
        id: 3000
        toolNbr: "064-50000 [Series]"
        qty: 1
        description: "Recorder"
      }
      {
        id: 4000
        toolNbr: "064-50000 [Series]"
        qty: 4
        description: "Radar Antenna"
      }
    ],
    "station": "las",
    "stationManager": {
      "firstName":"Stacy",
      "lastName":"Peralta",
      "phone":"(523) 823-2300 Ext. 78",
      "address":"342 Airport Rd."
      "city":"Duluth",
      "state":"MN",
      "zip":" 92734"
    },
    "stationOnCall": {
      "firstName":"Lucy",
      "lastName":"Dredge",
      "phone":"(723) 728-7261 Ext. 7239"
    },
    "mxVendor": [{
      "name":"Ray's Machine Co.",
      "contactFirstName":"Ray",
      "contactLastName":"Verguenca",
      "phone":"(523) 823-2300 Ext. 78",
      "fax":"(723) 728-7261",
      "address":"342 Airport Rd.",
      "city":"Duluth",
      "state":"MN",
      "zip":"92734",
      "contract":"AW67890"
    }],
    "repairScheme": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sagittis risus lorem. In sit amet nisl posuere, imperdiet sem posuere, bibendum libero. Pellentesque quis erat tellus. Nunc aliquam quam vitae leo vehicula adipiscing. Posuere, bibendum libero. Pellentesque quis erat tellus. Nunc aliquam quam vitae leo vehicula adipiscing. Mauris sed lectus nec felis tincidunt aliquet. Praesent vitae dolor quis risus lobortis blandit. Sed at sem consectetur, interdum sem eget, gravida est. Aliquam cursus augue eu maur.",
    "roadTripTraveler": [
      {
        "employee": {
          "firstName":"Steve",
          "lastName":"Bruner",
          "id":234859,
          "phone":"(984) 727-7237",
          "base":"LAS",
          "DOB":"08/23/1963",
          "gender":"M"
        },
        "travelInfo": {
          "hotel":[{
            "name":"Red Roof Inn",
            "address":"342 Airport Rd.",
            "city":"Duluth",
            "state":"MN",
            "zip":"92734",
            "phone":"(523) 823-2300",
            "confNbr":"56789",
          }],
          "airline":[{
            "name":"Delta",
            "departure":{
              "flightNbr":"DL718",
              "station":"ORD",
              "departUnixTimestamp":1406125858,
              "seat":"12B",
              "confNbr":"92376789"
            },
            "arrival":{
              "flightNbr":"NK241",
              "station":"LAS",
              "arriveUnixTimestamp":1407143921,
              "seat":"36A",
              "confNbr":"00244443"
            }
          }],
          "car":[{
            "name":"Avis",
            "address":"342 Airport Rd.",
            "city":"Duluth",
            "state":"MN",
            "zip":"92734",
            "phone":"(523) 823-2300",
            "confNbr":"AA02375"
          }]
        }
      }
    ]
  }
]





# GET ROAD TRIPS
router.get '/', (req, res, next) ->
  responseObj = rtObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




count = 1
# CREATE ROAD TRIP
router.post '/', (req, res, next) ->
  rtObj.push(req.body)
  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)






# GET SINGLE ROAD TRIP
router.get '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0

  while i < rtObj.length
    event = rtObj[i]
    if event.id.toString() == requestedId.toString()
      responseObj = event
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))



# UPDATE ROAD TRIP BY ID
router.put '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0
  while i < rtObj.length
    event = rtObj[i]
    if event.id.toString() == requestedId.toString()
      rtObj[i] = req.body
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)







module.exports = router