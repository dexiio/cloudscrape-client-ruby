require "spec_helper"

require "vcr"
require "webmock"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE>") do
    ENV["CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE"]
  end

  c.filter_sensitive_data("<CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE>") do
    ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID_OVERRIDE"]
  end
end
