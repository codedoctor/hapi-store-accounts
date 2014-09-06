(function() {
  var AccountMethods, Boom, Hoek, i18n, mongooseRestHelper, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  _ = require('underscore-ext');

  Boom = require('boom');

  Hoek = require('hoek');

  mongooseRestHelper = require('mongoose-rest-helper');

  i18n = require('../i18n');


  /*
  Provides methods to interact with accounts.
   */

  module.exports = AccountMethods = (function() {
    var UPDATE_EXCLUDEFIELDS;

    UPDATE_EXCLUDEFIELDS = ['_id', 'createdByUserId', 'createdAt', 'updatedAt'];


    /*
    Initializes a new instance of the @see AccountMethods class.
    @param {Object} models A collection of models that can be used.
     */


    /*
    Initializes a new instance of the @see AccountMethods class.
    @param {Object} models A collection of models that can be used.
     */

    function AccountMethods(models) {
      this.models = models;
      this.createOrPut = __bind(this.createOrPut, this);
      this.patch = __bind(this.patch, this);
      this.create = __bind(this.create, this);
      this.destroy = __bind(this.destroy, this);
      this.getAllForOwner = __bind(this.getAllForOwner, this);
      this.getForOwner = __bind(this.getForOwner, this);
      this.get = __bind(this.get, this);
      this.all = __bind(this.all, this);
    }

    AccountMethods.prototype.all = function(options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      settings = {
        baseQuery: {},
        defaultSort: 'name',
        defaultSelect: null,
        defaultCount: 50
      };
      return mongooseRestHelper.all(this.models.Account, settings, options, cb);
    };


    /*
    Retrieve a single account through it's id
     */

    AccountMethods.prototype.get = function(accountId, options, cb) {
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (!accountId) {
        return cb(Boom.badRequest(i18n.errorAccountIdRequired));
      }
      return mongooseRestHelper.getById(this.models.Account, accountId, null, options, cb);
    };

    AccountMethods.prototype.getForOwner = function(userId, options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (!userId) {
        return cb(Boom.badRequest(i18n.errorUserIdRequired));
      }
      settings = {
        baseQuery: {
          owningUserId: mongooseRestHelper.asObjectId(userId)
        }
      };
      return mongooseRestHelper.getOne(this.models.Account, settings, options, cb);
    };

    AccountMethods.prototype.getAllForOwner = function(userId, options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      settings = {
        baseQuery: {
          owningUserId: mongooseRestHelper.asObjectId(userId)
        },
        defaultSort: 'name',
        defaultSelect: null,
        defaultCount: 50
      };
      return mongooseRestHelper.all(this.models.Account, settings, options, cb);
    };

    AccountMethods.prototype.destroy = function(accountId, options, cb) {
      var settings;
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (!accountId) {
        return cb(Boom.badRequest(i18n.errorAccountIdRequired));
      }
      settings = {};
      return mongooseRestHelper.destroy(this.models.Account, accountId, settings, {}, cb);
    };


    /*
    Create a new account
     */

    AccountMethods.prototype.create = function(objs, options, cb) {
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
      settings = {};
      return mongooseRestHelper.create(this.models.Account, settings, objs, options, cb);
    };


    /*
    Updates a deployment
     */

    AccountMethods.prototype.patch = function(accountId, obj, options, cb) {
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
      if (!accountId) {
        return cb(Boom.badRequest(i18n.errorAccountIdRequired));
      }
      settings = {
        exclude: UPDATE_EXCLUDEFIELDS
      };
      return mongooseRestHelper.patch(this.models.Account, accountId, settings, obj, options, cb);
    };


    /*
    Creates a new item, or just perform a put if it exists
     */

    AccountMethods.prototype.createOrPut = function(objs, options, cb) {
      if (objs == null) {
        objs = {};
      }
      if (options == null) {
        options = {};
      }
      if (cb == null) {
        cb = function() {};
      }
      if (!objs._id) {
        return cb(Boom.badRequest(i18n.errorObjs_idRequired));
      }
      return this.get(objs._id, {}, (function(_this) {
        return function(err, item) {
          if (err) {
            return cb(err);
          }
          if (item) {
            return _this.put(objs._id, objs, {}, cb);
          } else {
            return _this.create(objs, {}, cb);
          }
        };
      })(this));
    };

    return AccountMethods;

  })();

}).call(this);

//# sourceMappingURL=account-methods.js.map
