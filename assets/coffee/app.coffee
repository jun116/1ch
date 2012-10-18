
###
Module dependencies.
###
express = require("express")
http = require("http")
path = require("path")
socket = require('./routes/socket.js')

app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

server = http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

io = require('socket.io').listen server
io.sockets.on 'connection', socket

# io.sockets.on 'connection', (socket) =>
#   sess = new session();
#   sess.socketid = socket.id
#   sess.save (err) ->
#     throw err if err
#     console.log '登録済み'
    
#   message(socket)
  #console.log socket
