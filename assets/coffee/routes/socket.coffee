'use strict'

module.exports = (socket) -> 

  message = require '../models/message'
  session = require '../models/session'
  
  socket.on 'session:start', (data) ->
    sess = new session();
    sess.socketid = socket.id
    sess.location = [data.longitude, data.latitude]
    sess.save (err) ->
      throw err if err
      console.log "登録済み : " + socket.id

  socket.on 'tweet:show', (data) ->
    message.find { location : { $within : { $centerSphere : [[data.longitude, data.latitude], 0.0001] } } }, {}, {sort: {'created': -1}}, (err, messages) ->
      socket.emit 'tweet:result', { tweets: messages }

  socket.on 'tweet', (data) ->
    msg = new message()
    msg.icon = "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    msg.name = data.name
    msg.text = data.text
    msg.location = [data.longitude, data.latitude]

    msg.save (err) ->
      throw err if err
      
      # 取得範囲は半径1km(0.0001ラジアン)とする。※1ラジアンは6371km
      session.find { location : { $within : { $centerSphere : [[data.longitude, data.latitude], 0.0001] } } }, (err, sessions) ->
        throw err if err
        for sess in sessions
          console.log '------ push socketid ------' + sess.socketid
          socket.manager.sockets.socket(sess.socketid).emit 'tweet:end', { tweets: msg }

  socket.on 'disconnect', (data) ->
    socketid = socket.id
    console.log 'discconect ' + socketid 
    session.remove {socketid: socketid}, (err) ->
      console.log 'discconected ' + socketid 

