mongo = require 'mongoose'
mongo.connect 'mongodb://localhost/1ch'
 
Schema = mongo.Schema
 
Message = mongo.model 'messages', new Schema
  id: String
  icon: String
  name: String
  text: String
  location: [Number, Number]
  created: {type: Date, default: Date.now}
  updated: {type: Date, default: Date.now}

module.exports = Message