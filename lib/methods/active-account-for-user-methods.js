(function() {
  var ActiveAccountForUser, Boom, Hoek, i18n, mongooseRestHelper, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  _ = require('underscore-ext');

  Boom = require('boom');

  Hoek = require('hoek');

  mongooseRestHelper = require('mongoose-rest-helper');

  i18n = require('../i18n');


  /*
  Provides methods to interact with ActiveAccountForUser
   */

  module.exports = ActiveAccountForUser = (function() {
    var UPDATE_EXCLUDEFIELDS;

    UPDATE_EXCLUDEFIELDS = ['_id', 'createdAt', 'updatedAt'];


    /*
    Initializes a new instance of the @see ActiveAccountForUser class.
    @param {Object} models A collection of models that can be used.
     */

    function ActiveAccountForUser(models) {
      this.models = models;
      this.createOrPut = __bind(this.createOrPut, this);
    }


    /*
    Creates or replaces the active account/app
    @Note: This could be an upsert
     */

    ActiveAccountForUser.prototype.createOrPut = function(userId, data, options, cb) {
      if (data == null) {
        data = {};
      }
      if (!userId) {
        return cb(Boom.badRequest(i18n.errorUserIdRequired));
      }
      userId = mongooseRestHelper.asObjectId(userId);
      return this.models.ActiveAccountForUserUser.findOne({
        _id: userId
      }, (function(_this) {
        return function(err, item) {
          if (err) {
            return cb(err);
          }
          if (!item) {
            item = new _this.models.ActiveAccountForUser({
              _id: userId
            });
          }
          item.accountId = mongooseRestHelper.asObjectId(data.accountId) || null;
          return item.save(function(err) {
            if (err) {
              return cb(err);
            }
            return cb(null, item);
          });
        };
      })(this));
    };

    return ActiveAccountForUser;

  })();

}).call(this);

//# sourceMappingURL=active-account-for-user-methods.js.map
