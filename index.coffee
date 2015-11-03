redis = require 'redis'
client = redis.createClient "redis://192.168.100.34:6379"
debug = require('debug')('redis-experiments')
_ = require 'lodash'

REDIS_KEY = 'a-different-key'


bigNumber = 70 * 1024 * 1024
bigData = Array(bigNumber).join("e")
console.log bigData.length

debug('setting data')
client.hset REDIS_KEY, 'a', bigData, (error) =>
  return console.error error if error?
  debug('data set')
  debug ('getting data')
  client.hget REDIS_KEY, 'a', (error, data) =>
    return console.error error if error?
    debug('data got')
    debug(data.length)
    client.unref()
