mbtiles = require 'mbtiles'
express = require 'express'
app = express()
MBTiles = require 'mbtiles'
path = require 'path'

filepath = path.join __dirname, 'airports.mbtiles'

server = new MBTiles filepath, (err, mbtiles) ->
  if err
    throw err

  app.get "/:map/:z/:x/:y.*", (req, res) ->
    extension = req.param(0)
    switch extension
      when "png"
        mbtiles.getTile req.param("z"), req.param("x"), req.param("y"), (err, tile, headers) ->
          if err
            res.status(404).send "Tile rendering error: " + err + "\n"
          else
            res.header "Content-Type", "image/png"
            res.send tile
          return

        break
      when "grid.json"
        mbtiles.getGrid req.param("z"), req.param("x"), req.param("y"), (err, grid, headers) ->
          if err
            res.status(404).send "Grid rendering error: " + err + "\n"
          else
            res.header "Content-Type", "text/json"
            res.send grid
          return

        break
    return

  app.get "/:map.*", (req, res) ->
    extension = req.param(0)
    switch extension
      when "json"
        mbtiles.getInfo (err, data, headers) ->
          if err
            res.status(404).send "Metadata Retrieval error: " + err + "\n"
          else
            res.header "Content-Type", "text/json"
            res.send data
          return

        break
    return

module.exports = app