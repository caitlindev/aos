express = require 'express'
bodyParser = require 'body-parser'

router = express.Router()

router.use bodyParser.json()

###### Source Document Issuer ######

itemsList = [
  {
    id: 1,
    code: 'HPR'
    description: 'High Priority'
    rootCauseCodeIds: [1,3,5]
  }
  {
    id: 2,
    code: 'AOS'
    description: 'Aircraft Out of Service'
    rootCauseCodeIds: [5,9,6]
  }
  {
    id: 3,
    code: 'SOS'
    description: 'Scheduled Out of Service'
    rootCauseCodeIds: [11,2,3]
  }
  {
    id: 5,
    code: 'SPR'
    description: 'Spare Status'
    rootCauseCodeIds: [4,7,9]
  }
];




lastItem = 30

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


#  Don't need to chack if rootCauseCodesIds exists
#  if not item.rootCauseCodeIds
#    return res.status(400).send { message: 'Root Cause is required' }
#
#  if itemExitsByColumn('rootCauseCodeIds', item)
#    return res.status(400).send { message: 'Root Cause already exists' }

  return false

router.get '/', (req, res) ->
  console.log 'Get List: '
  console.log itemsList
  res.status(200).send {
    items: itemsList
    total: itemsList.length
  }

router.post '/', (req, res) ->
  item = {
    id: lastItem++
    description: req.body.description
    code: req.body.code
    rootCauseCodeIds:req.body.rootCauseCodeIds
  }

  return if isInvalidItem res, item

  itemsList.push item


  res.status(200).send item

router.get '/:id', (req, res) ->
  item = findItem(req.params.id)

  return res.status(404).send { message: 'Event Code ID ' + req.params.id + ' not found' } if not item

  res.status(200).send item

router.put '/', (req, res) ->
  item = findItem(req.body.id)
#  putting item here

  console.log "ITEM: "
  console.log item
  console.log " "

  return res.status(404).send { message: 'Event Code ID ' + req.body.id + ' not found' } if not item

  checkItem = {
    id: item.id
    description: req.body.description
    code: req.body.code
    rootCauseCodeIds: req.body.rootCauseCodeIds
  }
#  return if isInvalidItem res, checkItem

  console.log 'Check Item:'
  console.log checkItem
  console.log ' '

  updatedItem = req.body
  console.log req.body


  console.log 'Item before sending:'
  console.log item

  item.description = updatedItem.description
  item.code = updatedItem.code
  item.rootCauseCodeIds = updatedItem.rootCauseCodeIds

  console.log 'Updated Code:'
  console.log updatedItem.code



  console.log 'Sending Item:'
  console.log item
  res.status(200).send item

router.put '/:id', (req, res) ->
  item = findItem(req.params.id)

  return res.status(404).send { message: 'Event Code ID ' + req.params.id + ' not found' } if not item

  checkItem = {
    id: item.id
    description: req.body.description
    code: req.body.code
    rootCauseCodeIds: req.body.rootCauseCodeIds
  }
  return if isInvalidItem res, checkItem

  item.description = req.body.description
  item.code = req.body.code
  item.rootCauseCodeIds = req.body.rootCauseCodeIds

  res.status(200).send item

router.delete '/:id', (req, res) ->
  outItem = null
  outIndex = -1
  for item, index in itemsList
    if item.id is parseInt(req.params.id, 10)
      outItem = item
      outIndex = index

  return res.status(404).send { message: 'Event Code ID ' + req.params.id + ' not found' } if not outItem

  itemsList.splice outIndex, 1

  res.status(200).send {
    code: 200,
    message: item.code + ' Delete success'
  }







module.exports = router