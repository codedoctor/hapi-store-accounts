_ = require 'underscore'
mongoose = require 'mongoose'

CreditCardSchema = require './schemas/credit-card-schema'
AccountSchema = require './schemas/account-schema'
ActiveAccountForUserSchema = require './schemas/active-account-for-user-schema'

CreditCardMethods = require './methods/credit-card-methods'
AccountMethods = require './methods/account-methods'
ActiveAccountForUserMethods = require './methods/active-account-for-user-methods'

module.exports = class Store

  ###
  Initializes a new instance of the {Store}
  @param [Object] settings configuration options for this store
  @option settings [Function] initializeSchema optional function that is called with the schema before it is converted to a model.
  @option settings [Boolean] autoIndex defaults to true and updates the db indexes on load. Should be off for production.
  ###
  constructor: (@settings = {}) ->
    _.defaults @settings, 
                  autoIndex : true
                  initializeSchema: (schema) -> 

    @schemas = [
      CreditCardSchema
      AccountSchema
      ActiveAccountForUserSchema
    ]

    @settings.initializeSchema schema for schema in @schemas
    schema.set 'autoIndex', @settings.autoIndex for schema in @schemas

    m = mongoose
    m = @settings.connection if @settings.connection

    @models =
      CreditCard: m.model "CreditCard", CreditCardSchema
      Account: m.model "Account",AccountSchema
      ActiveAccountForUser: m.model "ActiveAccountForUser", ActiveAccountForUserSchema
    

    @creditCards = new CreditCardMethods @models
    @accounts = new AccountMethods @models
    @activeAccountForUser = new ActiveAccountForUserMethods @models

    @methodNames = [
        'creditCards'
        'accounts'
        'activeAccountForUser'
      ]


