_ = require 'underscore-ext'
Boom = require 'boom'
Hoek = require 'hoek'
mongooseRestHelper = require 'mongoose-rest-helper'

i18n = require '../i18n'


###
Provides methods to interact with accounts.
###
module.exports = class AccountMethods
  UPDATE_EXCLUDEFIELDS = ['_id','createdByUserId','createdAt','updatedAt']

  ###
  Initializes a new instance of the @see AccountMethods class.
  @param {Object} models A collection of models that can be used.
  ###

  ###
  Initializes a new instance of the @see AccountMethods class.
  @param {Object} models A collection of models that can be used.
  ###
  constructor:(@models) ->

  all: (options = {},cb = ->) =>
    cb = options if _.isFunction options
    settings = 
        baseQuery: {}
        defaultSort: 'name'
        defaultSelect: null
        defaultCount: 50
    mongooseRestHelper.all @models.Account,settings,options, cb


  ###
  Retrieve a single account through it's id
  ###
  get: (accountId, options = {}, cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorAccountIdRequired) unless accountId
    mongooseRestHelper.getById @models.Account,accountId,null,options, cb

  getForOwner: (userId,options = {}, cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorUserIdRequired) unless userId
    settings = 
      baseQuery: 
        owningUserId: mongooseRestHelper.asObjectId userId
      defaultSort: 'name'
    mongooseRestHelper.getOne @models.Account,settings,options, cb

  getAllForOwner: (userId,options = {},cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorUserIdRequired) unless userId

    settings = 
      baseQuery:
        owningUserId: mongooseRestHelper.asObjectId userId
      defaultSort: 'name'
      defaultSelect: null
      defaultCount: 50
    mongooseRestHelper.all @models.Account,settings,options, cb


  countAllForOwner: (userId,options = {},cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorUserIdRequired) unless userId

    options.where ||= {}
    options.where['owningUserId'] = mongooseRestHelper.asObjectId userId

    @models.Account.count options.where,(err, totalCount) ->
      return cb err if err
      cb null,totalCount
      

  destroy: (accountId, options = {}, cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorAccountIdRequired) unless accountId
    settings = {}
    mongooseRestHelper.destroy @models.Account,accountId, settings,{}, cb

  ###
  Create a new account
  ###
  create:(objs = {}, options = {}, cb = ->) =>
    cb = options if _.isFunction options
    settings = {}
    mongooseRestHelper.create @models.Account,settings,objs,options,cb

  ###
  Updates a deployment
  ###
  patch: (accountId, obj = {}, options = {}, cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorAccountIdRequired) unless accountId
    settings =
      exclude : UPDATE_EXCLUDEFIELDS
    mongooseRestHelper.patch @models.Account,accountId, settings, obj, options, cb

  ###
  Creates a new item, or just perform a put if it exists
  ###
  createOrPut :(objs = {}, options = {}, cb = ->) =>
    cb = options if _.isFunction options
    return cb Boom.badRequest( i18n.errorObjs_idRequired) unless objs._id

    @get objs._id, {}, (err, item) =>
      return cb err if err
      if item
        @put objs._id,objs, {},cb
      else
        @create objs, {} ,cb


