redis = require '../lib'

xdescribe 'example', () ->
  xit '', () ->
    client = redis.createClient()
    i = 0
    setValue = (key, value, cb) ->
      client.set key, value, cb

    client.on 'error', (err) ->
      #console.error('redis error', err);

    setInterval () ->
      i = i + 1
      f = (r) ->
        console.time('set' + r)
        setValue 'test-redis-foo', 'bar', (err) ->
          console.timeEnd 'set' + r
          #console.log 'set error', err if err
      f(i)
    , 1000