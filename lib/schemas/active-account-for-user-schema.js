(function() {
  var ActiveAccountForUserSchema, mongoose, pluginTimestamp, _;

  _ = require('underscore');

  mongoose = require('mongoose');

  pluginTimestamp = require("mongoose-plugins-timestamp");


  /*
  NOTE: _id -> user._id
   */

  module.exports = ActiveAccountForUserSchema = new mongoose.Schema({

    /*
    The active account id, if any.
     */
    accountId: {
      type: mongoose.Schema.ObjectId,
      unique: false,
      required: false
    }
  }, {
    strict: true,
    collection: 'accountmgmt.activeaccountforusers'
  });

  ActiveAccountForUserSchema.plugin(pluginTimestamp.timestamps);

}).call(this);

//# sourceMappingURL=active-account-for-user-schema.js.map
