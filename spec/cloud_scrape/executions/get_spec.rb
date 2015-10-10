require "spec_helper"

describe CloudScrape::Executions::Get do
  let(:instance) { described_class.new(response: response) }

  let(:response) do
    {
      _id: "c535dfdc-b84f-11e4-b6cc-001f5b3cb724",
      state: state,
      starts: 142_436_140_145_8,
      finished: nil
    }
  end

  let(:state) { "QUEUED" }

  describe "#queued?" do
    subject(:queued) { instance.queued? }

    it "results boolean" do
      expect(queued).to eq(true)
    end
  end

  describe "#pending?" do
    subject(:pending) { instance.pending? }

    let(:state) { "PENDING" }

    it "results boolean" do
      expect(pending).to eq(true)
    end
  end

  describe "#running?" do
    subject(:running) { instance.running? }

    let(:state) { "RUNNING" }

    it "results boolean" do
      expect(running).to eq(true)
    end
  end

  describe "#failed?" do
    subject(:failed) { instance.failed? }

    let(:state) { "FAILED" }

    it "results boolean" do
      expect(failed).to eq(true)
    end
  end

  describe "#stopped?" do
    subject(:stopped) { instance.stopped? }

    let(:state) { "STOPPED" }

    it "results boolean" do
      expect(stopped).to eq(true)
    end
  end

  describe "#ok?" do
    subject(:ok) { instance.ok? }

    let(:state) { "OK" }

    it "results boolean" do
      expect(ok).to eq(true)
    end
  end
end
