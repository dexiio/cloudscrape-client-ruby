# frozen_string_literal: true

require "spec_helper"

require "vcr"
require "webmock/rspec"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE>") do
    CloudscrapeClient.configuration.api_key
  end

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE>") do
    CloudscrapeClient.configuration.account_id
  end
end
