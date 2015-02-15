assert = require 'power-assert'

$ = require 'jquery'
Countdown = require '../countdown'

mocha.setup 'bdd'
window.onload = ->
  if window.mochaPhantomJS
    mochaPhantomJS.run()
  else
    mocha.run()



# .test()
describe '.test()', ->
  it 'テストのテスト', ->
    assert true
