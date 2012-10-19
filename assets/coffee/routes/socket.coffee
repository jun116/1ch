'use strict'

module.exports = (socket) -> 

  message = require '../models/message'
  session = require '../models/session'
  
  socket.on 'session:start', (data) ->
    sess = new session();
    sess.socketid = socket.id
    sess.location = [data.latitude, data.longitude]
    sess.save (err) ->
      throw err if err
      console.log "登録済み : " + socket.id

  socket.on 'tweet:show', (data) ->
    message.find {}, {}, {sort: {'created': -1}}, (err, messages) ->
      socket.emit 'tweet:result', { tweets: messages }

  socket.on 'tweet', (data) ->
    msg = new message()
    msg.icon = "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    msg.name = data.name
    msg.text = data.text
    msg.location = [data.latitude, data.longitude]

    msg.save (err) ->
      throw err if err
        
      session.find {}, (err, sessions) ->
        throw err if err
        for sess in sessions
          console.log '------ push socketid ------' + sess.socketid
          socket.manager.sockets.socket(sess.socketid).emit 'tweet:end', { tweets: msg }

  socket.on 'disconnect', (data) ->
    socketid = socket.id
    console.log 'discconect ' + socketid 
    session.remove {socketid: socketid}, (err) ->
      console.log 'discconected ' + socketid 

