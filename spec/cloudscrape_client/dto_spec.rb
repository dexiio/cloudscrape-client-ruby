# frozen_string_literal: true

require "spec_helper"

RSpec.describe CloudscrapeClient::DTO do
  let(:instance) { described_class.new(options: options) }
  let(:options) { { something: :else } }

  let(:response) { double("Faraday::Response", status: 200, body: {}) }

  describe ".get" do
    subject { described_class.get(options) }

    let(:domain) { "https://example.com" }
    let(:endpoint) { "/endpoint" }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it "calls off to API and returns response body" do
      expect(CloudscrapeClient::API).to receive(:get).with(
        domain: domain,
        url: endpoint,
        content_type: "application/json",
        options: {
          api_key: CloudscrapeClient.configuration.api_key,
          format: "json"
        }
      ) { response }

      expect(subject).to eq({})
    end
  end

  describe ".post" do
    subject { described_class.post(options) }

    let(:domain) { "https://example.com" }
    let(:endpoint) { "/endpoint" }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it "calls off to API and returns response body" do
      expect(CloudscrapeClient::API).to receive(:post).with(
        domain: domain,
        url: endpoint,
        content_type: "application/json",
        options: {
          api_key: CloudscrapeClient.configuration.api_key,
          format: "json"
        }
      ) { response }

      expect(subject).to eq({})
    end
  end

  describe ".delete" do
    subject { described_class.delete(options) }

    let(:domain) { "https://example.com" }
    let(:endpoint) { "/endpoint" }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it "calls off to API and returns response body" do
      expect(CloudscrapeClient::API).to receive(:delete).with(
        domain: domain,
        url: endpoint,
        content_type: "application/json",
        options: {
          api_key: CloudscrapeClient.configuration.api_key,
          format: "json"
        }
      ) { response }

      expect(subject).to eq({})
    end
  end

  describe "#params" do
    it "returns empty hash" do
      expect(instance.params).to eq({})
    end
  end

  describe "#endpoint" do
    let(:msg) { "Inheriting class must implement" }

    it "raises an error" do
      expect { instance.endpoint }.to raise_error(NotImplementedError, msg)
    end
  end

  describe "#content_type" do
    subject(:content_type) { instance.content_type }

    it "returns nil" do
      expect(content_type).to be_nil
    end
  end

  describe "#content_type_or_default" do
    subject(:content_type_or_default) { instance.content_type_or_default }

    it "returns default content type" do
      expect(content_type_or_default).to eq("application/json")
    end

    context "when context type is not nil" do
      before do
        allow(instance).to receive(:content_type) { "image/png" }
      end

      it "returns content type" do
        expect(content_type_or_default).to eq("image/png")
      end
    end
  end
end
