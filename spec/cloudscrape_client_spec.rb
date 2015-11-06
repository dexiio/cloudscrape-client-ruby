require "spec_helper"

describe CloudscrapeClient do
  let(:instance) { described_class.new }

  describe ".new" do
    subject(:new) do
      described_class.new(api_key: api_key, account_id: account_id)
    end

    let(:api_key) { "new_api_key" }
    let(:account_id) { "new_accout_id" }

    it "sets configuration api key" do
      new
      expect(CloudscrapeClient.configuration.api_key).to eq(api_key)
    end

    it "sets configuration account id" do
      new
      expect(CloudscrapeClient.configuration.account_id).to eq(account_id)
    end
  end

  describe ".runs" do
    subject(:runs) { instance.runs(id) }

    let(:id) { "123" }

    it "returns run object" do
      expect(runs).to be_an_instance_of(CloudscrapeClient::Runs)
    end
  end

  describe ".executions" do
    subject(:executions) { instance.executions(id) }

    let(:id) { "123" }

    it "returns run object" do
      expect(executions).to be_an_instance_of(CloudscrapeClient::Executions)
    end
  end
end
