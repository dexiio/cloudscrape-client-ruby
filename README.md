# CloudScrape Ruby Client

Wrapper for CloudScrape API.

* [API Documentation](https://app.cloudscrape.com/#/api)
* [Support](https://cloudscrape.zendesk.com/hc/en-us)

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_scrape'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloud_scrape

## Configuration

``` ruby
CloudScrape.configure do |config|
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
* `user_agent_version` sets the UserAgent version sent to CloudScrape `1.0`
* `timeout` sets the CloudScrape API request timeout `3600`
* `verbose` should all output be printed to STDOUT `false`
* `logger` Logger object. `Logger`

## Basic Usage

``` ruby
# Execute execution for a run (optional arguments to override configuration)
client = CloudScrape.new(
  api_key: "pol6BFzsASYw4gQBl02b24nt",
  account_id: "a814a8r2-a664-4rcb-759c-9de21744117a",
  user_agent: "MY-AGENT/1.0"
)

execution_id = client.runs.execute(run_id)

# Check execution state
execution = client.executions.get(execution_id)
execution.queued? # => false
execution.pending? # => true
execution.running? # => false
execution.failed? # => false
execution.stopped? # => false
execution.ok? # => false

# Execution results (Methods are dynamically defined based on headers)
execution = client.executions.result(execution_id)
execution.response # => { headers: [...], rows: [...] }
execution.as_hash # => { ... }

# Remove execution
client.executions.remove(execution_id)

# Stop execution
client.executions.stop(execution_id)

# Continue execution
client.executions.continue(execution_id)
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
