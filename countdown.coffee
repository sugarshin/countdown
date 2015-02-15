do (root = this, factory = ($) ->
  "use strict"

  class Countdown

    _defaults:
      dayChar: '.js-countdown-day-char'
      hourChar: '.js-countdown-hour-char'
      minChar: '.js-countdown-min-char'
      secChar: '.js-countdown-sec-char'
      digit: 2
      onAfterFinish: ->

    _formatNum: (digit, num) ->
      str = new String num
      count = digit - str.length
      if count <= 0 then return str
      str = "0#{str}" while count-- > 0
      return str

    _configure: (opts) ->
      @opts = $.extend {}, @_defaults, opts
      @_aDay = 24 * 60 * 60 * 1000

      zero = @_formatNum @opts.digit, 0
      @$dayChar = $(@opts.dayChar).text zero
      @$hourChar = $(@opts.hourChar).text zero
      @$minChar = $(@opts.minChar).text zero
      @$secChar = $(@opts.secChar).text zero

    constructor: (@end, opts) ->
      @_configure opts

    updateChar: (d, h, m, s) ->
      @$dayChar.text d
      @$hourChar.text h
      @$minChar.text m
      @$secChar.text s
      return this

    update: (remaind) ->
      d = @_formatNum @opts.digit, Math.floor(remaind / @_aDay)
      h = @_formatNum @opts.digit, Math.floor((remaind % @_aDay) / (60 * 60 * 1000))
      m = @_formatNum @opts.digit, Math.floor((remaind % @_aDay) / (60 * 1000)) % 60
      s = @_formatNum @opts.digit, Math.floor((remaind % @_aDay) / 1000) % 60 % 60
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
          @opts.onAfterFinish?()
      return this

) ->
  if typeof module is 'object' and typeof module.exports is 'object'
    module.exports = factory require 'jquery'
  else
    root.Countdown or= factory root.jQuery
  return
