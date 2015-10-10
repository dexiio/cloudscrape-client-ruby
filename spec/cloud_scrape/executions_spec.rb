require "vcr_helper"

describe CloudScrape::Executions do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "5438f8a3-524e-429b-9791-de114f290931" }

  describe "#get" do
    subject(:get) { instance.get }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/get") do
        expect(get).to be_an_instance_of(CloudScrape::Executions::Get)
      end
    end
  end

  describe "#result" do
    subject(:result) { instance.result }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/result") do
        expect(result.keys.size).to be > 0
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
end
