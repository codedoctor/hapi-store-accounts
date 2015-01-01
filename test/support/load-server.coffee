_ = require 'underscore'
Hapi = require "hapi"
mongoose = require 'mongoose'

databaseCleaner = require './database-cleaner'
index = require '../../lib/index'

loggingEnabled = false
testUrl = 'mongodb://localhost/codedoctor-test'

module.exports = loadServer = (cb) ->
    server = new Hapi.Server()
    server.connection
              port: 5675
              host: "localhost"

    pluginConf = [
        register: index
    ]

    server.register pluginConf, (err) ->
      return cb err if err

      mongoose.disconnect()
      mongoose.connect testUrl, (err) ->
        return cb err if err
        databaseCleaner loggingEnabled, (err) ->
          return cb err if err
          plugin = server.plugins['hapi-store-accounts']
          plugin.rebuildIndexes (err) ->
            cb err,server,plugin

