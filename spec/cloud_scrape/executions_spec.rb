require "vcr_helper"

describe CloudScrape::Executions do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "9356518b-3869-4c18-8164-9afe0986e824" }

  describe "#result" do
    subject(:result) { instance.result }

    it "calls off to ExecutionDTO and returns" do
      VCR.use_cassette("valid/executions/result") do
        expect(result.keys.size).to be > 0
      end
    end
  end
end
