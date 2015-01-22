$ = require 'jquery'

class CountDown
  "use strict"

  _defaults:
    day: '.js-countdown-day'
    hour: '.js-countdown-hour'
    min: '.js-countdown-min'
    sec: '.js-countdown-sec'

  _init: ->
    @$dayChara.text '00'
    @$hourChara.text '00'
    @$minChara.text '00'
    @$secChara.text '00'
    return this

  _prepareEl: ->
    @$day = $(@opts.day)
    @$hour = $(@opts.hour)
    @$min = $(@opts.min)
    @$sec = $(@opts.sec)

    @$dayChara = @$day.find 'span'
    @$hourChara = @$hour.find 'span'
    @$minChara = @$min.find 'span'
    @$secChara = @$sec.find 'span'
    return this

  _formatNum: (digit, num) ->
    str = new String num
    count = digit - str.length
    if count <= 0 then return str
    str = "0#{str}" while count-- > 0
    return str

  constructor: (@end, opts) ->
    @opts = $.extend {}, @_defaults, opts
    @_aDay = 24 * 60 * 60 * 1000
    @_prepareEl()._init()

  update: (remaind) ->
    d = @_formatNum 2, Math.floor(remaind / @_aDay)
    h = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 60 * 1000))
    m = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 1000)) % 60
    s = @_formatNum 2, Math.floor((remaind % @_aDay) / 1000) % 60 % 60
    @$dayChara.text d
    @$hourChara.text h
    @$minChara.text m
    @$secChara.text s
    return this

  start: ->
    do calleee = =>
      @start = new Date
      remaind = @end - @start
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
  global.CountDown or= CountDown
