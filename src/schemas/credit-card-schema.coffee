_ = require 'underscore'
mongoose = require 'mongoose'
pluginTimestamp = require "mongoose-plugins-timestamp"
pluginCreatedBy = require "mongoose-plugins-created-by"

module.exports = CreditCardSchema = new mongoose.Schema
      accountId:
        type: mongoose.Schema.ObjectId
        required: true
        index: true

      cardProcessor:
        type: String
        required: true
        default: "stripe"
      ###
      The customer id, as returned from stripe when creating a customer.
      ###
      stripeCustomerId:
        type: String

      stripeCardId:
        type: String
      last4:
        type: String
      cardType:
        type: String
      expMonth:
        type: Number
      expYear:
        type: Number
      country:
        type: String
      name:
        type: String
      addressLine1:
        type: String
      addressLine2:
        type: String
      addressCity:
        type: String
      addressState:
        type: String
      addressZip:
        type: String
      addressCountry:
        type: String
    , 
      strict: true
      collection: 'accountmgmt.creditcards'

CreditCardSchema.plugin pluginTimestamp.timestamps
CreditCardSchema.plugin pluginCreatedBy.createdBy, {isRequired : true, v:2, keepV1 : false}

