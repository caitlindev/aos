express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })


tailRoutesObj = [
  {
    tailNbr: "429NV"
    airports: [
      "LAS"
      "MCO"
      "AZA"
      "COS"
      "LAS"
    ]
  }
  {
    tailNbr: "415NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
  {
    tailNbr: "401NV"
    airports: [
      "LAS"
      "SCK"
      "LAS"
      "SCK"
      "LAS"
    ]
  }
  {
    tailNbr: "901NV"
    airports: [
      "LAS"
      "MCO"
      "CID"
      "AZA"
      "BLI"
    ]
  }
  {
    tailNbr: "907NV"
    airports: [
      "XNA"
      "MCO"
      "SFB"
      "XNA"
      "SFB"
    ]
  }
  {
    tailNbr: "403NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
  {
    tailNbr: "421NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
  {
    tailNbr: "905NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
  {
    tailNbr: "407NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
  {
    tailNbr: "423NV"
    airports: [
      "LAS"
      "XNA"
      "AZA"
      "XNA"
      "LAS"
    ]
  }
]


# GET TAIL ROUTE INFO
router.get '/', (req, res, next) ->
  responseObj = tailRoutesObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))


module.exports = router
