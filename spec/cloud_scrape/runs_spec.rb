require "vcr_helper"

describe CloudScrape::Runs do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "27c719bb-f28f-49f5-aedf-dba2f8e60ba3" }

  describe "#execute" do
    subject(:execute) { instance.execute }

    it "calls off to RunDTO and returns" do
      VCR.use_cassette("valid/runs/execute") do
        expect(execute).to eq("3a8ea1f2-6781-4371-841f-66f6210a27b9")
      end
    end

    context "when input" do
      subject(:execute) { instance.execute(input) }

      let(:input) { { url: "http://www.google.com" } }

      it "calls off to RunDTO and returns" do
        VCR.use_cassette("valid/runs/execute_with_input") do
          expect(execute).to eq("283002e2-9117-4dd6-a830-5bdecd8889a6")
        end
      end
    end
  end
end
