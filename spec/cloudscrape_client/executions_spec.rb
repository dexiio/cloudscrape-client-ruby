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
