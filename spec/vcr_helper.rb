require "spec_helper"

require "vcr"
require "webmock"

RSpec.configure do |config|
  config.before do
    CloudScrape.configuration.api_key =
      ENV["CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE"]

    CloudScrape.configuration.account_id =
      ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE"]
  end

  config.after do
    CloudScrape.configuration.api_key = nil
    CloudScrape.configuration.account_id = nil
  end
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_API_KEY>") do
    ENV["CLOUD_SCRAPE_CLIENT_API_KEY"]
  end

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_ACCOUNT_ID>") do
    ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID"]
  end
end
