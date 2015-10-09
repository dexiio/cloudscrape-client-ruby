require "spec_helper"

describe CloudScrape::RunDTO do
  subject(:run) { described_class.for(method: :get, id: id, url: url) }

  let(:id) { "tE2e9y7J-eyFiOAKaivrxsMl" }
  let(:url) { "execute" }
  let(:response) { double("Faraday::Response", body: {}) }

  it "calls API with expected arguments" do
    expect(CloudScrape::API).to receive(:get).with(
      domain: "https://app.cloudscrape.com/api/",
      url: "runs/#{id}/#{url}",
      options: {
        api_key: "MY_API_KEY",
        format: "json"
      }
    ) { response }

    expect(run).to eq({})
  end
end
