module.exports = (socket) -> 

  message = require '../models/message'
  
  message.find {}, (err, messages) -> 
    socket.emit 'send:name', { tweets: messages }