(function() {
  var Hoek, Store, async, internals, _;

  _ = require('underscore');

  async = require('async');

  Hoek = require("hoek");

  Store = require('./store');

  internals = {};

  module.exports.register = function(server, options, cb) {
    var dataStore, defaults, fnEnsureIndexesForModel, fnRebuildIndexes, fnRemoveIndexForModel, methodName, methods, models, n, v, _i, _j, _len, _len1, _ref, _ref1, _ref2;
    if (options == null) {
      options = {};
    }
    defaults = {
      autoIndex: false
    };
    options = Hoek.applyToDefaults(defaults, options);
    dataStore = new Store({
      autoIndex: options.autoIndex
    });
    methods = {};
    _ref = dataStore.methodNames;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      n = _ref[_i];
      methods[n] = dataStore[n];
    }
    models = {};
    _ref1 = dataStore.models;
    for (n in _ref1) {
      v = _ref1[n];
      models[n] = v;
    }
    server.expose('dataStore', dataStore);
    server.expose('methods', methods);
    server.expose('models', models);
    _ref2 = dataStore.methodNames;
    for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
      methodName = _ref2[_j];
      server.expose(methodName, dataStore[methodName]);
    }
    fnRemoveIndexForModel = function(model, cb) {
      return model.collection.dropAllIndexes(function(err) {
        if (err && err.message !== 'ns not found') {
          return cb(err);
        }
        return cb(null);
      });
    };
    fnEnsureIndexesForModel = function(model, cb) {
      return model.ensureIndexes(function(err) {
        if (err && err.message !== 'ns not found') {
          return cb(err);
        }
        return cb(null);
      });
    };
    fnRebuildIndexes = function(cb) {
      var modelsAsArray;
      modelsAsArray = _.values(dataStore.models);
      return async.eachSeries(modelsAsArray, fnRemoveIndexForModel, function(err) {
        if (err) {
          return cb(err);
        }
        return async.eachSeries(modelsAsArray, fnEnsureIndexesForModel, function(err) {
          if (err) {
            return cb(err);
          }
          return cb(null);
        });
      });
    };
    server.expose('rebuildIndexes', fnRebuildIndexes);
    return cb();
  };

  module.exports.register.attributes = {
    pkg: require('../package.json')
  };

}).call(this);

//# sourceMappingURL=index.js.map
