require "vcr_helper"

describe CloudScrape::Runs do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "27c719bb-f28f-49f5-aedf-dba2f8e60ba3" }

  describe "#execute" do
    subject(:execute) { instance.execute }

    it "calls off to RunDTO and returns" do
      VCR.use_cassette("valid/runs/execute") do
        expect(execute).to eq("52f49f63-51e7-4ce3-90b4-6294814f8b34")
      end
    end

    context "when input" do
      subject(:execute) { instance.execute(input, connect: true) }

      let(:input) { { url: "http://www.google.com" } }

      it "calls off to RunDTO and returns" do
        VCR.use_cassette("valid/runs/execute_with_input") do
          expect(execute).to eq("ea5da785-bcee-4a63-b714-b29eb9a3d852")
        end
      end
    end
  end
end
