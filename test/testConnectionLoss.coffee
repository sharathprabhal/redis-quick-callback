redis = require '../lib/'
async = require 'async'
should = require 'should'

describe 'connection loss', () ->

  it 'should return err callback immediately', (done) ->
    client = redis.createClient()
    value = 'bar' + Math.random()

    client.on 'error', () ->
    
    client.on 'ready', () ->
      client.connected = false

      setValue = (cb) ->
        client.set 'foo', value, (err) ->
          err.should.be.ok
          cb null

      wait = (cb) ->
        setTimeout () ->
          client.connected = true
          cb null
        , 200

      getValue = (cb) ->
        # check that the value actually got set
        client.get 'foo', (err, data) ->
          throw err if err
          # value should actually be set
          data.should.equal value
          cb null

      async.series [setValue, wait, getValue], (err) ->
        throw err if err
        done()

