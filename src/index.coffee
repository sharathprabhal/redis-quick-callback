redis = require 'redis'
redisCommands = require '../node_modules/redis/lib/commands'

toArray = (args) ->
  len = args.length - 1
  arr = new Array(len)
  for i in [0..len] by 1
    arr[i] = args[i]
  return arr

module.exports.createClient = () ->
  client = redis.createClient.apply null, arguments

  redisCommands.forEach (command) ->
    original = client[command]
    client[command] = () ->
      # if connected, then pass on the commands
      if client.connected == true
        return original.apply client, arguments
      else
      # else return immediately and then queue commands with noop callback
        args = toArray(arguments)
        last = args[args.length - 1]
        if typeof last == 'function'
          err = new Error('No connection to server')
          last err
          # Replace callback with a noop callback
          args[args.length - 1] = () ->
          original.apply client, args

  return client