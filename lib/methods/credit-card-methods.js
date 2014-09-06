(function() {
  var Boom, CreditCardMethods, Hoek, i18n, mongooseRestHelper, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  _ = require('underscore-ext');

  Boom = require('boom');

  Hoek = require('hoek');

  mongooseRestHelper = require('mongoose-rest-helper');

  i18n = require('../i18n');


  /*
  Provides methods to interact with creditCards.
   */

  module.exports = CreditCardMethods = (function() {
    var UPDATE_EXCLUDEFIELDS;

    UPDATE_EXCLUDEFIELDS = ['_id', 'createdByUserId', 'createdAt', 'updatedAt'];


    /*
    Initializes a new instance of the @see CreditCardMethods class.
    @param {Object} models A collection of models that can be used.
     */

    function CreditCardMethods(models) {
      this.models = models;
      this.patch = __bind(this.patch, this);
      this.create = __bind(this.create, this);
      this.destroy = __bind(this.destroy, this);
      this.get = __bind(this.get, this);
      this.allForAccountId = __bind(this.allForAccountId, this);
      this.all = __bind(this.all, this);
    }

    CreditCardMethods.prototype.all = function(options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      settings = {
        baseQuery: {},
        defaultSort: 'name',
        defaultSelect: null,
        defaultCount: 50
      };
      return mongooseRestHelper.all(this.models.CreditCard, settings, options, cb);
    };

    CreditCardMethods.prototype.allForAccountId = function(accountId, options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      if (!accountId) {
        return cb(Boom.badRequest(i18n.errorAccountIdRequired));
      }
      settings = {
        baseQuery: {
          accountId: mongooseRestHelper.asObjectId(accountId)
        },
        defaultSort: 'name',
        defaultSelect: null,
        defaultCount: 50
      };
      return mongooseRestHelper.all(this.models.CreditCard, settings, options, cb);
    };


    /*
    Retrieve a single creditCard through it's id
     */

    CreditCardMethods.prototype.get = function(creditCardId, options, cb) {
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      if (!creditCardId) {
        return cb(Boom.badRequest(i18n.errorCreditCardIdRequired));
      }
      return mongooseRestHelper.getById(this.models.CreditCard, creditCardId, null, options, cb);
    };

    CreditCardMethods.prototype.destroy = function(creditCardId, options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      if (!creditCardId) {
        return cb(Boom.badRequest(i18n.errorCreditCardIdRequired));
      }
      settings = {};
      return mongooseRestHelper.destroy(this.models.CreditCard, creditCardId, settings, {}, cb);
    };


    /*
    Create a new creditCard
     */

    CreditCardMethods.prototype.create = function(accountId, objs, options, cb) {
      var settings;
      if (objs == null) {
        objs = {};
      }
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      if (!accountId) {
        return cb(Boom.badRequest(i18n.errorAccountIdRequired));
      }
      settings = {};
      objs.accountId = mongooseRestHelper.asObjectId(accountId);
      return mongooseRestHelper.create(this.models.CreditCard, settings, objs, options, cb);
    };


    /*
    Updates a credit card
     */

    CreditCardMethods.prototype.patch = function(creditCardId, obj, options, cb) {
      var settings;
      if (obj == null) {
        obj = {};
      }
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (_.isFunction(options)) {
        cb = options;
      }
      if (!creditCardId) {
        return cb(Boom.badRequest(i18n.errorCreditCardIdRequired));
      }
      settings = {
        exclude: UPDATE_EXCLUDEFIELDS
      };
      return mongooseRestHelper.patch(this.models.CreditCard, creditCardId, settings, obj, options, cb);
    };

    return CreditCardMethods;

  })();

}).call(this);

//# sourceMappingURL=credit-card-methods.js.map
