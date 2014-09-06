async = require 'async'
mongoose = require 'mongoose'

collections = [
  'accountmgmt.accounts'
  'accountmgmt.activeaccountforusers'
  'accountmgmt.creditcards'
]

module.exports = (loggingEnabled,cb) ->
  if loggingEnabled
    console.log "" 
    console.log "CLEANING database"

  removeCollection = (name,cb) ->
    mongoose.connection.db.dropCollection name, (err) ->
      return cb err  if (err && err.message != 'ns not found') 
      cb null

  async.eachSeries collections ,removeCollection, (err) ->
    if err
      console.log "CLEANING database ERROR: #{err.message}"
    else
      console.log "CLEANING database COMPLETE" if loggingEnabled
    cb err
