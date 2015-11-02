redis = require 'redis'
client = redis.createClient()
REDIS_KEY = 'redis-large-file-test'
debug = require('debug')('redis-experiments')

startGet = Date.now()

debug('setting data')
client.set REDIS_KEY, 'hi', (error) =>
  debug('data set')
  debug ('getting data')
  client.get REDIS_KEY, (error, data) =>
    debug('data got')
    debug(data.length)
    client.unref()
