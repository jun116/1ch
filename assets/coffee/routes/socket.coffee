module.exports = (socket) -> 

  message = require '../models/message'
 
  socket.on 'tweet:show', (data) ->
    message.find {}, (err, messages) ->
      socket.emit 'send:name', { tweets: messages }

  socket.on 'tweet', (data) ->
    msg = new message()
    msg.icon = "https://twimg0-a.akamaihd.net/profile_images/2588527924/lsbr4m4drnpsgp2rwgrb.jpeg"
    msg.name = "warppy_"
    msg.text = data.test
    msg.location = [35.681736, 139.765939]

    msg.save (err) ->
      throw err if err
      socket.emit 'tweet:end', {}
