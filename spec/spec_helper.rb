require "simplecov"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "cloudscrape_client"

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before do
    CloudscrapeClient.configuration.api_key =
      ENV["CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE"]

    CloudscrapeClient.configuration.account_id =
      ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE"]

    CloudscrapeClient.configuration.verbose = false
  end

  config.after do
    CloudscrapeClient.configuration.api_key = nil
    CloudscrapeClient.configuration.account_id = nil
    CloudscrapeClient.configuration.verbose = false
  end
end
