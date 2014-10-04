express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })




# GET EVENTS
router.get '/', (req, res, next) ->
  responseObj = [
        {
          "id": 1000,
          "part": "064-50000 [Series]"
          "description": "DME-XCVR",
          "status": "In Stock",
        },{
          "id": 2000,
          "part": "17M903 [Series]"
          "description": "LCD Monitor Assembly",
          "status": "On Order",
        },{
          "id": 3000,
          "part": "064-50000 [Series]"
          "description": "Recorder",
          "status": "In Stock",
        },{
          "id": 4000,
          "part": "064-50000 [Series]"
          "description": "Radar Antenna",
          "status": "In Stock",
        },{
          "id": 5000,
          "part": "Hammer"
          "description": "Lorem ipsum dolor sit",
          "status": "In Stock",
        },{
          "id": 6000,
          "part": "Screwdriver"
          "description": "Lorem ipsum dolor",
          "status": "On Order",
        },{
          "id": 7000,
          "part": "Nails"
          "description": "Lorem ipsum",
          "status": "In Stock",
        },{
          "id": 8000,
          "part": "Wrench"
          "description": "Lorem ipsum dolor sit",
          "status": "In Stock",
        },{
          "id": 9000,
          "part": "Saw"
          "description": "DME-XCVR",
          "status": "In Stock",
        },{
          "id": 10000,
          "part": "Stick"
          "description": "Lorem ipsum dolor",
          "status": "On Order",
        },{
          "id": 11000,
          "part": "Rock"
          "description": "Lorem ipsum",
          "status": "In Stock",
        },{
          "id": 12000,
          "part": "Wheel"
          "description": "Lorem ipsum dolor",
          "status": "In Stock",
        },{
          "id": 13000,
          "part": "Blade"
          "description": "Lorem ipsum dolor",
          "status": "In Stock",
        },{
          "id": 14000,
          "part": "Windows"
          "description": "Lorem ipsum",
          "status": "On Order",
        },{
          "id": 15000,
          "part": "Doors"
          "description": "Lorem",
          "status": "In Stock",
        },{
          "id": 16000,
          "part": "Wings"
          "description": "Lorem ipsum",
          "status": "In Stock",
        }
      ]

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router