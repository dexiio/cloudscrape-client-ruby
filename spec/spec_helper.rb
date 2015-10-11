require "simplecov"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "cloud_scrape"

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
    CloudScrape.configuration.api_key =
      ENV["CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE"]

    CloudScrape.configuration.account_id =
      ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE"]

    CloudScrape.configuration.verbose = false
  end

  config.after do
    CloudScrape.configuration.api_key = nil
    CloudScrape.configuration.account_id = nil
    CloudScrape.configuration.verbose = false
  end
end
