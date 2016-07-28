require "spec_helper"

describe CloudscrapeClient::RunDTO do
  subject(:run) do
    described_class.for(
      method: :post,
      id: id,
      input: input,
      connect: true,
      url: url
    )
  end

  let(:id) { "tE2e9y7J-eyFiOAKaivrxsMl" }
  let(:url) { "execute" }
  let(:input) { { url: "http://google.com" } }
  let(:response) { double("Faraday::Response", status: 200, body: {}) }

  it "calls API with expected arguments" do
    expect(CloudscrapeClient::API).to receive(:post).with(
      domain: "https://api.dexi.io/",
      url: "runs/#{id}/#{url}?connect=true",
      options: {
        api_key: CloudscrapeClient.configuration.api_key,
        format: "json",
        url: input[:url]
      }
    ) { response }

    expect(run).to eq({})
  end
end
