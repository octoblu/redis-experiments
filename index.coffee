
REDIS_HOST = process.env.REDIS_HOST || '127.0.0.1:6379'
REDIS_KEY = process.env.REDIS_KEY || 'some-big-key'
REDIS_VALUE_SIZE = process.env.REDIS_VALUE_SIZE || '100'

redis = require 'redis'
client = redis.createClient "redis://#{REDIS_HOST}"
debug = require('debug')('redis-experiments')
_ = require 'lodash'
Benchmark = require 'simple-benchmark'

bigNumber = parseInt(REDIS_VALUE_SIZE) * 1024 * 1024
bigData = Array(bigNumber).join("e")
console.log bigData.length

benchmark = new Benchmark label: 'set'
client.hset REDIS_KEY, 'a', bigData, (error) =>
  return console.error error if error?
  benchmark.prettyPrint()
  benchmark = new Benchmark label: 'get'
  client.hget REDIS_KEY, 'a', (error, data) =>
    return console.error error if error?
    benchmark.prettyPrint()
    console.error 'get and set data does not match' if bigData != data
    benchmark = new Benchmark label: 'del'
    client.del REDIS_KEY, (error) =>
      benchmark.prettyPrint()
      client.unref()
