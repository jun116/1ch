'use strict'

module.exports = (socket) -> 

  message = require '../models/message'
  session = require '../models/session'
  
  socket.on 'session:start', (data) ->
    conditions = 
      socketid : socket.id
    update = 
      $set : 
        location : [data.longitude, data.latitude]
    options = 
      upsert : true
      multi : true 

    session.update conditions, update, options, (err, numAffected) ->
      throw err if err
      console.log "登録済み : " + numAffected

  socket.on 'tweet:show', (data) ->
    conditions = getSphereConditions data
    message.find conditions, {}, {sort: {'created': -1}}, (err, messages) ->
      socket.emit 'tweet:result', { tweets: messages }

  socket.on 'tweet', (data) ->
    msg = new message()
    msg.icon = if data.icon then data.icon else 'https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg'
    msg.name = if data.name then data.name else '全国の名無しZ'  
    msg.text = data.text
    msg.location = [data.longitude, data.latitude]

    msg.save (err) ->
      throw err if err
      conditions = getSphereConditions data
      # 取得範囲は半径1km(0.00015ラジアン)とする。※1ラジアンは6371km
      session.find conditions, (err, sessions) ->
        throw err if err
        for sess in sessions
          console.log '------ push socketid ------' + sess.socketid
          socket.manager.sockets.socket(sess.socketid).emit 'tweet:end', tweets: msg

  socket.on 'disconnect', (data) ->
    socketid = socket.id
    console.log 'discconect ' + socketid 
    session.remove {socketid: socketid}, (err) ->
      console.log 'discconected ' + socketid 

  getSphereConditions = (data) ->
    conditions = 
      location : 
        $within : 
          $centerSphere : [[data.longitude, data.latitude], 0.00015]

  return true
