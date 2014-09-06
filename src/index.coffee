_ = require 'underscore'
async = require 'async'
Hoek = require "hoek"
Store = require './store'

internals = {}

module.exports.register = (plugin, options = {}, cb) ->
  defaults =
    autoIndex: false

  options = Hoek.applyToDefaults defaults, options

  dataStore = new Store {autoIndex : options.autoIndex}

  methods = {}
  methods[n] = dataStore[n] for n in dataStore.methodNames
    
  models = {}
  models[n] = v for n,v of dataStore.models

  plugin.expose 'dataStore', dataStore
  plugin.expose 'methods', methods
  plugin.expose 'models', models

  plugin.expose methodName, dataStore[methodName] for methodName in dataStore.methodNames

  fnRemoveIndexForModel = (model,cb) ->
    model.collection.dropAllIndexes (err) ->
      return cb err  if (err && err.message != 'ns not found')
      cb null

  fnEnsureIndexesForModel = (model,cb) ->
    model.ensureIndexes (err) ->
      return cb err if (err && err.message != 'ns not found')
      cb null

  fnRebuildIndexes = (cb) ->
    modelsAsArray = _.values(dataStore.models)

    async.eachSeries modelsAsArray ,fnRemoveIndexForModel, (err) ->
      return cb err if err
      async.eachSeries modelsAsArray ,fnEnsureIndexesForModel, (err) ->
        return cb err if err

        cb null

  plugin.expose 'rebuildIndexes', fnRebuildIndexes

  cb()


module.exports.register.attributes =
    pkg: require '../package.json'
