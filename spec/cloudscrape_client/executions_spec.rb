# frozen_string_literal: true

require "vcr_helper"

describe CloudscrapeClient::Executions do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "3a8ea1f2-6781-4371-841f-66f6210a27b9" }

  describe "#get" do
    subject(:get) { instance.get }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/get") do
        expect(get).to be_an_instance_of(CloudscrapeClient::Executions::Get)
      end
    end
  end

  describe "#file" do
    subject(:file) { instance.file(result_file) }

    let(:id) { "ae101b8f-1326-451c-ada7-3eab3c0f8a91" }
    let(:result_file) do
      CloudscrapeClient::Executions::Result::File.new(
        "FILE:image/png;26071;11fed7f0-a508-4dc8-956a-481535c6f88a"
      )
    end

    it "calls off to ExecutionDTO and returns content" do
      VCR.use_cassette("valid/executions/file") do
        expect(file).to be_an_instance_of(String)
      end
    end
  end

  describe "#results" do
    subject(:results) { instance.results }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/result") do
        expect(results)
          .to be_an_instance_of(CloudscrapeClient::Executions::Results)
      end
    end
  end

  describe "#remove" do
    subject(:remove) { instance.remove }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/remove") do
        expect(remove).to eq("")
      end
    end
  end

  describe "#stop" do
    subject(:stop) { instance.stop }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/stop") do
        expect(stop).to be_a(Hash)
      end
    end
  end

  describe "#continue" do
    subject(:continue) { instance.continue }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/continue") do
        expect(continue).to be_a(Hash)
      end
    end
  end
end
