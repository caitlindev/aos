express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })




# GET TAILS
router.get '/', (req, res, next) ->
  responseObj = [
    {
      tailNbr: "429NV"
    }
    {
      tailNbr: "415NV"
    }
    {
      tailNbr: "401NV"
    }
    {
      tailNbr: "901NV"
    }
    {
      tailNbr: "907NV"
    }
    {
      tailNbr: "403NV"
    }
    {
      tailNbr: "421NV"
    }
    {
      tailNbr: "905NV"
    }
    {
      tailNbr: "407NV"
    }
    {
      tailNbr: "423NV"
    }
  ]

  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))




module.exports = router