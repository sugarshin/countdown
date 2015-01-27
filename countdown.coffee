$ = require 'jquery'
inherits = require 'inherits'
EventEmitter2 = require('eventemitter2').EventEmitter2

class CountDown
  "use strict"

  inherits @, EventEmitter2

  _defaults:
    dayChar: '.js-countdown-day-char'
    hourChar: '.js-countdown-hour-char'
    minChar: '.js-countdown-min-char'
    secChar: '.js-countdown-sec-char'

  _init: ->
    @$dayChar.text '00'
    @$hourChar.text '00'
    @$minChar.text '00'
    @$secChar.text '00'
    return this

  _prepareEl: ->
    @$dayChar = $(@opts.dayChar)
    @$hourChar = $(@opts.hourChar)
    @$minChar = $(@opts.minChar)
    @$secChar = $(@opts.secChar)
    return this

  _formatNum: (digit, num) ->
    str = new String num
    count = digit - str.length
    if count <= 0 then return str
    str = "0#{str}" while count-- > 0
    return str

  updateChar: (d, h, m, s) ->
    @$dayChar.text d
    @$hourChar.text h
    @$minChar.text m
    @$secChar.text s
    return this

  constructor: (@end, opts) ->
    EventEmitter2.call @
    @opts = $.extend {}, @_defaults, opts
    @_aDay = 24 * 60 * 60 * 1000
    @_prepareEl()._init()

  update: (remaind) ->
    d = @_formatNum 2, Math.floor(remaind / @_aDay)
    h = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 60 * 1000))
    m = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 1000)) % 60
    s = @_formatNum 2, Math.floor((remaind % @_aDay) / 1000) % 60 % 60
    @updateChar d, h, m, s
    return this

  start: ->
    do calleee = =>
      start = new Date
      remaind = @end - start
      if remaind > 0
        timer = setTimeout =>
          @update remaind
          calleee()
        , 1000
      else
        clearTimeout timer
        @emit 'finish'
    return this

if typeof define is 'function' and define.amd
  define -> CountDown
else if typeof module isnt 'undefined' and module.exports
  module.exports = CountDown
else
  window.CountDown or= CountDown
