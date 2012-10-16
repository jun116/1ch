module.exports = (socket) -> 

  message = require '../models/message'
 
  socket.on 'tweet:show', (data) ->
    message.find {}, {}, {sort: {'created': -1}}, (err, messages) ->
      socket.emit 'send:name', { tweets: messages }

  socket.on 'tweet', (data) ->
    console.log data
    msg = new message()
    msg.icon = "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    msg.name = data.name
    msg.text = data.text
    msg.location = [data.latitude, data.longitude]

    msg.save (err) ->
      throw err if err
      message.find {}, (err, messages) ->
        throw err if err
        socket.broadcast.emit 'tweet:end', { tweets: messages }
        socket.emit 'tweet:why', { tweets: messages }
