require "spec_helper"

describe CloudScrape::Runs do
  let(:instance) { described_class.new(id: id) }

  let(:id) { "tE2e9y7J-eyFiOAKaivrxsMl" }

  describe "#execute" do
    subject(:execute) { instance.execute }

    let(:run) { {} }

    it "calls off to RunDTO and returns", :aggregate_failures do
      expect(CloudScrape::RunDTO).to receive(:for)
        .with(id: id, url: "executions") { run }

      expect(execute).to eq(run)
    end
  end
end
