_ = require 'underscore-ext'
Boom = require 'boom'
Hoek = require 'hoek'
mongooseRestHelper = require 'mongoose-rest-helper'

i18n = require '../i18n'

###
Provides methods to interact with ActiveAccountForUser
###
module.exports = class ActiveAccountForUser
  UPDATE_EXCLUDEFIELDS = ['_id','createdAt','updatedAt']

  ###
  Initializes a new instance of the @see ActiveAccountForUser class.
  @param {Object} models A collection of models that can be used.
  ###
  constructor:(@models) ->


  ###
  Retrieves the active account for a user, if available. Can return null, which 
  means none has been set.
  ###
  get: (userId,options,cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorUserIdRequired) unless userId

    userId = mongooseRestHelper.asObjectId userId

    @models.ActiveAccountForUser.findOne _id : userId, (err,item) =>
      return cb err if err
      cb null, item

  ###
  Creates or replaces the active account/app
  @Note: This could be an upsert
  ###
  createOrPut: (userId,data = {},options,cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorUserIdRequired) unless userId

    userId = mongooseRestHelper.asObjectId userId

    @models.ActiveAccountForUser.findOne _id : userId, (err,item) =>
      return cb err if err
      item = new @models.ActiveAccountForUser _id : userId unless item

      item.accountId = mongooseRestHelper.asObjectId(data.accountId) || null
      item.save (err) =>
        return cb err if err
        cb null, item
