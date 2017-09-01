# frozen_string_literal: true

require "vcr_helper"

RSpec.describe CloudscrapeClient::Runs do
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
      subject(:execute) { instance.execute(input: input, connect: true) }

      let(:input) { { url: "http://www.google.com" } }

      it "calls off to RunDTO and returns" do
        VCR.use_cassette("valid/runs/execute_with_input") do
          expect(execute).to eq("5226842f-175c-492f-835a-1f822676f10b")
        end
      end
    end

    context "when bulk" do
      subject(:execute) { instance.execute(input: input) }

      let(:input) { [{ url: "http://www.google.com" }] }

      it "calls off to RunDTO and returns" do
        VCR.use_cassette("valid/runs/execute_bulk") do
          expect(execute).to eq("5226842f-175c-492f-835a-1f822676f10b")
        end
      end
    end
  end
end
