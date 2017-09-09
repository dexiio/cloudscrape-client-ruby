# frozen_string_literal: true

require "spec_helper"

RSpec.describe CloudscrapeClient::ExecutionDTO do
  subject(:run) do
    described_class.for(
      url: url,
      method: :get,
      execution_id: execution_id,
      record_id: record_id,
      content_type: content_type
    )
  end

  let(:execution_id) { "813d13cd-bd5e-4f65-bd60-45eee6251865" }
  let(:record_id) { "ae101b8f-1326-451c-ada7-3eab3c0f8a91" }
  let(:url) { "file" }
  let(:content_type) { "image/png" }
  let(:response) { double("Faraday::Response", status: 200, body: {}) }

  it "calls API with expected arguments" do
    expect(CloudscrapeClient::API).to receive(:get).with(
      domain: "https://api.dexi.io/",
      url: "executions/#{execution_id}/#{url}/#{record_id}",
      content_type: content_type,
      options: {}
    ) { response }

    expect(run).to eq({})
  end

  context "when there is no record id or content type" do
    subject(:run) do
      described_class.for(
        url: url,
        method: :get,
        execution_id: execution_id
      )
    end

    it "calls API with expected arguments" do
      expect(CloudscrapeClient::API).to receive(:get).with(
        domain: "https://api.dexi.io/",
        url: "executions/#{execution_id}/#{url}",
        content_type: CloudscrapeClient::DTO::DEFAULT_CONTENT_TYPE,
        options: {}
      ) { response }

      expect(run).to eq({})
    end
  end
end
