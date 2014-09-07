assert = require 'assert'
should = require 'should'
_ = require 'underscore'

fixtures = require './support/fixtures'
loadServer = require './support/load-server'
setupData = require './support/setup-data'

describe 'WHEN index has been loaded', ->
  server = null
  plugin = null

  describe 'ON a clean database', ->
    beforeEach (cb) ->
      loadServer (err,serverResult,pluginResult) ->
        return cb err if err
        server = serverResult
        plugin = pluginResult

        setupData plugin, (err) ->
          cb err

    it 'it should delete an account', (cb) ->
      plugin.accounts.destroy fixtures.account1._id, null, (err) ->
        should.not.exist err
        cb err


    it 'it should update an account', (cb) ->
      plugin.accounts.patch fixtures.account1._id, {name: 'xxx'}, null, (err,account) ->
        should.not.exist err
        should.exist account
        account.should.have.property 'name','xxx'
        cb err

    it 'it should get an account', (cb) ->
      plugin.accounts.get fixtures.account1._id, null, (err,account) ->
        should.not.exist err
        should.exist account
        account.should.have.property 'name',fixtures.account1.name
        cb err

    it 'it should get all accounts', (cb) ->
      plugin.accounts.all null, (err,accountsResult) ->
        should.not.exist err
        should.exist accountsResult
        accountsResult.should.have.property 'items'
        accountsResult.items.length.should.equal 3

        cb err

    it 'it should get all accounts for owner', (cb) ->
      plugin.accounts.getAllForOwner fixtures.userId, null, (err,accountsResult) ->
        should.not.exist err
        should.exist accountsResult
        accountsResult.should.have.property 'items'
        accountsResult.items.length.should.equal 2

        cb err

    it 'it should get count accounts for owner', (cb) ->
      plugin.accounts.countAllForOwner fixtures.userId, null, (err,totalCount) ->
        should.not.exist err
        should.exist totalCount
        totalCount.should.equal 2

        cb err


    it 'it should get first one by name for owner', (cb) ->
      plugin.accounts.getForOwner fixtures.userId, null, (err,account) ->
        console.log JSON.stringify(account)
        should.not.exist err
        should.exist account
        account.should.have.property 'name',fixtures.account1.name
        cb err
