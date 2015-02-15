# Countdown

[![Build Status](https://travis-ci.org/sugarshin/countdown.svg?branch=master)](https://travis-ci.org/sugarshin/countdown)

Countdown

```shell
npm i -S sugarshin/countdown
```

## Usage

```coffeescript
Countdown = require 'countdown'

countdown = new Countdown endDate
countdown.start()
```

or

```html
<script src="jquery.js"></script>
<script src="countdown.js"></script>
<script>
  countdown = new Countdown(endDate);
  countdown.start();
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
