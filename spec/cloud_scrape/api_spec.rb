require "spec_helper"

RSpec.describe CloudScrape::API do
  describe ".get" do
    subject(:get) do
      described_class.get(domain: domain, url: url, options: options)
    end

    let(:domain) { "https://example.com" }
    let(:url) { "/endpoint/Some Bad URL" }
    let(:options) { { key: "value" } }

    let(:connection) { double("Faraday") }
    let(:response) { double("Faraday::Response", status: 200, body: {}) }

    it "calls off to Faraday", :aggregate_failures do
      expect(Faraday).to receive(:new).with(url: domain) { connection }
      expect(connection).to receive(:get)
        .with("/endpoint/Some%20Bad%20URL", options) { response }

      get
    end
  end

  describe ".post" do
    subject(:post) do
      described_class.post(domain: domain, url: url, options: options)
    end

    let(:domain) { "https://example.com" }
    let(:url) { "/endpoint/Some Bad URL" }
    let(:options) { { key: "value" } }

    let(:connection) { double("Faraday") }
    let(:request) { double("Faraday::Request") }
    let(:headers) { {} }

    it "calls off to Faraday", :aggregate_failures do
      expect(Faraday).to receive(:new).with(url: domain) { connection }
      expect(connection).to receive(:post).and_yield(request)

      expect(request).to receive(:url).with("/endpoint/Some%20Bad%20URL")
      expect(request).to receive(:body=).with("key=value")

      post
    end
  end

  describe ".delete" do
    subject(:delete) do
      described_class.delete(domain: domain, url: url, options: options)
    end

    let(:domain) { "https://example.com" }
    let(:url) { "/endpoint/Some Bad URL" }
    let(:options) { { key: "value" } }

    let(:connection) { double("Faraday") }
    let(:response) { double("Faraday::Response", status: 200) }

    it "calls off to Faraday", :aggregate_failures do
      expect(Faraday).to receive(:new).with(url: domain) { connection }
      expect(connection).to receive(:delete)
        .with("/endpoint/Some%20Bad%20URL", options) { response }

      delete
    end
  end
end
