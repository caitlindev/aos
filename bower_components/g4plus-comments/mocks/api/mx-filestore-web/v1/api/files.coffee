express = require 'express'
router = express.Router()
busboy = require 'connect-busboy'
concat= require 'concat-stream'

router.use busboy()

router.post '/', (req, res, next) ->

  # console.log req.busboy
  req.busboy.on 'file', (fieldName, file, filename, encoding, mimetype) ->
    res.send [
      {
        fileStoreKey: 'f561aaf6ef0bf14d4208bb46a4ccb3ad'
        id: 2
        fileName: filename
        # fileSize: 2754
      }
    ]
  req.pipe req.busboy

router.get '/', (req, res, next) ->
  res.send '
    <form method="POST" enctype="multipart/form-data">
      <input type="file" name="bob" />
      <input type="submit" name="go" />
    </form>
  '

router.get '/:ref', (req, res) ->
  res.send('Path to download file!!!')

module.exports = router
