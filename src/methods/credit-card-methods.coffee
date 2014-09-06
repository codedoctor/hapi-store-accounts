_ = require 'underscore-ext'
Boom = require 'boom'
Hoek = require 'hoek'
mongooseRestHelper = require 'mongoose-rest-helper'

i18n = require '../i18n'

###
Provides methods to interact with creditCards.
###
module.exports = class CreditCardMethods
  UPDATE_EXCLUDEFIELDS = ['_id','createdByUserId','createdAt','updatedAt']

  ###
  Initializes a new instance of the @see CreditCardMethods class.
  @param {Object} models A collection of models that can be used.
  ###
  constructor:(@models) ->

  all: (options = {},cb = ->) =>
    settings = 
        baseQuery: {}
        defaultSort: 'name'
        defaultSelect: null
        defaultCount: 50
    mongooseRestHelper.all @models.CreditCard,settings,options, cb


  allForAccountId: (accountId,options = {},cb = ->) =>
    return cb Boom.badRequest( i18n.errorAccountIdRequired) unless accountId

    settings = 
        baseQuery:
          accountId : mongooseRestHelper.asObjectId accountId
        defaultSort: 'name'
        defaultSelect: null
        defaultCount: 50
    mongooseRestHelper.all @models.CreditCard,settings,options, cb


  ###
  Retrieve a single creditCard through it's id
  ###
  get: (creditCardId, options = {}, cb = ->) =>
    return cb Boom.badRequest( i18n.errorCreditCardIdRequired) unless creditCardId
    mongooseRestHelper.getById @models.CreditCard,creditCardId,null,options, cb


  destroy: (creditCardId, options = {}, cb = ->) =>
    return cb Boom.badRequest( i18n.errorCreditCardIdRequired) unless creditCardId
    settings = {}
    mongooseRestHelper.destroy @models.CreditCard,creditCardId, settings,{}, cb

  ###
  Create a new creditCard
  ###
  create:(accountId,objs = {}, options = {}, cb = ->) =>
    return cb Boom.badRequest( i18n.errorAccountIdRequired) unless accountId

    settings = {}
    objs.accountId = mongooseRestHelper.asObjectId accountId
    mongooseRestHelper.create @models.CreditCard,settings,objs,options,cb

  ###
  Updates a credit card
  ###
  patch: (creditCardId, obj = {}, options = {}, cb = ->) =>
    return cb Boom.badRequest( i18n.errorCreditCardIdRequired) unless creditCardId
    settings =
      exclude : UPDATE_EXCLUDEFIELDS
    mongooseRestHelper.patch @models.CreditCard,creditCardId, settings, obj, options, cb



