require "spec_helper"

describe CloudScrape::RunDTO do
  subject(:run) do
    described_class.for(method: :get, id: id, input: input, url: url)
  end

  let(:id) { "tE2e9y7J-eyFiOAKaivrxsMl" }
  let(:url) { "execute" }
  let(:input) { { url: "http://google.com" } }
  let(:response) { double("Faraday::Response", status: 200, body: {}) }

  it "calls API with expected arguments" do
    expect(CloudScrape::API).to receive(:get).with(
      domain: "https://app.cloudscrape.com/api/",
      url: "runs/#{id}/#{url}",
      options: {
        api_key: ENV["CLOUD_SCRAPE_CLIENT_API_KEY_OVERRIDE"],
        format: "json",
        url: input[:url],
      }
    ) { response }

    expect(run).to eq({})
  end
end
