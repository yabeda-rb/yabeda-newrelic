# Yabeda::[NewRelic]

[![Gem Version](https://badge.fury.io/rb/yabeda-newrelic.svg)](https://rubygems.org/gems/yabeda-newrelic) [![Build Status](https://travis-ci.org/yabeda-rb/yabeda-newrelic.svg?branch=master)](https://travis-ci.org/yabeda-rb/yabeda-newrelic)

Adapter for easy exporting collected custom metrics from your application to the [NewRelic Insights].

<a href="https://evilmartians.com/?utm_source=yabeda-newrelic&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>


## Installation

 1. [Install and configure official NewRelic agent for Ruby](https://docs.newrelic.com/docs/agents/ruby-agent/installation/install-new-relic-ruby-agent).

 2. Add this line to your application's Gemfile:

    ```ruby
    gem 'yabeda-newrelic'
    ```

    And then execute:

        $ bundle


## Usage

All metrics registered in [Yabeda] will be sent to NewRelic automatically.

Go to [NewRelic Insights] → Data Explorer → Metrics to view them.

### Caveats

When testing make sure that your NewRelic agent is enabled (`NewRelic::Agent.config[:agent_enabled]` is `true`) as it is being automatically disabled in console sessions as example.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Please read following articles about how [NewRelic Ruby Agent](https://github.com/newrelic/rpm/) works under the hood to better understand how to interact with it:

 - http://mgiroux.me/2016/instrumenting-rails-apps/
 - https://qiita.com/k0kubun/items/4810d2044c47e597540f

### Architecture

Every time Yabeda metric is being updated the NewRelic API will be called.

`collect` blocks for metrics collected on demand will be called during NewRelic's [harvest cycle](https://docs.newrelic.com/docs/using-new-relic/welcome-new-relic/getting-started/glossary#harvest-cycle). 


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yabeda-rb/yabeda-newrelic.

### Releasing

1. Bump version number in `lib/yabeda/newrelic/version.rb`

   In case of pre-releases keep in mind [rubygems/rubygems#3086](https://github.com/rubygems/rubygems/issues/3086) and check version with command like `Gem::Version.new(Yabeda::NewRelic::VERSION).to_s`

2. Fill `CHANGELOG.md` with missing changes, add header with version and date.

3. Make a commit:

   ```sh
   git add lib/yabeda/newrelic/version.rb CHANGELOG.md
   version=$(ruby -r ./lib/yabeda/newrelic/version.rb -e "puts Gem::Version.new(Yabeda::NewRelic::VERSION)")
   git commit --message="${version}: " --edit
   ```

4. Create annotated tag:

   ```sh
   git tag v${version} --annotate --message="${version}: " --edit --sign
   ```

5. Fill version name into subject line and (optionally) some description (list of changes will be taken from changelog and appended automatically)

6. Push it:

   ```sh
   git push --follow-tags
   ```

7. GitHub Actions will create a new release, build and push gem into RubyGems! You're done!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[NewRelic]: https://newrelic.com/
[NewRelic Insights]: https://insights.newrelic.com/
[Yabeda]: https://github.com/yabeda-rb/yabeda/ "Extendable framework for collecting and exporting metrics from your Ruby application "
