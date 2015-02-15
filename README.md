# Countdown

[![Build Status](https://travis-ci.org/sugarshin/countdown.svg?branch=master)](https://travis-ci.org/sugarshin/countdown)

Countdown

```shell
npm i -S sugarshin/countdown
```

## Usage

```coffeescript
Countdown = require 'countdown'

new Countdown endDate
```

or

```html
<script src="jquery.js"></script>
<script src="countdown.js"></script>
<script>
  new Countdown(endDate);
</script>
```

## Contributing

[CoffeeScript](//coffeescript.org/)

[mocha-phantomjs](//github.com/metaskills/mocha-phantomjs)

[power-assert](//github.com/twada/power-assert)

```shell
npm test
```

## License

MIT

© sugarshin
