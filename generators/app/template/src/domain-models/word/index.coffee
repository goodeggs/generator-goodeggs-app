mongoose = require 'mongoose'

schema = new mongoose.Schema
  text: String
, strict: true

module.exports = mongoose.model 'Word', schema

