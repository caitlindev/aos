express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.json()

###### Root Cause Codes ######

itemsList = [
  {
    id: 1,
    code: 'A'
    description: 'Aircraft Damaged Tech Ops'
  }
  {
    id: 2,
    code: 'C'
    description: 'Crew Refusal'
  }
  {
    id: 3,
    code: 'CK'
    description: 'Complete Overnight Check'
  }
  {
    id: 4,
    code: 'D'
    description: 'Unplanned Workload'
  }
  {
    id: 5,
    code: 'E'
    description: 'Troubleshooting'
  }
  {
    id: 6,
    code: 'ENG'
    description: 'Engine Change'
  }
  {
    id: 7,
    code: 'F'
    description: 'Facility Restriction'
  }
  {
    id: 8,
    code: 'FCD'
    description: 'Fleet Campaign Directive'
  }
  {
    id: 9,
    code: 'FOD'
    description: 'Foreign Object Damage'
  }
  {
    id: 10,
    code: 'G'
    description: 'Aircraft Damage Other'
  }
  {
    id: 11,
    code: 'HCK'
    description: 'Heavy Check'
  }
  {
    id: 12,
    code: 'K'
    description: 'Marketing'
  }
];


lastItem = 13

findItem = (id) ->
  for item in itemsList
    if parseInt(id) is item.id
      return item
  return null

itemExitsByColumn = (column, item) ->
  for itemL in itemsList
    if item?[column] and itemL?[column] and item.id isnt itemL.id and itemL?[column].toLowerCase() is item[column].toLowerCase()
      return true
  return false

isInvalidItem = (res, item) ->
  console.log(item)
  if not item.code
    return res.status(400).send { message: 'Code is required' }

  if not item.code.length > 4
    return res.status(400).send { message: 'Code maximum length is 4' }

  if itemExitsByColumn('code', item)
    return res.status(400).send { message: 'Code already exists' }

  if not item.description
    return res.status(400).send { message: 'Description is required' }

  if not item.description.length > 25
    return res.status(400).send { message: 'Description maximum length is 25' }

  if itemExitsByColumn('description', item)
    return res.status(400).send { message: 'Description already exists' }

  return false

router.get '/', (req, res) ->
  res.status(200).send {
    items: itemsList
    total: itemsList.length
  }

router.post '/', (req, res) ->
  item = {
    id: lastItem++
    description: req.body.description
    code: req.body.code
  }

  return if isInvalidItem res, item

  itemsList.push item

  res.status(200).send item

router.get '/:id', (req, res) ->
  item = findItem(req.params.id)

  return res.status(404).send { message: 'RootCauseCodes ID ' + req.params.id + ' not found' } if not item

  res.status(200).send item

router.put '/', (req, res) ->
  item = findItem(req.body.id)


  return res.status(404).send { message: 'RootCauseCodes ID ' + req.body.id + ' not found' } if not item

  checkItem = {
    id: item.id
    description: req.body.description
    code: req.body.code
  }
  return if isInvalidItem res, checkItem

  item.description = req.body.description
  item.code = req.body.code

  res.status(200).send item

router.put '/:id', (req, res) ->
  item = findItem(req.params.id)

  return res.status(404).send { message: 'RootCauseCodes ID ' + req.params.id + ' not found' } if not item

  checkItem = {
    id: item.id
    description: req.body.description
    code: req.body.code
  }
  return if isInvalidItem res, checkItem

  item.description = req.body.description
  item.code = req.body.code

  res.status(200).send item

router.delete '/:id', (req, res) ->
  outItem = null
  outIndex = -1
  for item, index in itemsList
    if item.id is parseInt(req.params.id, 10)
      outItem = item
      outIndex = index

  return res.status(404).send { message: 'RootCauseCodes ID ' + req.params.id + ' not found' } if not outItem

  itemsList.splice outIndex, 1

  res.status(200).send {
    code: 200,
    message: item.code + ' Delete success'
  }

###### END Root Cause Event Codes ######

module.exports = router