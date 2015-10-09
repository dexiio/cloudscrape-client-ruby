require "vcr_helper"

describe CloudScrape::Runs do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "27c719bb-f28f-49f5-aedf-dba2f8e60ba3" }

  describe "#execute" do
    subject(:execute) { instance.execute }

    it "calls off to RunDTO and returns" do
      VCR.use_cassette("valid/runs/execute") do
        expect(execute).to eq("ae703394-894c-4f59-8677-15df3d6a60d8")
      end
    end
  end
end
