(function() {
  var AccountMethods, AccountSchema, ActiveAccountForUserMethods, ActiveAccountForUserSchema, CreditCardMethods, CreditCardSchema, Store, mongoose, _;

  _ = require('underscore');

  mongoose = require('mongoose');

  CreditCardSchema = require('./schemas/credit-card-schema');

  AccountSchema = require('./schemas/account-schema');

  ActiveAccountForUserSchema = require('./schemas/active-account-for-user-schema');

  CreditCardMethods = require('./methods/credit-card-methods');

  AccountMethods = require('./methods/account-methods');

  ActiveAccountForUserMethods = require('./methods/active-account-for-user-methods');

  module.exports = Store = (function() {

    /*
    Initializes a new instance of the {Store}
    @param [Object] settings configuration options for this store
    @option settings [Function] initializeSchema optional function that is called with the schema before it is converted to a model.
    @option settings [Boolean] autoIndex defaults to true and updates the db indexes on load. Should be off for production.
     */
    function Store(settings) {
      var m, schema, _i, _j, _len, _len1, _ref, _ref1;
      this.settings = settings != null ? settings : {};
      _.defaults(this.settings, {
        autoIndex: true,
        initializeSchema: function(schema) {}
      });
      this.schemas = [CreditCardSchema, AccountSchema, ActiveAccountForUserSchema];
      _ref = this.schemas;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        schema = _ref[_i];
        this.settings.initializeSchema(schema);
      }
      _ref1 = this.schemas;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        schema = _ref1[_j];
        schema.set('autoIndex', this.settings.autoIndex);
      }
      m = mongoose;
      if (this.settings.connection) {
        m = this.settings.connection;
      }
      this.models = {
        CreditCard: m.model("CreditCard", CreditCardSchema),
        Account: m.model("Account", AccountSchema),
        ActiveAccountForUser: m.model("ActiveAccountForUser", ActiveAccountForUserSchema)
      };
      this.creditCards = new CreditCardMethods(this.models);
      this.accounts = new AccountMethods(this.models);
      this.activeAccountForUser = new ActiveAccountForUserMethods(this.models);
      this.methodNames = ['creditCards', 'accounts', 'activeAccountForUser'];
    }

    return Store;

  })();

}).call(this);

//# sourceMappingURL=store.js.map
