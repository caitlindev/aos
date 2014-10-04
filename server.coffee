express = require 'express'
httpProxy = require 'http-proxy'
argv = require("yargs").argv

exports.gulpServer = () ->
  if argv.server == 'false'
    console.log "no server"
  else
    app = express()
    httpProxy = require 'http-proxy'
    proxy = new httpProxy.RoutingProxy()
    apiProxy = (host, port) ->
      if argv.port > 0
        argv.port = argv.port
      else argv.port = 3333
      (req, res, next) ->
        req.setMaxListeners(0)
        if req.url.match(new RegExp('^/api\/'))
          req.url = '/'+req.url.split('/').slice(2).join('/')
          proxy.proxyRequest(req, res, {host: host, port: port})
        else
          next()

    app.use apiProxy('localhost', 1337)
    app.use(require("connect-livereload")({
      port: 35729
    }))
    app.use express.static __dirname + '/_public'

    app.listen argv.port or 3333
    console.log "Listening on port: " + argv.port or 3333
