// Generated by CoffeeScript 1.8.0
(function() {
  var $, CountDown, EventEmitter2, inherits;

  $ = require('jquery');

  inherits = require('inherits');

  EventEmitter2 = require('eventemitter2').EventEmitter2;

  CountDown = (function() {
    "use strict";
    inherits(CountDown, EventEmitter2);

    CountDown.prototype._defaults = {
      dayChar: '.js-countdown-day-char',
      hourChar: '.js-countdown-hour-char',
      minChar: '.js-countdown-min-char',
      secChar: '.js-countdown-sec-char'
    };

    CountDown.prototype._init = function() {
      this.$dayChar.text('00');
      this.$hourChar.text('00');
      this.$minChar.text('00');
      this.$secChar.text('00');
      return this;
    };

    CountDown.prototype._prepareEl = function() {
      this.$dayChar = $(this.opts.dayChar);
      this.$hourChar = $(this.opts.hourChar);
      this.$minChar = $(this.opts.minChar);
      this.$secChar = $(this.opts.secChar);
      return this;
    };

    CountDown.prototype._formatNum = function(digit, num) {
      var count, str;
      str = new String(num);
      count = digit - str.length;
      if (count <= 0) {
        return str;
      }
      while (count-- > 0) {
        str = "0" + str;
      }
      return str;
    };

    CountDown.prototype.updateChar = function(d, h, m, s) {
      this.$dayChar.text(d);
      this.$hourChar.text(h);
      this.$minChar.text(m);
      this.$secChar.text(s);
      return this;
    };

    function CountDown(end, opts) {
      this.end = end;
      EventEmitter2.call(this);
      this.opts = $.extend({}, this._defaults, opts);
      this._aDay = 24 * 60 * 60 * 1000;
      this._prepareEl()._init();
    }

    CountDown.prototype.update = function(remaind) {
      var d, h, m, s;
      d = this._formatNum(2, Math.floor(remaind / this._aDay));
      h = this._formatNum(2, Math.floor((remaind % this._aDay) / (60 * 60 * 1000)));
      m = this._formatNum(2, Math.floor((remaind % this._aDay) / (60 * 1000)) % 60);
      s = this._formatNum(2, Math.floor((remaind % this._aDay) / 1000) % 60 % 60);
      this.updateChar(d, h, m, s);
      return this;
    };

    CountDown.prototype.start = function() {
      var start;
      (start = (function(_this) {
        return function() {
          var remaind, timer;
          start = new Date;
          remaind = _this.end - start;
          if (remaind > 0) {
            return timer = setTimeout(function() {
              _this.update(remaind);
              return start();
            }, 1000);
          } else {
            clearTimeout(timer);
            return _this.emit('finish');
          }
        };
      })(this))();
      return this;
    };

    return CountDown;

  })();

  if (typeof define === 'function' && define.amd) {
    define(function() {
      return CountDown;
    });
  } else if (typeof module !== 'undefined' && module.exports) {
    module.exports = CountDown;
  } else {
    window.CountDown || (window.CountDown = CountDown);
  }

}).call(this);