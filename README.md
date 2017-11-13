# Edwig Ruby

Ruby tools for [Edwig](https://github.com/af83/edwig)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'edwig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edwig

## Munin

Munin plugin can be executed via :

EDWIG_SERVER=your_host EDWIG_TOKEN=your_token EDWIG_REFERENTIAL=your_referential bundle exec ./exe/edwig-munin model_count

The following munin plugins are available :

* model_count
* partner_operational_status
* stop_visit_status

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/af83/edwig.

## License

The gem is available as open source under the terms of the [Apache License 2.0](http://www.apache.org/licenses/).
