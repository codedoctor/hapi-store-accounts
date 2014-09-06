assert = require 'assert'
should = require 'should'
_ = require 'underscore'

fixtures = require './support/fixtures'
loadServer = require './support/load-server'

describe 'WHEN index has been loaded', ->
  server = null
  plugin = null

  describe 'ON a clean database', ->
    beforeEach (cb) ->
      loadServer (err,serverResult,pluginResult) ->
        return cb err if err
        server = serverResult
        plugin = pluginResult

        cb null

    it 'it should return null for an non existing item', (cb) ->
      plugin.activeAccountForUsers.get fixtures.userId, null, (err,activeAccountForUser) ->
        should.not.exist err
        should.not.exist activeAccountForUser
        cb null

    it 'it should create an activeAccountForUser', (cb) ->
      payload = 
        accountId: fixtures.accountId
      plugin.activeAccountForUsers.createOrPut fixtures.userId,payload, null, (err,activeAccountForUser) ->
        should.not.exist err
        should.exist activeAccountForUser

        activeAccountForUser = JSON.parse(JSON.stringify(activeAccountForUser))

        activeAccountForUser.should.have.property 'createdAt'
        activeAccountForUser.should.have.property 'updatedAt'
        activeAccountForUser.should.have.property 'accountId', fixtures.accountId
        activeAccountForUser.should.have.property '_id', fixtures.userId

        cb err


    it 'it should retrieve an activeAccountForUser', (cb) ->
      payload = 
        accountId: fixtures.accountId
      plugin.activeAccountForUsers.createOrPut fixtures.userId,payload, null, (err,activeAccountForUser) ->
        should.not.exist err
        should.exist activeAccountForUser

        plugin.activeAccountForUsers.get fixtures.userId, null, (err,activeAccountForUser) ->
          should.not.exist err
          should.exist activeAccountForUser

          activeAccountForUser = JSON.parse(JSON.stringify(activeAccountForUser))

          activeAccountForUser.should.have.property 'createdAt'
          activeAccountForUser.should.have.property 'updatedAt'
          activeAccountForUser.should.have.property 'accountId', fixtures.accountId
          activeAccountForUser.should.have.property '_id', fixtures.userId

          cb err


