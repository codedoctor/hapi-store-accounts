fixtures = require './fixtures'
async = require 'async'

module.exports = (plugin,cb) ->

  accounts = [fixtures.account1,fixtures.account2,fixtures.account3]
  delete account._id for account in accounts

  addAccount = (accountData,cb) ->
    plugin.accounts.create accountData,null, (err,account) ->
      return cb err if err
      accountData._id = account._id
      cb null,account

  async.eachSeries accounts ,addAccount, (err) ->
    cb err
