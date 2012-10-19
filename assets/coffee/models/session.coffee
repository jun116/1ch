mongo = require 'mongoose'
mongo.connect 'mongodb://localhost/1ch'
 
Schema = mongo.Schema
 
Session = mongo.model 'sessions', new Schema
  socketid: String,
  location: [Number, Number],
  created: {type: Date, default: Date.now},
  updated: {type: Date, default: Date.now}

module.exports = Session