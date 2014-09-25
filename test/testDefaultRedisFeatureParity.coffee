redis = require '../lib/'
should = require 'should'

describe 'default redis feature parity', () ->
  describe 'the export', () ->
    it 'should contain createClient function', () ->
      redis.createClient.should.be.ok

  describe 'create client', () ->
    
    it 'should create default client', () ->
      client = redis.createClient()
      client.on 'error', () ->
      client.should.be.ok

    it 'should accept port and host', () ->
      client = redis.createClient '6379', 'localhost'
      client.on 'error', () ->
      client.should.be.ok

    it 'should support basic redis commands', () ->
      client = redis.createClient()
      client.on 'error', () ->
      client.get.should.be.ok
      client.set.should.be.ok

    it 'should set and then get', (done) ->
      client = redis.createClient()
      value = 'bar' + Math.random()

      client.on 'error', () ->

      client.on 'ready', () ->
        client.set 'foo', value, (err) ->
          if err
            throw err
          client.get 'foo', (err, data) ->
            data.should.equal value
            done()