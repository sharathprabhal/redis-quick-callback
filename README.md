redis-quick-callback
====================

[![NPM](https://nodei.co/npm/redis-quick-callback.png)](https://nodei.co/npm/redis-quick-callback/)

An enhancement to [mranney/node-redis](https://github.com/mranney/node_redis) that calls back immediately when no connection is present. When a connection is lost, `node-redis` client takes anywhere between 200ms to 2500ms to callback. One way around this to turn off `enable_offline_queue` and loose the awesome offline queuing functionality. This client calls back immediately and executes the command asynchronously.

## Usage
Create a new client using the same API as [mranney/node-redis](https://github.com/mranney/node_redis)

```javascript
var redis = require('redis-quick-callback');
var client = redis.createClient();
client.on('ready', function () {
  // when no connection exists
  client.set('key', 'value', function (err) {
    console.log(err); // Err: No connection to server
  });

  // redis connection is back
  client.get('key', function (err, data) {
    console.log(data); // 'value'
  });

});
```

## Build and Test
The code can be built using [gulp](http://gulpjs.com/) as follows

```
$ gulp 
```

Tests require redis to be running at `localhost:6379`

Run tests using

```
$ npm test
```