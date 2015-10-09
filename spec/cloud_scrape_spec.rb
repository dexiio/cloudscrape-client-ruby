require "spec_helper"

describe CloudScrape do
  let(:instance) { described_class.new }

  describe ".runs" do
    subject(:runs) { instance.runs(id) }

    let(:id) { "123" }

    it "returns run object" do
      expect(runs).to be_an_instance_of(CloudScrape::Runs)
    end
  end

  describe ".executions" do
    subject(:executions) { instance.executions(id) }

    let(:id) { "123" }

    it "returns run object" do
      expect(executions).to be_an_instance_of(CloudScrape::Executions)
    end
  end
end
