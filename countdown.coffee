do (root = this, factory = ($) ->
  "use strict"

  class Countdown

    _defaults:
      dayChar: '.js-countdown-day-char'
      hourChar: '.js-countdown-hour-char'
      minChar: '.js-countdown-min-char'
      secChar: '.js-countdown-sec-char'

    _formatNum: (digit, num) ->
      str = new String num
      count = digit - str.length
      if count <= 0 then return str
      str = "0#{str}" while count-- > 0
      return str

    _configure: (opts) ->
      @opts = $.extend {}, @_defaults, opts
      @_aDay = 24 * 60 * 60 * 1000

      @$dayChar = $(@opts.dayChar).text '00'
      @$hourChar = $(@opts.hourChar).text '00'
      @$minChar = $(@opts.minChar).text '00'
      @$secChar = $(@opts.secChar).text '00'

    constructor: (@end, opts) ->
      @_configure opts

    updateChar: (d, h, m, s) ->
      @$dayChar.text d
      @$hourChar.text h
      @$minChar.text m
      @$secChar.text s
      return this

    update: (remaind) ->
      d = @_formatNum 2, Math.floor(remaind / @_aDay)
      h = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 60 * 1000))
      m = @_formatNum 2, Math.floor((remaind % @_aDay) / (60 * 1000)) % 60
      s = @_formatNum 2, Math.floor((remaind % @_aDay) / 1000) % 60 % 60
      @updateChar d, h, m, s
      return this

    start: ->
      do _start = =>
        start = new Date
        remaind = @end - start
        if remaind > 0
          timer = setTimeout =>
            @update remaind
            _start()
          , 1000
        else
          clearTimeout timer
      return this

) ->
  if typeof module is 'object' and typeof module.exports is 'object'
    module.exports = factory require 'jquery'
  else
    root.Countdown or= factory root.jQuery
  return
