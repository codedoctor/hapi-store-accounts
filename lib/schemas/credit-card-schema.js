(function() {
  var CreditCardSchema, mongoose, pluginCreatedBy, pluginTimestamp, _;

  _ = require('underscore');

  mongoose = require('mongoose');

  pluginTimestamp = require("mongoose-plugins-timestamp");

  pluginCreatedBy = require("mongoose-plugins-created-by");

  module.exports = CreditCardSchema = new mongoose.Schema({
    accountId: {
      type: mongoose.Schema.ObjectId,
      required: true,
      index: true
    },
    cardProcessor: {
      type: String,
      required: true,
      "default": "stripe"
    },

    /*
    The customer id, as returned from stripe when creating a customer.
     */
    stripeCustomerId: {
      type: String,
      required: false
    },
    stripeCardId: {
      type: String
    },
    last4: {
      type: String
    },
    cardType: {
      type: String
    },
    expMonth: {
      type: Number
    },
    expYear: {
      type: Number
    },
    country: {
      type: String,
      required: false
    },
    name: {
      type: String,
      required: false
    },
    addressLine1: {
      type: String,
      required: false
    },
    addressLine2: {
      type: String,
      required: false
    },
    addressCity: {
      type: String,
      required: false
    },
    addressState: {
      type: String,
      required: false
    },
    addressZip: {
      type: String,
      required: false
    },
    addressCountry: {
      type: String,
      required: false
    }
  }, {
    strict: true,
    collection: 'accountmgmt.creditcards'
  });

  CreditCardSchema.plugin(pluginTimestamp.timestamps);

  CreditCardSchema.plugin(pluginCreatedBy.createdBy, {
    isRequired: true,
    v: 2,
    keepV1: false
  });

}).call(this);

//# sourceMappingURL=credit-card-schema.js.map
