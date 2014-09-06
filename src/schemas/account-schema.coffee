_ = require 'underscore'
mongoose = require 'mongoose'
pluginTimestamp = require "mongoose-plugins-timestamp"
ObjectId = mongoose.Schema.ObjectId

module.exports = AccountSchema = new mongoose.Schema
      owningUserId:
        type: mongoose.Schema.ObjectId
        required: true

      name:
        type: String
        required: false
      sitename:
        type: String
        required: false
      contactPhone:
        type: String
        required: false
      contactEmail:
        type: String
        required: false
      accountStatus:
        type: String
        default: 'active'
        required: true

      ###
      The customer id, as returned from stripe when creating a customer.
      ###
      stripeCustomerId:
        type: String
        required: false

      ###
      Contains an array of features that define what the account can do.
      List of available features:
      multi-app .. This allows a user to have more than one app.
      ###
      features: 
        type: [String]

      defaultCreditCardId:
        type: mongoose.Schema.ObjectId 

    , 
      strict: true
      collection: 'accountmgmt.accounts'

AccountSchema.plugin pluginTimestamp.timestamps

