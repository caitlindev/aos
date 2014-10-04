express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.urlencoded()
router.use bodyParser.json()
router.use bodyParser.json({ type: 'application/json' })



favoritesObj = [
  {
    "id": 0,
    "level": 0,
    "name": "Source Documents",
    "url": "https://www.google.com/",
    "displayMode": "_blank",
    "code": "mx_source_documents"
  },{
    "id": 1,
    "level": 0,
    "name": "DMI",
    "url": "https://www.google.com/",
    "displayMode": "_blank",
    "code": "mxdmi"
  },{
    "id": 2,
    "level": 0,
    "name": "Skill Codes",
    "url": "https://www.google.com/",
    "displayMode": "_blank",
    "code": "mx-skill-codes"
  },{
    "id": 3,
    "level": 0,
    "name": "Failure Effect Codes",
    "url": "https://www.google.com/",
    "displayMode": "_blank",
    "code": "mx-failure-effect-codes"
  },{
    "id": 4,
    "level": 0,
    "name": "Task Cards",
    "url": "https://www.google.com/",
    "code": "mx-task-cards"
  }
]




# GET FAVORITES
router.get '/', (req, res, next) ->
  responseObj = favoritesObj
  res.setHeader('Content-Type', 'application/json')
  res.send(JSON.stringify(responseObj))


# CREATE FAVORITES
count = 5
router.post '/', (req, res, next) ->
  req.body.id = count
  count++
  favoritesObj.push(req.body)
  res.setHeader('Content-Type', 'application/json')
  res.send(req.body)


# DELETE FAVORITE
router.delete '/:id', (req, res, next) ->
  requestedId = req.params.id

  i = 0
  while i < favoritesObj.length
    favorite = favoritesObj[i]
    if favorite.id.toString() == requestedId.toString()
      favoritesObj.splice(i, 1)
    i++

  res.setHeader('Content-Type', 'application/json')
  res.send(favoritesObj)








module.exports = router