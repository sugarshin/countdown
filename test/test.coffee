assert = require 'power-assert'

$ = require 'jquery'
Countdown = require '../countdown'

mocha.setup 'bdd'
window.onload = ->
  if window.mochaPhantomJS
    mochaPhantomJS.run()
  else
    mocha.run()



# constructor
describe 'constructor', ->
  it '正しくインスタンスが生成されること', ->
    c = new Countdown
    assert c instanceof Countdown

# initialize
describe 'initialize', ->
  it '正しくinitializeされること', ->
    els = [
      'js-countdown-day-char'
      'js-countdown-hour-char'
      'js-countdown-min-char'
      'js-countdown-sec-char'
    ]
    for name, i in els
      span = document.createElement 'span'
      span.className = name
      document.body.appendChild span

    new Countdown

    assert do ->
      $span = $('span')
      for el, i in $span
        if $(el).text() isnt '00' then return false
      return true
        
