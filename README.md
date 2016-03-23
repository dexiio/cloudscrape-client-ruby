# CloudScrape Ruby Client [![Build Status](https://travis-ci.org/cloudscrape/cloudscrape-client-ruby.svg?branch=master)](https://travis-ci.org/cloudscrape/cloudscrape-client-ruby) [![Gem Version](https://badge.fury.io/rb/cloudscrape-client.svg)](https://badge.fury.io/rb/cloudscrape-client)

Wrapper for CloudScrape API.

* [API Documentation](https://app.cloudscrape.com/#/api)
* [Support](https://cloudscrape.zendesk.com/hc/en-us)

## Requirements

* Ruby `> 1.9.x`

## Installation

Add this line to your application's Gemfile:

    gem 'cloudscrape-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloudscrape-client

## Configuration

``` ruby
CloudscrapeClient.configure do |config|
  config.base_url = "https://app.cloudscrape.com/api/"
  config.api_key = "pol6BFzsASYw4gQBl02b24nt"
  config.account_id = "a814a8r2-a664-4rcb-759c-9de21744117a"
  config.user_agent_app = "MY-AGENT"
  config.user_agent_version = "1.0"
  config.timeout = 60000
  config.verbose = true
  config.logger = Rails.logger
end
```

Some configuration can be set by environment variables:

``` bash
CLOUD_SCRAPE_CLIENT_BASE_URL="https://app.cloudscrape.com/api/"
CLOUD_SCRAPE_CLIENT_API_KEY="pol6BFzsASYw4gQBl02b24nt"
CLOUD_SCRAPE_CLIENT_ACCOUNT_ID="a814a8r2-a664-4rcb-759c-9de21744117a"
CLOUD_SCRAPE_CLIENT_USER_AGENT_APP="MY-AGENT"
CLOUD_SCRAPE_CLIENT_USER_AGENT_VERSION="1.0"
CLOUD_SCRAPE_CLIENT_TIMEOUT=60000
CLOUD_SCRAPE_CLIENT_VERBOSE=true
```

* `base_url` sets the CloudScrape API url `https://app.cloudscrape.com/api/`
* `api_key` sets the CloudScrape API Key `nil`
* `user_agent_app` sets the UserAgent app sent to CloudScrape `CS-RUBY-CLIENT`
* `user_agent_version` sets the UserAgent version sent to CloudscrapeClient `1.0`
* `timeout` sets the CloudScrape API request timeout `3600`
* `verbose` should all output be printed to STDOUT `false`
* `logger` Logger object. `Logger`

## Usage

``` ruby
# Create client (optional arguments to override configuration)
client = CloudscrapeClient.new(
  api_key: "pol6BFzsASYw4gQBl02b24nt",
  account_id: "a814a8r2-a664-4rcb-759c-9de21744117a"
)
```

#### Runs (Execute) [Docs](https://app.cloudscrape.com/#/api/sections/runs/execute)

``` ruby
execution_id = client.runs(run_id).execute
```

#### Runs (Execute with Input) [Docs](https://app.cloudscrape.com/#/api/sections/runs/executeWithInput)

When `connect: true` is passed execution will upload it's result to configured integrations for this run.

``` ruby
execution_id = client.runs(run_id).execute(input: { url: 'http://google.com' }, connect: true)
```

#### Executions (Get) [Docs](https://app.cloudscrape.com/#/api/sections/executions/get)

``` ruby
execution = client.executions(execution_id).get
execution.queued? # => false
execution.pending? # => true
execution.running? # => false
execution.failed? # => false
execution.stopped? # => false
execution.ok? # => false
```

#### Executions (Remove) [Docs](https://app.cloudscrape.com/#/api/sections/executions/remove)

``` ruby
client.executions(execution_id).remove
```

#### Executions (Get Result) [Docs](https://app.cloudscrape.com/#/api/sections/executions/getResult)

Methods are dynamically defined based on headers.

``` ruby
execution = client.executions(execution_id).results
execution.response # => { headers: [...], rows: [...] }
execution.collection # => [ #<CloudscrapeClient::Executions::Result:0x007ffd7d132950> ]
execution.as_hash # => [ { ... } ]
```

#### Executions (Stop) [Docs](https://app.cloudscrape.com/#/api/sections/executions/stop)

``` ruby
client.executions(execution_id).stop
```

#### Executions (Continue) [Docs](https://app.cloudscrape.com/#/api/sections/executions/continue)

``` ruby
client.executions(execution_id).continue
```

## Postman File

[Download](./postman_collection) and add the Postman File for API endpoints.

## Testing

Ensure `CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE` and `CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE` environment variable is set when recording VCR cassettes.

    # Includes Rubocop
    $ bin/test

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/cloudscrape/cloudscrape-client-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
