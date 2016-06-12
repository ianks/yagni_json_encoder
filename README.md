# YagniJsonEncoder

[![Build Status](https://travis-ci.org/ianks/yagni_json_encoder.svg?branch=master)](https://travis-ci.org/ianks/yagni_json_encoder)

This gem overrides the [default ActiveSupport JSON
encoder](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/json/encoding.rb)
with a faster encoder which makes a few assumptions about your app.

1. You do not need the escape HTML entities in your JSON
2. You do not need any special escaping besides that provided by the JSON
   standard.

Under the hood, this app removes Rails' special JSON escaping, and relies on
[Oj](https://github.com/ohler55/oj) to do the heavy lifting of JSON encoding.


## Why?

By default, Rails plays it safe and escapes `\u2028` and `\u2029`. In order to
do this, a `#gsub` call (O(n) time complexity) is required on every string it
encounters. I do not interface with old browsers, so escaping these characters
is useless to me. Instead, we dont escape these characters, and let Oj do all
the heavy JSON encoding work.


## Perfomance (show me the money!)

In a real Rails app, I benchmarked `Tips.all.to_json` with the different
encoders. On average, YagniJsonEncoder is ~2x as fast. However, you could
see bigger gains if your models are text/string-heavy.

```
Calculating -------------------------------------
    YagniJsonEncoder    10.000  i/100ms
      JSONGemEncoder     5.000  i/100ms
-------------------------------------------------
    YagniJsonEncoder    105.536  (± 6.6%) i/s -    530.000
      JSONGemEncoder     50.605  (± 4.0%) i/s -    255.000

Comparison:
    YagniJsonEncoder:      105.5 i/s
      JSONGemEncoder:       50.6 i/s - 2.09x slower
```


## Installation

Just add this line to your application's Gemfile:

```ruby
gem 'yagni_json_encoder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yagni_json_encoder


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/ianks/yagni_json_encoder.
